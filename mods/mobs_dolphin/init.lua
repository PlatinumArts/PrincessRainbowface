if mobs.mod and mobs.mod == "redo" then

	local l_water_level		= minetest.setting_get("water_level") - 1

	mobs:register_mob("mobs_dolphin:dolphin", {
		type = "animal",
		attack_type = "dogfight",
		damage = 10,
		reach = 3,
		hp_min = 20,
		hp_max = 25,
		armor = 150,
		collisionbox = {-0.75, -0.5, -0.75, 0.75, 0.5, 0.75},
		visual = "mesh",
		mesh = "mobs_dolphin.b3d",
		textures = {
			{"dolphin_pink.png"},
			{"dolphin_blue.png"},
			{"dolphin_white.png"}
		},
		sounds = {
	    random = "dolphin",
	  },
		drops = {
        {name = "mobs:meat_raw", chance = 1, min = 1, max = 1},
    },
		makes_footstep_sound = false,
		walk_velocity = 4,
		run_velocity = 6,
		fly = true,
		fly_in = "default:water_source",
		fall_speed = 0,
		rotate = 0,
		view_range = 10,
		water_damage = 0,
		lava_damage = 10,
		light_damage = 0,
		animation = {
			speed_normal = 15,
	    speed_run = 15,
	    stand_start = 66,
	    stand_end = 90,
	    walk_start = 0,
	    walk_end = 40,
	    run_start = 40,
	    run_end = 60,
	    punch_start = 40,
	    punch_end = 40,
		},
		follow = {"ethereal:fish_raw"},
		on_rightclick = function(self, clicker)
			mobs:capture_mob(self, clicker, 80, 100, 0, true, nil)
		end
	})
	--name, nodes, neighbours, minlight, maxlight, interval, chance, active_object_count, min_height, max_height
	mobs:spawn_specific("mobs_dolphin:dolphin",	{"default:water_source"},	{"default:water_flowing","default:water_source"},	5, 20, 30, 10000, 2, -31000, l_water_level)
	mobs:register_egg("mobs_dolphin:dolphin", "Dolphin", "dolphin_inv.png", 0)

end
