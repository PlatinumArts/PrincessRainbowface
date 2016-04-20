---items.lua doing the items code easier since 2011!

minetest.register_tool("rainbowmod:magic_wand_piece", {
   description = "Magic Wand Piece",
   inventory_image = "magic_wand_piece.png",
   stack_max = 9,
})


---Ice Cream, Better don't let it melts! (it doesn't so it's the perfect ice cream!)

minetest.register_craftitem("rainbowmod:ice_cream_a", {
	description = "Ice Cream Cone",
	inventory_image = "ice_cream_cone.png",
	on_use = function(itemstack, user, pointed_thing)
		hp_change = 3
		replace_with_item = nil

		minetest.chat_send_player(user:get_player_name(), "This Ice Cream Cone it's delicious! Yum Yum!")

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

minetest.register_craftitem("rainbowmod:ice_cream_b", {
	description = "Cookie Ice Cream",
	inventory_image = "ice_cream_cookie.png",
	on_use = function(itemstack, user, pointed_thing)
		hp_change = 4
		replace_with_item = nil

		minetest.chat_send_player(user:get_player_name(), "This Cookie Ice Cream it's delicious! Yum Yum!")
	

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

minetest.register_craftitem("rainbowmod:ice_cream_c", {
	description = "Popsicle",
	inventory_image = "popsicle.png",
	on_use = function(itemstack, user, pointed_thing)
		hp_change = 2
		replace_with_item = nil

		minetest.chat_send_player(user:get_player_name(), "This Popsicle it's delicious! Yum Yum!")

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

---There are many ice cream flavors to do from this one!
---Exactly seven from this three, that means:21 Icecreams to taste!

minetest.register_node("rainbowmod:easter_egg_a", {
	description = "Easter Egg Blue-Yellow",
	drawtype = "plantlike",
	tiles = { "easter_egg_a.png" },
	inventory_image = "easter_egg_a.png",
	wield_image = "easter_egg_a.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,attached_node=1},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.2, 0.5 },
	},
})

minetest.register_node("rainbowmod:easter_egg_b", {
	description = "Easter Egg Red-Yellow",
	drawtype = "plantlike",
	tiles = { "easter_egg_b.png" },
	inventory_image = "easter_egg_b.png",
	wield_image = "easter_egg_b.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,attached_node=1},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.2, 0.5 },
	},
})

minetest.register_node("rainbowmod:easter_egg_c", {
	description = "Easter Egg Blue-Red",
	drawtype = "plantlike",
	tiles = { "easter_egg_c.png" },
	inventory_image = "easter_egg_c.png",
	wield_image = "easter_egg_c.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,attached_node=1},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.2, 0.5 },
	},
})

--Golden Easter Egg! (Very preciable!)


minetest.register_node("rainbowmod:easter_egg_d", {
	description = "Test Easter Egg",
	drawtype = "plantlike",
	tiles = { "easter_egg_d.png" },
	inventory_image = "easter_egg_d.png",
	wield_image = "easter_egg_d.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,attached_node=1},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.2, 0.5 },
	on_use = function(itemstack, user, pointed_thing)
	hp_change = 20
	replace_with_item = nil

		minetest.chat_send_player(user:get_player_name(), "Easter Egg Test!")


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
	},
})