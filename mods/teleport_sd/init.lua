teleport_sd = {
	min_x = -30900,
	min_y = -30900,
	min_z = -30900,
	max_x = 30900,
	max_y = 30900,
	max_z = 30900,

	particle_amount = 25,
	particle_time = 2,

	infotext_src_activate = '-- STAND ON and PUNCH to teleport --',
	infotext_dst_no_owner = '-- Teleport is allowed from ANY source teleporter --',

	msg_loading			= '[TELEPORT] Loading teleport destination, please wait...',
	msg_load_error		= '[TELEPORT] Unable to load teleport destination, giving up',
	msg_timer_error		= '[TELEPORT] Unable to get timer for teleport source node, giving up',
	msg_obstructed		= '[TELEPORT] Teleport destination is obstructed!',
	msg_owner_mismatch	= '[TELEPORT] Teleport destination has different owner than source',
	msg_no_dst_at		= '[TELEPORT] No teleport destination node found at ',

	timeout_wait = 30, -- [seconds] stop trying to load destination
	wait_queue = {} -- don't touch
}



-- Teleport Destination Block

minetest.register_node("teleport_sd:teleport_dst", {
	description = "Teleport Destination",
	tiles = {"teleport_sd_S.png"},
	sounds = default.node_sound_stone_defaults(),
	groups = {dig_immediate=2},
	paramtype = "light",
	light_source = 10,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		if meta ~= nil then
			meta:set_string("owner", placer:get_player_name() or "")
			meta:set_int("yaw", 0)
			teleport_sd.set_dst_infotext(meta, pos)
		end
	end,

	-- configure yaw and owner
	on_rightclick = function(pos, node, clicker, itemstack)
		if minetest.is_protected(pos, clicker:get_player_name()) then return end

		local meta = minetest.get_meta(pos)
		if meta ~= nil then
			local toggle_owner_button = nil
			if meta:get_string("owner") ~= "" then
				toggle_owner_button = "button_exit[0.1,2;7.8,0.5;clr_owner;Teleport is ONLY allowed from owner's source teleporters]"
					.."label[1,2.75;Owner: "..meta:get_string("owner").."]"
			else
				toggle_owner_button = "button_exit[0.75,2;6.5,0.5;set_owner;Teleport is allowed from ANY source teleporter]"
			end
			minetest.show_formspec(clicker:get_player_name(), "teleport_sd:node_"..minetest.pos_to_string(pos),
				"size[8,4.5]"..default.gui_bg..default.gui_bg_img
				.."label[1.3,0;Enter player's yaw after teleport (0 to 359)]"
				.."field[2.75,1;3,0.5;yaw;;"..meta:get_int("yaw").."]"
				..toggle_owner_button
				.."button_exit[0.95,4;3,0.5;save;Save]"
				.."button_exit[4.05,4;3,0.5;cancel;Cancel]")
		end
	end
})

minetest.register_craft({
	output = "teleport_sd:teleport_dst 2",
	recipe = {
		{"default:mese","default:diamondblock","default:mese"},
		{"default:diamondblock","default:obsidian","default:diamondblock"},
		{"default:mese","default:diamondblock","default:mese"},
	}
})



-- Teleport Source Block

