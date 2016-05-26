minetest.register_tool("portalgun:ed", {
	description = "Entity Destroyer",
	inventory_image = "portalgun_edestroyer.png",
	range = 15,
on_use = function(itemstack, user, pointed_thing)
	local pos=user:getpos()
	if pointed_thing.type=="node" then
		pos=pointed_thing.above
	end
	if pointed_thing.type=="object" then
		pos=pointed_thing.ref:getpos()
	end
	local name=user:get_player_name()
	if minetest.check_player_privs(name, {kick=true})==false then
		minetest.chat_send_player(name, "You need the kick privilege to use this tool!")
		return itemstack
	end
	for ii, ob in pairs(minetest.get_objects_inside_radius(pos, 7)) do
		if ob:get_luaentity() then
			ob:set_hp(0)
			ob:punch(ob, {full_punch_interval=1.0,damage_groups={fleshy=9000}}, "default:bronze_pick", nil)
		end
	end
	return itemstack
end
})

minetest.register_node("portalgun:cake", {
	description = "Cake",
	tiles = {"default_cloud.png","default_cloud.png^[colorize:#FF0000ff","default_cloud.png^[colorize:#FFFF00ff","default_dirt.png"},
	groups = {dig_immediate = 3,not_in_creative_inventory=0},
	paramtype = "light",
	sunlight_propagates = true,
	drawtype="mesh",
	mesh="portalgun_cake.obj",
	selection_box = {type = "fixed",fixed = { -0.3, -0.5, -0.3, 0.3, 0, 0.3 }},
	sounds = default.node_sound_defaults(),
})


