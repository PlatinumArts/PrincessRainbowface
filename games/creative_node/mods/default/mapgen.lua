function default.register_biomes()
	minetest.clear_registered_biomes()

	-- First (test) Biome

minetest.register_biome({
		name = "test",
		node_dust = "default:stone",
		node_top = "default:grass",
		depth_top = 7,
		node_filler = "default:dirt",
		depth_filler = 3,
		node_stone = "default:stone",
		node_water_top = "default:alphnium",
		depth_water_top = 10,
		node_water = "default:alphnium",
		node_river_water = "default:alphnium",
		y_min = -8,
		y_max = 31000,
		heat_point = 0,
		humidity_point = 20,
	})
end
