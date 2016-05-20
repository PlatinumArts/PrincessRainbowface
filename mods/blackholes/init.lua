local blackholes_not_in_creative_inventory=0

blackholes={time=tonumber(minetest.setting_get("item_entity_ttl")),new_ob=0,new_user="",new_ob_drop=""}

if blackholes.time=="" or blackholes.time==nil then
	blackholes.time=880
else
	blackholes.time=blackholes.time-10
end


minetest.register_privilege("blackhole", {
	description = "",
	give_to_singleplayer= true,
})
minetest.register_privilege("blackhole_small", {
	description = "",
	give_to_singleplayer= true,
})

minetest.register_privilege("blackhole_no", {
	description = "No gravity to blackholes",
	give_to_singleplayer= true,
})


minetest.register_tool("blackholes:rifle1", {
	description = "Blackhole rifle",
	range = 15,
	inventory_image = "blackholes_rifle_big.png",
		on_use = function(itemstack, user, pointed_thing)
			if minetest.check_player_privs(user:get_player_name(), {blackhole=true})==false then
				minetest.chat_send_player(user:get_player_name(), "You need the blackhole privilege to use this")
				return itemstack
			end
			if pointed_thing.type=="object" and blackholes.is_backhole(nil,pointed_thing.ref,1)==false then blackholes.kill(pointed_thing.ref,user) return itemstack end
			if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.above,user:get_player_name())==false then
				minetest.sound_play("blackholes__lightning", {pos=pointed_thing.above, gain = 1.0, max_hear_distance = 10,})
				blackholes.new_ob=1
				minetest.env:add_entity(pointed_thing.above, "blackholes:blackhole_big")
			end
		return itemstack
		end,
		groups = {not_in_creative_inventory=blackholes_not_in_creative_inventory},
})

minetest.register_tool("blackholes:rifle1s", {
	description = "Blackhole rifle static ",
	range = 15,
	inventory_image = "blackholes_rifle_big_static.png",
		on_use = function(itemstack, user, pointed_thing)
			if minetest.check_player_privs(user:get_player_name(), {blackhole=true})==false then
				minetest.chat_send_player(user:get_player_name(), "You need the blackhole privilege to use this")
				return itemstack
			end
			if pointed_thing.type=="object" and blackholes.is_backhole(nil,pointed_thing.ref,1)==false then blackholes.kill(pointed_thing.ref,user) return itemstack end
			if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.above,user:get_player_name())==false then
				minetest.sound_play("blackholes__lightning", {pos=pointed_thing.above, gain = 1.0, max_hear_distance = 10,})
				blackholes.new_ob=1
				minetest.env:add_entity(pointed_thing.above, "blackholes:blackhole_big_static")
			end
		return itemstack
		end,
		groups = {not_in_creative_inventory=blackholes_not_in_creative_inventory},
})

minetest.register_tool("blackholes:rifle2", {
	description = "Blackhole rifle small",
	range = 15,
	inventory_image = "blackholes_rifle_small.png",
		on_use = function(itemstack, user, pointed_thing)
			if minetest.check_player_privs(user:get_player_name(), {blackhole_small=true})==false then
				minetest.chat_send_player(user:get_player_name(), "You need the blackhole_small privilege to use this")
				return itemstack
			end
			if pointed_thing.type=="object" and blackholes.is_backhole(nil,pointed_thing.ref,1,1) then blackholes.kill(pointed_thing.ref,user) return itemstack end
			if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.above,user:get_player_name())==false then
				minetest.sound_play("blackholes__lightning2", {pos=pointed_thing.above, gain = 1.0, max_hear_distance = 10,})
				blackholes.new_ob=1
				minetest.env:add_entity(pointed_thing.above, "blackholes:blackhole_small")
			end
		return itemstack
		end,
		groups = {not_in_creative_inventory=blackholes_not_in_creative_inventory},
})


minetest.register_tool("blackholes:rifle2s", {
	description = "Blackhole rifle small static",
	range = 15,
	inventory_image = "blackholes_rifle_small_static.png",
		on_use = function(itemstack, user, pointed_thing)
			if minetest.check_player_privs(user:get_player_name(), {blackhole_small=true})==false then
				minetest.chat_send_player(user:get_player_name(), "You need the blackhole_small privilege to use this")
				return itemstack
			end
			if pointed_thing.type=="object" and blackholes.is_backhole(nil,pointed_thing.ref,1,1) then blackholes.kill(pointed_thing.ref,user) return itemstack end
			if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.above,user:get_player_name())==false then
				minetest.sound_play("blackholes__lightning2", {pos=pointed_thing.above, gain = 1.0, max_hear_distance = 10,})
				blackholes.new_ob=1
				minetest.env:add_entity(pointed_thing.above, "blackholes:blackhole_small_static")
			end
		return itemstack
		end,
		groups = {not_in_creative_inventory=blackholes_not_in_creative_inventory},
})



