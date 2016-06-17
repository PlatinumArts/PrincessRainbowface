-- creative_node = default mod
-- ===========================
-- By: MineYoshi, see README.txt for more info


default = {}
default.NAME = "creative_node"
default.LIGHT_MAX = 17

---Item Stack 

minetest.nodedef_default.stack_max = 999
minetest.craftitemdef_default.stack_max = 999

---Load Code---
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/items.lua")
dofile(minetest.get_modpath("default").."/player.lua")
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
