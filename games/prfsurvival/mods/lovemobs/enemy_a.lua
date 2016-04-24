--A simple test, of the 1st enemy, also i want some coffee (i don't have beans or powdered coffee ;_; , i gotta go buy that!)

mobs:register_mob("lovemobs:enemy_a.lua", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 3,
	damage = 4,
	hp_min = 25,
	hp_max = 29,
	armor = 50,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "character.b3d",
	textures = {
		{"enemy_a.png"},
	}
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	drops = {
		{},
	},
	water_damage = 5,
	lava_damage = 0,
	light_damage = 2,
	fear_height = 2,
animation = {
		speed_normal = 30,
		speed_run = 30,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 200,
		punch_end = 219,
	},
		on_die = function(self, pos)
		local num = math.random(1, 2)
		for i=1,num do
			minetest.add_entity({x=pos.x + math.random(-2, 2), y=pos.y + 1, z=pos.z + (math.random(-2, 2))}, "lovemobs:friendly_person")
	},
})

mobs:register_spawn("lovemobs_monster:enemy_a",
	{"default:stone"}, 7, 0, 7000, 1, 31000, false)
