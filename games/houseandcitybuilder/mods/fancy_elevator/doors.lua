elevator_doors = {}

-- Registers a door
-- name: The name of the door
-- def: a table with the folowing fields:
-- description
-- inventory_image
-- groups
-- tiles_bottom: the tiles of the bottom part of the door {front, side}
-- tiles_top: the tiles of the bottom part of the door {front, side}
-- If the following fields are not defined the default values are used
-- node_box_bottom
-- node_box_top
-- selection_box_bottom
-- selection_box_top
-- only_placer_can_open: if true only the player who placed the door can
-- open it
-- time_until_close: Time in seconds until the door will automatic close

function elevator_doors.register_door(name, def)
	def.groups.not_in_creative_inventory = 1
	local box = {{-0.5, -0.5, -0.5, 0.5, 0.5, -0.5+1.5/16}}
	if not def.node_box_bottom then
		def.node_box_bottom = box
	end
	if not def.node_box_top then
		def.node_box_top = box
	end
	if not def.selection_box_bottom then
		def.selection_box_bottom= box
	end
	if not def.selection_box_top then
		def.selection_box_top = box
	end
	if not def.sound_close_door then
		def.sound_close_door = "door_close"
	end
	if not def.sound_open_door then
		def.sound_open_door = "door_open"
	end
	if not def.time_until_close then
		def.time_until_close = 15
	end
	
	elevator_doors[name] = def
	
	minetest.register_craftitem(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		on_place = function(itemstack, placer, pointed_thing)
			if not pointed_thing.type == "node" then
				return itemstack
			end
			local ptu = pointed_thing.under
			local nu = minetest.get_node(ptu)
			if minetest.registered_nodes[nu.name].on_rightclick then
				return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
			end
			local pt = pointed_thing.above
			local pt2 = {x=pt.x, y=pt.y, z=pt.z}
			pt2.y = pt2.y+1
			if
				not minetest.registered_nodes[minetest.get_node(pt).name].buildable_to or
				not minetest.registered_nodes[minetest.get_node(pt2).name].buildable_to or
				not placer or
				not placer:is_player()
			then
				return itemstack
			end
			if minetest.is_protected(pt, placer:get_player_name()) or
			minetest.is_protected(pt2, placer:get_player_name()) then
				minetest.record_protection_violation(pt, placer:get_player_name())
				return itemstack
			end
			local p2 = minetest.dir_to_facedir(placer:get_look_dir())
			local pt3 = {x=pt.x, y=pt.y, z=pt.z}
			if p2 == 0 then
				pt3.x = pt3.x-1
			elseif p2 == 1 then
				pt3.z = pt3.z+1
			elseif p2 == 2 then
				pt3.x = pt3.x+1
			elseif p2 == 3 then
				pt3.z = pt3.z-1
			end
			if minetest.get_item_group(minetest.get_node(pt3).name, "door") == 0 then
				minetest.set_node(pt, {name=name.."_b_1", param2=p2})
				minetest.set_node(pt2, {name=name.."_t_1", param2=p2})
			else
				minetest.set_node(pt, {name=name.."_b_2", param2=p2})
				minetest.set_node(pt2, {name=name.."_t_2", param2=p2})
				minetest.get_meta(pt):set_int("right", 1)
				minetest.get_meta(pt2):set_int("right", 1)
			end
			if def.only_placer_can_open then
				local pn = placer:get_player_name()
				local meta = minetest.get_meta(pt)
				meta:set_string("doors_owner", pn)
				meta = minetest.get_meta(pt2)
				meta:set_string("doors_owner", pn)
			end
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
	})

	local tt = def.tiles_top
	local tb = def.tiles_bottom
	local function after_dig_node(pos, name, digger)
		local node = minetest.get_node(pos)
		if node.name == name then
			minetest.node_dig(pos, node, digger)
		end
	end
	
	local function check_player_priv(pos, player)
		if not def.only_placer_can_open then
			return true
		end
		local meta = minetest.get_meta(pos)
		local pn = player:get_player_name()
		return meta:get_string("doors_owner") == pn
	end
	
	--bottom elements of doors get the group elevator_door
	def.groups.elevator_door = 1
	minetest.register_node(name.."_b_1", {
		tiles = {tb[2], tb[2], tb[2], tb[2], tb[1], tb[1].."^[transformfx"},
		paramtype = "light",
		paramtype2 = "facedir",
		drop = name,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_bottom
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_bottom
		},
		groups = def.groups,
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			pos.y = pos.y+1
			after_dig_node(pos, name.."_t_1", digger)
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_int("door_status", 0)
			elevator_doors.set_formspec(meta)
			meta:set_string("infotext", "\"\"")
			meta:set_string("calling", "false")
			meta:set_int("order",-1)
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			local meta = minetest.get_meta(pos)
			pos.y = pos.y+1
			local meta2 = minetest.get_meta(pos)
			if fields.text and fields.text ~= meta:get_string("text") then 
				if minetest.is_protected(pos, sender:get_player_name()) then
					minetest.record_protection_violation(pos, sender:get_player_name())
				else
					minetest.log("action", (sender:get_player_name() or "").." wrote \""..fields.text..
					"\" to elevator at "..minetest.pos_to_string(pos))
					meta:set_string("text", fields.text)
					meta:set_string("infotext", '"'..fields.text..'"')
					meta2:set_string("text", fields.text)
					meta2:set_string("infotext", '"'..fields.text..'"')
				end
			end
		
			pos.y = pos.y-1		
			if fields.call ~= nil then
				elevator_func:add_calling(pos)
			end
			
			if fields.open ~= nil then
				if check_player_priv(pos, sender) then
					elevator_doors.open_door(pos, 1, name, name.."_t_1", name.."_b_2", name.."_t_2", {1,2,3,0})
				else
					minetest.chat_send_player(sender:get_player_name(),"Only "..meta:get_string("doors_owner").." can open this door")
				end
			end
		end,
		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight
	})
	
	def.groups.elevator_door = 0
	minetest.register_node(name.."_t_1", {
		tiles = {tt[2], tt[2], tt[2], tt[2], tt[1], tt[1].."^[transformfx"},
		paramtype = "light",
		paramtype2 = "facedir",
		drop = "",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_top
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_top
		},
		groups = def.groups,
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			pos.y = pos.y-1
			after_dig_node(pos, name.."_b_1", digger)
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_int("door_status", 0)
			elevator_doors.set_formspec(meta)
			meta:set_string("infotext", "\"\"")
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			local meta = minetest.get_meta(pos)
			pos.y = pos.y-1
			local meta2 = minetest.get_meta(pos)
			if fields.text and fields.text ~= meta:get_string("text") then
				if minetest.is_protected(pos, sender:get_player_name()) then
					minetest.record_protection_violation(pos, sender:get_player_name())
				else
					minetest.log("action", (sender:get_player_name() or "").." wrote \""..fields.text..
					"\" to elevator at "..minetest.pos_to_string(pos))
					meta:set_string("text", fields.text)
					meta:set_string("infotext", '"'..fields.text..'"')
					meta2:set_string("text", fields.text)
					meta2:set_string("infotext", '"'..fields.text..'"')
				end
			end
			
			if fields.call ~= nil then
				elevator_func:add_calling(pos)
			end
			pos.y = pos.y+1
			if fields.open ~= nil then
				if check_player_priv(pos, sender) then
					elevator_doors.open_door(pos, -1, name, name.."_b_1", name.."_t_2", name.."_b_2", {1,2,3,0})
				else
					minetest.chat_send_player(sender:get_player_name(),"Only "..meta:get_string("doors_owner").." can open this door")
				end
			end
		end,
		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight,
	})
	
	def.groups.elevator_door = 1
	minetest.register_node(name.."_b_2", {
		tiles = {tb[2], tb[2], tb[2], tb[2], tb[1].."^[transformfx", tb[1]},
		paramtype = "light",
		paramtype2 = "facedir",
		drop = name,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box_bottom
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_bottom
		},
		groups = def.groups,
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			pos.y = pos.y+1
			after_dig_node(pos, name.."_t_2", digger)
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_int("door_status", 0)
			elevator_doors.set_formspec(meta)
			meta:set_string("infotext", "\"\"")
			meta:set_string("calling", "false")
			meta:set_int("order",-1)
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			local meta = minetest.get_meta(pos)
			pos.y = pos.y+1
			local meta2 = minetest.get_meta(pos)
			if fields.text and fields.text ~= meta:get_string("text") then 
				if minetest.is_protected(pos, sender:get_player_name()) then
					minetest.record_protection_violation(pos, sender:get_player_name())
				else
					minetest.log("action", (sender:get_player_name() or "").." wrote \""..fields.text..
					"\" to elevator at "..minetest.pos_to_string(pos))
					meta:set_string("text", fields.text)
					meta:set_string("infotext", '"'..fields.text..'"')
					meta2:set_string("text", fields.text)
					meta2:set_string("infotext", '"'..fields.text..'"')
				end
			end
		
			pos.y = pos.y-1
			if fields.call ~= nil then
				elevator_func:add_calling(pos)
			end
			
			if fields.open ~= nil then
				if check_player_priv(pos, sender) then
					elevator_doors.open_door(pos, 1, name, name.."_t_2", name.."_b_1", name.."_t_1", {3,0,1,2})
				else
					minetest.chat_send_player(sender:get_player_name(),"Only "..meta:get_string("doors_owner").." can open this door")
				end
			end
		end,
		on_timer = function(pos, elapsed)
			local meta = minetest.get_meta(pos)
			if meta:get_int("door_status") == 1 then
				elevator_doors.open_door(pos, 1, name, name.."_t_2", name.."_b_1", name.."_t_1", {3,0,1,2}, 0)
			end
		end,
		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight
	})
	
	def.groups.elevator_door = 0
	minetest.register_node(name.."_t_2", {
		tiles = {tt[2], tt[2], tt[2], tt[2], tt[1].."^[transformfx", tt[1]},
		paramtype = "light",
		paramtype2 = "facedir",
		drop = "",
		drawtype = "nodebox",
		node_box = {
		type = "fixed",
			fixed = def.node_box_top
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box_top
		},
		groups = def.groups,
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			pos.y = pos.y-1
			after_dig_node(pos, name.."_b_2", digger)
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_int("door_status", 0)
			elevator_doors.set_formspec(meta)
			meta:set_string("infotext", "\"\"")
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			local meta = minetest.get_meta(pos)
			pos.y = pos.y-1
			local meta2 = minetest.get_meta(pos)
			if fields.text and fields.text ~= meta:get_string("text") then
				if minetest.is_protected(pos, sender:get_player_name()) then
					minetest.record_protection_violation(pos, sender:get_player_name())
				else
					minetest.log("action", (sender:get_player_name() or "").." wrote \""..fields.text..
					"\" to elevator at "..minetest.pos_to_string(pos))
					meta:set_string("text", fields.text)
					meta:set_string("infotext", '"'..fields.text..'"')
					meta2:set_string("text", fields.text)
					meta2:set_string("infotext", '"'..fields.text..'"')
				end
			end
		
			if fields.call ~= nil then
				elevator_func:add_calling(pos)
			end
			pos.y = pos.y+1
			if fields.open ~= nil then
				if check_player_priv(pos, sender) then
					elevator_doors.open_door(pos, -1, name, name.."_b_2", name.."_t_1", name.."_b_1", {3,0,1,2})
				else
					minetest.chat_send_player(sender:get_player_name(),"Only "..meta:get_string("doors_owner").." can open this door")
				end
			end
		end,
		can_dig = check_player_priv,
		sounds = def.sounds,
		sunlight_propagates = def.sunlight
	})