blackholes.distance=function(self,o)
	if o==nil or o.x==nil then return nil end
	local p=self.object:getpos()
	return math.sqrt((p.x-o.x)*(p.x-o.x) + (p.y-o.y)*(p.y-o.y)+(p.z-o.z)*(p.z-o.z))
end


blackholes.kill=function(o,p)
	if not p then p=o end
	o:set_hp(0)
	o:punch(p, 1, "default:bronze_pick", nil)
end
blackholes.is_backhole=function(self,o,type,small)
	if not o then return true end
	if o:is_player() then return false end
	if not o:get_luaentity() then return true end
	local e=o:get_luaentity()
	if small and e.blackhole_small then
		return true
	elseif small then
		return false
	end
	if type then
		if e.blackhole_big or e.blackhole_small then
			return false
		end
		return true
	end
	if self and self.blackhole_big and (e.blackhole_big or e.blackhole_power) then
		return true

	end
	if self and self.blackhole_small and (e.blackhole_big or e.blackhole_small or e.blackhole_power) then
		return true
	end
	return false
end

minetest.register_entity("blackholes:blackhole_power",{
	hp_max = 100,
	physical = false,
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"blackholes_power.png"},
	is_visible =true,
	timer = 0,
	timer2=0,
	blackhole_power=true,
	on_activate=function(self, staticdata)
	if blackholes.new_ob==1 then
		blackholes.new_ob=0

		if not blackholes.tmp and blackholes.tmp.hole then
			self.ob:set_detach()
			blackholes.kill(self.object)
			return self
		end


		self.hole=blackholes.tmp.hole
		self.gravonly=blackholes.tmp.gravonly
		self.big=blackholes.tmp.big
		self.ob=blackholes.tmp.ob

		

		self.d=blackholes.distance(self,self.hole:getpos())
		self.s=0.1
		self.a=0
		blackholes.tmp={}
		local pos=self.hole:getpos()
		local spos=self.object:getpos()
		local a=self.a * math.pi * self.s
  		local x, z =  pos.x+self.d*math.cos(a), pos.z+self.d*math.sin(a)
		local y=(pos.y - self.object:getpos().y)*(self.s*0.5)
		self.a=blackholes.distance(self,{x=x,y=spos.y+y,z=z})*(math.pi*1)
	else
		self.object:remove()
	end
	end,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.15 then return true end
		self.timer=0
		if not (self.hole:get_luaentity()) then
			self.ob:set_detach()
			local v=self.ob:getvelocity()
			if v and v.x then
				self.ob:setacceleration({x=0,y=-8,z=0})
				self.ob:setvelocity({x=v.x,y=-2,z=v.z})
				if self.ob:get_luaentity().age then self.ob:get_luaentity().age=blackholes.time end
			end
			blackholes.kill(self.object)
			return self
		end
		if self.gravonly and self.big and self.d<6 then
			self.d=6
		elseif self.gravonly and self.d<3.5 then
			self.d=3.5
		end
		local pos=self.hole:getpos()
		local spos=self.object:getpos()
		local s=0
		local a=self.a * math.pi * self.s
  		local x, z =  pos.x+self.d*math.cos(a), pos.z+self.d*math.sin(a)
  		self.a=self.a+1
		self.d=self.d-0.1
  		if self.gravonly==nil and self.s<0.12 then self.s=self.s+0.001 end
		local y=(pos.y - self.object:getpos().y)*self.s
		if minetest.registered_nodes[minetest.get_node({x=x,y=spos.y+y,z=z}).name].walkable then
			if minetest.registered_nodes[minetest.get_node({x=x,y=spos.y+y+1,z=z}).name].walkable==false then
				y=y+1
			else
				self.d=self.d-0.5
				a=self.a * self.s
  				x=pos.x+self.d*math.cos(a)
				z =pos.z+self.d*math.sin(a)
				self.object:moveto({x=x,y=spos.y+y,z=z})
				return self
			end
		end
		self.object:moveto({x=x,y=spos.y+y,z=z})
		return self
	end,

on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		if self.object:get_hp()<=0 and self.ob and self.ob:get_attach() then
			self.ob:set_detach()
			if self.ob:is_player() then self.ob:moveto({x=0,y=0,z=0}) end
			blackholes.kill(self.ob,self.object)
		end
	end,
})

