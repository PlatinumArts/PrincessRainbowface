minetest.register_craftitem("lovemod:chocolate", {
    description = "Chocolate (Click To Eat)",
    inventory_image = "chocolate.png",
    on_use = minetest.item_eat(1, "lovemod:chocolate_wrapper")
})

--Here goes the craft_recipe of the chocolate

minetest.register_craftitem("lovemod:chocolate_wrapper", {
    description = "Chocolate Wrapper"
    inventory_image = "chocolate_wrapper.png",
})

minetest.register_craft({
  type = "shapeless",
  output = "lovemod:chocolate_wrapper",
  recipe = {"default:paper", "default:paper"}
})


minetest.register_craftitem("lovemod:chocolate_box", {
    description = "Chocolate Box (Is Empty)",
    inventory_image = "chocolate_box.png"
})

minetest.register_craft({
    type = "shapeless",
    output = "lovemod:chocolate_box",
    recipe = {"default:paper", "default:paper", "default:paper", "default:paper"}
})

