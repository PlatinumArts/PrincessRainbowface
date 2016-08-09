--inventory_plus compatibility wrapper for use with modmenu

--DO WHAT YOU WANT TO PUBLIC LICENSE
--or DWYWPL

--December 2nd 2015
--License Copyright (C) 2015 Michael Tomaino (PlatinumArts@gmail.com)
--http://www.sandboxgamemaker.com/dwywpl/

--1. You are allowed to do whatever you want to with whatever is being licensed by this license!

inventory_plus = {}

inventory_plus.set_inventory_formspec = function(player, formspec)
	minetest.show_formspec(player:get_player_name(), "custom", formspec)
end

inventory_plus.register_button = function(player, button_name, button_text)
	modmenu.add_button(player:get_player_name(), button_name, button_text)
end

--handle the "Back" button on inv. plus forms (such as skins/3d armor)
minetest.register_on_player_receive_fields(function(player,formname,fields)
	if fields.main then
		modmenu.show_menu(player:get_player_name())
	end
end)
