local stone_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
		}
	}
local sstone_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	}

local sq_cbox = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, -0.3125, 0.4375},
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
		}
	}
local s_sq_cbox = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, 0.5, 0.4375},
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	}
local smsq_cbox = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, -0.0625, -0.3125, -0.0625},
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
			{-0.4375, -0.5, 0.0625, -0.0625, -0.3125, 0.4375},
			{0.0625, -0.5, -0.4375, 0.4375, -0.3125, -0.0625},
			{0.0625, -0.5, 0.0625, 0.4375, -0.3125, 0.4375},
		}
	}
local s_smsq_cbox = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, -0.0625, 0.5, -0.0625},
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
			{-0.4375, -0.5, 0.0625, -0.0625, 0.5, 0.4375},
			{0.0625, -0.5, -0.4375, 0.4375, 0.5, -0.0625},
			{0.0625, -0.5, 0.0625, 0.4375, 0.5, 0.4375},
		}
	}
local xsmsq_cbox = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, -0.1875, -0.3125, -0.1875},
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
			{-0.4375, -0.5, 0.1875, -0.1875, -0.3125, 0.4375},
			{0.1875, -0.5, -0.4375, 0.4375, -0.3125, -0.1875},
			{0.1875, -0.5, 0.1875, 0.4375, -0.3125, 0.4375},
			{-0.4375, -0.5, -0.125, -0.1875, -0.3125, 0.125},
			{-0.125, -0.5, 0.1875, 0.125, -0.3125, 0.4375},
			{-0.125, -0.5, -0.125, 0.125, -0.3125, 0.125},
			{0.1875, -0.5, -0.125, 0.4375, -0.3125, 0.125},
			{-0.125, -0.5, -0.4375, 0.125, -0.3125, -0.1875},
		}
	}
local s_xsmsq_cbox = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, -0.1875, 0.5, -0.1875},
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
			{-0.4375, -0.5, 0.1875, -0.1875, 0.5, 0.4375},
			{0.1875, -0.5, -0.4375, 0.4375, 0.5, -0.1875},
			{0.1875, -0.5, 0.1875, 0.4375, 0.5, 0.4375},
			{-0.4375, -0.5, -0.125, -0.1875, 0.5, 0.125},
			{-0.125, -0.5, 0.1875, 0.125, 0.5, 0.4375},
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			{0.1875, -0.5, -0.125, 0.4375, 0.5, 0.125},
			{-0.125, -0.5, -0.4375, 0.125, 0.5, -0.1875},
		}
	}
local paver_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.3125, -0.3125, -0.3125, 0.5},
			{-0.25, -0.5, 0.3125, -0.0625, -0.3125, 0.5},
			{-0.5, -0.5, 0.0625, -0.0625, -0.3125, 0.25}, 
			{0, -0.5, 0.0625, 0.1875, -0.3125, 0.5}, 
			{-0.5, -0.5, -0.4375, -0.3125, -0.3125, 0},
			{-0.25, -0.5, -0.1875, 0.1875, -0.3125, 0}, 
			{0.25, -0.5, 0.3125, 0.5, -0.3125, 0.5}, 
			{0.25, -0.5, -0.1875, 0.4375, -0.3125, 0.25}, 
			{-0.25, -0.5, -0.5, -0.0625, -0.3125, -0.25}, 
			{0, -0.5, -0.4375, 0.4375, -0.3125, -0.25}, 
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, 
		}
	}
local spaver_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.3125, -0.3125, 0.5, 0.5},
			{-0.25, -0.5, 0.3125, -0.0625, 0.5, 0.5},
			{-0.5, -0.5, 0.0625, -0.0625, 0.5, 0.25}, 
			{0, -0.5, 0.0625, 0.1875, 0.5, 0.5}, 
			{-0.5, -0.5, -0.4375, -0.3125, 0.5, 0},
			{-0.25, -0.5, -0.1875, 0.1875, 0.5, 0}, 
			{0.25, -0.5, 0.3125, 0.5, 0.5, 0.5}, 
			{0.25, -0.5, -0.1875, 0.4375, 0.5, 0.25}, 
			{-0.25, -0.5, -0.5, -0.0625, 0.5, -0.25}, 
			{0, -0.5, -0.4375, 0.4375, 0.5, -0.25}, 
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5}, 
		}
	}