end

-- door_status:  0 = closed
--				 1 = open
function elevator_doors.open_door(pos, dir, name, check_name, replace, replace_dir, params, door_status)
	pos.y = pos.y+dir
	local meta = minetest.get_meta(pos)
	if not minetest.get_node(pos).name == check_name then
		return
	end
	local door_status_is = meta:get_int("door_status")
	if door_status_is == door_status then
		return
	end
	local p2 = minetest.get_node(pos).param2
	p2 = params[p2+1]
	minetest.swap_node(pos, {name=replace_dir, param2=p2})
	pos.y = pos.y-dir
	local meta2 = minetest.get_meta(pos)
	minetest.swap_node(pos, {name=replace, param2=p2})
	
	local def = elevator_doors[name]
	
	local snd_1 = def.sound_close_door
	local snd_2 = def.sound_open_door
	if params[1] == 3 then
		snd_1 = def.sound_open_door
		snd_2 = def.sound_close_door
	end
	
	if dir == -1 then
		pos.y = pos.y+dir
	end
	
	if door_status_is == 1 then
		meta:set_int("door_status", 0)
		meta2:set_int("door_status", 0)
		elevator_func:organice(pos)
	else
		meta:set_int("door_status", 1)
		meta2:set_int("door_status", 1)
		local timer = minetest.get_node_timer(pos)
		timer:set(def.time_until_close,0)
	end
	
	elevator_doors.set_formspec(meta)
	elevator_doors.set_formspec(meta2)
	
	if minetest.get_meta(pos):get_int("right") ~= 0 then
		minetest.sound_play(snd_1, {pos = pos, gain = 0.3, max_hear_distance = 10})
	else
		minetest.sound_play(snd_2, {pos = pos, gain = 0.3, max_hear_distance = 10})
	end
end

function elevator_doors.get_door_status(pos)
	local meta = minetest.get_meta(pos)
	return meta:get_int("door_status")
end

function elevator_doors.set_formspec(meta)
	local status = meta:get_int("door_status")
	if status == 1 then
		meta:set_string("formspec", "size[6,3] field[1,1;4,1;text;;${text}]"..
				"button_exit[0,2;2,1;call;Call elevator]"..
				"button_exit[2,2;2,1;open;Close]"..
				"button_exit[4,2;2,1;exit;Exit]")
	else
		meta:set_string("formspec", "size[6,3] field[1,1;4,1;text;;${text}]"..
				"button_exit[0,2;2,1;call;Call elevator]"..
				"button_exit[2,2;2,1;open;Force open]"..
				"button_exit[4,2;2,1;exit;Exit]")
	end
end
