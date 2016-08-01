local slope_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
}

local icorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.5, -0.25, 0.5, 0, 0.5},
		{-0.5, -0.5, -0.5, 0.25, 0, 0.5},
		{-0.5, 0, -0.5, 0, 0.25, 0.5},
		{-0.5, 0, 0, 0.5, 0.25, 0.5},
		{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5},
		{-0.5, 0.25, -0.5, -0.25, 0.5, 0.5},
	}
}

local ocorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
		{-0.5,     0,     0,     0,  0.25, 0.5},
		{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5}
	}
}
local moreblocks_slopes = {   --Material , Description , Item, Image
	{ "cactus_brick" ,        "Cactus Brick" ,         "moreblocks:cactus_brick",        "cactus_brick"},
	{ "cactus_checker" ,      "Cactus Checker" ,       "moreblocks:cactus_checker",      "cactus_checker"},
	{ "coal_stone_bricks" ,   "Coal Stone Bricks" ,    "moreblocks:coal_stone_bricks",   "coal_stone_bricks"},
	{ "circle_stone_bricks" , "Circle Stone Bricks" ,  "moreblocks:circle_stone_bricks", "circle_stone_bricks"},
	{ "iron_checker" ,        "Iron Checker" ,         "moreblocks:iron_checker",        "iron_checker"},
	{ "iron_stone_bricks" ,   "Iron Stone Bricks" ,    "moreblocks:iron_stone_bricks",   "iron_stone_bricks"},
	{ "plankstone" ,          "Plankstone" ,           "moreblocks:plankstone",          "plankstone"},
	{ "stone_tile" ,          "Stone Tile" ,           "moreblocks:stone_tile",          "stone_tile"},
	{ "wood_tile_center" ,    "Wood Tile Center" ,     "moreblocks:wood_tile_center",    "wood_tile_center"},
	{ "wood_tile_full" ,      "Wood Tile Full" ,       "moreblocks:wood_tile_full",      "wood_tile_full"},
}

for i in ipairs(moreblocks_slopes) do
	local mat = moreblocks_slopes[i][1]
	local desc = moreblocks_slopes[i][2]
	local item = moreblocks_slopes[i][3]
	local img = moreblocks_slopes[i][4]

--slope
minetest.register_node("myslopes:"..mat.."_slope", {
	description = desc.." Slope",
	drawtype = "mesh",
	mesh = "twelve-twelve.obj",
	tiles = {"moreblocks_"..img..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = slope_cbox,
	selection_box = slope_cbox
})
--icorner
minetest.register_node("myslopes:"..mat.."_icorner", {
	description = desc.." Slope Inside Corner",
	drawtype = "mesh",
	mesh = "twelve-twelve-ic.obj",
	tiles = {"moreblocks_"..img..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = icorner_cbox,
	selection_box = icorner_cbox
})
--ocorner
minetest.register_node("myslopes:"..mat.."_ocorner", {
	description = desc.." Slope Outside Corner",
	drawtype = "mesh",
	mesh = "twelve-twelve-oc.obj",
	tiles = {"moreblocks_"..img..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	collision_box = ocorner_cbox,
	selection_box = ocorner_cbox
})

--Crafts--------------------------------------------------------

--slope
minetest.register_craft({
	output = "myslopes:"..mat.."_slope 3",
	recipe = {
		{"", "",""},
		{item, "",""},
		{item, item,""},
	}
})
--slope icorner
minetest.register_craft({
	output = "myslopes:"..mat.."_icorner 3",
	recipe = {
		{"", "",""},
		{"", item,""},
		{item,"", item},
	}
})
--slope ocorner
minetest.register_craft({
	output = "myslopes:"..mat.."_ocorner 3",
	recipe = {
		{"", "",""},
		{item, "",item},
		{"", item,""},
	}
})

--rotated-----------------------------------------------
--slope
minetest.register_craft({
	output = "myslopes:"..mat.."_slope_r 1",
	recipe = {
		{"", "",""},
		{"", "myslopes:"..mat.."_slope",""},
		{"", "",""},
	}
})
--slope icorner
minetest.register_craft({
	output = "myslopes:"..mat.."_icorner_r 1",
	recipe = {
		{"", "",""},
		{"", "myslopes:"..mat.."_icorner",""},
		{"", "",""},
	}
})
--slope ocorner
minetest.register_craft({
	output = "myslopes:"..mat.."_ocorner_r 1",
	recipe = {
		{"", "",""},
		{"", "myslopes:"..mat.."_ocorner",""},
		{"", "",""},
	}
})
--]]
end






