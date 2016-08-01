-- [Mod] Angled Stairs [angledstairs] (1.0) by TumeniNodes 05-31-2016

angledstairs = {}

-- Register angledstairs.
-- Node will be called angledstairs:angled_stair_<subname>

function angledstairs.register_angled_stair(subname, recipeitem, groups, images, description, sounds)
	groups.angledstair = 1
minetest.register_node(":angledstairs:angled_stair_right" .. subname, {
	description = description,
	drawtype = "mesh",
	mesh = "angled_stairR.obj",
	tiles = images,
	paramtype = "light",
	paramtype2 = "facedir",
	facedir = simple,
	groups = groups,
	sounds = sounds,
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, 0.0625, 0.5, 0.5},
			{0.0625, -0.5, 0.0625, 0.125, 0.5, 0.5},
			{0.125, -0.5, 0.125, 0.1875, 0.5, 0.5},
			{0.1875, -0.5, 0.1875, 0.25, 0.5, 0.5},
			{0.25, -0.5, 0.25, 0.3125, 0.5, 0.5},
			{0.3125, -0.5, 0.3125, 0.375, 0.5, 0.5},
			{0.375, -0.5, 0.375, 0.4375, 0.5, 0.5},
			{0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375},
			{-0.5, -0.5, -0.4375, -0.375, 0.5, -0.375},
			{-0.5, -0.5, -0.375, -0.3125, 0.5, -0.3125},
			{-0.5, -0.5, -0.3125, -0.25, 0.5, -0.25},
			{-0.5, -0.5, -0.25, -0.1875, 0.5, -0.1875},
			{-0.5, -0.5, -0.1875, -0.125, 0.5, -0.125},
			{-0.5, -0.5, -0.125, -0.0625, 0.5, -0.0625},
			{-0.5, -0.5, -0.0625, 0, 0.5, 0},
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		}
	}
})

minetest.register_node(":angledstairs:angled_stair_left" .. subname, {
	description = description,
	drawtype = "mesh",
	mesh = "angled_stairL.obj",
	tiles = images,
	paramtype = "light",
	paramtype2 = "facedir",
	facedir = simple,
	groups = groups,
	sounds = sounds,
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, 0, 0.5, 0.5, 0.5},
			{-0.125, -0.5, 0.0625, -0.0625, 0.5, 0.5},
			{-0.1875, -0.5, 0.125, -0.125, 0.5, 0.5},
			{-0.25, -0.5, 0.1875, -0.1875, 0.5, 0.5},
			{-0.3125, -0.5, 0.25, -0.25, 0.5, 0.5},
			{-0.375, -0.5, 0.3125, -0.3125, 0.5, 0.5},
			{-0.4375, -0.5, 0.375, -0.375, 0.5, 0.5},
			{-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
			{0.4375, -0.5, -0.5, 0.5, 0.5, -0.4375},
			{0.375, -0.5, -0.4375, 0.5, 0.5, -0.375},
			{0.3125, -0.5, -0.375, 0.5, 0.5, -0.3125},
			{0.25, -0.5, -0.3125, 0.5, 0.5, -0.25},
			{0.1875, -0.5, -0.25, 0.5, 0.5, -0.1875},
			{0.125, -0.5, -0.1875, 0.5, 0.5, -0.125},
			{0.0625, -0.5, -0.125, 0.5, 0.5, -0.0625},
			{0, -0.5, -0.0625, 0.5, 0.5, 0},
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		}
	}
})
end

-- Register angledstairs.
-- Node will be called angledstairs:angled_slab_<subname>

function angledstairs.register_angled_slab(subname, recipeitem, groups, images, description, sounds)
	groups.angledslab = 1
minetest.register_node(":angledstairs:angled_slab_right" .. subname, {
	description = description,
	drawtype = "mesh",
	mesh = "angled_slabR.obj",
	tiles = images,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = groups,
	sounds = sounds,
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, 0.0625, 0, 0.5},
			{0.0625, -0.5, 0.0625, 0.125, 0, 0.5},
			{0.125, -0.5, 0.125, 0.1875, 0, 0.5},
			{0.1875, -0.5, 0.1875, 0.25, 0, 0.5},
			{0.25, -0.5, 0.25, 0.3125, 0, 0.5},
			{0.3125, -0.5, 0.3125, 0.375, 0, 0.5},
			{0.375, -0.5, 0.375, 0.4375, 0, 0.5},
			{0.4375, -0.5, 0.4375, 0.5, 0, 0.5},
			{-0.5, -0.5, -0.5, -0.4375, 0, -0.4375},
			{-0.5, -0.5, -0.4375, -0.375, 0, -0.375},
			{-0.5, -0.5, -0.375, -0.3125, 0, -0.3125},
			{-0.5, -0.5, -0.3125, -0.25, 0, -0.25},
			{-0.5, -0.5, -0.25, -0.1875, 0, -0.1875},
			{-0.5, -0.5, -0.1875, -0.125, 0, -0.125},
			{-0.5, -0.5, -0.125, -0.0625, 0, -0.0625},
			{-0.5, -0.5, -0.0625, 0, 0, 0},
		}
	}
})

