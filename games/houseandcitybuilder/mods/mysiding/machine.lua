local material = {}
local shape = {}
local make_ok = {}
local anzahl = {}

minetest.register_node("mysiding:machine2", {
--	description = "Siding Machine 2",
	tiles = {
		"mysiding_right_top.png",
		"mysiding_right_bottom.png",
		"mysiding_right_side.png",
		"mysiding_left_side.png",
		"mysiding_right_back.png",
		"mysiding_right_front.png"
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	drop = "mysiding:machine",
	node_box = {
		type = "fixed",
		fixed = {
			{0.3125, -0.5, 0.3125, 0.5, 0.125, 0.5},
			{0.3125, -0.5, -0.5, 0.5, 0.125, -0.3125}, 
			{-0.5, -0.25, -0.5, 0.5, 0.25, 0.5}, 
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.3125}, 
			{-0.5, 0.25, -0.25, -0.4375, 0.3125, 0.1875}, 
		}
	},

	selection_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0.0625, 0.0625, 0.0625},
		}
	},

after_destruct = function(pos)
	if minetest.get_node({x=pos.x + 1, y=pos.y, z=pos.z}).name == "mysiding:machine" then
      minetest.set_node({x=pos.x + 1, y=pos.y, z=pos.z}, {name="air"})
	end
	if minetest.get_node({x=pos.x - 1, y=pos.y, z=pos.z}).name == "mysiding:machine" then
      minetest.set_node({x=pos.x - 1, y=pos.y, z=pos.z}, {name="air"})
	end
	if minetest.get_node({x=pos.x, y=pos.y, z=pos.z + 1}).name == "mysiding:machine" then
      minetest.set_node({x=pos.x, y=pos.y, z=pos.z + 1}, {name="air"})
	end
	if minetest.get_node({x=pos.x, y=pos.y, z=pos.z - 1}).name == "mysiding:machine" then
      minetest.set_node({x=pos.x, y=pos.y, z=pos.z - 1}, {name="air"})
	end
end,
})

minetest.register_node("mysiding:machine", {
	description = "Siding Machine",
	tiles = {
		"mysiding_left_top.png",
		"mysiding_left_bottom.png",
		"mysiding_right_side.png",
		"mysiding_left_side.png",
		"mysiding_left_back.png",
		"mysiding_left_front.png"
		},
	drawtype = "nodebox",
	inventory_image = "mysiding_mach_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.3125, -0.3125, 0.125, 0.5}, 
			{-0.5, -0.5, -0.5, -0.3125, 0.125, -0.3125}, 
			{-0.5, -0.25, -0.5, 0.5, 0.25, 0.5}, 
			{-0.5, 0.25, 0.1875, 0.5, 0.5, 0.3125}, 
			{0.4375, 0.25, -0.25, 0.5, 0.3125, 0.1875}, 
		}
	},

	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,1.5,0.25,0.5}

		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,1.5,0.25,0.5}

		}
	},


after_place_node = function(pos, placer)
      local dir = placer:get_look_dir()
      local right_pos = vector.new(pos)
      if math.abs(dir.x) < math.abs(dir.z) then
         right_pos.x = right_pos.x+dir.z/math.abs(dir.z)
      else
         right_pos.z = right_pos.z-dir.x/math.abs(dir.x)
      end
      local right_node = minetest.get_node(right_pos)
	if right_node.name == "air" then
      minetest.set_node(right_pos, {name="mysiding:machine2",param2 = minetest.dir_to_facedir(placer:get_look_dir())})
	end

local meta = minetest.get_meta(pos);
	meta:set_string("owner",  (placer:get_player_name() or ""));
	meta:set_string("infotext",  "Siding Machine (owned by " .. (placer:get_player_name() or "") .. ")");
	
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") then
		return false
	elseif not inv:is_empty("res") then
		return false
	end
	return true
end,

can_dig = function(pos,player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	if player:get_player_name() == meta:get_string("owner") and
	inv:is_empty("ingot") and
	inv:is_empty("res") then
		return true
	else
	return false
	end
end,

on_construct = function(pos)
		
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", "invsize[10,11;]"..
		"background[-0.15,-0.25;10.40,11.75;mysiding_background.png]"..
		"list[current_name;ingot;7,2;1,1;]"..
		"list[current_name;res;7,4;1,1;]"..
		"label[7,1.5;Input:]"..
		"label[7,3.5;Output:]"..
		"label[0,0;Choose Siding Stye:]"..
		"label[1.5,1.5;Wide Siding]"..
		"image_button[1.5,2;1,1;mysiding_mach1.png;wide; ]"..
		"label[4,1.5;Narrow Siding]"..
		"image_button[4,2;1,1;mysiding_mach2.png;narrow; ]"..
		"list[current_player;main;1,7;8,4;]")
	meta:set_string("infotext", "Siding Machine")
	local inv = meta:get_inventory()
	inv:set_size("ingot", 1)
	inv:set_size("res", 1)
