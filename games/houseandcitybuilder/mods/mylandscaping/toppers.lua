local block_type1 = { -- desc2, obj, texture
{"Sphere", 		"sphere",	'concrete'},
{"Suzanne", 	"suzanne",	'concrete'},
{'Dragon', 		'dragon',	'dragon'},
{'Cross',	'cross',	'concrete'},
}
for i in ipairs (block_type1) do
	local desc2 = block_type1[i][1]
	local obj = block_type1[i][2]
	local tex = block_type1[i][3]

local color_tab = {
{"black", 	"Black",		"^[colorize:black:150"},
{"blue", 	"Blue",			"^[colorize:#0404B4:100"},
{"brown", 	"Brown",		"^[colorize:#190B07:100"},
{"cyan", 	"Cyan",			"^[colorize:cyan:100"},
{"dark_green", 	"Dark Green",		"^[colorize:#071907:150"},
{"dark_grey", 	"Dark Grey",		"^[colorize:black:150"},
{"green", 	"Green",		"^[colorize:green:100"},
{"grey", 	"Grey",			"^[colorize:black:100"},
{"magenta", 	"Magenta",		"^[colorize:magenta:100"},
{"orange",	"Orange",		"^[colorize:orange:100"},
{"pink", 	"Pink",			"^[colorize:#FE2E9A:100"},
{"red", 	"Red",			"^[colorize:#B40404:100"},
{"violet", 	"Violet",		"^[colorize:#2F0B3A:100"},
{"white", 	"White",		"^[colorize:white:100"},
{"yellow", 	"Yellow",		"^[colorize:yellow:100"},
{"cement", 	"Concrete",		""},
}
for i in ipairs (color_tab) do
local col = color_tab[i][1]
local coldesc = color_tab[i][2]
local alpha = color_tab[i][3]

minetest.register_node('mylandscaping:column_t_'..obj.."_"..col, {
	description = desc2..' topper',
	drawtype = 'mesh',
	mesh = 'mylandscaping_column_t_'..obj..'.obj',
	tiles = {name='mylandscaping_'..tex..'.png'..alpha},
	groups = {cracky=2, not_in_creative_inventory=mylandscaping_visible, ml=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	sounds = default.node_sound_stone_defaults(),
})

end
end