blackholes.getnode=function(self)
		if self.power>3 and self.grow then
			local np=minetest.find_node_near(self.object:getpos(), (self.power*0.3)+2,{
				"group:snappy",
				"group:wood",
				"group:choppy",
				"group:tree",
				"group:level",
				"group:crumbly",
				"group:falling_node",
				"group:sand",
				"group:dig_immediate",
				"group:flammable",
				"group:water",
				"group:liquid ",
				"group:oddly_breakable_by_hand",
				"group:soil"
			})

			if np~=nil and (self.dynamic or minetest.is_protected(np,"")==false) then
				local node=minetest.registered_nodes[minetest.get_node(np).name]
				local tiles={}
				local stop=0
				for i, t in pairs(node.tiles) do
					tiles[i]=t
					stop=stop+1
					if type(tiles[i])~="string" then
						if stop==1 then tiles[i]="default_dirt.png" end
						stop=stop-1
						break
					end
				end
					for i=stop,6,1 do
						tiles[i]=tiles[stop] 
					end
					if node.drop~=nil then blackholes.new_ob_drop=node.drop end
					blackholes.new_ob=1
					minetest.set_node(np, {name="air"})
					local m=minetest.env:add_entity(np, "blackholes:block")
					m:set_properties({textures = tiles})
			end
		end
	return self
end

blackholes.power=function(self)
		if self.power < 0.5 then
			if self.sound then minetest.sound_stop(self.sound) end
			minetest.sound_play("default_break_glass", {pos=self.object:getpos(), gain = 0.8, max_hear_distance = 10,})
			blackholes.kill(self.object)
			return self
		end
		if self.power>150 then self.selfkill=4 self.grow=false end
		self.power=self.power-self.selfkill
		self.speed=self.power*0.001
		self.object:set_properties({visual_size = {x=0.2+(self.power*0.02), y=0.2+(self.power*0.02)}})
	return self
end

blackholes.gravity=function(self,g)
		local pos=self.object:getpos()
		for i, ob in pairs(minetest.get_objects_inside_radius(pos,1)) do
			if blackholes.is_backhole(self,ob,1) then
				blackholes.kill(ob,self.object)
				if self.grow then self.power=self.power+0.1 end
			end
		end
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, (self.power*0.25)+2)) do
			if blackholes.is_backhole(self,ob)==false and (not ob:get_attach()) and (self.dynamic or minetest.is_protected(pos,"")==false)
			and (not (ob:is_player() and (minetest.check_player_privs(ob:get_player_name(), {blackhole_no=true}) or ob:get_hp()<1))) then
				local v=ob:getpos()
				blackholes.tmp={hole=self.object,ob=ob,gravonly=g,big=self.blackhole_big}
				blackholes.new_ob=1
				local m=minetest.env:add_entity(ob:getpos(), "blackholes:blackhole_power")
				if ob:get_luaentity() and ob:get_luaentity().age then ob:get_luaentity().age=0 end
				ob:set_attach(m, "", {x=0,y=0,z=0}, {x=0,y=0,z=0})
			end
		end
	return self
end

minetest.register_entity("blackholes:block",{
	hp_max = 1,
	physical = true,
	weight = 5,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "cube",
	visual_size = {x=1, y=1},
	mesh = "cube",
	textures = {},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	local pos=self.object:getpos()
	if pos==nil then return false end
	if self.drop~="" then minetest.add_item(pos, self.drop) end
	end,
on_activate=function(self, staticdata)
		if blackholes.new_ob~=1 then
			blackholes.kill(self.object)
			return false
		end
		blackholes.new_ob=0
		if blackholes.new_ob_drop=="" then
			blackholes.kill(self.object)
			return false
		end
		blackholes.new_ob=0
		self.drop=blackholes.new_ob_drop
		blackholes.new_ob_drop=""
	end,
on_step= function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.5 then return self end
		self.timer=0
		self.timer2=self.timer2+1
		local pos=self.object:getpos()
		if minetest.registered_nodes[minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name].walkable==false then self.object:getacceleration({x=0,y=-8,z=0}) end
		if self.timer2>10 then
			if self.drop~="" then
				local e=minetest.add_item(self.object:getpos(), self.drop)
				if e and e:get_luaentity() then e:get_luaentity().age=blackholes.time end
			end
			blackholes.kill(self.object)
		end
	end,
	timer=0,
	timer2=0,
	drop="",
	block=1,
})

