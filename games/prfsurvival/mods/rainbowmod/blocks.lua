--This code is of the blocks (well, obvious? sometimes the life has no sense!)

minetest.register_node("rainbowmod:rainbow_block", {
	description = "Rainbow Block",
	tile_images = {"rainbow.png"},
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_craft({
	output = '"rainbowmod:rainbow_block" 1',
	recipe = {
		{'', '', 'air'},  --Why with air, simply a rainbow is in the sky, where there is many air, if you want get air try this: "giveme:air"
		{'', '', ''},
		{'', '', ''}
		}
})

--Blocks to do pixel art
minetest.register_node("rainbowmod:green_block",{
	description = "Green Block",
	tile_images = {"green.png"},
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_node("rainbowmod:yellow_block",{
	description = "Yellow Block",
	tile_images = {"yellow.png"},
	groups = {oddly_breakable_by_hand = 3},
})

minetest.register_node("rainbowmod:red_block",{
	description = "Red Block",
	tile_images = {"red.png"},
})

minetest.register_node("rainbowmod:blue_block",{
	description = "Blue Block",
	tile_images = {"blue.png"}
})

minetest.register_node("rainbowmod:white_block",{
	description = "White Block",
	tile_images = {"white.png"},
})

minetest.register_node("rainbowmod:orange_block",{
	description = "Orange Block",
	tile_images = {"orange.png"},
})

minetest.register_node("rainbowmod:purple_block",{
	description = "Purple Block",
	tile_images = {"purple.png"},
})
