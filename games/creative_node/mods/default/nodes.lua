---Nodes.lua



minetest.register_node("default:grass", {
	description = "Grass",
	tiles = {"grass.png"},
	groups = {crumbly=3}
})

minetest.register_node("default:dirt", {
	description = "Dirt",
	tiles = {"dirt.png"},
	groups = {crumbly=3}
})

minetest.register_node("default:sand", {
	description = "Sand",
	tiles = {"sand.png"},
	groups = {crumbly=3}
})

minetest.register_node("default:stone", {
	description = "Stone",
	tiles = {"stone.png"},
	groups = {cracky=1}
})

minetest.register_node("default:alphnium", {
	description = "Alphnium Ore",
	tiles = {"alphnium.png"},
	groups = {cracky=2},
	drop = "default:alphynium_ore"
})


