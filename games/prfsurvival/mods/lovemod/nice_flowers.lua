---Flowers

minetest.register_craftitem("lovemod:nice_roses", {
	description = "Bouquet Of Roses",
	inventory_image = "red_roses.bmp"
})

minetest.register_craftitem("lovemod:nice_tulips", {
   description = "Bouquet Of Tulips",
   inventory_image = "tulips.bmp"
})

minetest.register_craft({
	output = "lovemod:nice_roses",
	recipe = {
		{"flowers:rose", "flowers:rose"},
	}
})

minetest.register_craft({
	output = "lovemod:nice_tulips",
	recipe = {
		{"flowers:tulip", "flowers:tulip"},
	}
})
minetest.register_craftitem("lovemod:nice_geraniums", {
  description = "Bouquet Of Geraniums",
  inventory_image = "geraniums.bmp"
})

minetest.register_craftitem("lovemod:nice_violas", {
  description = "Bouquet Of Violas",
  inventory_image = "violas.bmp"
})

minetest.register_craft({
	output = "lovemod:nice_geraniums",
	recipe = {
		{"flowers:geranium", "flowers:geranium"},
	}
})

minetest.register_craft({
	output = "lovemod:nice_violas",
	recipe = {
		{"flowers:viola", "flowers:viola"},
	}
})
