--configs
-- change this to make blocks show in creative inventory. 0 will show, 1 is invisible
mylandscaping_visible = 1

--Load File
dofile(minetest.get_modpath('mylandscaping')..'/walls_freeport.lua')
dofile(minetest.get_modpath('mylandscaping')..'/walls_madison.lua')
dofile(minetest.get_modpath('mylandscaping')..'/walls_adaridge.lua')
dofile(minetest.get_modpath('mylandscaping')..'/walls_deco.lua')
dofile(minetest.get_modpath('mylandscaping')..'/stones.lua')
dofile(minetest.get_modpath('mylandscaping')..'/recipes.lua')
dofile(minetest.get_modpath("mylandscaping").."/machine.lua")
dofile(minetest.get_modpath("mylandscaping").."/mixer.lua")
dofile(minetest.get_modpath('mylandscaping')..'/concrete.lua')
dofile(minetest.get_modpath('mylandscaping')..'/formspec.lua')
dofile(minetest.get_modpath('mylandscaping')..'/toppers.lua')
