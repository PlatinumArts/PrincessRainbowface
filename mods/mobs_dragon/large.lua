
-- all of the following is documented in 'api.txt' in the mobs_redo folder

-- large red dragon
mobs:register_mob("mobs_dragon:dragon_lg_red", {
	visual = "mesh",
	mesh = "dragon.b3d",
	animation = { 
		speed_normal = 10,	speed_run = 20,
		stand_start = 1,	stand_end = 22,
		walk_start = 1,		walk_end = 22,
		run_start = 1,		run_end = 22,
		punch_start = 22,	punch_end = 47
	},
	runaway = false,
	jump_chance = 30,
	fly = true,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"mobs:meat_raw"},
	attack_type = "shoot",
	attacks_monsters = true,
	pathfinding = true,
	arrow = "mobs_dragon:fire",
	fall_damage = 0,
	makes_footstep_sound = true,
	sounds = {
		shoot_attack = "mobs_fireball",
	},
	shoot_interval = 2.0,

	--change
	textures = {
		{"dmobs_dragon1.png"}
	},
	hp_min = 50,
	hp_max = 70,
	armor = 80,
	damage = 20,
	lava_damage = 0,
	water_damage = 10,
	walk_velocity = 4,
	run_velocity = 5,
	--dogshoot_switch = 1,
	--dogshoot_count_max = 5,
	--immune_to = {},

	-- change by size
	type = "monster",
	lifetimer = 360,
	visual_size = {x=1.5, y=1.5},
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
	stepheight = 10,
	jump_height = 10,
	view_range = 20,
	passive = false,
	reach = 3,
	group_attack = false,
	shoot_offset = 1,
	knock_back = 1,
	drops = {
		{name = "mobs_dragon:dragon_egg", chance = 0.5, min = 1, max = 1},
	}
})

-- large black dragon
mobs:register_mob("mobs_dragon:dragon_lg_black", {
	visual = "mesh",
	mesh = "dragon.b3d",
	animation = { 
		speed_normal = 10,	speed_run = 20,
		stand_start = 1,	stand_end = 22,
		walk_start = 1,		walk_end = 22,
		run_start = 1,		run_end = 22,
		punch_start = 22,	punch_end = 47
	},
	runaway = false,
	jump_chance = 30,
	fly = true,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"mobs:meat_raw"},
	attack_type = "shoot",
	attacks_monsters = true,
	pathfinding = true,
	arrow = "mobs_dragon:fire",
	fall_damage = 0,
	makes_footstep_sound = true,
	sounds = {
		shoot_attack = "mobs_fireball",
	},
	shoot_interval = 2.0,

	--change
	textures = {
		{"dmobs_dragon2.png"}
	},
	hp_min = 100,
	hp_max = 120,
	armor = 80,
	damage = 4,
	lava_damage = 0,
	water_damage = 0,
	walk_velocity = 2,
	run_velocity = 3,
	--dogshoot_switch = 1,
	--dogshoot_count_max = 5,
	--immune_to = {},

	-- change by size
	type = "monster",
	lifetimer = 360,
	visual_size = {x=1.5, y=1.5},
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
	stepheight = 10,
	jump_height = 10,
	view_range = 20,
	passive = false,
	reach = 3,
	group_attack = false,
	shoot_offset = 1,
	knock_back = 1,
	drops = {
		{name = "mobs_dragon:dragon_egg", chance = 1, min = 1, max = 1},
	}
})

-- large green dragon
mobs:register_mob("mobs_dragon:dragon_lg_green", {
	visual = "mesh",
	mesh = "dragon.b3d",
	animation = { 
		speed_normal = 10,	speed_run = 20,
		stand_start = 1,	stand_end = 22,
		walk_start = 1,		walk_end = 22,
		run_start = 1,		run_end = 22,
		punch_start = 22,	punch_end = 47
	},
	runaway = false,
	jump_chance = 30,
	fly = true,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"mobs:meat_raw"},
	attack_type = "shoot",
	attacks_monsters = true,
	pathfinding = true,
	arrow = "mobs_dragon:fire",
	fall_damage = 0,
	makes_footstep_sound = true,
	sounds = {
		shoot_attack = "mobs_fireball",
	},
	shoot_interval = 2.0,

	--change
	textures = {
		{"dmobs_dragon3.png"}
	},
	hp_min = 80,
	hp_max = 100,
	armor = 80,
	damage = 12,
	lava_damage = 5,
	water_damage = 5,
	walk_velocity = 3,
	run_velocity = 4,
	--dogshoot_switch = 1,
	--dogshoot_count_max = 5,
	--immune_to = {},

	-- change by size
	type = "monster",
	lifetimer = 360,
	visual_size = {x=1.5, y=1.5},
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
	stepheight = 10,
	jump_height = 10,
	view_range = 20,
	passive = false,
	reach = 3,
	group_attack = false,
	shoot_offset = 1,
	knock_back = 1,
	drops = {
		{name = "mobs_dragon:dragon_egg", chance = 1, min = 1, max = 1},
	}
})

-- large blue dragon
mobs:register_mob("mobs_dragon:dragon_lg_blue", {
	visual = "mesh",
	mesh = "dragon.b3d",
	animation = { 
		speed_normal = 10,	speed_run = 20,
		stand_start = 1,	stand_end = 22,
		walk_start = 1,		walk_end = 22,
		run_start = 1,		run_end = 22,
		punch_start = 22,	punch_end = 47
	},
	runaway = false,
	jump_chance = 30,
	fly = true,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"mobs:meat_raw"},
	attack_type = "shoot",
	attacks_monsters = true,
	pathfinding = true,
	arrow = "mobs_dragon:fire",
	fall_damage = 0,
	makes_footstep_sound = true,
	sounds = {
		shoot_attack = "mobs_fireball",
	},
	shoot_interval = 2.0,

	--change
	textures = {
		{"dmobs_dragon4.png"}
	},
	hp_min = 80,
	hp_max = 100,
	armor = 80,
	damage = 12,
	lava_damage = 10,
	water_damage = 0,
	walk_velocity = 3,
	run_velocity = 4,
	--dogshoot_switch = 1,
	--dogshoot_count_max = 5,
	--immune_to = {},

	-- change by size
	type = "monster",
	lifetimer = 360,
	visual_size = {x=1.5, y=1.5},
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
	stepheight = 10,
	jump_height = 10,
	view_range = 20,
	passive = false,
	reach = 3,
	group_attack = false,
	shoot_offset = 1,
	knock_back = 1,
	drops = {
		{name = "mobs_dragon:dragon_egg", chance = 1, min = 1, max = 1},
	}
})
