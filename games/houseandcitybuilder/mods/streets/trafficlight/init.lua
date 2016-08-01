--[[
	StreetsMod: inDev Trafficlights
]]
dofile(streets.modpath .. "/../trafficlight/old2new.lua")

streets.tlBox =	{
	{-0.1875,-0.5,0.5,0.1875,0.5,0.75}, --Box

	{-0.125, -0.125, 0.85, 0.125, 0.125, 0.75}, -- Pole Mounting Bracket

	{-0.125,0.3125,0.3125,-0.0625,0.375,0.5}, --Top Visor, Left
	{-0.0625,0.375,0.3125,0.0625,0.4375,0.5}, --Top Visor, Center
	{0.0625,0.3125,0.3125,0.125,0.38,0.5}, --Top Visor, Right

	{-0.125,0,0.3125,-0.0625,0.0625,0.5}, --Middle Visor, Left
	{-0.0625,0.0625,0.3125,0.0625,0.125,0.5}, --Middle Visor, Center
	{0.0625,0,0.3125,0.125,0.0625,0.5}, --Middle Visor, Right

	{-0.125,-0.3125,0.3125,-0.0625,-0.25,0.5}, --Bottom Visor, Left
	{-0.0625,-0.25,0.3125,0.0625,-0.1875,0.5}, --Bottom Visor, Center
	{0.0625,-0.3125,0.3125,0.125,-0.25,0.5}, --Bottom Visor, Right
}

streets.tleBox =	{
	{-0.1875,-0.1875,0.5,0.1875,0.5,0.75}, --Box

	{-0.125,0.3125,0.3125,-0.0625,0.375,0.5}, --Top Visor, Left
	{-0.0625,0.375,0.3125,0.0625,0.4375,0.5}, --Top Visor, Center
	{0.0625,0.3125,0.3125,0.125,0.38,0.5}, --Top Visor, Right

	{-0.125,0,0.3125,-0.0625,0.0625,0.5}, --Middle Visor, Left
	{-0.0625,0.0625,0.3125,0.0625,0.125,0.5}, --Middle Visor, Center
	{0.0625,0,0.3125,0.125,0.0625,0.5}, --Middle Visor, Right
}

streets.plBox =	{
	{-0.1875,-0.5,0.5,0.1875,0.5,0.75}, --Box

	{-0.125, -0.125, 0.85, 0.125, 0.125, 0.75}, -- Pole Mounting Bracket

	{-0.1875,0.0625,0.3125,-0.1375,0.4375,0.5}, --Top Visor, Left
	{-0.1375,0.3875,0.3125,0.1375,0.4375,0.5}, --Top Visor, Center
	{0.1875,0.0625,0.3125,0.1375,0.4375,0.5}, --Top Visor, Right

	{-0.1875,-0.0625,0.3125,-0.1375,-0.4375,0.5}, --Bottom Visor, Left
	{-0.1375,-0.0625,0.3125,0.1375,-0.1125,0.5}, --Bottom Visor, Center
	{0.1875,-0.0625,0.3125,0.1375,-0.4375,0.5}, --Bottom Visor, Right
}

streets.bBox =	{
	{-0.1875,-0.1875,0.5,0.1875,0.1875,0.75}, --Box

	{-0.125, -0.125, 0.85, 0.125, 0.125, 0.75}, -- Pole Mounting Bracket

	{-0.125,0,0.3125,-0.0625,0.0625,0.5}, --Visor, Left
	{-0.0625,0.0625,0.3125,0.0625,0.125,0.5}, --Visor, Center
	{0.0625,0,0.3125,0.125,0.0625,0.5}, --Visor, Right
}

streets.hbBox =	{
	{-0.375,-0.25,0.5,0.375,0.25,0.75}, --Box

	{-0.125, -0.125, 0.85, 0.125, 0.125, 0.75}, -- Pole Mounting Bracket

	{-0.3,0.0625,0.3125,-0.2375,0.125,0.5}, --Top Left Visor, Left
	{-0.2375,0.125,0.3125,-0.1125,0.1875,0.5}, --Top Left Visor, Center
	{-0.1125,0.0625,0.3125,-0.05,0.125,0.5}, --Top Left Visor, Right

	{0.1125,0.0625,0.3125,0.05,0.125,0.5}, --Top Right Visor, Left
	{0.2375,0.125,0.3125,0.1125,0.1875,0.5}, --Top Right Visor, Center
	{0.3,0.0625,0.3125,0.2375,0.125,0.5}, --Top Right Visor, Right

	{-0.125,-0.125,0.3125,-0.0625,-0.0625,0.5}, --Bottom Visor, Left
	{-0.0625,-0.0625,0.3125,0.0625,0,0.5}, --Bottom Visor, Center
	{0.0625,-0.125,0.3125,0.125,-0.0625,0.5}, --Bottom Visor, Right
}

