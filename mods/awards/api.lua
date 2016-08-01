-- AWARDS
--
-- Copyright (C) 2013-2015 rubenwardy
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License as published by
-- the Free Software Foundation; either version 2.1 of the License, or
-- (at your option) any later version.
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
-- You should have received a copy of the GNU Lesser General Public License along
-- with this program; if not, write to the Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
--

-- The global award namespace
awards = {
	show_mode = "hud"
}
dofile(minetest.get_modpath("awards").."/api_helpers.lua")

-- Table Save Load Functions
function awards.save()
	local file = io.open(minetest.get_worldpath().."/awards.txt", "w")
	if file then
		file:write(minetest.serialize(awards.players))
		file:close()
	end
end

local S = function(s) return s end
function awards.set_intllib(locale)
	S = locale
end

function awards.init()
	awards.players = awards.load()
	awards.def = {}
	awards.trigger_types = {}
	awards.on = {}
	awards.on_unlock = {}
end

function awards.load()
	local file = io.open(minetest.get_worldpath().."/awards.txt", "r")
	if file then
		local table = minetest.deserialize(file:read("*all"))
		if type(table) == "table" then
			return table
		end
	end
	return {}
end

function awards.register_trigger(name, func)
	awards.trigger_types[name] = func
	awards.on[name] = {}
	awards['register_on_'..name] = function(func)
		table.insert(awards.on[name], func)
	end
end

function awards.run_trigger_callbacks(player, data, trigger, table_func)
	for i = 1, #awards.on[trigger] do
		local res = nil
		local entry = awards.on[trigger][i]
		if type(entry) == "function" then
			res = entry(player, data)
		elseif type(entry) == "table" and entry.award then
			res = table_func(entry)
		end

		if res then
			awards.unlock(player:get_player_name(), res)
		end
	end
end

function awards.increment_item_counter(data, field, itemname)
	local name_split = string.split(itemname, ":")
	if #name_split ~= 2 then
		return false
	end
	local mod = name_split[1]
	local item = name_split[2]

	if data and field and mod and item then
		awards.assertPlayer(data)
		awards.tbv(data, field)
		awards.tbv(data[field], mod)
		awards.tbv(data[field][mod], item, 0)

		data[field][mod][item] = data[field][mod][item] + 1
		return true
	else
		return false
	end
end

function awards.register_on_unlock(func)
	table.insert(awards.on_unlock, func)
end

-- API Functions
function awards._additional_triggers(name, def)
	-- Depreciated!
end

function awards.register_achievement(name, def)
	def.name = name

	-- Add Triggers
	if def.trigger and def.trigger.type then
		local func = awards.trigger_types[def.trigger.type]

		if func then
			func(def)
		else
			awards._additional_triggers(name, def)
		end
	end

	-- Add Award
	awards.def[name] = def
end

function awards.enable(name)
	local data = awards.player(name)
	if data then
		data.disabled = nil
	end
end

function awards.disable(name)
	local data = awards.player(name)
	if data then
		data.disabled = true
	end
end

function awards.clear_player(name)
	awards.players[name] = nil
end

-- This function is called whenever a target condition is met.
-- It checks if a player already has that achievement, and if they do not,
-- it gives it to them
----------------------------------------------
--awards.unlock(name, award)
-- name - the name of the player
-- award - the name of the award to give
function awards.unlock(name, award)
	-- Access Player Data
	local data  = awards.players[name]
	local awdef = awards.def[award]

	-- Perform checks
	if not data then
		return
	end
	if not awdef then
		return
	end
	if data.disabled then
		return
	end
	awards.tbv(data,"unlocked")

	-- Don't give the achievement if it has already been given
	if data.unlocked[award] and data.unlocked[award] == award then
		return
	end

	-- Unlock Award
	minetest.log("action", name.." has unlocked award "..name)
	data.unlocked[award] = award
	awards.save()

	-- Give Prizes
	if awdef and awdef.prizes then
		for i = 1, #awdef.prizes do
			local itemstack = ItemStack(awdef.prizes[i])
			if not itemstack:is_empty() then
				local receiverref = minetest.get_player_by_name(name)
				if receiverref then
					receiverref:get_inventory():add_item("main", itemstack)
				end
			end
		end
	end

	-- Run callbacks
	if awdef.on_unlock and awdef.on_unlock(name, awdef) then
		return
	end
	for _, callback in pairs(awards.on_unlock) do
		if callback(name, awdef) then
			return
		end
	end

	-- Get Notification Settings
	local title = awdef.title or award
	local desc = awdef.description or ""
	local background = awdef.background or "bg_default.png"
	local icon = awdef.icon or "unknown.png"
	local custom_announce = awdef.custom_announce or S("Achievement Unlocked:")

	-- Do Notification
	if awards.show_mode == "formspec" then
		-- use a formspec to send it
		minetest.show_formspec(name, "achievements:unlocked", "size[4,2]"..
				"image_button_exit[0,0;4,2;"..background..";close1; ]"..
				"image_button_exit[0.2,0.8;1,1;"..icon..";close2; ]"..
				"label[1.1,1;"..title.."]"..
				"label[0.3,0.1;"..custom_announce.."]")
	elseif awards.show_mode == "chat" then
		-- use the chat console to send it
		minetest.chat_send_player(name, S("Achievement Unlocked:")..title)
		if desc~="" then
			minetest.chat_send_player(name, desc)
		end
	else
		local player = minetest.get_player_by_name(name)
		local one = player:hud_add({
			hud_elem_type = "image",
			name = "award_bg",
			scale = {x = 1, y = 1},
			text = background,
			position = {x = 0.5, y = 0},
			offset = {x = 0, y = 138},
			alignment = {x = 0, y = -1}
		})
		local two = player:hud_add({
			hud_elem_type = "text",
			name = "award_au",
			number = 0xFFFFFF,
			scale = {x = 100, y = 20},
			text = "Achievement Unlocked!",
			position = {x = 0.5, y = 0},
			offset = {x = 0, y = 40},
			alignment = {x = 0, y = -1}
		})
		local three = player:hud_add({
			hud_elem_type = "text",
			name = "award_title",
			number = 0xFFFFFF,
			scale = {x = 100, y = 20},
			text = title,
			position = {x = 0.5, y = 0},
			offset = {x = 30, y = 100},
			alignment = {x = 0, y = -1}
		})
		local four = player:hud_add({
			hud_elem_type = "image",
			name = "award_icon",
			scale = {x = 4, y = 4},
			text = icon,
			position = {x = 0.5, y = 0},
			offset = {x = -81.5, y = 126},
			alignment = {x = 0, y = -1}
		})
		minetest.after(3, function()
			player:hud_remove(one)
			player:hud_remove(two)
			player:hud_remove(three)
			player:hud_remove(four)
		end)
	end
