local colbox_type1 = { --top blocks
	type = "fixed",
	fixed = {{-.49, -.5, 0.05, .5, .6, .52}}
}
local colbox_type2 = { --outside corner columns
	type = "fixed",
	fixed = {{-.2, -.5, -.2, .5, .5, .5}}
}
local colbox_type3 = { --bottom blocks
	type = "fixed",
	fixed = {{-.5, -.5, -.16, .5, .5, .25}}
}
local colbox_type4 = { --inside corner
	type = "fixed",
	fixed = {{-.5, -.5, 0, .5, .5, .5},
		{0, -.5, -.5, .5, .5, .5}}
}
local colbox_type5 = { --inside corner column
	type = "fixed",
	fixed = {{-.5, -.5, -.5, .5, .5, .5},}
}
local colbox_type6 = { --middle column
	type = "fixed",
	fixed = {{-.5, -.5, -.3, .5, .5, .5},}
}

local colbox_type7 = { --outside corner
	type = 'fixed',
	fixed = {{-.5, -.5, -.3, .5, .5, .5},}
}

local block_type1 = { -- desc2, typ, obj, colbox, drops, grup
{"Retaining Wall Left", 		"left", 		"blocka_l_t",	colbox_type1, "left",   	{ml=1,cracky=2,not_in_creative_inventory=mylandscaping_visible}},
{"Retaining Wall Middle", 		"middle",		"blocka_m_t",	colbox_type1, "middle", 	{ml=1,cracky=2,not_in_creative_inventory=mylandscaping_visible}},
{"Retaining Wall Right", 		"right",		"blocka_r_t",	colbox_type1, "right",  	{ml=1,cracky=2,not_in_creative_inventory=mylandscaping_visible}},
{"Retaining Wall Inside Corner", 		"icorner",		"blocka_ic_t",	colbox_type4, "icorner", 	{ml=1,cracky=2,not_in_creative_inventory=mylandscaping_visible}},
{"Retaining Wall Outside Corner", 		"ocorner",		"blocka_oc_t",	colbox_type2, "ocorner", 	{ml=1,cracky=2,not_in_creative_inventory=mylandscaping_visible}},
{"Retaining Wall Left Bot", 	"bleft", 		"blocka_l_b",	colbox_type3, "left",   	{not_in_creative_inventory=mylandscaping_visible}},
{"Retaining Wall Middle Bot", 	"bmiddle",		"blocka_m_b",	colbox_type3, "middle", 	{not_in_creative_inventory=mylandscaping_visible}},
{"Retaining Wall Right Bot", 	"bright",		"blocka_r_b",	colbox_type3, "right",  	{not_in_creative_inventory=mylandscaping_visible}},
{"Retaining Wall Inside Corner Bot", 	"bicorner",		"blocka_ic_b",	colbox_type4, "icorner", 	{not_in_creative_inventory=mylandscaping_visible}},
{"Retaining Wall Outside Corner Bot", 	"bocorner",		"blocka_oc_b",	colbox_type2, "ocorner", 	{not_in_creative_inventory=mylandscaping_visible}},
{"Column Inside Corner",     	"column_ic_t",	"columna_ic_t",	colbox_type5, "column_ic_t",  	{ml=1,cracky=2,not_in_creative_inventory=mylandscaping_visible}},
{"Column Outside Corner",   	"column_oc_t",	"columna_oc_t",	colbox_type2, "column_oc_t",  	{ml=1,cracky=2,not_in_creative_inventory=mylandscaping_visible}},
{"Column Middle", 	    		"column_m_t",	"columna_m_t",	colbox_type6, "column_m_t",   	{ml=1,cracky=2,not_in_creative_inventory=mylandscaping_visible}},
{"Column Inside Corner Bot", 	"bcolumn_ic_t",	"columna_ic_b",	colbox_type5, "column_ic_b",  	{not_in_creative_inventory=mylandscaping_visible}},
{"Column Outside Corner Bot",	"bcolumn_oc_t",	"columna_oc_b",	colbox_type2, "column_oc_b",  	{not_in_creative_inventory=mylandscaping_visible}},
{"Column Middle Bot", 	     	"bcolumn_m_t",	"columna_m_b",	colbox_type6, "column_m_b",   	{not_in_creative_inventory=mylandscaping_visible}},
}
for i in ipairs (block_type1) do
	local desc2 = block_type1[i][1]
	local typ = block_type1[i][2]
	local obj = block_type1[i][3]
	local colbox = block_type1[i][4]
	local drops = block_type1[i][5]
	local grup = block_type1[i][6]

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

minetest.register_node('mylandscaping:awall_'..typ.."_"..col, {
	description = desc2.." "..coldesc,
	drawtype = 'mesh',
	mesh = 'mylandscaping_'..obj..'.obj',
	tiles = {name='mylandscaping_adaridge_tex.png'..alpha},
	groups = grup,
	paramtype = 'light',
	paramtype2 = 'facedir',
	drop = 'mylandscaping:awall_'..drops.."_"..col,
	selection_box = colbox,
	collision_box = colbox,
	sounds = default.node_sound_stone_defaults(),

after_place_node = function(pos, placer, itemstack, pointed_thing)
	local nodeu = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
	local nodea = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
	local node = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
	if nodeu.name == "mylandscaping:awall_"..typ.."_"..col then
	   minetest.set_node(pos,{name="mylandscaping:awall_"..typ.."_"..col,param2=nodeu.param2})
	   minetest.set_node({x=pos.x,y=pos.y-1,z=pos.z},{name="mylandscaping:awall_b"..typ.."_"..col,param2=nodeu.param2})
	end
	if nodea.name == "mylandscaping:awall_"..typ..col then
	   minetest.set_node(pos,{name="mylandscaping:awall_b"..typ.."_"..col,param2=node.param2})
	end
end,

after_destruct = function(pos, oldnode)
	local node = minetest.get_node(pos).name
	local nodeu = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
	local nodea = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})

	if nodeu.name == "mylandscaping:awall_b"..typ.."_"..col and
	   nodea.name == "air" then
	   minetest.set_node({x=pos.x,y=pos.y-1,z=pos.z},{name="mylandscaping:awall_"..typ.."_"..col,param2=nodeu.param2})
	end

end,

})

end
end
