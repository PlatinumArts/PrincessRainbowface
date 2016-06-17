--Alphynium Ore
minetest.register_craftitem("default:alphynium_ore", {
	description = "Alphynium Ore",
	inventory_image = "alphynium_ore.png"
})

--Spagghetti
minetest.register_craftitem("default:pasta", {
	description = "Spagghetti",
	inventory_image = "pasta.png",
	on_use = minetest.item_eat(7)
})

--Potato
minetest.register_craftitem("default:potato", {
	description = "¡Potato!",
	inventory_image = "potato.png",
	on_use = minetest.item_eat(20)
})

--Coffee
minetest.register_craftitem("default:coffee_", {
	description = "Coffee_",
	inventory_image = "coffee_.png",
	on_use = function(itemstack, user, pointed_thing)
		hp_change = 3
		replace_with_item = nil

		minetest.chat_send_player(user:get_player_name(), "Loving the coffee, tasting the coffee, fixing the bugs in the code of the coffee")

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
