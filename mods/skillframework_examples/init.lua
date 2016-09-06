--Author: Domtron Vox(domtron.vox@gmail.com)
--Description: A handful of example skills.

--1) define skills. Here we define a dig skill and a wood cutting skill plus
-- a bunch of useless test skills. We shall place both in the landscaping group.

--(skill name, skill group, cost function for each level.)
SkillsFramework.define_skill({
    --these values are required and the skill will not register if they are not defined
    name = "Digging",
    mod = "skillframework_examples",
    cost_func = function(next_level)
        --this callback function will tell SkillsFramework how many experience points 
        --  each level costs. It will call this function and provide the level it needs 
        --  information on. For example the player just reached level 3 so SkillsFramework
        --  calls this function with 4 as an argument, expecting an integer to be returned.

        -- this is digging so we will make it have a constant cost.
        return 400
    end,
    --these values are optional.
    group = "Landscaping",
    min = 1, --minimum and initialization skill level is 1
    max = 3, --maximum level is 3 eperience gain stops once the skill reaches this level
    on_levelup = function(set_id, level)
        --this callback function is called when the skill levels up naturally. If you want
        --  something to happen when a certain level is reached this is a good way to do it.
        print(level)
        if level == 2 then
            SkillsFramework.append_skills(set_id, "skillframework_examples:Mining")
        end
    end
})

--do it again for woodcutting
SkillsFramework.define_skill({
    name = "Woodcutting",
    mod = "skillframework_examples",
    group = "Landscaping",
    cost_func = function(next_level)
        --but for this one make the cost go up linearly
        return 400*next_level -- at level 4 it costs 4*400=1600 experience 
    end
    --min defaults to zero so we don't need to specify it
})


SkillsFramework.define_skill({
    name = "Mining",
    mod = "skillframework_examples",
    group = "Landscaping",
    cost_func = function(next_level)
        --but for this one make the cost go up linearly
        return 400*next_level -- at level 4 it costs 4*400=1600 experience 
    end
    --min defaults to zero so we don't need to specify it
})


SkillsFramework.define_skill({
    name = "Sword Fighting",
    mod = "skillframework_examples",
    group = "Combat",
    cost_func = function(next_level)
        --but for this one make the cost go up linearly
        return 600*next_level -- at level 4 it costs 4*400=1600 experience 
    end
    --min defaults to zero so we don't need to specify it
})

--Now loop through and make test skills

--for i = 1,10 do

--    SkillsFramework.define_skill({
--        name = "Test Skill "..i, 
--        mod = "skillframework_examples", 
--        group = "Testing",
--        cost_func = function(next_level)
--            return 10000
--        end
--    })

--end


--3) Finally we need to use these skills by defining register_on_punch (or 
--    register_on_craft or some other "register_on_*" function). 
--    In this case both skills use register_on_dignode.

--use the digging skill
minetest.register_on_dignode(function(pos, node, digger)
    local player = digger:get_player_name()

    --verify node is a dirt type
    if minetest.registered_nodes[node.name] ~= nil 
    and minetest.get_item_group(node.name, "soil") >= 1
    or minetest.get_item_group(node.name, "crumbly") >= 1
    then
        --if a dirt-like we change the digging skill 
        --give more experience for using a tool.
        if digger:get_wielded_item():get_tool_capabilities().groupcaps["crumbly"] then
            SkillsFramework.add_experience(player, 
                               "skillframework_examples:Digging", (math.random()*200)/4)
        else
            SkillsFramework.add_experience(player, 
                                "skillframework_examples:Digging", (math.random()*100)/6)
        end
    
    --verify node is a tree type
    elseif minetest.registered_nodes[node.name] ~= nil 
    and minetest.get_item_group(node.name, "choppy") >= 1
    then
        --if a tree-like we change the chopping skill

        --give more experience for using a tool.
        if digger:get_wielded_item():get_tool_capabilities().groupcaps["choppy"] then
            SkillsFramework.add_experience(player, 
                      "skillframework_examples:Woodcutting", (math.random()*200)/4)
        else
            SkillsFramework.add_experience(player, 
                      "skillframework_examples:Woodcutting", (math.random()*100)/8)
        end

    elseif minetest.registered_nodes[node.name] ~= nil 
    and minetest.get_item_group(node.name, "cracky") >= 1
    then
        --give more experience for using a tool.
        if digger:get_wielded_item():get_tool_capabilities().groupcaps["cracky"] then
            SkillsFramework.add_experience(player, 
                         "skillframework_examples:Mining", (math.random()*200)/4)
        else
            SkillsFramework.add_experience(player, 
                          "skillframework_examples:Mining", (math.random()*100)/8)
        end
    end
    
end)


--4) create an item that adds a skill to the player's skillset when used.
minetest.register_craftitem("skillframework_examples:booklet", {
	description = "Sword Fighting Booklet",
	inventory_image = "book.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
            SkillsFramework.append_skills(user:get_player_name(), "skillframework_examples:Sword Fighting")
            itemstack:take_item(1) --TODO: Why do I have to call take_item twice to get an item removed? passing 2 as the arg does not help either.
            return itemstack:take_item(1)
	end,
})
minetest.register_on_newplayer(function(player)
    player:get_inventory():add_item('main', 'skillframework_examples:booklet')
end)

--5) Give players a set of starting skills.
--IMPORTANT: You should not do what I do below but instead edit skillframwork's
--    settings.lua STARTING_SKILLS option. Below is just a hack so the repo's settings 
--    file has a good default value
SkillsFramework.STARTING_SKILLS = {"skillframework_examples:Digging", "skillframework_examples:Woodcutting"}
