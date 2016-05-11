space.get_distance=function(a,b)
return math.sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y)+(a.z-b.z)*(a.z-b.z))
end

space.planet_last={x=0,y=0,z=0}

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "space_planets:planet_spawner",
	wherein        = "default:stone",
	clust_scarcity =  3 * 3 * 3,
	clust_num_ores = 1,
	clust_size     = 1,
	y_min          = space.y2+100,
	y_max          = 31000,
})

minetest.register_node("space_planets:planet_earthlike", {
	description = "Planet earthlike",
	drawtype="airlike",
	sunlight_propagates =true,
})
minetest.register_node("space_planets:planet_desert", {
	description = "Planet desert",
	drawtype="airlike",
	sunlight_propagates =true,
})
minetest.register_node("space_planets:planet_cool", {
	description = "Planet cool",
	drawtype="airlike",
	sunlight_propagates =true,
})
minetest.register_node("space_planets:planet_rnd", {
	description = "Planet rnd",
	drawtype="airlike",
	sunlight_propagates =true,
})
minetest.register_node("space_planets:planet_dryearth", {
	description = "Planet dryearth",
	drawtype="airlike",
	sunlight_propagates =true,
})

minetest.register_node("space_planets:planet_spawner", {
	description = "Planet spawner",
	tiles = {"default_cloud.png^[colorize:#19ffd655"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-1,-1,-1,1,1,1},
		}
	},
})

minetest.register_abm({
	nodenames = {"space_planets:planet_spawner"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "air"})
		local rs=space.get_distance(pos,space.planet_last)
		print("distance to last planet: " .. rs)
		if rs < 1000 or minetest.find_node_near(pos, 200,{"group:spacestuff"}) then print("planet spawning failed") return end
		print("planet is spawning")
		space.planet_last=pos
		local r=math.random(1,5)
		local c=math.random(1,17)
		local planet={}
		local t=minetest.get_modpath("space").."/schematics/space_plant.mts"
		planet[1]={grass="default:dirt_with_grass",dirt="default:dirt",deco="space_planets:planet_earthlike",stone="space:stone"}
		planet[2]={grass="default:desert_sand",dirt="default:desert_sand",deco="space_planets:planet_desert",stone="default:desert_stone"}
		planet[3]={grass="default:snowblock",dirt="default:snowblock",deco="space_planets:planet_cool",stone="space:stone"}
		planet[4]={grass="",dirt="",deco="space_planets:planet_rnd",stone="space:stone"}
		planet[5]={grass="default:dirt_with_dry_grass",dirt="default:dirt",deco="space_planets:planet_dryearth",stone="space:stone"}

		planet=planet[r]

		if r==4 then
			local stuff={"default:cobble","default:dirt_with_dry_grass","default:stone","default:dirt_with_grass","default:cactus","default:ice","default:clay","default:gravel","default:desert_sand","default:sand","default:obsidian","default:sandstone","default:desert_cobble","space:moon_stone"}
			planet.dirt=stuff[math.random(1,14)]
			planet.grass=stuff[math.random(1,14)]
		end

		local elemets={["space:stone"]=planet.stone,["default:cobble"]=planet.grass,["default:wood"]=planet.dirt,["default:junglewood"]=planet.deco}

		minetest.place_schematic({x=pos.x,y=pos.y,z=pos.z}, t,"0",elemets,true)

		minetest.after(1,function(elemets,t,pos)
			minetest.place_schematic({x=pos.x,y=pos.y,z=pos.z-170}, t,"90",elemets,true)
		end,elemets,t,pos)
		minetest.after(2,function(elemets,t,pos)
			minetest.place_schematic({x=pos.x-170,y=pos.y,z=pos.z-170}, t,"180",elemets,true)
		end,elemets,t,pos)
		minetest.after(3,function(elemets,t,pos)
			minetest.place_schematic({x=pos.x-170,y=pos.y,z=pos.z}, t,"270",elemets,true)
		end,elemets,t,pos)
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 50)) do
			local p=ob:getpos()
			p.y=pos.y+75
			ob:moveto(p)
		end
	end,
})

minetest.register_abm({
	nodenames = {"space_planets:planet_earthlike"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local r=math.random(1,19)
		local stuff={
		"default:grass_3",
		"default:junglesapling",
		"default:sapling",
		"default:aspen_sapling",
		"default:junglesapling",
		"default:sapling",
		"default:aspen_sapling",
		"default:junglegrass",
		"default:grass_3",
		"flowers:mushroom_brown",
		"flowers:mushroom_red",
		"flowers:rose",
		"flowers:tulip",
		"flowers:dandelion_yellow",
		"flowers:geranium",
		"flowers:viola",
		"flowers:dandelion_white",
		"farming:wheat_" .. math.random(4,8),
		"farming:cotton_" .. math.random(4,8),
		""}
		minetest.set_node(pos, {name = stuff[r]})
		local t=minetest.get_modpath("space").."/schematics/space_lightfix.mts"
		minetest.place_schematic(pos, t,"random",nil,false)
	end,
})

minetest.register_abm({
	nodenames = {"space_planets:planet_desert"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local r=math.random(1,3)
		local stuff={
		"default:cactus",
		"default:dry_shrub",
		"default:desert_stone",
		""}
		minetest.set_node(pos, {name = stuff[r]})
		local t=minetest.get_modpath("space").."/schematics/space_lightfix.mts"
		minetest.place_schematic(pos, t,"random",nil,false)
	end,
})

minetest.register_abm({
	nodenames = {"space_planets:planet_dryearth"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local r=math.random(1,4)
		local stuff={
		"default:cactus",
		"default:acacia_sapling",
		"default:dry_shrub",
		"default:desert_stone",
		""}
		if r==1 then
			minetest.set_node({x=pos.x,y=pos.y-1,z=pos.z}, {name = "default:sand"})
		end
		minetest.set_node(pos, {name = stuff[r]})
		local t=minetest.get_modpath("space").."/schematics/space_lightfix.mts"
		minetest.place_schematic(pos, t,"random",nil,false)
	end,
})




minetest.register_abm({
	nodenames = {"space_planets:planet_cool"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local r=math.random(1,3)
		local stuff={
		"default:snow",
		"default:ice",
		"default:dirt_with_snow",
		"default:pine_sapling",
		""}
		minetest.set_node(pos, {name = stuff[r]})
		local t=minetest.get_modpath("space").."/schematics/space_lightfix.mts"
		minetest.place_schematic(pos, t,"random",nil,false)
	end,
})

minetest.register_abm({
	nodenames = {"space_planets:planet_rnd"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "air"})
		local t=minetest.get_modpath("space").."/schematics/space_lightfix.mts"
		minetest.place_schematic(pos, t,"random",nil,false)
	end,
})