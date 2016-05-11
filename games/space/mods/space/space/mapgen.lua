minetest.register_node("space:air", {
	description = "Air",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	post_effect_color = {a = 20, r = 220, g = 200, b = 100},
	groups = {msa=1,not_in_creative_inventory=0},
	paramtype = "light",
	sunlight_propagates =true,
	drawtype = "glasslike",
	tiles = {"default_cloud.png^[colorize:#E0E0E033"},
	alpha = 0.1,
})

minetest.register_node("space:water", {
	description = "Space water",
	drawtype = "liquid",
	tiles = {"default_water.png"},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	liquid_viscosity = 1,
	liquidtype = "source",
	liquid_alternative_flowing="space:water",
	liquid_alternative_source="space:water",
	liquid_renewable = false,
	liquid_range = 0,
	drowning = 1,
	sunlight_propagates = true,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, puts_out_fire = 1,crumbly = 3},
})

minetest.register_node("space:astroid_spawner", {
	description = "Astroid spawner",
	drawtype="airlike",
	groups = {not_in_creative_inventory=1}
})

minetest.register_node("space:ore_pawner", {
	description = "Ore spawner",
	drawtype="airlike",
	groups = {not_in_creative_inventory=1}
})

minetest.register_node("space:moon_stone", {
	description = "Moon stone",
	tiles = {"default_gravel.png^[colorize:#ffffff22"},
	groups = {spacestuff=1,cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("space:stone", {
	description = "Stone",
	tiles = {"default_stone.png"},
	groups = {cracky = 1,stone=1,spacestuff=1},
	sounds = default.node_sound_stone_defaults(),
	drop="default:cobble"
})

minetest.register_abm({
	nodenames = {"space:astroid_spawner"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name = "default:stone"})
		if minetest.find_node_near(pos, 10,{"group:spacestuff"}) then return end
		local r=math.random(1,10)
		if r>5 then r=math.random(1,10) end
		if r>6 then r=math.random(1,10) end
		local t=minetest.get_modpath("space").."/schematics/space_astroid" .. r .. ".mts"
		minetest.place_schematic({x=pos.x,y=pos.y,z=pos.z}, t,"random",nil,false)
	end,
})

minetest.register_abm({
	nodenames = {"space:ore_pawner"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local r=math.random(1,8)
		if space.ores[r].scarcity==6 then r=math.random(1,8) end
		minetest.set_node(pos, {name = space.ores[r].ore})
	end,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone",
	wherein        = "air",
	clust_scarcity =  80 * 80 * 80,
	clust_num_ores = 1,
	clust_size     = 1,
	y_min          = space.y,
	y_max          = 31000,
})

space.ores={
{scarcity=6,ore="space:water"},
{scarcity=6,ore="default:ice"},
{scarcity=6,ore="default:stone_with_diamond"},
{scarcity=6,ore="default:stone_with_mese"},
{scarcity=6,ore="default:stone_with_gold"},
{scarcity=5,ore="default:stone_with_copper"},
{scarcity=4,ore="default:stone_with_iron"},
{scarcity=2,ore="default:stone_with_coal"},
{scarcity=1,ore="space:astroid_spawner"},
}

for i, ore in pairs(space.ores) do
minetest.register_ore({
	ore_type       = "scatter",
	ore            = ore.ore,
	wherein        = "default:stone",
	clust_scarcity =  ore.scarcity * ore.scarcity * ore.scarcity,
	clust_num_ores = 1,
	clust_size     = 1,
	y_min          = space.y,
	y_max          =31000,
})
if ore.scarcity~=1 then
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = ore.ore,
		wherein        = "space:stone",
		clust_scarcity =  (ore.scarcity*3) * (ore.scarcity*3) * (ore.scarcity*3),
		clust_num_ores = 1,
		clust_size     = 1,
		y_min          = space.y,
		y_max          = 31000,
	})
end
end

space.ores[8]={scarcity=2,ore="default:stone"}