streets.tlDigilineRules = {
				{x= 0, y= 0, z=-1},
				{x= 0, y= 0, z= 1},
				{x= 1, y= 0, z= 0},
				{x=-1, y= 0, z= 0},
				{x= 0, y=-1, z= 0},
				{x= 0, y= 1, z= 0}
			}

streets.tlSwitch = function(pos,to)
	if not pos or not to then
		return
	end
	minetest.swap_node(pos, {name = to, param2 = minetest.get_node(pos).param2})
end

streets.on_digiline_receive = function(pos, node, channel, msg)
	local setchan = minetest.get_meta(pos):get_string("channel")
	if setchan ~= channel then
		return
	end
	-- Tl states
	local name = minetest.get_node(pos).name
	if msg == "OFF" then
		if name:find("pedlight") then
			streets.tlSwitch(pos,"streets:pedlight_top_off")
		elseif name:find("extender_left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_left_off")
		elseif name:find("extender_right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_right_off")
		elseif name:find("left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_left_off")
		elseif name:find("right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_right_off")
		elseif name:find("beacon_hybrid") then
			streets.tlSwitch(pos,"streets:beacon_hybrid_off")
		elseif name:find("beacon") then
			streets.tlSwitch(pos,"streets:beacon_off")
		else
			streets.tlSwitch(pos,"streets:trafficlight_top_off")
		end
	elseif msg == "GREEN" then
		if name:find("pedlight") then
			streets.tlSwitch(pos,"streets:pedlight_top_walk")
		elseif name:find("extender_left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_left_green")
		elseif name:find("extender_right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_right_green")
		elseif name:find("left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_left_green")
		elseif name:find("right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_right_green")
		elseif name:find("beacon_hybrid") then
			--Not Supported
		elseif name:find("beacon") then
			--Not Supported
		else
			streets.tlSwitch(pos,"streets:trafficlight_top_green")
		end
	elseif msg == "RED" then
		if name:find("pedlight") then
			streets.tlSwitch(pos,"streets:pedlight_top_dontwalk")
		elseif name:find("extender_left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_left_off")
		elseif name:find("extender_right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_right_off")
		elseif name:find("left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_left_red")
		elseif name:find("right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_right_red")
		elseif name:find("beacon_hybrid") then
			streets.tlSwitch(pos,"streets:beacon_hybrid_red")
		elseif name:find("beacon") then
			--Not Supported
		else
			streets.tlSwitch(pos,"streets:trafficlight_top_red")
		end
	elseif msg == "WARN" then
		if name:find("pedlight") then
			streets.tlSwitch(pos,"streets:pedlight_top_flashingdontwalk")
		elseif name:find("extender_left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_left_off")
		elseif name:find("extender_right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_right_off")
		elseif name:find("left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_left_warn")
		elseif name:find("right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_right_warn")
		elseif name:find("beacon_hybrid") then
			streets.tlSwitch(pos,"streets:beacon_hybrid_flashyellow")
		elseif name:find("beacon") then
			streets.tlSwitch(pos,"streets:beacon_flashyellow")
		else
			streets.tlSwitch(pos,"streets:trafficlight_top_warn")
		end
	elseif msg == "FLASHYELLOW" then
		if name:find("pedlight") then
			streets.tlSwitch(pos,"streets:pedlight_top_flashingdontwalk")
		elseif name:find("extender_left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_left_off")
		elseif name:find("extender_right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_right_off")
		elseif name:find("left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_left_warn")
		elseif name:find("right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_right_warn")
		elseif name:find("beacon_hybrid") then
			streets.tlSwitch(pos,"streets:beacon_hybrid_flashyellow")
		elseif name:find("beacon") then
			streets.tlSwitch(pos,"streets:beacon_flashyellow")
		else
			streets.tlSwitch(pos,"streets:trafficlight_top_warn")
		end
	elseif msg == "YELLOW" then
		if name:find("pedlight") then
			streets.tlSwitch(pos,"streets:pedlight_top_flashingdontwalk")
		elseif name:find("extender_left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_left_yellow")
		elseif name:find("extender_right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_right_yellow")
		elseif name:find("left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_left_yellow")
		elseif name:find("right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_right_yellow")
		elseif name:find("beacon_hybrid") then
			streets.tlSwitch(pos,"streets:beacon_hybrid_yellow")
		elseif name:find("beacon") then
			--Not Supported
		else
			streets.tlSwitch(pos,"streets:trafficlight_top_yellow")
		end
	elseif msg == "FLASHRED" then
		if name:find("pedlight") then
			streets.tlSwitch(pos,"streets:pedlight_top_flashingdontwalk")
		elseif name:find("extender_left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_left_off")
		elseif name:find("extender_right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_extender_right_off")
		elseif name:find("left") then
			streets.tlSwitch(pos,"streets:trafficlight_top_left_flashred")
		elseif name:find("right") then
			streets.tlSwitch(pos,"streets:trafficlight_top_right_flashred")
		elseif name:find("beacon_hybrid") then
			streets.tlSwitch(pos,"streets:beacon_hybrid_flashred")
		elseif name:find("beacon") then
			streets.tlSwitch(pos,"streets:beacon_flashred")
		else
			streets.tlSwitch(pos,"streets:trafficlight_top_flashred")
		end
	end