minetest.register_node(":angledstairs:angled_slab_left" .. subname, {
	description = description,
	drawtype = "mesh",
	mesh = "angled_slabL.obj",
	tiles = images,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = groups,
	sounds = sounds,
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, 0, 0.5, 0, 0.5},
			{-0.125, -0.5, 0.0625, -0.0625, 0, 0.5},
			{-0.1875, -0.5, 0.125, -0.125, 0, 0.5},
			{-0.25, -0.5, 0.1875, -0.1875, 0, 0.5},
			{-0.3125, -0.5, 0.25, -0.25, 0, 0.5},
			{-0.375, -0.5, 0.3125, -0.3125, 0, 0.5},
			{-0.4375, -0.5, 0.375, -0.375, 0, 0.5},
			{-0.5, -0.5, 0.4375, -0.4375, 0, 0.5},
			{0.4375, -0.5, -0.5, 0.5, 0, -0.4375},
			{0.375, -0.5, -0.4375, 0.5, 0, -0.375},
			{0.3125, -0.5, -0.375, 0.5, 0, -0.3125},
			{0.25, -0.5, -0.3125, 0.5, 0, -0.25},
			{0.1875, -0.5, -0.25, 0.5, 0, -0.1875},
			{0.125, -0.5, -0.1875, 0.5, 0, -0.125},
			{0.0625, -0.5, -0.125, 0.5, 0, -0.0625},
			{0, -0.5, -0.0625, 0.5, 0, 0},
		}
	}
})
end

-- Angled stair/slab registration function.
-- Nodes will be called angledstairs:{angled_stair,angled_slab}_<subname>

function angledstairs.register_angled_stair_and_angled_slab(subname, recipeitem, groups, images,desc_angled_stair, desc_angled_slab, sounds)
	angledstairs.register_angled_stair(subname, recipeitem, groups, images, desc_angled_stair, sounds)
	angledstairs.register_angled_slab(subname, recipeitem, groups, images, desc_angled_slab, sounds)
end


-- Register angled stairs and slabs

angledstairs.register_angled_stair_and_angled_slab("wood", "default:wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_wood.png"},
		"Wooden Angled Stair",
		"Wooden Angled Slab",
		default.node_sound_wood_defaults())

angledstairs.register_angled_stair_and_angled_slab("junglewood", "default:junglewood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_junglewood.png"},
		"Junglewood Angled Stair",
		"Junglewood Angled Slab",
		default.node_sound_wood_defaults())

angledstairs.register_angled_stair_and_angled_slab("pine_wood", "default:pine_wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_pine_wood.png"},
		"Pine Wood Stair",
		"Pine Wood Slab",
		default.node_sound_wood_defaults())

angledstairs.register_angled_stair_and_angled_slab("acacia_wood", "default:acacia_wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_acacia_wood.png"},
		"Acacia Wood Stair",
		"Acacia Wood Slab",
		default.node_sound_wood_defaults())

angledstairs.register_angled_stair_and_angled_slab("aspen_wood", "default:aspen_wood",
		{snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
		{"default_aspen_wood.png"},
		"Aspen Wood Stair",
		"Aspen Wood Slab",
		default.node_sound_wood_defaults())

angledstairs.register_angled_stair_and_angled_slab("stone", "default:stone",
		{cracky = 3},
		{"default_stone.png"},
		"Stone Stair",
		"Stone Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("cobble", "default:cobble",
		{cracky = 3},
		{"default_cobble.png"},
		"Cobblestone Stair",
		"Cobblestone Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("stonebrick", "default:stonebrick",
		{cracky = 3},
		{"default_stone_brick.png"},
		"Stone Brick Stair",
		"Stone Brick Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("desert_stone", "default:desert_stone",
		{cracky = 3},
		{"default_desert_stone.png"},
		"Desertstone Stair",
		"Desertstone Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("desert_cobble", "default:desert_cobble",
		{cracky = 3},
		{"default_desert_cobble.png"},
		"Desert Cobblestone Stair",
		"Desert Cobblestone Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("desert_stonebrick", "default:desert_stonebrick",
		{cracky = 3},
		{"default_desert_stone_brick.png"},
		"Desert Stone Brick Stair",
		"Desert Stone Brick Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("sandstone", "default:sandstone",
		{crumbly = 1, cracky = 3},
		{"default_sandstone.png"},
		"Sandstone Stair",
		"Sandstone Slab",
		default.node_sound_stone_defaults())
		
angledstairs.register_angled_stair_and_angled_slab("sandstonebrick", "default:sandstonebrick",
		{cracky = 2},
		{"default_sandstone_brick.png"},
		"Sandstone Brick Stair",
		"Sandstone Brick Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("obsidian", "default:obsidian",
		{cracky = 1, level = 2},
		{"default_obsidian.png"},
		"Obsidian Stair",
		"Obsidian Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("obsidianbrick", "default:obsidianbrick",
		{cracky = 1, level = 2},
		{"default_obsidian_brick.png"},
		"Obsidian Brick Stair",
		"Obsidian Brick Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("brick", "default:brick",
		{cracky = 3},
		{"default_brick.png"},
		"Brick Stair",
		"Brick Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("steelblock", "default:steelblock",
		{cracky = 1, level = 2},
		{"default_steel_block.png"},
		"Steel Block Stair",
		"Steel Block Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("copperblock", "default:copperblock",
		{cracky = 1, level = 2},
		{"default_copper_block.png"},
		"Copper Block Stair",
		"Copper Block Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("bronzeblock", "default:bronzeblock",
		{cracky = 1, level = 2},
		{"default_bronze_block.png"},
		"Bronze Block Stair",
		"Bronze Block Slab",
		default.node_sound_stone_defaults())

angledstairs.register_angled_stair_and_angled_slab("goldblock", "default:goldblock",
		{cracky = 1},
		{"default_gold_block.png"},
		"Gold Block Stair",
		"Gold Block Slab",
		default.node_sound_stone_defaults())
