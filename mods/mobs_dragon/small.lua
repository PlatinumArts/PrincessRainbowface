
-- functions common to all four small dragon entities
-------------------------------------------------------------------------------
-- mob.do_custom
local step_custom = function(self, dtime)
	-- does this mob have a "driver" (is someone attached)?
	if self.driver then
		-- allow mounted mob to me "driven"
		-- send self, dtime, animation when moving, animation when standing, and can it fly
		lib_mount.drive(self, dtime, true, "walk", "stand", 0, true)

		-- return false to skip the rest of mobs_redo on_step function
		-- must do this or the mob will not obey you and will go about it's own business
		return false
	end

	-- return true to allow mobs_redo on_step to complete (normal mob fuction with no "driver")
	return true
end

-- mob.on_rightclick
local on_rc = function(self, clicker)
	-- if the clicker is not a player then abort
	if not clicker or not clicker:is_player() then
		return
	end

	-- are we feeding
	if mobs:feed_tame(self, clicker, 1, false, false) then
		return
	end

	-- if mob is tamed and the clicker is the owner
	if self.tamed and self.owner == clicker:get_player_name() then
		-- get the inventory of the clicker so we can take or return the saddle
		local inv = clicker:get_inventory()
		if self.driver and clicker == self.driver then
			-- is the clicker driving? then dismount and return saddle to player
			lib_mount.detach(clicker, {x=1, y=0, z=1})
			if inv:room_for_item("main", "mobs:saddle") then
				inv:add_item("main", "mobs:saddle")
			else
				minetest.add_item(clicker.getpos(), "mobs:saddle")
			end
			--set mob velocity and acceleration to zero
			self.object:setvelocity({x=0, y=0, z=0})
			self.object:setacceleration({x=0, y=-1, z=0})
		elseif not self.driver then
			-- no driver? then mount and take saddle from player
			if clicker:get_wielded_item():get_name() == "mobs:saddle" then
				lib_mount.attach(self, clicker, {x=0, y=12, z=4}, {x=0, y=0, z=4})
				inv:remove_item("main", "mobs:saddle")
			end
		end
	end
end
-------------------------------------------------------------------------------


-- small red dragon
mobs:register_mob("mobs_dragon:dragon_sm_red", {
	visual = "mesh",
	mesh = "dragon.b3d",
	animation = { 
		speed_normal = 10,	speed_run = 20,
		stand_start = 56,	stand_end = 56,
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
	hp_min = 40,
	hp_max = 50,
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
	type = "npc",
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
	stepheight = 6,
	jump_height = 6,
	view_range = 14,
	passive = true,
	reach = 2,
	group_attack = true,
	shoot_offset = 1,
	knock_back = 2,
	do_custom = step_custom,
	on_rightclick = on_rc
})

-- small black dragon
mobs:register_mob("mobs_dragon:dragon_sm_black", {
	visual = "mesh",
	mesh = "dragon.b3d",
	animation = { 
		speed_normal = 10,	speed_run = 20,
		stand_start = 56,	stand_end = 56,
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
	hp_min = 90,
	hp_max = 100,
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
	type = "npc",
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
	stepheight = 6,
	jump_height = 6,
	view_range = 14,
	passive = true,
	reach = 2,
	group_attack = true,
	shoot_offset = 1,
	knock_back = 2,
	do_custom = step_custom,
	on_rightclick = on_rc
})

-- small green dragon
mobs:register_mob("mobs_dragon:dragon_sm_green", {
	visual = "mesh",
	mesh = "dragon.b3d",
	animation = { 
		speed_normal = 10,	speed_run = 20,
		stand_start = 56,	stand_end = 56,
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
	hp_min = 70,
	hp_max = 80,
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
	type = "npc",
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
	stepheight = 6,
	jump_height = 6,
	view_range = 14,
	passive = true,
	reach = 2,
	group_attack = true,
	shoot_offset = 1,
	knock_back = 2,
	do_custom = step_custom,
	on_rightclick = on_rc
})

-- small blue dragon
mobs:register_mob("mobs_dragon:dragon_sm_blue", {
	visual = "mesh",
	mesh = "dragon.b3d",
	animation = { 
		speed_normal = 10,	speed_run = 20,
		stand_start = 56,	stand_end = 56,
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
	hp_min = 70,
	hp_max = 80,
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
	type = "npc",
	collisionbox = {-0.6, -0.9, -0.6, 0.6, 0.6, 0.6},
	stepheight = 6,
	jump_height = 6,
	view_range = 14,
	passive = true,
	reach = 2,
	group_attack = true,
	shoot_offset = 1,
	knock_back = 2,
	do_custom = step_custom,
	on_rightclick = on_rc
})