minetest.register_entity("blackholes:blackhole_big",{
	hp_max = 999,
	physical = false,
	visual = "sprite",
	visual_size = {x=0.2, y=0.2},
	textures = {"blackholes_blackhole.png"},
	timer = 0,
	timer2 = 0,
	timer3 = 0,
	power=3.5,
	speed=0,
	selfkill=0.1,
	grow=true,
	dynamic=true,
	blackhole_big=true,
	on_activate=function(self, staticdata)
		if staticdata ~= nil then
			self.power=tonumber(staticdata)
		end
		self.sound=minetest.sound_play("blackholes__background",{pos = self.object:getpos(), gain = 0.5, max_hear_distance = 25})
	end,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.5+self.speed then return self end
		self.timer3=self.timer3+self.timer
		if self.timer3>=5.7 then
			self.timer3=0
			self.sound=minetest.sound_play("blackholes__background",{pos = self.object:getpos(), gain = 0.8, max_hear_distance = 25})
		end
		self.timer=0
		self.timer2=self.timer2+dtime
		self.object:set_hp(999)
		blackholes.power(self)
		blackholes.getnode(self)
		blackholes.gravity(self)
		local pos=self.object:getpos()
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
	end,
	get_staticdata = function(self)
		if self.power ~= nil then
			return self.power
		end
	end,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	if self.sound and self.object and self.object:get_hp()<=0 then minetest.sound_stop(self.sound) end
	end,
})


minetest.register_entity("blackholes:blackhole_big_static",{
	hp_max = 999,
	physical = false,
	visual = "sprite",
	visual_size = {x=0.2, y=0.2},
	textures = {"blackholes_blackhole.png"},
	timer = 0,
	timer2 = 0,
	timer3 = 0,
	power=100,
	speed=0,
	selfkill=0.1,
	grow=true,
	user="",
	blackhole_big=true,
	on_activate=function(self, staticdata)
		blackholes.power(self)
		self.sound=minetest.sound_play("blackholes__background",{pos = self.object:getpos(), gain = 0.5, max_hear_distance = 25})
	end,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.5+self.speed then return self end
		self.timer3=self.timer3+self.timer
		if self.timer3>=5.7 then
			self.timer3=0
			self.sound=minetest.sound_play("blackholes__background",{pos = self.object:getpos(), gain = 0.8, max_hear_distance = 25})
		end
		self.timer=0
		self.timer2=self.timer2+dtime
		self.object:set_hp(999)
		blackholes.getnode(self)
		blackholes.gravity(self)
		local pos=self.object:getpos()
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
	end,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	if self.sound and self.object and self.object:get_hp()<=0 then minetest.sound_stop(self.sound) end
	end,
})


minetest.register_entity("blackholes:blackhole_small",{
	hp_max = 999,
	physical = false,
	visual = "sprite",
	visual_size = {x=0.2, y=0.2},
	textures = {"blackholes_blackhole.png"},
	timer = 0,
	timer2 = 0,
	timer3 = 0,
	power=20,
	speed=0,
	selfkill=0.1,
	grow=false,
	dynamic=true,
	blackhole_small=true,
	on_activate=function(self, staticdata)
		if staticdata ~= nil then
			self.power=tonumber(staticdata)
		end
		self.sound=minetest.sound_play("blackholes__background2",{pos = self.object:getpos(), gain = 0.5, max_hear_distance = 25})
	end,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.5+self.speed then return self end
		self.timer3=self.timer3+self.timer
		if self.timer3>=3.1 then
			self.timer3=0
			self.sound=minetest.sound_play("blackholes__background2",{pos = self.object:getpos(), gain = 0.8, max_hear_distance = 25})
		end
		self.timer=0
		self.timer2=self.timer2+dtime
		self.object:set_hp(999)
		blackholes.gravity(self)
		blackholes.power(self)
		local pos=self.object:getpos()
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
	end,
	get_staticdata = function(self)
		if self.power ~= nil then
			return self.power
		end
	end,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	if self.sound and self.object and self.object:get_hp()<=0 then minetest.sound_stop(self.sound) end
	end,
})