end

minetest.register_node(":streets:digiline_distributor",{
	description = streets.S("Digiline distributor"),
	tiles = {"streets_lampcontroller_top.png","streets_lampcontroller_bottom.png","streets_lampcontroller_sides.png"},
	groups = {cracky = 1},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.5,0.5},
			{-0.05,0.5,-0.05,0.05,1.6,0.05}
		}
	},
	digiline = {
		wire = {
			rules = {
				{x= 0, y= 0, z=-1},
				{x= 0, y= 0, z= 1},
				{x= 1, y= 0, z= 0},
				{x=-1, y= 0, z= 0},
				{x= 0, y= 2, z=0}
			}
		}
	}
})

minetest.register_node(":streets:beacon_hybrid_off",{
	description = "Hybrid Beacon",
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	inventory_image = "streets_hybrid_beacon_inv.png",
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.hbBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_hb_off.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:beacon_hybrid_yellow",{
	drop = "streets:beacon_hybrid_off",
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.hbBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_hb_yellow.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:beacon_hybrid_red",{
	drop = "streets:beacon_hybrid_off",
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.hbBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_hb_red.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:beacon_hybrid_flashyellow",{
	drop = "streets:beacon_hybrid_off",
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.hbBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png",{
		name="streets_hb_flashyellow.png",
		animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.2},
	}},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:beacon_hybrid_flashred",{
	drop = "streets:beacon_hybrid_off",
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.hbBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png",{
		name="streets_hb_flashred.png",
		animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.2},
	}},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:beacon_off",{
	description = "Beacon",
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	inventory_image = "streets_beacon_inv.png",
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.bBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_off.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:beacon_flashred",{
	drop = "streets:beacon_off",
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.bBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png",{
		name="streets_b_flashred.png",
		animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.2},
	}},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:beacon_flashyellow",{
	drop = "streets:beacon_off",
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.bBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png",{
		name="streets_tl_warn.png",
		animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.2},
	}},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:trafficlight_top_extender_left_off",{
	description = streets.S("Traffic Light Left-Turn Module"),
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	inventory_image = "streets_trafficlight_inv_extender_left.png",
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.tleBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_left_off.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:trafficlight_top_extender_left_yellow",{
	drop = "streets:trafficlight_top_extender_left_off",
	description = streets.S("Traffic Light Left-Turn Module"),
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.tleBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tle_left_yellow.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:trafficlight_top_extender_left_green",{
	drop = "streets:trafficlight_top_extender_left_off",
	description = streets.S("Traffic Light Left-Turn Module"),
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.tleBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tle_left_green.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:trafficlight_top_extender_right_off",{
	description = streets.S("Traffic Light Right-Turn Module"),
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	inventory_image = "streets_trafficlight_inv_extender_right.png",
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.tleBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_right_off.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:trafficlight_top_extender_right_yellow",{
	drop = "streets:trafficlight_top_extender_right_off",
	description = streets.S("Traffic Light Right-Turn Module"),
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.tleBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tle_right_yellow.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:trafficlight_top_extender_right_green",{
	drop = "streets:trafficlight_top_extender_left_off",
	description = streets.S("Traffic Light Right-Turn Module"),
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2, not_in_creative_inventory = 1},
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.tleBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tle_right_green.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:pedlight_top_off",{
	description = streets.S("Pedestrian Light"),
	drawtype="nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1, level = 2},
	inventory_image = "streets_pedlight_inv.png",
	light_source = 11,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = streets.plBox
	},
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_pl_off.png"},
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,
})

