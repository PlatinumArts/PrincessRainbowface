
dofile(minetest.get_modpath("myslopes").."/slopes.lua")
dofile(minetest.get_modpath("myslopes").."/long_slopes.lua")


local mod_moreblocks = minetest.get_modpath("moreblocks") 
local mod_castle = minetest.get_modpath("castle")
local mod_castles = minetest.get_modpath("castles")
local mod_bat_blocks = minetest.get_modpath("bat_blocks")

if mod_moreblocks then
	dofile(minetest.get_modpath("myslopes").."/moreblocks.lua")
	
	end

if mod_castle then
	dofile(minetest.get_modpath("myslopes").."/castle.lua")
	
	end

if mod_castles then
	dofile(minetest.get_modpath("myslopes").."/castle.lua")
	
	end

if mod_bat_blocks then
	dofile(minetest.get_modpath("myslopes").."/batmod.lua")
	
	end
