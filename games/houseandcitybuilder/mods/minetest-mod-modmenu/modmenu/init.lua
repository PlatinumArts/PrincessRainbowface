--Modmenu - Simple menu for mod actions
--inventory_plus compatibility wrapper for use with modmenu

--DO WHAT YOU WANT TO PUBLIC LICENSE
--or DWYWPL
--December 2nd 2015
--License Copyright (C) 2015 Michael Tomaino (PlatinumArts@gmail.com)
--http://www.sandboxgamemaker.com/dwywpl/

modmenu = {}
modmenu.users = {}

--Adds a button to a player's menu
--Parameters:
--	name - name of player to add the button for
--	button_name - name that will be submitted in fields.*
--	button_text - label for the button in the menu
modmenu.add_button = function(name, button_name, button_text)
	--Don't crash if user doesn't have any buttons yet
	if modmenu.users[name] == nil then
		modmenu.users[name] = {}
	end
	modmenu.users[name][button_name] = button_text
end

--Builds the formspec to display
--Use modmenu.show_menu() in other mods instead (if needed)
modmenu.get_formspec = function(name)
	local spec = "size[3,8;]label[1,0;Menu]"
	local pos = 1
	if modmenu.users[name] ~= nil then
		for btn_name,btn_txt in pairs((modmenu.users[name])) do
			spec = spec .. "button[0," .. pos ..";3,1;" .. btn_name .. ";" .. btn_txt .. "]"
			pos = pos + 1
		end
	end
	spec = spec .. "button_exit[0," .. pos .. ";3,1;close;Close]"
	return spec
end

--Shows the menu to a player
--Parameters:
--	name: name of player who will be shown the menu
modmenu.show_menu = function(name)
	minetest.show_formspec(name, "modmenu", modmenu.get_formspec(name))
end

--Register the /m command to show the menu
minetest.register_chatcommand("m", {
	description = "Show a menu for various actions",
	func = function(name, param)
		modmenu.show_menu(name)
	end,
})