end

-- Backwards compatibility
awards.give_achievement = awards.unlock

--[[minetest.register_chatcommand("gawd", {
	params = "award name",
	description = "gawd: give award to self",
	func = function(name, param)
		awards.unlock(name,param)
	end
})]]--

function awards.getFormspec(name, to, sid)
	local formspec = "size[11,5]"
	local listofawards = awards._order_awards(name)

	-- Sidebar
	if sid then
		local item = listofawards[sid+0]
		local def = awards.def[item.name]
		if def and def.secret and not item.got then
			formspec = formspec .. "label[1,2.75;Secret Award]"..
								"image[1,0;3,3;unknown.png]"
			if def and def.description then
				formspec = formspec	.. "label[0,3.25;Unlock this award to find out what it is]"
			end
		else
			local title = item.name
			if def and def.title then
				title = def.title
			end
			local status = ""
			if item.got then
				status = " (got)"
			end
			formspec = formspec .. "label[1,2.75;" .. title .. status .. "]"
			if def and def.icon then
				formspec = formspec .. "image[1,0;3,3;" .. def.icon .. "]"
			end
			if def and def.description then
				formspec = formspec	.. "label[0,3.25;"..def.description.."]"
			end
		end
	end

	-- Create list box
	formspec = formspec .. "textlist[4.75,0;6,5;awards;"
	local first = true
	for _,award in pairs(listofawards) do
		local def = awards.def[award.name]
		if def then
			if not first then
				formspec = formspec .. ","
			end
			first = false

			if def.secret and not award.got then
				formspec = formspec .. "#ACACACSecret Award"
			else
				local title = award.name
				if def and def.title then
					title = def.title
				end
				if award.got then
					formspec = formspec .. minetest.formspec_escape(title)
				else
					formspec = formspec .. "#ACACAC".. minetest.formspec_escape(title)
				end
			end
		end
	end
	return formspec .. ";"..sid.."]"
end

function awards.show_to(name, to, sid, text)
	if name == "" or name == nil then
		name = to
	end
	if name == to and awards.player(to).disabled then
		minetest.chat_send_player("You've disabled awards. Type /awards" ..
				" enable to reenable")
		return
	end
	if text then
		if not awards.players[name] or not awards.players[name].unlocked  then
			minetest.chat_send_player(to, "You have not unlocked any awards")
			return
		end
		minetest.chat_send_player(to, name.."'s awards:")

		for _, str in pairs(awards.players[name].unlocked) do
			local def = awards.def[str]
			if def then
				if def.title then
					if def.description then
						minetest.chat_send_player(to, def.title..": "..def.description)
					else
						minetest.chat_send_player(to, def.title)
					end
				else
					minetest.chat_send_player(to, str)
				end
			end
		end
	else
		if sid == nil or sid < 1 then
			sid = 1
		end
		-- Show formspec to user
		minetest.show_formspec(to,"awards:awards", awards.getFormspec(name, to, sid))
	end
end
awards.showto = awards.show_to

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "awards:awards" then
		return false
	end
	if fields.quit then
		return true
	end
	local name = player:get_player_name()
	if fields.awards then
		local event = minetest.explode_textlist_event(fields.awards)
		if event.type == "CHG" then
			awards.show_to(name, name, event.index, false)
		end
	end

	return true
end)

awards.init()

minetest.register_on_newplayer(function(player)
	local playern = player:get_player_name()
	awards.assertPlayer(playern)
end)

minetest.register_on_shutdown(function()
	awards.save()
end)