end,

on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

if fields["wide"] 
or fields["narrow"]
then

	if fields["wide"] then
		make_ok = "0"
		anzahl = "1"
		shape = "mysiding:wide_"
		if inv:is_empty("ingot") then
			return
		end
	end

	if fields["narrow"] then
		make_ok = "0"
		anzahl = "1"
		shape = "mysiding:narrow_"
		if inv:is_empty("ingot") then
			return
		end
	end



		local ingotstack = inv:get_stack("ingot", 1)
		local resstack = inv:get_stack("res", 1)


------------------------------------------------------------------------------------------
--register nodes here
------------------------------------------------------------------------------------------
		if ingotstack:get_name()=="default:sandstone" then
				material = "default_sandstone"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:clay" then
				material = "default_clay"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:desert_stone" then
				material = "default_desert_stone"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:cobble" then
				material = "default_cobble"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:stone" then
				material = "default_stone"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:wood" then
				material = "default_wood"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:pine_wood" then
				material = "default_pine_wood"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:dirt" then
				material = "default_dirt"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:desert_cobble" then
				material = "default_desert_cobble"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:gravel" then
				material = "default_gravel"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:junglewood" then
				material = "default_junglewood"
				make_ok = "1"
		end

		if ingotstack:get_name()=="default:mossycobble" then
				material = "default_mossycobble"
				make_ok = "1"
		end

		if ingotstack:get_name()=="farming:straw" then
				material = "farming_straw"
				make_ok = "1"
		end

----------------------------------------------------------------------------
--wool

		if ingotstack:get_name()=="wool:white" then
				material = "wool_white"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:black" then
				material = "wool_black"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:blue" then
				material = "wool_blue"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:brown" then
				material = "wool_brown"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:cyan" then
				material = "wool_cyan"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:dark_green" then
				material = "wool_dark_green"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:dark_grey" then
				material = "wool_dark_grey"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:green" then
				material = "wool_green"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:grey" then
				material = "wool_grey"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:magenta" then
				material = "wool_magenta"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:orange" then
				material = "wool_orange"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:pink" then
				material = "wool_pink"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:red" then
				material = "wool_red"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:violet" then
				material = "wool_violet"
				make_ok = "1"
		end
		if ingotstack:get_name()=="wool:yellow" then
				material = "wool_yellow"
				make_ok = "1"
		end

----------------------------------------------------------------------
		if make_ok == "1" then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("res",shape..material)
			end
			ingotstack:take_item()
			inv:set_stack("ingot",1,ingotstack)
		end            

end	
end,

after_destruct = function(pos)
	if minetest.get_node({x=pos.x + 1, y=pos.y, z=pos.z}).name == "mysiding:machine2" then
      minetest.set_node({x=pos.x + 1, y=pos.y, z=pos.z}, {name="air"})
	end
	if minetest.get_node({x=pos.x - 1, y=pos.y, z=pos.z}).name == "mysiding:machine2" then
      minetest.set_node({x=pos.x - 1, y=pos.y, z=pos.z}, {name="air"})
	end
	if minetest.get_node({x=pos.x, y=pos.y, z=pos.z+ 1}).name == "mysiding:machine2" then
      minetest.set_node({x=pos.x, y=pos.y, z=pos.z + 1}, {name="air"})
	end
	if minetest.get_node({x=pos.x, y=pos.y, z=pos.z - 1}).name == "mysiding:machine2" then
      minetest.set_node({x=pos.x, y=pos.y, z=pos.z - 1}, {name="air"})
	end
end,
})

--Craft

minetest.register_craft({
		output = 'mysiding:machine',
		recipe = {
			{'default:copperblock', 'default:copperblock', 'default:copperblock'},
			{'default:copperblock', 'default:steel_ingot', 'default:copperblock'},
			{'default:copperblock', "default:copperblock", 'default:copperblock'},		
		},
})













