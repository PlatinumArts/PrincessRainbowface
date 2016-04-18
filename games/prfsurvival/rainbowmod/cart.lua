---Under Building, Feature added soon!

dofile(minetest.get_modpath("rainbowmod").."/functions.lua")


---The rainbow cart!
minetest.register_craftitem("carts:cart", {
	description = "Minecart",
	inventory_image = minetest.inventorycube("cart_top.png", "cart_side.png", "cart_side.png"),
	wield_image = "cart_side.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if not pointed_thing.type == "node" then
			return
		end
		if cart_func:is_rail(pointed_thing.under) then
			minetest.env:add_entity(pointed_thing.under, "carts:cart")
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		elseif cart_func:is_rail(pointed_thing.above) then
			minetest.env:add_entity(pointed_thing.above, "carts:cart")
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end
	end,
})

minetest.register_node("rainbowmod:rainbow_rail", {
	description = "Rainbow Rail",
	drawtype = "raillike",
	tiles = {"rainbow_rail.png", "rainbow_rail_curved.png", "rainbow_rail_t_junction.png", "rainbow_rail_crossing.png"},
	inventory_image = "rainbow_rail_inventory.png",
	wield_image = "rainbow_rail.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,snappy=1,dig_immediate=2,attached_node=1,rail=1,connect_to_raillike=1},
})


minetest.register_node("rainbowmod:rainbow_powered_rail", {
	description = "Rainbow Powered Rail",
	drawtype = "raillike",
	tiles = {"rainbow_rail_pwr.png", "rainbow_rail_curved_pwr.png", "rainbow_rail_t_junction_pwr.png", "rainbow_rail_crossing_pwr.png"},
	inventory_image = "rainbow_rail_pwr_inventory.png",
	wield_image = "rainbow_rail_pwr.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		-- but how to specify the dimensions for curved and sideways rails?
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2,snappy=1,dig_immediate=2,attached_node=1,rail=1,connect_to_raillike=1},
	
	after_place_node = function(pos, placer, itemstack)
		if not mesecon then
			minetest.env:get_meta(pos):set_string("cart_acceleration", "0.5")
		end
	end,
	
	mesecons = {
		effector = {
			action_on = function(pos, node)
				minetest.env:get_meta(pos):set_string("cart_acceleration", "0.5")
			end,
			
			action_off = function(pos, node)
				minetest.env:get_meta(pos):set_string("cart_acceleration", "0")
			end,
		},
	},
})


