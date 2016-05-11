
minetest.register_craft({
	output = "marssurvive:door1_1 2",
	recipe = {
		{"","marssurvive:shieldblock",""},
		{"","marssurvive:shieldblock", ""},
		{"","marssurvive:shieldblock", ""},
	}
})

minetest.register_craft({
	output = "marssurvive:airgen5",
	recipe = {
		{"marssurvive:shieldblock","marssurvive:air_gassbotte","marssurvive:shieldblock"},
		{"marssurvive:shieldblock","marssurvive:oxogen", "marssurvive:shieldblock"},
	}
})

minetest.register_craft({
	output = "marssurvive:air_gassbotte 2",
	recipe = {
		{"default:steel_ingot","marssurvive:oxogen","default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "marssurvive:sp",
	recipe = {
		{"marssurvive:sp","marssurvive:air_gassbotte",""}

	}
})

minetest.register_craft({
	output = "marssurvive:steelwallblock 8",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:steel_ingot","", "default:steel_ingot"},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "marssurvive:shieldblock 4",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:iron_lump"},
		{"default:steel_ingot","default:steel_ingot", ""},
	}
})



