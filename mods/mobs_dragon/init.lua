
-- HIGHLY EXPERIMENTAL
-------------------------------------------------------------------------------
-- do not set true unless you are helping to work on this
local use_whistle = false

local tamed_dragons = {}

if use_whistle == true then
	minetest.register_on_joinplayer(function(player)
		tamed_dragons[player:get_player_name()] = {}
	end)
end
-------------------------------------------------------------------------------


-- load dragons
-------------------------------------------------------------------------------
local path = minetest.get_modpath("mobs_dragon")
dofile(path.."/large.lua")
dofile(path.."/small.lua")
-------------------------------------------------------------------------------


-- spawn in the wild
-------------------------------------------------------------------------------
mobs:spawn_specific("mobs_dragon:dragon_lg_red",
	{"air"},
	{"default:lava_source"},
	20, 10, 300, 15000, 2, -100, 11000
)

mobs:spawn_specific("mobs_dragon:dragon_lg_black",
	{"air"},
	{"default:obsidian"},
	20, 10, 300, 15000, 2, -100, 11000
)

mobs:spawn_specific("mobs_dragon:dragon_lg_green",
	{"air"},
	{"default:cactus"},
	20, 10, 300, 15000, 2, -100, 11000
)

mobs:spawn_specific("mobs_dragon:dragon_lg_blue",
	{"air"},
	{"default:water_source"},
	20, 10, 300, 15000, 2, -100, 11000
)
-------------------------------------------------------------------------------


-- wild spawn eggs
-------------------------------------------------------------------------------
-- uncomment the following lines to have spawn eggs for the "wild" dragon in the inventory
--mobs:register_egg("mobs_dragon:dragon_lg_red", "Dragon", "dmobs_egg1.png", 1)
--mobs:register_egg("mobs_dragon:dragon_lg_black", "Dragon", "dmobs_egg2.png", 1)
--mobs:register_egg("mobs_dragon:dragon_lg_green", "Dragon", "dmobs_egg3.png", 1)
--mobs:register_egg("mobs_dragon:dragon_lg_blue", "Dragon", "dmobs_egg4.png", 1)
-------------------------------------------------------------------------------


-- dropped eggs for hatching ridable dragons
-------------------------------------------------------------------------------
minetest.register_node("mobs_dragon:dragon_egg", {
	description = "Dragon Egg",
	drawtype = "mesh",
	mesh = "egg.b3d",
	tiles = {"dmobs_egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=3},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		-- is alter built correctly?
		local p = {x = pos.x, y = pos.y - 1, z = pos.z}
		local name1
		for x1 = -1,1 do
			for z1 = -1,1 do
				p.x = pos.x + x1
				p.z = pos.z + z1
				local name2 = minetest.get_node(p).name
				if x1 == -1 and z1 == -1 then			-- get name of one of the surrounding nodes
					name1 = minetest.get_node(p).name
				elseif x1 == 0 and z1 == 0 then			-- is center node obsidian?
					if name2 ~= "default:obsidian" then return end
				else
					if name2 ~= name1 then return end	-- do the rest of the surrounding nodes match the original sample?
				end
			end
		end

		-- determine which dragon to spawn depending on what the "alter" is made of
		local which_dragon
		if name1 == "default:lava_source" then which_dragon = "red"
		elseif name1 == "default:obsidian" then which_dragon = "black"
		elseif name1 == "default:cactus" then which_dragon = "green"
		elseif name1 == "default:water_source" then which_dragon = "blue"
		else return
		end

		-- 10 seconds after the egg is placed, spawn the appropriate dragon
		minetest.after(10, function(pos, dragon, pname)
			-- remove egg
			minetest.remove_node(pos)
			-- spawn dragon
			local ent = minetest.add_entity(pos, "mobs_dragon:dragon_sm_"..dragon)
			-- get dragon object and set owner name
			local obj = ent:get_luaentity()
			obj.tamed = true
			obj.owner = pname

			if use_whistle == true then
				-- not used because use_whistle should not be set to true
				local dcount = #tamed_dragons[pname]
				tamed_dragons[pname][dcount+1] = ent
			else
				-- set dragon order and state (and therefore animation) to stand
				-- dragon will wander off if you don't do this
				obj.order = "stand"
				obj.state = "stand"
			end
		end, pos, which_dragon, placer:get_player_name())
	end
})
-------------------------------------------------------------------------------


-- whistle
-------------------------------------------------------------------------------
-- under construction, does not work yet (maybe never)
if use_whistle == true then
	local fs = function(pname)
		local formspec = "size[7,7]"
			.."label[2,0;--== Call Dragon ==--]"
			.."dropdown[0.5,1.5;5.6,4.6;call_dragon;"
		if tamed_dragons[pname] and #tamed_dragons[pname] > 0 then
			for i = 1,#tamed_dragons[pname] do
				local dname = tamed_dragons[pname][i]:get_luaentity().nametag
				if dname then
					formspec = formspec .. dname .. ","
				end
			end
		end
		formspec = formspec .. ";1]"
		return formspec
	end

	core.register_on_player_receive_fields(function(player, formname, fields)
		local pname = player:get_player_name()
		-- go to bookmark
		if fields.call_dragon then
			for i = 1,#tamed_dragons[pname] do
				local obj = tamed_dragons[pname][i]:get_luaentity()
				if fields.call_dragon == obj.nametag then
					tamed_dragons[pname][i]:moveto(player:getpos(), true)
					obj.order = "stand"
					obj.state = "stand"
				end
			end
		end
	end)

	minetest.register_craftitem("mobs_dragon:whistle", {
		description = "Dragon Whistle",
		inventory_image = "dmobs_whistle.png",
		on_use = function(itemstack, user, pointed_thing)
			local pname = user:get_player_name()
			minetest.show_formspec(pname, "dragons", fs(pname))
		end
	})
end
-------------------------------------------------------------------------------


-- saddle (if not already available)
-------------------------------------------------------------------------------
-- if mobs_horse is loaded then there is no need to register the saddle
if not minetest.get_modpath("mobs_horse") then
	minetest.register_craftitem(":mobs:saddle", {
		description = "Saddle",
		inventory_image = "mobs_saddle.png"
	})

	minetest.register_craft({
		output = "mobs:saddle",
		recipe = {
			{"mobs:leather", "mobs:leather", "mobs:leather"},
			{"mobs:leather", "default:steel_ingot", "mobs:leather"},
			{"mobs:leather", "default:steel_ingot", "mobs:leather"}
		}
	})
end
-------------------------------------------------------------------------------


-- fireball
-------------------------------------------------------------------------------
mobs:register_arrow("mobs_dragon:fire", {
   visual = "sprite",
   visual_size = {x = 0.5, y = 0.5},
   textures = {"dmobs_fire.png"},
   velocity = 8,
   tail = 1,
   tail_texture = "dmobs_fire.png",
   hit_player = function(self, player)
      player:punch(self.object, 1.0, {
         full_punch_interval = 1.0,
         damage_groups = {fleshy = 8},
      }, nil)
   end,
   hit_mob = function(self, player)
      player:punch(self.object, 1.0, {
         full_punch_interval = 1.0,
         damage_groups = {fleshy = 8},
      }, nil)
   end,
   hit_node = function(self, pos, node)
      mobs:explosion(pos, 2, 1, 1)
   end
})
-------------------------------------------------------------------------------