minetest.register_node(":streets:pedlight_top_dontwalk",{
	drop = "streets:pedlight_top_off",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	drawtype = "nodebox",
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_pl_dontwalk.png"},
	node_box = {
		type = "fixed",
		fixed = streets.plBox
	},
	light_source = 6,
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
})

minetest.register_node(":streets:pedlight_top_walk",{
	drop = "streets:pedlight_top_off",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	drawtype = "nodebox",
	tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_pl_walk.png"},
	node_box = {
		type = "fixed",
		fixed = streets.plBox
	},
	light_source = 6,
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
})

minetest.register_node(":streets:pedlight_top_flashingdontwalk",{
	drop = "streets:pedlight_top_off",
	groups = {cracky = 1, not_in_creative_inventory = 1},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	drawtype = "nodebox",
		tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png",{
			name="streets_pl_flashingdontwalk.png",
			animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.2},
		}},
	node_box = {
		type = "fixed",
		fixed = streets.plBox
	},
	light_source = 6,
	digiline = {
		receptor = {},
		wire = {rules=streets.tlDigilineRules},
		effector = {
			action = function(pos, node, channel, msg)
				streets.on_digiline_receive(pos, node, channel, msg)
			end
		}
	},
})


for _,i in pairs({"","_left","_right"}) do
	minetest.register_node(":streets:trafficlight_top"..i.."_off",{
		description = streets.S((i == "" and "Traffic Light") or (i == "_left" and "Traffic Light (Left Turn)") or (i == "_right" and "Traffic Light (Right Turn)")),
		drawtype="nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 1, level = 2},
		inventory_image = ((i == "") and "streets_trafficlight_inv_straight.png") or ((i == "_left") and "streets_trafficlight_inv_left.png") or ((i == "_right") and "streets_trafficlight_inv_right.png"),
		light_source = 11,
		sunlight_propagates = true,
		node_box = {
			type = "fixed",
			fixed = streets.tlBox
		},
		tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl"..i.."_off.png"},
		digiline = {
			receptor = {},
			wire = {rules=streets.tlDigilineRules},
			effector = {
				action = function(pos, node, channel, msg)
					streets.on_digiline_receive(pos, node, channel, msg)
				end
			}
		},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", "field[channel;Channel;${channel}]")
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if (fields.channel) then
				minetest.get_meta(pos):set_string("channel", fields.channel)
				minetest.get_meta(pos):set_string("state", "Off")
			end
		end,
	})

	minetest.register_node(":streets:trafficlight_top"..i.."_red",{
		drop = "streets:trafficlight_top"..i.."_off",
		groups = {cracky = 1, not_in_creative_inventory = 1},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		drawtype = "nodebox",
		tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl"..i.."_red.png"},
		node_box = {
			type = "fixed",
			fixed = streets.tlBox
		},
		light_source = 6,
		digiline = {
			receptor = {},
			wire = {rules=streets.tlDigilineRules},
			effector = {
				action = function(pos, node, channel, msg)
					streets.on_digiline_receive(pos, node, channel, msg)
				end
			}
		},
	})

	minetest.register_node(":streets:trafficlight_top"..i.."_yellow",{
		drop = "streets:trafficlight_top"..i.."_off",
		groups = {cracky = 1, not_in_creative_inventory = 1},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		drawtype = "nodebox",
		tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl"..i.."_yellow.png"},
		node_box = {
			type = "fixed",
			fixed = streets.tlBox
		},
		light_source = 6,
		digiline = {
			receptor = {},
			wire = {rules=streets.tlDigilineRules},
			effector = {
				action = function(pos, node, channel, msg)
					streets.on_digiline_receive(pos, node, channel, msg)
				end
			}
		},
	})

	minetest.register_alias("streets:trafficlight_top"..i.."_redyellow","streets:trafficlight_top"..i.."_green")

	minetest.register_node(":streets:trafficlight_top"..i.."_green",{
		drop = "streets:trafficlight_top"..i.."_off",
		groups = {cracky = 1, not_in_creative_inventory = 1},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		drawtype = "nodebox",
		tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl"..i.."_green.png"},
		node_box = {
			type = "fixed",
			fixed = streets.tlBox
		},
		light_source = 6,
		digiline = {
			receptor = {},
			wire = {rules=streets.tlDigilineRules},
			effector = {
				action = function(pos, node, channel, msg)
					streets.on_digiline_receive(pos, node, channel, msg)
				end
			}
		},
	})

	minetest.register_node(":streets:trafficlight_top"..i.."_warn",{
		drop = "streets:trafficlight_top"..i.."_off",
		groups = {cracky = 1, not_in_creative_inventory = 1},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		drawtype = "nodebox",
		tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png",{
			name="streets_tl"..i.."_warn.png",
			animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.2},
		}},
		node_box = {
			type = "fixed",
			fixed = streets.tlBox
		},
		light_source = 6,
		digiline = {
			receptor = {},
			wire = {rules=streets.tlDigilineRules},
			effector = {
				action = function(pos, node, channel, msg)
					streets.on_digiline_receive(pos, node, channel, msg)
				end
			}
		},
	})

	minetest.register_node(":streets:trafficlight_top"..i.."_flashred",{
		drop = "streets:trafficlight_top"..i.."_off",
		groups = {cracky = 1, not_in_creative_inventory = 1},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		drawtype = "nodebox",
		tiles = {"streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png","streets_tl_bg.png",{
			name="streets_tl"..i.."_flashred.png",
			animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.2},
		}},
		node_box = {
			type = "fixed",
			fixed = streets.tlBox
		},
		light_source = 6,
		digiline = {
			receptor = {},
			wire = {rules=streets.tlDigilineRules},
			effector = {
				action = function(pos, node, channel, msg)
					streets.on_digiline_receive(pos, node, channel, msg)
				end
			}
		},
	})