minetest.register_node("portalgun:testblock", {
	description = "Test block",
	tiles = {"portalgun_testblock.png"},
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("portalgun:apb", {
	description = "Anti portal block",
	tiles = {"portalgun_testblock.png^[colorize:#ffffffaa"},
	groups = {cracky = 3,antiportal=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("portalgun:apg", {
	description = "Anti portal glass",
	drawtype="glasslike",
	paramtype="light",
	sunlight_propagates = true,
	tiles = {"default_glass.png^[colorize:#ffffffaa"},
	groups = {cracky = 1,antiportal=1},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_node("portalgun:hard_glass", {
	description = "Hard glass",
	drawtype="glasslike",
	paramtype="light",
	sunlight_propagates = true,
	tiles = {"default_glass.png^[colorize:#ddddddaa"},
	groups = {cracky = 1},
	sounds = default.node_sound_glass_defaults(),
})

function portalgun_visiable(pos,ob)
	if ob==nil or ob:getpos()==nil or ob:getpos().y==nil then return false end
	local ta=ob:getpos()
	local v = {x = pos.x - ta.x, y = pos.y - ta.y-1, z = pos.z - ta.z}
	v.y=v.y-1
	local amount = (v.x ^ 2 + v.y ^ 2 + v.z ^ 2) ^ 0.5
	local d=math.sqrt((pos.x-ta.x)*(pos.x-ta.x) + (pos.y-ta.y)*(pos.y-ta.y)+(pos.z-ta.z)*(pos.z-ta.z))
	v.x = (v.x  / amount)*-1
	v.y = (v.y  / amount)*-1
	v.z = (v.z  / amount)*-1
	for i=1,d,1 do
		local node=minetest.registered_nodes[minetest.get_node({x=pos.x+(v.x*i),y=pos.y+(v.y*i),z=pos.z+(v.z*i)}).name]
		if node.walkable then
			return false
		end
	end
	return true
end

function portalgun_round(x)
if x%2 ~= 0.5 then
return math.floor(x+0.5)
end
return x-0.5
end


function portalgun_ra2shoot(pos,ob)
		local op=ob:getpos()
		local m=minetest.get_meta(pos)
		local x=m:get_int("x")
		local y=m:get_int("y")
		local z=m:get_int("z")
		local ox=portalgun_round(op.x)
		local oy=portalgun_round(op.y)
		local oz=portalgun_round(op.z)
		if x==1 and ox==pos.x and oz<=pos.z then
			return true
		end
		if x==-1 and ox==pos.x and oz>=pos.z then
			return true
		end
		if z==-1 and oz==pos.z and ox<=pos.x then
			return true
		end
		if z==1 and oz==pos.z and ox>=pos.x then
			return true
		end
		return false
end
--[[  Removed cam and robot / turret for class
minetest.register_node("portalgun:robot", {
	description = "Turret Gun" ,
	tiles = {"default_cloud.png","default_cloud.png^[colorize:#ff0000ff","default_cloud.png^[colorize:#000000ff"},
	drawtype = "mesh",
	mesh="portalgun_robot.obj",
	groups = {dig_immediate = 2},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.1, 0.5}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.5, -0.5, -0.5, 0.5, 1.1, 0.5},}},
	on_construct = function(pos)
		local dir=minetest.get_node(pos).param2
		local m=minetest.get_meta(pos)
		if dir==0 then m:set_int("z",-1)
		elseif dir==1 then m:set_int("x",-1)
		elseif dir==2 then m:set_int("z",1)
		elseif dir==3 then m:set_int("x",1)
		elseif dir==8 then m:set_int("y",-1)
		elseif dir==4 then m:set_int("x",1)
		end
		minetest.env:get_node_timer(pos):start(1)
	end,
on_timer=function(pos, elapsed)
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 10)) do
			if ob:is_player() or (ob:get_luaentity() and ob:get_luaentity().itemstring==nil and ob:get_luaentity().portalgun==nil) then
				if portalgun_ra2shoot(pos,ob) and portalgun_visiable(pos,ob) then
					local v=ob:getpos()
					if not ob:get_luaentity() then v.y=v.y+1 end
					local s={x=(v.x-pos.x)*3,y=(v.y-pos.y)*3,z=(v.z-pos.z)*3}
					local m=minetest.env:add_entity(pos, "portalgun:bullet1")
					m:setvelocity(s)
					m:setacceleration(s)
					minetest.sound_play("portalgun_bullet1", {pos=pos, gain = 1, max_hear_distance = 15,})
					minetest.after((math.random(1,9)*0.1), function(pos,s,v)
					local m=minetest.env:add_entity(pos, "portalgun:bullet1")
					m:setvelocity(s)
					m:setacceleration(s)
					minetest.sound_play("portalgun_bullet1", {pos=pos, gain = 1, max_hear_distance = 15,})
					end, pos,s,v)
				end
			end
		end
		return true
	end,
		
})

minetest.register_node("portalgun:secam_off", {
	description = "Security cam (off)" ,
	tiles = {"portalgun_scam.png"},
	drawtype = "nodebox",
	walkable=false,
	groups = {dig_immediate = 3},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {type="fixed",
		fixed={	{-0.2, -0.5, -0.2, 0.2, -0.4, 0.2},
			{-0.1, -0.2, -0.1, 0.1, -0.4, 0.1}}
	},
	on_place = minetest.rotate_node,
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext","click to activate")
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	minetest.set_node(pos, {name ="portalgun:secam", param1 = node.param1, param2 = node.param2})
	minetest.env:get_node_timer(pos):start(1)
end,
})

minetest.register_node("portalgun:secam", {
	description = "Security cam",
	tiles = {"portalgun_scam.png"},
	drawtype = "nodebox",
	walkable=false,
	groups = {dig_immediate = 3,stone=1,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	drop="portalgun:secam_off",
	node_box = {type="fixed",
		fixed={	{-0.2, -0.5, -0.2, 0.2, -0.4, 0.2},
			{-0.1, -0.2, -0.1, 0.1, -0.4, 0.1}}
	},
on_timer=function(pos, elapsed)
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 10)) do
			if ob:is_player() or (ob:get_luaentity() and ob:get_luaentity().itemstring==nil and ob:get_luaentity().portalgun==nil) then
				if portalgun_visiable(pos,ob) then
					local v=ob:getpos()
					if not ob:get_luaentity() then v.y=v.y+1 end
					local s={x=(v.x-pos.x)*3,y=(v.y-pos.y)*3,z=(v.z-pos.z)*3}
					local m=minetest.env:add_entity(pos, "portalgun:bullet1")
					m:setvelocity(s)
					m:setacceleration(s)
					minetest.sound_play("portalgun_bullet1", {pos=pos, gain = 1, max_hear_distance = 15,})
					minetest.after((math.random(1,9)*0.1), function(pos,s,v)
					local m=minetest.env:add_entity(pos, "portalgun:bullet1")
					m:setvelocity(s)
					m:setacceleration(s)
					minetest.sound_play("portalgun_bullet1", {pos=pos, gain = 1, max_hear_distance = 15,})
					end, pos,s,v)
				end
			end
		end
		return true
	end,
})

minetest.register_entity("portalgun:bullet1",{
	hp_max = 1,
	physical = false,
	weight = 5,
	--collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
	visual = "sprite",
	visual_size = {x=0.1, y=0.1},
	textures = {"default_mese_block.png"},
	--spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	portalgun=2,
	bullet=1,
on_step= function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.05 then return self end
		local pos=self.object:getpos()
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 2)) do
			if  ob:is_player() or (ob:get_luaentity() and ob:get_luaentity().itemstring==nil and ob:get_luaentity().bullet~=1) then
				ob:set_hp(ob:get_hp()-7)
				ob:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
				self.timer2=2
				break
			end

		end
		self.timer=0
		self.timer2=self.timer2+dtime
		if self.timer2>1 or minetest.registered_nodes[minetest.get_node(self.object:getpos()).name].walkable then self.object:remove() end
	end,
	timer=0,
	timer2=0,
})
--]]