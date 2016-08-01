minetest.register_node("mylandscaping:concrete", {
	description = "Concrete",
	drawtype = "normal",
	tiles = {"mylandscaping_cement.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),

})