local ashlar_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, -0.375, -0.3125, 0.5}, 
			{-0.5, -0.5, 0.1875, -0.375, -0.3125, 0.3125}, 
			{-0.3125, -0.5, 0.1875, -0.0625, -0.3125, 0.5}, 
			{0, -0.5, 0.375, 0.25, -0.3125, 0.5}, 
			{0.3125, -0.5, 0.375, 0.5, -0.3125, 0.5}, 
			{-0.5, -0.5, -0.1875, -0.1875, -0.3125, 0.125}, 
			{-0.5, -0.5, -0.5, -0.375, -0.3125, -0.25}, 
			{-0.3125, -0.5, -0.375, -0.1875, -0.3125, -0.25}, 
			{-0.125, -0.5, -0.0625, -0.0625, -0.3125, 0.125}, 
			{-0.125, -0.5, -0.375, 0.0625, -0.3125, -0.125}, 
			{0, -0.5, -0.0625, 0.0625, -0.3125, 0}, 
			{0, -0.5, 0.0625, 0.3125, -0.3125, 0.3125}, 
			{0.375, -0.5, 0.1875, 0.5, -0.3125, 0.3125}, 
			{0.375, -0.5, -0.1875, 0.5, -0.3125, 0.125}, 
			{0.125, -0.5, -0.1875, 0.3125, -0.3125, 0}, 
			{0.125, -0.5, -0.375, 0.25, -0.3125, -0.25}, 
			{-0.3125, -0.5, -0.5, -0.0625, -0.3125, -0.4375}, 
			{0, -0.5, -0.5, 0.25, -0.3125, -0.4375}, 
			{0.3125, -0.5, -0.5, 0.5, -0.3125, -0.25}, 
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5}, 
		}
	}
local sashlar_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5}, 
			{-0.5, -0.5, 0.1875, -0.375, 0.5, 0.3125}, 
			{-0.3125, -0.5, 0.1875, -0.0625, 0.5, 0.5}, 
			{0, -0.5, 0.375, 0.25, 0.5, 0.5}, 
			{0.3125, -0.5, 0.375, 0.5, 0.5, 0.5}, 
			{-0.5, -0.5, -0.1875, -0.1875, 0.5, 0.125}, 
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.25}, 
			{-0.3125, -0.5, -0.375, -0.1875, 0.5, -0.25}, 
			{-0.125, -0.5, -0.0625, -0.0625, 0.5, 0.125}, 
			{-0.125, -0.5, -0.375, 0.0625, 0.5, -0.125}, 
			{0, -0.5, -0.0625, 0.0625, 0.5, 0}, 
			{0, -0.5, 0.0625, 0.3125, 0.5, 0.3125}, 
			{0.375, -0.5, 0.1875, 0.5, 0.5, 0.3125}, 
			{0.375, -0.5, -0.1875, 0.5, 0.5, 0.125}, 
			{0.125, -0.5, -0.1875, 0.3125, 0.5, 0}, 
			{0.125, -0.5, -0.375, 0.25, 0.5, -0.25}, 
			{-0.3125, -0.5, -0.5, -0.0625, 0.5, -0.4375}, 
			{0, -0.5, -0.5, 0.25, 0.5, -0.4375}, 
			{0.3125, -0.5, -0.5, 0.5, 0.5, -0.25}, 
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5}, 
		}
	}
local flag_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.0625, -0.0625, -0.3125, 0.5},
			{-0.5, -0.5, -0.1875, -0.25, -0.3125, 0},
			{-0.5, -0.5, -0.4375, -0.25, -0.3125, -0.25},
			{0, -0.5, 0.3125, 0.4375, -0.3125, 0.5},
			{0, -0.5, 0.0625, 0.1875, -0.3125, 0.25},
			{-0.1875, -0.5, -0.4375, 0.1875, -0.3125, 0},
			{0.25, -0.5, -0.1875, 0.4375, -0.3125, 0.25},
			{0.25, -0.5, -0.4375, 0.5, -0.3125, -0.25},
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
		}
	}
