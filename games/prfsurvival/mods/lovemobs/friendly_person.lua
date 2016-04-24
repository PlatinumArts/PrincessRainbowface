--First mob of PRF, for some reason i called it "friendly_person" technically it's a mob, or an entity that walks around and spawns in the grass!

lovemobs.person_drops = {
	"default:pick_steel", "mobs:meat", "default:diamond"",
	"default:shovel_steel", "farming:bread", "bucket:bucket_water"
}

lovemobs.register_mob("lovemobs:friendly_person", {
	type = "npc",
	passive = true,
	damage = 2,
	attack_type = "dogfight",
	attacks_monsters = true,
	pathfinding = true,
	hp_min = 15,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "character.b3d",
	drawtype = "front",
	textures = {
		{"mobs_friendly_mob_b.png"},
		{"mobs_friendly_mob_a.png"}, 
	},
	child_texture = {
		{"mobs_friendly_mob_c.png"}, -- derpy baby by AmirDerAssassine
	},
	makes_footstep_sound = true,
	sounds = {},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	drops = {
		{}
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	follow = {"farming:bread", "default:diamond"},
	view_range = 15,
	owner = "",
	order = "follow",
	fear_height = 3,
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
	on_rightclick = function(self, clicker)

		-- feed to heal npc
		if lovemobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		local item = clicker:get_wielded_item()
		local name = clicker:get_player_name()

		-- right clicking with gold lump drops random item from lovemobs.person_drops
		if item:get_name() == "default:gold_lump" then

			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end

			local pos = self.object:getpos()

			pos.y = pos.y + 0.5

			minetest.add_item(pos, {
				name = lovemobs.person_drops[math.random(1, #lovemobs.person_drops)]
			})

			minetest.chat_send_player(name, "This Friendly Person, gave you an item for the Gold Lump!")

			return
		end

		-- capture npc with net or lasso
		lovesmobs:capture_mob(self, clicker, 0, 5, 80, false, nil)

		-- by right-clicking owner can switch npc between follow and stand
		if self.owner and self.owner == name then

			if self.order == "follow" then
				self.order = "stand"

				minetest.chat_send_player(name, "NPC stands still.")
			else
				self.order = "follow"

				minetest.chat_send_player(name, "NPC will follow you.")
			end
		end

	end,
})

lovemobs:register_spawn("lovemobs:friendly_person", {"default:dirt_with_grass"}, 20, 0, 7000, 1, 31000)
