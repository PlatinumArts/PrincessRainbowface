MAGICDUST_DAMAGE=1
MAGICDUST_GRAVITY=9
MAGICDUST_VELOCITY=19

lovemod_shoot_magicdust=function (item, player, pointed_thing)
	-- Check if arrows in Inventory and remove one of them
	local i=1
	if player:get_inventory():contains_item("main", "lovemod:magicdust") then
		player:get_inventory():remove_item("main", "lovemod:magicdust")
		-- Shoot Arrow
		local playerpos=player:getpos()
		local obj=minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "lovemod:magicdust_entity")
		local dir=player:get_look_dir()
		obj:setvelocity({x=dir.x*MAGICDUST_VELOCITY, y=dir.y*MAGICDUST_VELOCITY, z=dir.z*MAGICDUST_VELOCITY})
		obj:setacceleration({x=dir.x*-3, y=-MAGICDUST_GRAVITY, z=dir.z*-3})
	end
	return
end

minetest.register_craftitem("lovemod:magicdust_used", {
  description = "Useless Magic Dust",
	inventory_image = "used_magicdust.png",
	on_use = minetest.chat_send_player("singleplayer", "Hi, i'm the used magic dust!"),
	minetest.chat_send_player("singleplayer", "You are filled with determination after hear this, you want to continue playing!")
})

minetest.register_craftitem("lovemod:magic_wand", {
  description = "Magic Wand",
	inventory_image = "magic_wand.png",
    stack_max = 1,
	on_use = lovemod_shoot_magicdust,
})

minetest.register_craftitem("lovemod:magicdust", {
	description = "Magic Dust",
	inventory_image = "magicdust.png",
	on_use = function(itemstack, user, pointed_thing)
		hp_change = 20
		replace_with_item = "lovemod:magicdust_used"

		minetest.chat_send_player(user:get_player_name(), "You ate the Magic Dust, you recovered all your health, but you're having a stomach ache and you feel weird!")

		-- Support for hunger mods using minetest.register_on_item_eat
		for _ , callback in pairs(minetest.registered_on_item_eats) do
			local result = callback(hp_change, replace_with_item, itemstack, user, pointed_thing)
			if result then
				return result
			end
		end

		if itemstack:take_item() ~= nil then
			user:set_hp(user:get_hp() + hp_change)
		end

		return itemstack
	end
})
})

-- The Arrow Entity

LOVEMOD_MAGICDUST_ENTITY={
	physical = false,
	timer=0,
	textures = {"magicdust_back.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}


-- magicdust_entity.on_step()--> called when arrow is moving
LOVEMOD_MAGICDUST_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	-- When arrow is away from player (after 0.2 seconds): Cause damage to mobs and players
	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()-MAGICDUST_DAMAGE)
			if obj:get_entity_name() ~= "lovemod:magicdust_entity" then
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
			minetest.env:add_item(self.lastpos, 'lovemod:magicdust_used')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Item will be added at last pos outside the node
end

minetest.register_entity("lovemod:magicdust_entity", LOVEMOD_MAGICDUST_ENTITY)