local sflag_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.0625, -0.0625, 0.5, 0.5},
			{-0.5, -0.5, -0.1875, -0.25, 0.5, 0},
			{-0.5, -0.5, -0.4375, -0.25, 0.5, -0.25},
			{0, -0.5, 0.3125, 0.4375, 0.5, 0.5},
			{0, -0.5, 0.0625, 0.1875, 0.5, 0.25},
			{-0.1875, -0.5, -0.4375, 0.1875, 0.5, 0},
			{0.25, -0.5, -0.1875, 0.4375, 0.5, 0.25},
			{0.25, -0.5, -0.4375, 0.5, 0.5, -0.25},
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	}
local pin_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.125, -0.25, -0.3125, 0.5},
			{-0.5, -0.5, -0.4375, 0.125, -0.3125, -0.1875},
			{0.1875, -0.5, -0.4375, 0.4375, -0.3125, 0.1875},
			{-0.1875, -0.5, 0.25, 0.4375, -0.3125, 0.5},
			{-0.1875, -0.5, -0.125, 0.125, -0.3125, 0.1875},
			{-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
		}
	}
local spin_cbox = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.125, -0.25, 0.5, 0.5},
			{-0.5, -0.5, -0.4375, 0.125, 0.5, -0.1875},
			{0.1875, -0.5, -0.4375, 0.4375, 0.5, 0.1875},
			{-0.1875, -0.5, 0.25, 0.4375, 0.5, 0.5},
			{-0.1875, -0.5, -0.125, 0.125, 0.5, 0.1875},
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	}



local stone_types = { --style, desc, img1, img2
	{"square", "Square", "concrete", "square",sq_cbox,s_sq_cbox},
	{"square_sm", "Small Square", "concrete", "square_sm",smsq_cbox,s_smsq_cbox},
	{"square_xsm", "Extra Small Square", "concrete", "square_xsm",xsmsq_cbox,s_xsmsq_cbox},
	{"pavers", "Paver", "concrete", "pavers",paver_cbox,spaver_cbox},
	{"ashlar", "Ashlar", "concrete", "ashlar",ashlar_cbox,sashlar_cbox},
	{"flagstone", "Flagstone", "concrete", "flagstone",flag_cbox,sflag_cbox},
	{"pinwheel", "Pinwheel", "concrete", "pinwheel",pin_cbox,spin_cbox},
}
for i in ipairs (stone_types) do
	local style = stone_types[i][1]
	local desc = stone_types[i][2]
	local img1 = stone_types[i][3]
	local img2 = stone_types[i][4]
	local cbox = stone_types[i][5]
	local scbox = stone_types[i][6]

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

minetest.register_alias("mylandscaping:stone_"..style,"mylandscaping:stone_"..style.."cement")

minetest.register_node("mylandscaping:stone_"..style..col,{
	description = desc.." Patio Stone"..coldesc,
	drawtype = "nodebox",
	tiles = {
		"mylandscaping_"..img1..".png^mylandscaping_"..img2..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		},
	paramtype = "light",
	groups = {cracky = 2, not_in_creative_inventory=1, ml=1,},
	node_box = cbox,
	selection_box = stone_cbox,
	collision_box = stone_cbox,
	sounds = default.node_sound_stone_defaults(),
	
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		
		local nodeu = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name

		if nodeu == "default:sand" or
		   nodeu == "default:desert_sand" then
		   minetest.set_node({x=pos.x, y=pos.y-1, z=pos.z},{name = "mylandscaping:stone_"..style.."_sand"..col})
		   minetest.set_node(pos,{name = "air"})
		end
	end,

})
minetest.register_node("mylandscaping:stone_"..style.."_sand"..col,{
	description = desc.." Patio Stone in Sand "..coldesc,
	drawtype = "nodebox",
	tiles = {
		"mylandscaping_"..img1..".png^mylandscaping_"..img2..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		"mylandscaping_"..img1..".png"..alpha,
		},
	drop = "mylandscaping:stone_"..style,
	paramtype = "light",
	groups = {cracky = 2, not_in_creative_inventory = 1},
	node_box = scbox,
	selection_box = sstone_cbox,
	collision_box = sstone_cbox,
	sounds = default.node_sound_stone_defaults(),
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos,{name = "default:sand"})
	end,
})
end
end
