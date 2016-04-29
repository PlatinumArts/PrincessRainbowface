--Snow War, Technically add snowballs to the game, that are throwable!
SNOWBALL_DAMAGE=1
SNOWBALL_GRAVITY=9
SNOWBALL_VELOCITY=19

rainbowmod_shoot_snowball=function (item, player, pointed_thing)
	-- Check if arrows in Inventory and remove one of them
	local i=1
	if player:get_inventory():contains_item("main", "rainbowmod:snowball") then
		player:get_inventory():remove_item("main", "rainbowmod:snowball")
		-- Shoot Arrow
		local playerpos=player:getpos()
		local obj=minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "rainbowmod:snowball_entity")
		local dir=player:get_look_dir()
		obj:setvelocity({x=dir.x*SNOWBALL_VELOCITY, y=dir.y*SNOWBALL_VELOCITY, z=dir.z*SNOWBALL_VELOCITY})
		obj:setacceleration({x=dir.x*-3, y=-SNOWBALL_GRAVITY, z=dir.z*-3})
	end
	return
end

minetest.register_craftitem("rainbowmod:pie_preparation", {
  description = "Vanilla To Preparate A Pie (Cook this to get a pie)",
	inventory_image = "pie_van.png",
})

minetest.register_craftitem("rainbowmod:glove", {
  description = "Glove (Right Click To Throw A Snowball)",
	inventory_image = "snowball_thrower.png",
    stack_max = 1,
	on_use = rainbowmod_shoot_snowball,
})

minetest.register_craftitem("rainbowmod:snowball", {
	description = "SnowBall (Use glove to throw)",
	inventory_image = "snowball.png"
})

-- The Arrow Entity

RAINBOWMOD_SNOWBALL_ENTITY={
	physical = false,
	timer=0,
	textures = {"snowball_back.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}


-- Arrow_entity.on_step()--> called when arrow is moving
RAINBOWMOD_SNOWBALL_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	-- When arrow is away from player (after 0.2 seconds): Cause damage to mobs and players
	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()-SNOWBALL_DAMAGE)
			if obj:get_entity_name() ~= "rainbowmod:snowball_entity" then
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
			minetest.env:add_item(self.lastpos, 'default:snow')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Item will be added at last pos outside the node
end

minetest.register_entity("rainbowmod:snowball_entity", RAINBOWMOD_SNOWBALL_ENTITY)



--CRAFTS

minetest.register_craft({
	output = 'rainbowmod:snowball',
	recipe = {
		{'default:snow', '', ''},
		{'default:snow', '', ''},
		{'', '', ''},
	}
})

minetest.register_craft({
	output = 'rainbowmod:glove',
	recipe = {
		{'farming:cotton', 'farming:cotton', 'farming:cotton'},
		{'farming:cotton', 'farming:cotton', 'farming:cotton'},
		{'', 'farming:cotton', ''},
	}
})
