---Tea Party, code for this features, also i add cookies! (join the Minetest side, we have cookies!)

--This is mah Cookie!

-- add the mugs!

minetest.register_craftitem("rainbowmod:cookies", {
	description = "Cookie",
	inventory_image = "mah_cookie.png",
	on_use = function(itemstack, user, pointed_thing)
		hp_change = 5
		replace_with_item = nil

		minetest.chat_send_player(user:get_player_name(), "Cookie!")

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


minetest.register_craftitem("rainbowmod:tea_cup", {
	description = "Tea Cup (Without Tea)",
	inventory_image = "tea_cup.png"
})

minetest.register_craftitem("rainbowmod:tea_mug", {
	description = "Tea Mug (Without Tea)",
	inventory_image = "tea_mug.png"
})