minetest.register_node("teleport_sd:teleport_src", {
	description = "Teleport Source",
--	tiles = {"teleport_sd_U.png","teleport_sd_S.png","teleport_sd_S.png","teleport_sd_S.png","teleport_sd_S.png","teleport_sd_S.png"},
	tiles = {{name="teleport_sd_U_anim.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=4}},
			"teleport_sd_S.png","teleport_sd_S.png","teleport_sd_S.png","teleport_sd_S.png","teleport_sd_S.png"},
	sounds = default.node_sound_stone_defaults(),
	groups = {dig_immediate=2},
	paramtype = "light",
	light_source = 10,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		if meta ~= nil then
			teleport_sd.set_src_infotext(meta, pos, {x=0,y=0,z=0})
			meta:set_int("x", 0)
			meta:set_int("y", 0)
			meta:set_int("z", 0)
		end
	end,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		if meta ~= nil then
			meta:set_string("owner", placer:get_player_name() or "")
		end
	end,

	-- configure destination position
	on_rightclick = function(pos, node, clicker, itemstack)
		if minetest.is_protected(pos, clicker:get_player_name()) then return end

		local meta = minetest.get_meta(pos)
		if meta ~= nil then
			local change_owner_button = ""
			if meta:get_string("owner") ~= clicker:get_player_name() then
				change_owner_button = "button_exit[1,2;6,0.5;set_owner;Change Owner]"
			end
			minetest.show_formspec(clicker:get_player_name(), "teleport_sd:node_"..minetest.pos_to_string(pos),
				"size[8,4.5]"..default.gui_bg..default.gui_bg_img
				.."label[0.25,0;Enter coordinates of destination teleport node (e.g 100,20,-300)]"
				.."field[2.75,1;3,0.5;coords;;"..meta:get_int("x")..", "..meta:get_int("y")..", "..meta:get_int("z").."]"
				..change_owner_button
				.."label[1,2.75;Owner: "..meta:get_string("owner").."]"
				.."button_exit[0.95,4;3,0.5;save;Save]"
				.."button_exit[4.05,4;3,0.5;cancel;Cancel]")
		end
	end,

	-- activate teleport
	on_punch = function(pos, node, puncher)
		local meta = minetest.get_meta(pos)
		if meta ~= nil then
			local player_pos = puncher:getpos()
			if player_pos.y >= pos.y+0.5 and teleport_sd.round(player_pos.x) == pos.x and teleport_sd.round(player_pos.z) == pos.z then
				teleport_sd.teleport_player_to_dst(pos, puncher, {x=meta:get_int("x"), y=meta:get_int("y"), z=meta:get_int("z")}, 0)
			end
		end
	end,

	-- deferred teleport
	on_timer = function(pos, elapsed)
		local wait_longer = false

		-- get copy of wait queue for this node and clear original
		local pos_key = minetest.pos_to_string(pos)
		local wait_queue = teleport_sd.wait_queue[pos_key]
		teleport_sd.wait_queue[pos_key] = {}

		if wait_queue ~= nil then
			for i,waiter in pairs(wait_queue) do
				if minetest.get_player_by_name(waiter.player:get_player_name()) ~= nil then
					if teleport_sd.teleport_player_to_dst(pos, waiter.player, waiter.dst_pos, waiter.elapsed+elapsed) then
						-- teleport successful, remove forceloaders
						teleport_sd.remove_forceloaders(waiter.dst_pos)
--						minetest.chat_send_player(waiter.player:get_player_name(), '[TELEPORT] UN-LOAD')  
					else
						-- still waiting, keep the timer running
						wait_longer = true
					end
				else
					-- player quit, remove forceloaders
					teleport_sd.remove_forceloaders(waiter.dst_pos)
				end
			end
		end

		teleport_sd.remove_src_wait_queue_if_empty(pos)

		return wait_longer
	end,

	-- remove wait queue for this teleport source
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos_key = minetest.pos_to_string(pos)
		local wait_queue = teleport_sd.wait_queue[pos_key]
		if wait_queue ~= nil then
			for i,waiter in pairs(wait_queue) do
				teleport_sd.remove_forceloaders(waiter.dst_pos)
			end
		end
		teleport_sd.wait_queue[pos_key] = nil
	end
})

minetest.register_craft({
	output = "teleport_sd:teleport_src 1",
	recipe = {
		{"default:mese_crystal","default:mese_crystal","default:mese_crystal"},
		{"default:mese_crystal","teleport_sd:teleport_dst","default:mese_crystal"},
		{"default:mese_crystal","default:mese_crystal","default:mese_crystal"}
	}
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if string.sub(formname, 0, string.len("teleport_sd:node_")) ~= "teleport_sd:node_" then return end

	local pos_str = string.sub(formname, string.len("teleport_sd:node_")+1)
	local pos = minetest.string_to_pos(pos_str)
	if minetest.is_protected(pos, player:get_player_name()) then return end

	local meta = minetest.get_meta(pos)
	if meta == nil then return end

	if fields.cancel then return end

	if fields.coords ~= nil then
		-- Source Block
		if fields.set_owner then
			-- change owner
			meta:set_string("owner", player:get_player_name() or "")
		end
		-- set destination position
		local dst_pos = teleport_sd.parse_coords(fields.coords)
		if dst_pos ~= nil then
			teleport_sd.set_src_infotext(meta, pos, dst_pos)
			meta:set_int("x", dst_pos.x)
			meta:set_int("y", dst_pos.y)
			meta:set_int("z", dst_pos.z)
		end
	elseif fields.yaw ~= nil then
		-- Destination Block
		if fields.clr_owner then
			-- clear owner
			meta:set_string("owner", "")
			teleport_sd.set_dst_infotext(meta, pos)
		elseif fields.set_owner then
			-- set owner
			meta:set_string("owner", player:get_player_name() or "")
			teleport_sd.set_dst_infotext(meta, pos)
		end
		-- set yaw
		local yaw = tonumber(fields.yaw)
		if yaw < 0 then
			yaw = 0
		elseif yaw > 359 then
			yaw = 359
		end
		meta:set_int("yaw", yaw)
	end
end)



-- Helper Functions

teleport_sd.teleport_player_to_dst = function(src_pos, player, dst_pos, elapsed)
	-- get destination nodes
	local dst_node = minetest.get_node_or_nil(dst_pos)
	local above_node1 = minetest.get_node_or_nil({x=dst_pos.x, y=dst_pos.y+1, z=dst_pos.z})
	local above_node2 = minetest.get_node_or_nil({x=dst_pos.x, y=dst_pos.y+2, z=dst_pos.z})

	-- force load destination nodes and wait
	if dst_node == nil or above_node2 == nil then
		if elapsed >= teleport_sd.timeout_wait then
			minetest.chat_send_player(player:get_player_name(), teleport_sd.msg_load_error)
		else
			if elapsed == 0 then
				minetest.chat_send_player(player:get_player_name(), teleport_sd.msg_loading)
			end
			teleport_sd.forceload_and_wait_for_dst(src_pos, player, dst_pos, elapsed)
		end

		return false
	end

	-- verify dst position has a teleport destination node
	if dst_node.name == "teleport_sd:teleport_dst" then
		-- get src and dst meta
		local src_meta = minetest.get_meta(src_pos)
		local dst_meta = minetest.get_meta(dst_pos)
		-- verify src and dst have same owner or dst has no owner
		if src_meta ~= nil and dst_meta ~= nil and (src_meta:get_string("owner") == dst_meta:get_string("owner") or dst_meta:get_string("owner") == "") then
			-- verify dst node has 2 air blocks above it
			if above_node1.name == "air" and above_node2.name == "air" then
				-- teleport player
				local tp_pos = {x=dst_pos.x, y=dst_pos.y+0.5, z=dst_pos.z}

				minetest.sound_play("portal_close", {pos = src_pos, gain = 1.0, max_hear_distance = 5})
				teleport_sd.spawn_particles(src_pos, 2.3, -1, 1.7)

				-- TODO: position, pitch and yaw don't always sync to client
				player:setpos(tp_pos)
				player:set_look_pitch(0)
				player:set_look_yaw(dst_meta:get_int("yaw")*0.0174533)

				minetest.sound_play("portal_close", {pos = dst_pos, gain = 1.0, max_hear_distance = 5})
				teleport_sd.spawn_particles(dst_pos, 0.5, 1, 1.7)
			else
				minetest.chat_send_player(player:get_player_name(), teleport_sd.msg_obstructed)
			end
		else
			minetest.chat_send_player(player:get_player_name(), teleport_sd.msg_owner_mismatch)
		end
	else
		minetest.chat_send_player(player:get_player_name(),
			teleport_sd.msg_no_dst_at..dst_pos.x..','..dst_pos.y..','..dst_pos.z)
	end

	return true
end

teleport_sd.forceload_and_wait_for_dst = function(src_pos, player, dst_pos, elapsed)
	-- get node timer for source block
	local timer = minetest.get_node_timer(src_pos)
	if timer == nil then
		minetest.chat_send_player(player:get_player_name(), teleport_sd.msg_timer_error)
	else
		if elapsed == 0 then
			-- force load destination
			minetest.forceload_block(dst_pos)
			minetest.forceload_block({x=dst_pos.x, y=dst_pos.y+2, z=dst_pos.z})
--			minetest.chat_send_player(player:get_player_name(), '[TELEPORT] LOAD')  
		end

		-- add source block to wait queue
		local src_pos_key = minetest.pos_to_string(src_pos)
		if teleport_sd.wait_queue[src_pos_key] == nil then
			teleport_sd.wait_queue[src_pos_key] = {}
		end

		-- add waiter to wait queue
		table.insert(teleport_sd.wait_queue[src_pos_key], {player=player, dst_pos=dst_pos, elapsed=elapsed})

		-- start timer
		if not timer:is_started() then
			timer:start(1)
		end
	end
end

teleport_sd.remove_forceloaders = function(dst_pos)
	minetest.forceload_free_block(dst_pos)
	minetest.forceload_free_block({x=dst_pos.x, y=dst_pos.y+2, z=dst_pos.z})
end

teleport_sd.remove_src_wait_queue_if_empty = function(src_pos)
	local src_pos_key = minetest.pos_to_string(src_pos)
	if table.getn(teleport_sd.wait_queue[src_pos_key]) == 0 then
		teleport_sd.wait_queue[src_pos_key] = nil
	end
end

teleport_sd.parse_coords = function(str)
	if not str or str == "" then return nil end

	local x,y,z = string.match(str, "^(-?%d+) ?, ?(-?%d+) ?, ?(-?%d+)$")
	if x == nil or y == nil or z == nil then
		return nil
	end
	x = x + 0.0
	y = y + 0.0
	z = z + 0.0

	if x < teleport_sd.min_x or x > teleport_sd.max_x
	or y < teleport_sd.min_y or y > teleport_sd.max_y
	or z < teleport_sd.min_z or z > teleport_sd.max_z then
		return nil
	end

	return {x=x, y=y, z=z}
end

teleport_sd.round = function(n)
	return n + 0.5 - (n + 0.5) % 1
end

teleport_sd.set_dst_infotext = function(meta, dst_pos)
	local owner = meta:get_string("owner")
	local infotext = "Teleport Destination @ "..dst_pos.x..","..dst_pos.y..","..dst_pos.z
	if owner ~= "" then
		meta:set_string("infotext", infotext)
	else
		meta:set_string("infotext", infotext.."\n"..teleport_sd.infotext_dst_no_owner)
	end
end
teleport_sd.set_src_infotext = function(meta, src_pos, dst_pos)
	meta:set_string("infotext", "Teleport Source --> "..dst_pos.x..","..dst_pos.y..","..dst_pos.z
		.."\n"..teleport_sd.infotext_src_activate)
end

teleport_sd.spawn_particles = function(pos, start_y, vel, duration)
	minetest.add_particlespawner({
		amount = teleport_sd.particle_amount,
		time = teleport_sd.particle_time,
		minpos = {x=pos.x-0.4, y=pos.y+start_y, z=pos.z-0.4},
		maxpos = {x=pos.x+0.4, y=pos.y+start_y, z=pos.z+0.4},
		minvel = {x=0, y=vel, z=0},
		maxvel = {x=0, y=vel, z=0},
		minacc = {x=0, y=0, z=0},
		maxacc = {x=0, y=0, z=0},
		minexptime = duration,
		maxexptime = duration,
		minsize = 0.2,
		maxsize = 0.4,
		collisiondetection = false,
		vertical = true,
		texture = "teleport_sd_particle.png"
	})
end



print("[MOD] Teleport SD loaded")