minetest.register_entity("blackholes:blackhole_small_static",{
	hp_max = 999,
	physical = false,
	visual = "sprite",
	visual_size = {x=0.2, y=0.2},
	textures = {"blackholes_blackhole.png"},
	timer = 0,
	timer2 = 0,
	timer3 = 0,
	power=20,
	speed=0,
	selfkill=0.1,
	grow=false,
	blackhole_small=true,
	on_activate=function(self, staticdata)
		blackholes.power(self)
		self.sound=minetest.sound_play("blackholes__background2",{pos = self.object:getpos(), gain = 0.5, max_hear_distance = 25})
	end,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.5+self.speed then return self end
		self.timer3=self.timer3+self.timer
		if self.timer3>=3.1 then
			self.timer3=0
			self.sound=minetest.sound_play("blackholes__background2",{pos = self.object:getpos(), gain = 0.8, max_hear_distance = 25})
		end
		self.timer=0
		self.timer2=self.timer2+dtime
		self.object:set_hp(999)
		blackholes.gravity(self)
		local pos=self.object:getpos()
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
		blackholes.effect(pos)
	end,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	if self.sound and self.object and self.object:get_hp()<=0 then minetest.sound_stop(self.sound) end
	end,
})


blackholes.effect=function(pos)
	local rnd={x=pos.x+math.random(-5,5),y=pos.y+math.random(-5,5),z=pos.z+math.random(-5,5)}
	local v={x=pos.x-rnd.x,y=pos.y-rnd.y,z=pos.z-rnd.z}
	minetest.add_particlespawner({
	amount = 1,
	time = 1,
	minpos = rnd,
	maxpos = rnd,
	minvel = v,
	maxvel = v,
	minacc = 1,
	maxacc = 1,
	minexptime = 0.101,
	maxexptime = 0.606,
	minsize = 0.5,
	maxsize = 3,
	texture = "default_coal_lump.png",
	})
end




minetest.register_tool("blackholes:riflebhg", {
	description = "Backhole gravity rifle",
	range = 15,
	inventory_image = "blackholes_rifle_bigg.png",
		on_use = function(itemstack, user, pointed_thing)
			if minetest.check_player_privs(user:get_player_name(), {blackhole=true})==false then
				minetest.chat_send_player(user:get_player_name(), "You need the blackhole privilege to use this")
				return itemstack
			end
			if pointed_thing.type=="object" and blackholes.is_backhole(nil,pointed_thing.ref,1)==false then blackholes.kill(pointed_thing.ref,user) return itemstack end
			blackholes.new_ob=1
			blackholes.new_user=user
			if pointed_thing.type=="nothing" then
				local dir = user:get_look_dir()
				local pos = user:getpos()
				local npos={x=pos.x+(dir.x*10), y=pos.y+(dir.y*10)+1.6, z=pos.z+(dir.z*10)}
				minetest.env:add_entity(npos, "blackholes:blackhole_big_grav")
				minetest.sound_play("blackholes__lightning", {pos=npos, gain = 1.0, max_hear_distance = 10,})
			elseif pointed_thing.type=="node" then
				minetest.env:add_entity(pointed_thing.above, "blackholes:blackhole_big_grav")
				minetest.sound_play("blackholes__lightning", {pos=pointed_thing.above, gain = 1.0, max_hear_distance = 10,})
			end
			return itemstack
		end,
		groups = {not_in_creative_inventory=blackholes_not_in_creative_inventory},
})

minetest.register_tool("blackholes:riflebhgs", {
	description = "Backhole gravity rifle small",
	range = 9,
	inventory_image = "blackholes_rifle_smallg.png",
		on_use = function(itemstack, user, pointed_thing)
			if minetest.check_player_privs(user:get_player_name(), {blackhole_small=true})==false then
				minetest.chat_send_player(user:get_player_name(), "You need the blackhole_small privilege to use this")
				return itemstack
			end
			if pointed_thing.type=="object" and blackholes.is_backhole(nil,pointed_thing.ref,1,1) then blackholes.kill(pointed_thing.ref,user) return itemstack end
			blackholes.new_ob=1
			blackholes.new_user=user
			if pointed_thing.type=="nothing" then
				local dir = user:get_look_dir()
				local pos = user:getpos()
				local npos={x=pos.x+(dir.x*7), y=pos.y+(dir.y*7)+1.6, z=pos.z+(dir.z*7)}
				minetest.env:add_entity(npos, "blackholes:blackhole_small_grav")
				minetest.sound_play("blackholes__lightning2", {pos=npos, gain = 1.0, max_hear_distance = 10,})
			elseif pointed_thing.type=="node" then
				minetest.env:add_entity(pointed_thing.above, "blackholes:blackhole_small_grav")
				minetest.sound_play("blackholes__lightning2", {pos=pointed_thing.above, gain = 1.0, max_hear_distance = 10,})
			end
			return itemstack
		end,
		groups = {not_in_creative_inventory=blackholes_not_in_creative_inventory},
})

