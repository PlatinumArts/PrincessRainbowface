ARROW_DAMAGE=1
ARROW_GRAVITY=9
ARROW_VELOCITY=19

rainbowmod_shoot_arrow=function (item, player, pointed_thing)
	-- Check if arrows in Inventory and remove one of them
	local i=1
	if player:get_inventory():contains_item("main", "rainbowmod:arrow") then
		player:get_inventory():remove_item("main", "rainbowmod:arrow")
		-- Shoot Arrow
		local playerpos=player:getpos()
		local obj=minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "rainbowmod:arrow_entity")
		local dir=player:get_look_dir()
		obj:setvelocity({x=dir.x*ARROW_VELOCITY, y=dir.y*ARROW_VELOCITY, z=dir.z*ARROW_VELOCITY})
		obj:setacceleration({x=dir.x*-3, y=-ARROW_GRAVITY, z=dir.z*-3})
	end
	return
end

minetest.register_craftitem("rainbowmod:pie_preparation", {
  description = "Vanilla To Preparate A Pie (Cook this to get a pie)",
	inventory_image = "pie_van.png",
})

minetest.register_craftitem("rainbowmod:pie_terminator", {
  description = "Pie Thrower (Click to send a pie)",
	inventory_image = "pie_thrower.png",
    stack_max = 1,
	on_use = rainbowmod_shoot_arrow,
})

minetest.register_craftitem("rainbowmod:arrow", {
	description = "Pie",
	inventory_image = "pie_to_throw.png",
	on_use = minetest.item_eat(20)
})

-- The Arrow Entity

RAINBOWMOD_ARROW_ENTITY={
	physical = false,
	timer=0,
	textures = {"pie_back.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}


-- Arrow_entity.on_step()--> called when arrow is moving
RAINBOWMOD_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	-- When arrow is away from player (after 0.2 seconds): Cause damage to mobs and players
	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()-ARROW_DAMAGE)
			if obj:get_entity_name() ~= "rainbowmod:arrow_entity" then
				if obj:get_hp()<=0 then 
					obj:remove()
				end
				self.object:remove() 
			end
		end
	end

	-- Become item when hitting a node
	if self.lastpos.x~=nil then --If there is no lastpos for some reason
		if node.name ~= "air" then
			minetest.env:add_item(self.lastpos, 'rainbowmod:pie_preparation')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Item will be added at last pos outside the node
end

minetest.register_entity("rainbowmod:arrow_entity", RAINBOWMOD_ARROW_ENTITY)



--CRAFTS
minetest.register_craft({
	output = 'rainbowmod:pie_preparation',
	recipe = {
		{'default:wood'},
		{'default:wood'},
	}
})

minetest.register_craft({
	output = 'rainbowmod:pie_terminator',
	recipe = {
		{'default:wood', 'default:wood', ''},
		{'', '', 'default:wood'},
		{'default:wood', 'default:wood', ''},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "rainbowmod:arrow",
	recipe = "rainbowmod:pie_preparation",
	cooktime = 10,
})





