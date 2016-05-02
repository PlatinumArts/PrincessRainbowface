---Flowers

minetest.register_craftitem("lovemod:nice_roses", {
	description = "Bouquet Of Roses",
	inventory_image = "nice_roses.png"
})

minetest.register_craftitem("lovemod:nice_tulips", {
   description = "Bouquet Of Tulips",
   inventory_image = "nice_tulips.png"
})

minetest.register_craft({
	type = "shapeless",
	output = "lovemod:nice_roses",
	recipe = {"flowers:rose", "flowers:rose"}
})

minetest.register_craft({
  type = "shapeless",
  output = "lovemod:nice_tulips",
  recipe = {"flowers:tulip", "flowers:tulip"}
)}

minetest.register_craftitem("lovemod:nice_geraniums", {
  description = "Bouquet Of Geraniums",
  inventory_image = "nice_geraniums.png"
)}

minetest.register_craftitem("lovemod:nice_violas", {
  description = "Bouquet Of Violas",
  inventory_image = "nice_violas.png"
)}

minetest.register_craft({
  type = "shapeless",
  output = "lovemod:nice_geraniums"
  recipe = {"flowers:geranium", "flowers:geranium"}
minetest.register_craft({
  type= "shapeless",
  output = "lovemod:nice_violas",
  reciper = {"flowers:viola", "flowers:viola"}
})
