
function mysiding.register_all(mat, desc, image, groups, craft)

minetest.register_node("mysiding:wide_"..mat, {
	description = desc.." Wide Siding",
	drawtype = "normal",
	tiles = {
		image,
		image,
		image,
		image,
		image,
		image.."^mysiding_pattern1.png",
		},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky = 2,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("mysiding:narrow_"..mat, {
	description = desc.." Narrow Siding",
	drawtype = "normal",
	tiles = {
		image,
		image,
		image,
		image,
		image,
		image.."^mysiding_pattern2.png",
		},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky = 2,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})




end