minetest.register_entity("blackholes:blackhole_big_grav",{
	hp_max = 999,
	physical = false,
	visual = "sprite",
	visual_size = {x=0.2, y=0.2},
	textures = {"blackholes_blackhole.png"},
	timer = 0,
	timer2 = 0,
	timer3 = 0,
	power=100,
	speed=0,
	selfkill=0.1,
	grow=false,
	blackhole_big=true,
	on_activate=function(self, staticdata)
		if blackholes.new_ob~=1 then blackholes.kill(self.object) return self end
		self.user=blackholes.new_user
		blackholes.new_ob=0
		blackholes.power(self)
		self.sound=minetest.sound_play("blackholes__background",{pos = self.object:getpos(), gain = 0.5, max_hear_distance = 25})
		blackholes.new_user=""
	end,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.5+self.speed then return self end
		self.timer3=self.timer3+self.timer
		if self.timer3>=5.7 then
			self.timer3=0
			self.sound=minetest.sound_play("blackholes__background",{pos = self.object:getpos(), gain = 0.8, max_hear_distance = 25})
		end
		self.timer=0
		self.timer2=self.timer2+dtime
		self.object:set_hp(999)
		if not self.user:is_player() then blackholes.kill(self.object) return self end
		local pos=self.object:getpos()
		blackholes.effect(pos)
		blackholes.gravity(self,true)
		local dir = self.user:get_look_dir()
		local upos = self.user:getpos()
		local npos={x=upos.x+(dir.x*12), y=upos.y+(dir.y*12)+1.6, z=upos.z+(dir.z*12)}
		local v={x = (npos.x - pos.x)*2, y = (npos.y - pos.y)*2, z = (npos.z -pos.z)*2}
		if minetest.registered_nodes[minetest.get_node(npos).name].walkable then v={x=0,y=0,z=0} end
		self.object:setvelocity(v)
	end,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	if self.sound and self.object and self.object:get_hp()<=0 then minetest.sound_stop(self.sound) end
	end,
})

minetest.register_entity("blackholes:blackhole_small_grav",{
	hp_max = 999,
	physical = false,
	visual = "sprite",
	visual_size = {x=0.2, y=0.2},
	textures = {"blackholes_blackhole.png"},
	timer = 0,
	timer2 = 0,
	timer3 = 0,
	power=20,
	speed=0,
	selfkill=0.1,
	grow=false,
	blackhole_small=true,
	on_activate=function(self, staticdata)
		if blackholes.new_ob~=1 then blackholes.kill(self.object) return self end
		self.user=blackholes.new_user
		blackholes.new_ob=0
		blackholes.power(self)
		self.sound=minetest.sound_play("blackholes__background2",{pos = self.object:getpos(), gain = 0.5, max_hear_distance = 25})
		blackholes.new_user=""
	end,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.5+self.speed then return self end
		self.timer3=self.timer3+self.timer
		if self.timer3>=3.1 then
			self.timer3=0
			self.sound=minetest.sound_play("blackholes__background2",{pos = self.object:getpos(), gain = 0.8, max_hear_distance = 25})
		end
		self.timer=0
		self.timer2=self.timer2+dtime
		self.object:set_hp(999)
		if not self.user:is_player() then blackholes.kill(self.object) return self end
		local pos=self.object:getpos()
		blackholes.effect(pos)
		blackholes.gravity(self,true)
		local dir = self.user:get_look_dir()
		local upos = self.user:getpos()
		local npos={x=upos.x+(dir.x*7), y=upos.y+(dir.y*7)+1.6, z=upos.z+(dir.z*7)}
		local v={x = (npos.x - pos.x)*3, y = (npos.y - pos.y)*3, z = (npos.z -pos.z)*3}
		if minetest.registered_nodes[minetest.get_node(npos).name].walkable then v={x=0,y=0,z=0} end
		self.object:setvelocity(v)
	end,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	if self.sound and self.object and self.object:get_hp()<=0 then minetest.sound_stop(self.sound) end
	end,
})