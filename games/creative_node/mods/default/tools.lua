---Alphynium Tools

---Pick
minetest.register_tool("default:alphynium_pick", {
	description = "Alphynium Pick",
	inventory_image = "alphynium_pick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.4, [2]=1.2, [3]=0.60}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
})

---Shovel
minetest.register_tool("default:alphynium_shovel", {
	description = "Alphynium Shovel",
	inventory_image = "alphynium_shovel.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.30}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})


---Axe
minetest.register_tool("default:alphynium_axe", {
	description = "Alphynium Axe",
	inventory_image = "alphynium_axe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.20, [2]=1.00, [3]=0.60}, uses=79, maxlevel=5},
		},
		damage_groups = {fleshy=7},
	},
})
