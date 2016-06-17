-- creative_node = default mod
-- ===========================
-- By: MineYoshi, see README.txt for more info


default = {}
default.NAME = "creative_node"
default.LIGHT_MAX = 17

---Item Stack 

minetest.nodedef_default.stack_max      = 999
minetest.craftitemdef_default.stack_max = 999

---Load Code---
dofile(core.get_modpath("default") .. "/code/code_init.lua")
