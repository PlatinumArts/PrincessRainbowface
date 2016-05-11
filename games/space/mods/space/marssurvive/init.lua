marssurvive={breath_timer=0,player_sp={},air=21,player_space={},
itemdroptime=tonumber(minetest.setting_get("item_entity_ttl")),
aliens={},aliens_max=4}


if marssurvive.itemdroptime=="" or marssurvive.itemdroptime==nil then
	marssurvive.itemdroptime=880
else
	marssurvive.itemdroptime=hook_tmp_time-20
end
dofile(minetest.get_modpath("marssurvive") .. "/nodes.lua")
dofile(minetest.get_modpath("marssurvive") .. "/craft.lua")
dofile(minetest.get_modpath("marssurvive") .. "/functions.lua")

minetest.register_tool("marssurvive:sp", {
	description = "Spacesuit (wear slot 1, works in space only)",
	inventory_image = "marssurvive_sp.png",
})

-- seting up settings for joined players
minetest.register_on_joinplayer(function(player)
		marssurvive.player_sp[player:get_player_name()]={sp=0,skin={}}
end)

minetest.register_entity("marssurvive:sp1",{
	hp_max = 100,
	physical = false,
	weight = 0,
	collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
	visual = "mesh",
	mesh="marssurvive_sp.obj",
	visual_size = {x=0.5, y=0.5},
	textures = {"default_steel_block.png","default_obsidian.png^[colorize:#927C3044","default_cloud.png","default_steel_block.png","default_cloud.png","default_cloud.png"},
	spritediv = {x=1, y=1},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	timer=0,
on_activate=function(self, staticdata)
		if marssurvive.tmpuser then
			self.user=marssurvive.tmpuser
			marssurvive.tmpuser=nil
			self.hud=self.user:hud_add({
				hud_elem_type = "image",
				text ="marssurvive_scene.png",
				name = "mars_sky",
				scale = {x=-100, y=-100},
				position = {x=0, y=0},
				alignment = {x=1, y=1},
			})
		else
			self.object:remove()
		end
	end,
on_step= function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<2 then return end
		self.timer=0
		if (not self.user:get_player_name()) or marssurvive.player_sp[self.user:get_player_name()]==nil then
			self.object:set_hp(0)
			self.object:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
			return self
		end
		if self.user:get_inventory():get_stack("main", 1):get_name()~="marssurvive:sp" then
			self.object:set_detach()
			self.user:set_properties({mesh = "character.b3d",textures = marssurvive.player_sp[self.user:get_player_name()].skin})
			marssurvive.player_sp[self.user:get_player_name()].skin={}
			marssurvive.player_sp[self.user:get_player_name()].sp=0
			self.user:hud_remove(self.hud)
			self.object:remove()
			return self
		end
	end,
})