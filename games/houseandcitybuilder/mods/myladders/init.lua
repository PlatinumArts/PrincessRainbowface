myladders = {}

myladders.colors = {
		{"black",		"Black", 		"^[colorize:#000000:240"},
		{"blue",		"Blue", 		"^[colorize:#0404B4:100"},
		{"brown",		"Brown", 		"^[colorize:#190B07:160"},
		{"cyan",		"Cyan",			"^[colorize:#00ffff:120"},
		{"darkgreen",	"Dark Green",	"^[colorize:#071907:200"},
		{"darkgrey",	"Dark Grey",	"^[colorize:#000000:200"},
		{"green",		"Green", 		"^[colorize:#00ff00:160"},
		{"grey",		"Grey", 		"^[colorize:#000000:160"},
		{"magenta",		"Magenta",		"^[colorize:#ff00ff:160"},
		{"orange",		"Orange",		"^[colorize:#ff7700:220"},
		{"pink",		"Pink",			"^[colorize:#FE2E9A:200"},
		{"red",			"Red",			"^[colorize:#B40404:200"},
		{"violet",		"Violet",		"^[colorize:#2F0B3A:220"},
		{"white",		"White",		"^[colorize:#ffffff:200"},
		{"yellow",		"Yellow",		"^[colorize:#ffff00:200"},
		}

local paintables = {
	"myladders:treehouse", "myladders:heavy", "myladders:ladder"
	}

for _, entry in ipairs(myladders.colors) do
	local mat = entry[1]
	local desc = entry[2]
	local alpha = entry[3]

local ladders_type = {   --Material , Description
	{"myladders:treehouse", "Treehouse", "myladders_tree.obj","myladders_treewood.png^[transformR90","myladders_treehouse_inv.png"},
	{"myladders:heavy", "Heavy Duty", "myladders_heavy.obj","myladders_heavy.png","myladders_heavy_inv.png"},
	{"myladders:ladder", "Default", "myladders_default.obj","default_wood.png","myladders_default_inv.png"},
}

for i in ipairs(ladders_type) do
	local typ = ladders_type[i][1]
	local desct = ladders_type[i][2]
	local mesht = ladders_type[i][3]
	local img = ladders_type[i][4]
	local inim = ladders_type[i][5]
----------------------------------------------------------------------------------------

minetest.register_node(typ.."_"..mat, {
	description = desc.." "..desct.." Ladder",
	drawtype = "mesh",
	mesh = mesht,
	tiles = {img..alpha},
	inventory_image = inim..alpha,
	wield_image = inim..alpha,
	paramtype = "light",
	paramtype2 = "facedir",
	climbable = true,
	is_ground_content = false,
	groups = {choppy=2,flammable=1, not_in_creative_inventory = 1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, 0.375, 0.375, 0.5, 0.5},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, 0.375, 0.375, 0.5, 0.5},
		}
	},
	sounds = default.node_sound_wood_defaults(),

})
minetest.register_node(typ, {
	description = desct.." Ladder",
	drawtype = "mesh",
	mesh = mesht,
	tiles = {img},
	inventory_image = inim,
	wield_image = inim,
	paramtype = "light",
	paramtype2 = "facedir",
	climbable = true,
	is_ground_content = false,
	groups = {choppy=2,flammable=1},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, 0.375, 0.375, 0.5, 0.5},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, 0.375, 0.375, 0.5, 0.5},
		}
	},
	sounds = default.node_sound_wood_defaults(),

})
end
end

minetest.register_craft({
	type = "shapeless",
	output = "myladders:ladder 2",
	recipe = {"default:ladder"}
})

minetest.register_craft({
	type = "shapeless",
	output = "myladders:treehouse_ladder 2",
	recipe = {"default:ladder","default:stick"}
})

minetest.register_craft({
	type = "shapeless",
	output = "myladders:heavy_ladder 1",
	recipe = {"default:ladder","default:ladder"}
})

if minetest.get_modpath("mypaint") then
local colors = {}
for _, entry in ipairs(myladders.colors) do
	table.insert(colors, entry[1])
end

mypaint.register(paintables, colors)
end
