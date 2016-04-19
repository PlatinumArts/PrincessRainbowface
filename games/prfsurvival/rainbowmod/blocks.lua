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
		{'', '', ''},

