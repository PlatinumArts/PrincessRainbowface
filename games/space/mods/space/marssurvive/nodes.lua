
minetest.register_node("marssurvive:door2_1", {
	description = "Door",
	drop="marssurvive:door2_1",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
		}
	},
	tiles = {"marssurvive_warntape.png","marssurvive_warntape.png","marssurvive_door2.png","marssurvive_warntape.png","marssurvive_door2.png","marssurvive_door2_2.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
after_place_node = function(pos, placer, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y+1,z=pos.z}
	if minetest.registered_nodes[minetest.get_node(p).name].walkable then
		return false
	else
		minetest.set_node(p, {name = "marssurvive:door2_2",param2=minetest.get_node(pos).param2})
	end
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y+1,z=pos.z}
	minetest.swap_node(p, {name="marssurvive:door2_open_2", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_open_1", param2=minetest.get_node(pos).param2})
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.after(2, function(pos,p)
		if minetest.get_node(pos).name=="marssurvive:door2_open_1" then
			minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
			minetest.swap_node(p, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
			minetest.swap_node(pos, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
		end
	end, pos,p)
	end,
after_dig_node = function (pos, name, digger)
	marssurvive_replacenode({x=pos.x,y=pos.y+1,z=pos.z})
	end,
})

minetest.register_node("marssurvive:door2_2", {
	description = "Door 2-1",
	drawtype = "nodebox",
	drop="marssurvive:door2_1",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
		}
	},
	tiles = {"marssurvive_warntape.png","marssurvive_warntape.png","marssurvive_door2.png","marssurvive_warntape.png","marssurvive_door2.png","marssurvive_door2_2.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y-1,z=pos.z}
	minetest.swap_node(p, {name="marssurvive:door2_open_1", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_open_2", param2=minetest.get_node(pos).param2})
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.after(2, function(pos,p)
		if minetest.get_node(pos).name=="marssurvive:door2_open_2" then
			minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
			minetest.swap_node(p, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
			minetest.swap_node(pos, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
		end
	end, pos,p)
	end,
after_dig_node = function (pos, name, digger)
	marssurvive_replacenode({x=pos.x,y=pos.y-1,z=pos.z})
	end,
})

minetest.register_node("marssurvive:door2_open_1", {
	description = "Door (open) 2-o-1",
	drop="marssurvive:door2_1",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{0.41, -0.5, -0.124, 1.41, 0.5, 0.125},
		}
	},
	tiles = {"marssurvive_warntape.png","marssurvive_warntape.png","marssurvive_door2_open.png","marssurvive_warntape.png","marssurvive_door2_open.png","marssurvive_door2_2_open.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
after_dig_node = function (pos, name, digger)
	marssurvive_replacenode({x=pos.x,y=pos.y+1,z=pos.z})
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y+1,z=pos.z}
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.swap_node(p, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
	end,
})

minetest.register_node("marssurvive:door2_open_2", {
	description = "Door (open) 2-o-1",
	drawtype = "nodebox",
	drop="marssurvive:door2_1",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{0.41, -0.5, -0.124, 1.41, 0.5, 0.125},
		}
	},
	tiles = {"marssurvive_warntape.png","marssurvive_warntape.png","marssurvive_door2_open.png","marssurvive_warntape.png","marssurvive_door2_open.png","marssurvive_door2_2_open.png",},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
after_dig_node = function (pos, name, digger)
	marssurvive_replacenode({x=pos.x,y=pos.y-1,z=pos.z})
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	local p={x=pos.x,y=pos.y-1,z=pos.z}
	minetest.sound_play("marssurvive_door2", {pos=pos, gain = 1, max_hear_distance = 5})
	minetest.swap_node(p, {name="marssurvive:door2_1", param2=minetest.get_node(pos).param2})
	minetest.swap_node(pos, {name="marssurvive:door2_2", param2=minetest.get_node(pos).param2})
	end,
})


-- checks if the area is too big or if its outside in 14 directions
local airgen_tmpn=1
for i=0,5,1 do
if i==5 then airgen_tmpn=0 end
minetest.register_node("marssurvive:airgen" .. i, {
	description = "Air Generator " .. i*20 .."% power",
	tiles = {"marssurvive_shieldblock.png^default_obsidian_glass.png","marssurvive_gen" .. i ..".png"},
	groups = {dig_immediate=3,not_in_creative_inventory=airgen_tmpn},
	sounds = default.node_sound_stone_defaults(),
on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext", "Air Generater " .. i*20 .."% power")
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if pos.y<space.y then return false end
		if minetest.is_protected(pos,player:get_player_name())==false and minetest.get_node(pos).name~="marssurvive:airgen0" then
			local ch={xp=1,xm=1,yp=1,ym=1,zp=1,zm=1, ypxz=1,ypz=1,ypx=1,ypmxz=1, ymxz=1,ymz=1,ymx=1,ymmxz=1,all=14}
			for ii=1,marssurvive.air-2,1 do
				if ch.xp==1 and minetest.get_node({x=pos.x+ii,y=pos.y,z=pos.z}).name~="air" then ch.xp=0 ch.all=ch.all-1 end
				if ch.xm==1 and minetest.get_node({x=pos.x-ii,y=pos.y,z=pos.z}).name~="air" then ch.xm=0 ch.all=ch.all-1 end
				if ch.zp==1 and minetest.get_node({x=pos.x,y=pos.y,z=pos.z+ii}).name~="air" then ch.zp=0 ch.all=ch.all-1 end
				if ch.zm==1 and minetest.get_node({x=pos.x,y=pos.y,z=pos.z-ii}).name~="air" then ch.zm=0 ch.all=ch.all-1 end

				if ch.yp==1 and minetest.get_node({x=pos.x,y=pos.y+ii,z=pos.z}).name~="air" then ch.yp=0 ch.all=ch.all-1 end
				if ch.ym==1 and minetest.get_node({x=pos.x,y=pos.y-ii,z=pos.z}).name~="air" then ch.ym=0 ch.all=ch.all-1 end

				if ch.ypxz==1 and minetest.get_node({x=pos.x+ii,y=pos.y+ii,z=pos.z+ii}).name~="air" then ch.ypxz=0 ch.all=ch.all-1 end
				if ch.ypz==1 and minetest.get_node({x=pos.x-ii,y=pos.y+ii,z=pos.z+ii}).name~="air" then ch.ypz=0 ch.all=ch.all-1 end
				if ch.ypx==1 and minetest.get_node({x=pos.x+ii,y=pos.y+ii,z=pos.z-ii}).name~="air" then ch.ypx=0 ch.all=ch.all-1 end
				if ch.ypmxz==1 and minetest.get_node({x=pos.x-ii,y=pos.y+ii,z=pos.z-ii}).name~="air" then ch.ypmxz=0 ch.all=ch.all-1 end

				if ch.ymxz==1 and minetest.get_node({x=pos.x+ii,y=pos.y-ii,z=pos.z+ii}).name~="air" then ch.ymxz=0 ch.all=ch.all-1 end
				if ch.ymz==1 and minetest.get_node({x=pos.x-ii,y=pos.y-ii,z=pos.z+ii}).name~="air" then ch.ymz=0 ch.all=ch.all-1 end
				if ch.ymx==1 and minetest.get_node({x=pos.x+ii,y=pos.y-ii,z=pos.z-ii}).name~="air" then ch.ymx=0 ch.all=ch.all-1 end
				if ch.ymmxz==1 and minetest.get_node({x=pos.x-ii,y=pos.y-ii,z=pos.z-ii}).name~="air" then ch.ymmxz=0 ch.all=ch.all-1 end
				if ch.all==0 then break end
			end
				if ch.all>0 then
					minetest.get_meta(pos):set_string("infotext", "Air Generater " .. i*20 .."% power [This area is too big (max " .. marssurvive.air-1 .. ") you have to rebuild]")
					return
				end
			local done=0
			for ii=1,17,1 do
				minetest.get_meta(pos):set_int("prl",0)
				local np=minetest.find_node_near(pos,1,{"air"})
				if np~=nil then
					minetest.set_node(np, {name = "marssurvive:air"})
					minetest.get_meta(np):set_int("prl",1)
					done=1
				else
					break
				end
			end
			if done==1 then
				minetest.swap_node(pos, {name = "marssurvive:airgen" .. (i-1)})
				minetest.get_meta(pos):set_string("infotext", "Air Generater " .. (i-1)*20 .."% power")
				minetest.sound_play("marssurvive_pff", {pos=pos, gain = 1, max_hear_distance = 8,}) 
			end
		end
	end,
})
end


minetest.register_node("marssurvive:air", {
	description = "Air (unstabile)",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "glasslike",
	post_effect_color = {a = 180, r = 120, g = 120, b = 120},
	alpha = 20,
	tiles = {"default_cloud.png^[colorize:#E0E0E099"},
	groups = {msa=1,not_in_creative_inventory=0},
	paramtype = "light",
	sunlight_propagates =true,
	on_construct = function(pos)
		minetest.env:get_node_timer(pos):start(30)
	end,
	on_timer = function (pos, elapsed)
	minetest.set_node(pos, {name = "space:air"})
	end
})

minetest.register_node("marssurvive:shieldblock", {
	description = "Shieldblock",
	tiles = {"marssurvive_shieldblock.png"},
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("marssurvive:steelwallblock", {
	description = "Steel wallblock",
	tiles = {"marssurvive_wall.png"},
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("marssurvive:oxogen", {
	description = "Oxygen block",
	tiles = {"marssurvive_oxogen.png"},
	drawtype="glasslike",
	groups = {crumbly = 2},
	paramtype = "light",
	sunlight_propagates = true,
	alpha = 50,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("marssurvive:air_gassbotte", {
	description = "Air gassbotte",
	tiles = {"default_steel_block.png"},
	--inventory_image = "default_steel_block.png",
	drawtype = "nodebox",
	groups = {dig_immediate=3},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
	--paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
	type="fixed",
	fixed={-0.1,-0.5,-0.1,0.1,0.3,0.1}},
})

-- spread air gass in a level system
minetest.register_abm({
	nodenames = {"air"},
	neighbors = {"marssurvive:air"},
	interval = 3,
	chance = 1,
	action = function(pos)
		local np=minetest.find_node_near(pos, 1,{"marssurvive:air"})
		local n
		if np~=nil then n=minetest.get_node(np) end
		if n and n.name=="marssurvive:air" then
			local r=minetest.get_meta(np):get_int("prl")
			if r>0 and r<marssurvive.air then
				minetest.set_node(pos, {name = "marssurvive:air"})
				minetest.get_meta(pos):set_int("prl",r+1)
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"space:air"},
	neighbors = {"air"},
	interval = 10,
	chance = 3,
	action = function(pos)
		minetest.set_node(pos, {name = "air"})
	end,
})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:oxogen",
		wherein        = "space:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 1,
		clust_size     = 1,
		y_min          = space.y,
		y_max          = 31000,
	})