end

minetest.register_craft({
	output = "streets:trafficlight_top_off",
	recipe = {
		{"default:steel_ingot", "dye:red", "default:steel_ingot"},
		{"default:steel_ingot", "dye:yellow", "default:steel_ingot"},
		{"default:steel_ingot", "dye:green", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "streets:trafficlight_top_left_off",
	recipe = {
		{"dye:red", "default:steel_ingot", "default:steel_ingot"},
		{"dye:yellow", "default:steel_ingot", "default:steel_ingot"},
		{"dye:green", "default:steel_ingot", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "streets:trafficlight_top_right_off",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "dye:red"},
		{"default:steel_ingot", "default:steel_ingot", "dye:yellow"},
		{"default:steel_ingot", "default:steel_ingot", "dye:green"}
	}
})

minetest.register_craft({
	output = "streets:pedlight_top_off",
	recipe = {
		{"default:steel_ingot", "dye:orange", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "dye:white", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "streets:trafficlight_top_extender_left_off",
	recipe = {
		{"dye:yellow", "default:steel_ingot", "default:steel_ingot"},
		{"dye:green", "default:steel_ingot", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "streets:trafficlight_top_extender_right_off",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "dye:yellow"},
		{"default:steel_ingot", "default:steel_ingot", "dye:green"}
	}
})

minetest.register_craft({
	output = "streets:beacon_off",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "dye:red", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "streets:beacon_hybrid_off",
	recipe = {
		{"dye:red", "default:steel_ingot", "dye:red"},
		{"default:steel_ingot", "dye:yellow", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = "streets:digiline_distributor",
	recipe = {
		{"", "digilines:wire_std_00000000", ""},
		{"digilines:wire_std_00000000", "mesecons_luacontroller:luacontroller0000", "digilines:wire_std_00000000"},
		{"", "digilines:wire_std_00000000", ""}
	}
})
