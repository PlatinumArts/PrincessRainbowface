dofile(minetest.get_modpath("fancy_elevator").."/functions.lua")
dofile(minetest.get_modpath("fancy_elevator").."/doors.lua")

minetest.register_node("fancy_elevator:truss", {
	description = "Truss Shaft",
	tile_images = {"elevator_truss.png"},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, shaft=1},
	is_ground_content = true,
	node_box = {
		type = "fixed",
		fixed = {
			{1/2, -1/2, -1/2, 1/2, 1/2, 1/2},
			{-1/2, 1/2, -1/2, 1/2, 1/2, 1/2},
			{-1/2, -1/2, 1/2, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, -1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, -1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 1/2, -1/2}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 1/2, 1/2}
	}
})

minetest.register_node("fancy_elevator:shaft", {
	description = "Shaft",
	tiles = {
		"elevator_shaft_top.png", "elevator_shaft_top.png",
		"elevator_shaft.png", "elevator_shaft.png"},
	is_ground_content = true,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, shaft=1},
})
minetest.register_node("fancy_elevator:concrete", {
	description = "Concrete Shaft",
	tiles = {
		"elevator_concrete.png", "elevator_concrete.png",
		"elevator_concrete.png", "elevator_concrete.png"},
	is_ground_content = true,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, shaft=1},
})
minetest.register_node("fancy_elevator:brick", {
	description = "Brick Shaft",
	tiles = {
		"elevator_brick.png", "elevator_brick.png",
		"elevator_brick.png", "elevator_brick.png"},
	is_ground_content = true,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, shaft=1},
})

minetest.register_node("fancy_elevator:ground", {
	description = "Elevator ground",
	tiles = {"elevator_shaft_top.png", "elevator_shaft.png"},
	is_ground_content = true,
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, disable_jump=1, not_in_creative_inventory=1},
	on_dig = function(pos)
		minetest.remove_node(pos)
		return
	end
})

elevator_doors.register_door("fancy_elevator:door_gray", {
	description = "Elevator Door",
	tiles_bottom = {"elevator_door_gray_b.png", "elevator_door_gray.png"},
	tiles_top = {"elevator_door_gray_a.png", "elevator_door_gray.png"},
	inventory_image = "elevator_door.png",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, shaft=2},
})

minetest.register_craft({
	output = "fancy_elevator:shaft",
	recipe = {
		{"default:stone","group:wood"},
		{"group:wood","default:stone"}
	}
})

minetest.register_craft({
	output = "fancy_elevator:elevator",
	recipe = {
		{"group:wood","group:wood"},
		{"default:steel_ingot","default:steel_ingot"},
		{"group:wood","group:wood"}
	}
})

minetest.register_craft({
	output = "fancy_elevator:elevatorindustrial",
	recipe = {
		{"group:wood","group:wood",""},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"group:wood","group:wood",""}
	}
})

minetest.register_craft({
	output = "fancy_elevator:door_gray",
	recipe = {
		{"default:steel_ingot","default:steel_ingot"},
		{"group:wood","default:steel_ingot"},
		{"default:steel_ingot","default:steel_ingot"}
	}
})


--TODO: -create a chest
--		-better textures
--		-write elevator name onto the door (sign like)

local elevator = {
	physical = false,
	collisionbox = {-0.49,-0.49,-0.5, 0.49,1.5,0.49},
	visual = "mesh",
	mesh = "elevator.obj",
	visual_size = {x=1, y=1},
	spritediv = {x=1,y=1},
	textures = {"elevator.png"},
	stepheight = 0,
	
	driver = nil,
	velocity = 0,
	target = nil,
	floor_pos = nil,
	old_target = nil,
	old_pos = nil,
	old_velocity = nil,
	floorlist = nil,
	calling_floors = {},
	selected_floor = nil,
	speed_limit = 4, -- Limit of the velocity
}

local elevatorindustrial = {
	physical = false,
	collisionbox = {-0.49,-0.49,-0.5, 0.49,1.5,0.49},
	visual = "mesh",
	mesh = "elevator.obj",
	visual_size = {x=1, y=1},
	spritediv = {x=1,y=1},
	textures = {"elevator_industrial.png"},
	stepheight = 0,
	
	driver = nil,
	velocity = 0,
	target = nil,
	floor_pos = nil,
	old_target = nil,
	old_pos = nil,
	old_velocity = nil,
	floorlist = nil,
	calling_floors = {},
	selected_floor = nil,
	speed_limit = 2, -- Limit of the velocity
}


function elevator:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	if not puncher or not puncher:is_player() then
		return
	end
	
	if puncher:get_player_control().sneak then
		self.object:remove()
		local inv = puncher:get_inventory()
		if minetest.setting_getbool("creative_mode") then
			if not inv:contains_item("main", "fancy_elevator:elevator") then
				inv:add_item("main", "fancy_elevator:elevator")
			end
		else
			inv:add_item("main", "fancy_elevator:elevator")
		end
		return
	end
end

function elevatorindustrial:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	if not puncher or not puncher:is_player() then
		return
	end
	
	if puncher:get_player_control().sneak then
		self.object:remove()
		local inv = puncher:get_inventory()
		if minetest.setting_getbool("creative_mode") then
			if not inv:contains_item("main", "fancy_elevator:elevatorindustrial") then
				inv:add_item("main", "fancy_elevator:elevatorindustrial")
			end
		else
			inv:add_item("main", "fancy_elevator:elevatorindustrial")
		end
		return
	end
end

local lastformbyplayer = {}

function elevator:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	
	if not self.pos then
		self.pos = self.object:getpos()
	end
	
	local elevator_pos = elevator_func:round_pos(self.pos)
	local clicker_pos = elevator_func:round_pos(clicker:getpos())
	if not self.floor_pos then
		self.floor_pos = elevator_func:get_floor_pos(self.object:getyaw(), elevator_pos)	
	end
	if ( clicker_pos.x ~= self.floor_pos.x
	and clicker_pos.x ~= elevator_pos.x )
	or clicker_pos.y ~= elevator_pos.y 
	or ( clicker_pos.z ~= self.floor_pos.z
	and clicker_pos.z ~=elevator_pos.z ) then
		return
	end
	lastformbyplayer[clicker:get_player_name()] = self
	
	
	if self.velocity == 0 then
		self.floorlist = elevator_func:get_floors(elevator_pos, self.floor_pos, 1)
	else
		self.floorlist = elevator_func:get_floors(elevator_pos, self.floor_pos)
	end	

	local floors = nil
	if self.floorlist ~= nil then
		local line = ""
		for _,floor in pairs(self.floorlist) do
			line = floor.text
			if floor.calling == "true" then
				line = "#300000"..line
			end
			if floors == nil then
				floors = line
			else
				floors = floors .."," .. line
			end
			
		end
	end

	if floors == nil then
		floors = ""
	end
	
	local formspec =
		"size[6,7]"..
		"label[2,0;Elevator]"..
		"label[0,1;Floors:]"..
		"textlist[0,1;5.75,4.7;floors;" ..
		floors.."]"..
		"button_exit[0,6;2,1;goto;Goto]"..
		"button_exit[2,6;2,1;exit;Exit]"..
		"button_exit[4,6;2,1;cancel;Cancel]"
	
	minetest.show_formspec(clicker:get_player_name(), "elevator:floor_choose", formspec)
	self.selected_floor = 0


end

function elevatorindustrial:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	
	if not self.pos then
		self.pos = self.object:getpos()
	end
	
	local elevator_pos = elevator_func:round_pos(self.pos)
	local clicker_pos = elevator_func:round_pos(clicker:getpos())
	if not self.floor_pos then
		self.floor_pos = elevator_func:get_floor_pos(self.object:getyaw(), elevator_pos)	
	end
	if ( clicker_pos.x ~= self.floor_pos.x
	and clicker_pos.x ~= elevator_pos.x )
	or clicker_pos.y ~= elevator_pos.y 
	or ( clicker_pos.z ~= self.floor_pos.z
	and clicker_pos.z ~=elevator_pos.z ) then
		return
	end
	lastformbyplayer[clicker:get_player_name()] = self
	
	
	if self.velocity == 0 then
		self.floorlist = elevator_func:get_floors(elevator_pos, self.floor_pos, 1)
	else
		self.floorlist = elevator_func:get_floors(elevator_pos, self.floor_pos)
	end	

	local floors = nil
	if self.floorlist ~= nil then
		local line = ""
		for _,floor in pairs(self.floorlist) do
			line = floor.text
			if floor.calling == "true" then
				line = "#300000"..line
			end
			if floors == nil then
				floors = line
			else
				floors = floors .."," .. line
			end
			
		end
	end

	if floors == nil then
		floors = ""
	end
	
	local formspec =
		"size[6,7]"..
		"label[2,0;Elevator]"..
		"label[0,1;Floors:]"..
		"textlist[0,1;5.75,4.7;floors;" ..
		floors.."]"..
		"button_exit[0,6;2,1;goto;Goto]"..
		"button_exit[2,6;2,1;exit;Exit]"..
		"button_exit[4,6;2,1;cancel;Cancel]"
	
	minetest.show_formspec(clicker:get_player_name(), "elevator:floor_choose", formspec)
	self.selected_floor = 0


end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "elevator:floor_choose" then
--		if fields.quit then 
--			return
--		end
		local playername = player:get_player_name()
		local entity = lastformbyplayer[playername]
		if not entity then
			return
		end
		if fields["floors"] ~= nil then
			local event = minetest.explode_textlist_event(fields["floors"])
			entity.selected_floor = event.index
			return
		end
		if fields["goto"] ~= nil and entity.selected_floor > 0 then
			if entity.floorlist[entity.selected_floor] then
				if not entity.driver then
					entity.driver = player
					player:set_look_yaw(elevator_func:round_yaw(entity.object:getyaw(), 91))
					--entity.object:set_animation({x=0, y=20})
					player:set_attach(entity.object, "", {x=0, y=5, z=0}, {x=0, y=0, z=0})
					--player:set_animation({x=0, y=5})
					--entity.object:set_animation({x=0, y=-1})
					player:set_eye_offset({x=0, y=-3, z=0}, {x=0, y=0, z=0})
					
				end
				if entity.driver == player then
					local pos = entity.floorlist[entity.selected_floor].pos
					entity:add_calling(pos)
				end
				lastformbyplayer[playername] = nil
			end
			return
		elseif fields["exit"] ~= nil and entity.target == nil then
			if entity.driver == player then 
				entity.driver = nil
				local pos = entity.object:getpos()
				local pos_to = {}
				pos_to.x = entity.floor_pos.x
				pos_to.z = entity.floor_pos.z
				pos_to.y = pos.y
				--print(minetest.pos_to_string(pos_to))
				--print(minetest.pos_to_string(player:getpos()))
				player:set_detach()
				player:set_animation({x=0, y=-5})
				player:moveto(pos_to)
				player:set_eye_offset({x=0, y=0 ,z=0}, {x=0, y=0, z=0})
			end
			lastformbyplayer[playername] = nil
			return
		end
	end
	
end)

function elevator:move_to(pos)
	if pos.y ~= nil then
		local round_pos = elevator_func:round_pos(self.object:getpos())
		round_pos.y = round_pos.y - 1
		if minetest.get_node(round_pos).name == "fancy_elevator:ground" then
			minetest.remove_node(round_pos)
		end
		self.target = pos
		return true
	else
		minetest.log("error","Elevator: Failed to locate target position")
		return false
	end
end

function elevatorindustrial:move_to(pos)
	if pos.y ~= nil then
		local round_pos = elevator_func:round_pos(self.object:getpos())
		round_pos.y = round_pos.y - 1
		if minetest.get_node(round_pos).name == "fancy_elevator:ground" then
			minetest.remove_node(round_pos)
		end
		self.target = pos
		return true
	else
		minetest.log("error","Elevator: Failed to locate target position")
		return false
	end
end

minetest.register_entity("fancy_elevator:elevator", elevator)

minetest.register_craftitem("fancy_elevator:elevator", {
	description = "Elevator",
	inventory_image = minetest.inventorycube("elevator_top.png", "elevator_side.png", "elevator_front.png"),
	wield_image = "elevator_side.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if not pointed_thing.type == "node" then
			return
		end

		local pos = minetest.get_pointed_thing_position(pointed_thing, true) 
		
		for vary = 0, 1, 1 do
			if not elevator_func:is_shaft({x=pos.x,y=pos.y+vary,z=pos.z}) then
				minetest.chat_send_player(placer:get_player_name(),"This is not a shaft!")
				return
			end
		end
		
		local elevators, added = elevator_func:get_elevater(pos)
		if #elevators > 0 then
			minetest.chat_send_player(placer:get_player_name(),
				"In this shaft is already an elevator!")
			if not minetest.setting_getbool("creative_mode") then
				for i=1,added,1 do
					itemstack:add_item("fancy_elevator:elevator")
				end
				return itemstack
			else
				return 
			end
		end
		local entity = minetest.add_entity(pos, "fancy_elevator:elevator")
		if entity ~= nil then
			local yaw = elevator_func:round_yaw(placer:get_look_yaw(), 180)
			entity:setyaw(yaw)
			local entity1 = entity:get_luaentity()
			entity1.floor_pos = elevator_func:get_floor_pos(yaw, pos)
			
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end
	end,
})

minetest.register_entity("fancy_elevator:elevatorindustrial", elevatorindustrial)

minetest.register_craftitem("fancy_elevator:elevatorindustrial", {
	description = "Elevator (Industrial)",
	inventory_image = minetest.inventorycube("elevator_top.png", "elevator_truss.png", "elevator_truss.png"),
	wield_image = "elevator_truss.png",
	
	on_place = function(itemstack, placer, pointed_thing)
		if not pointed_thing.type == "node" then
			return
		end

		local pos = minetest.get_pointed_thing_position(pointed_thing, true) 
		
		for vary = 0, 1, 1 do
			if not elevator_func:is_shaft({x=pos.x,y=pos.y+vary,z=pos.z}) then
				minetest.chat_send_player(placer:get_player_name(),"This is not a shaft!")
				return
			end
		end
		
		local elevators, added = elevator_func:get_elevater(pos)
		if #elevators > 0 then
			minetest.chat_send_player(placer:get_player_name(),
				"In this shaft is already an elevator!")
			if not minetest.setting_getbool("creative_mode") then
				for i=1,added,1 do
					itemstack:add_item("fancy_elevator:elevatorindustrial")
				end
				return itemstack
			else
				return 
			end
		end
		local entity = minetest.add_entity(pos, "fancy_elevator:elevatorindustrial")
		if entity ~= nil then
			local yaw = elevator_func:round_yaw(placer:get_look_yaw(), 180)
			entity:setyaw(yaw)
			local entity1 = entity:get_luaentity()
			entity1.floor_pos = elevator_func:get_floor_pos(yaw, pos)
			
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end
	end,
})

function elevator:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	self.driver = nil
	self.old_pos = self.object:getpos()
	self.object:setvelocity({x=0, y=0, z=0})
	self.velocity = 0;
end

function elevator:organice()
	if not self.pos then
		self.pos = self.object:getpos()
	end
	if not self.floor_pos then
		self.floor_pos = elevator_func:get_floor_pos(self.object:getyaw(), self.pos)	
	end
	self.floorlist = elevator_func:get_floors(self.pos, self.floor_pos)
	self.calling_floors = elevator_func:get_calling_floors(self.floorlist)
	
	if #self.calling_floors > 0 then
		if self.target == nil then
			if self.old_target and elevator_doors.get_door_status(self.old_target) ~= 0 then
				return
			end
			if self.pos.y == self.calling_floors[1].pos.y then
				return
			end
			if #self.calling_floors > 0 then
				--self.old_target = self.target --why?
				self:move_to(self.calling_floors[1].pos)
			end
		end
	end
end

function elevator:add_calling(calling_pos)
	if self.pos == nil then
		self.pos = self.object:getpos()
	end
	local meta = minetest.get_meta(calling_pos)
	if self.pos.y == calling_pos.y then
		meta:set_string("calling", "false")
		meta:set_int("order", -1)
		local name = minetest.get_node(calling_pos).name
		name = name:sub(0,name:len()-4)
		elevator_doors.open_door(calling_pos, 1, name, name.."_t_1", name.."_b_2", name.."_t_2", {1,2,3,0}, 1)
		self:organice()
		return
	end
	local round_pos = elevator_func:round_pos(self.pos)	
	if self.floor_pos == nil then
		self.floor_pos = elevator_func:get_floor_pos(self.object:getyaw(), round_pos)	
	end
	self.floorlist = elevator_func:get_floors(round_pos, self.floor_pos)
	self.calling_floors = elevator_func:get_calling_floors(self.floorlist)
	local calling_h = #self.calling_floors+1
	local meta = minetest.get_meta(calling_pos)
	meta:set_string("calling", "true")
	meta:set_int("order", calling_h)
	self:organice()
end

function elevator:on_step(dtime)
	if self.target ~= nil then
		self.pos = self.object:getpos()
		
		self.pos.y = self.pos.y
		if self.target.y ~= self.pos.y then
			local diff = 0
			if self.target.y > self.pos.y then
				diff = self.target.y - self.pos.y
			elseif self.target.y < self.pos.y then
				diff = self.pos.y - self.target.y
			end
			if self.target.y > self.pos.y then
				if self.velocity <= 0 then
					self.velocity = 0.1
				end
				if diff > math.abs(self.velocity) then
					self.velocity = self.velocity*2
				else
					self.velocity = self.velocity/2
					if diff < 0.2 then
						elevator:stop_at_target(self, elevator_func:round_pos(self.pos))
					end
				end
			elseif self.target.y < self.pos.y then
				if self.velocity >= 0 then
					self.velocity = -0.1
				end
				if diff > math.abs(self.velocity) then
					self.velocity = self.velocity*2
				else
					self.velocity = self.velocity/2
					if diff < 0.2 then
						elevator:stop_at_target(self, elevator_func:round_pos(self.pos))
					end
				end
			end
			
			if math.abs(self.velocity) > self.speed_limit then
				if self.velocity > 0 then
					self.velocity = self.speed_limit
				else
					self.velocity = self.speed_limit * -1
				end
			end

			self.object:setvelocity({x=0, y=self.velocity, z=0})
			self.old_pos = self.object:getpos()
			self.old_velocity = self.velocity
		else
			self.target = nil
			self.velocity = 0
			self.old_pos = self.object:getpos()
			self.old_velocity = self.velocity
			self.object:setvelocity({x=0, y=self.velocity, z=0})
			self:organice()
		end
	else
		if self.velocity ~= 0 then	
			self.velocity = 0
			self.old_pos = self.object:getpos()
			self.old_velocity = self.velocity
			self.object:setvelocity({x=0, y=self.velocity, z=0})
		end
	end
end

function elevatorindustrial:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	self.driver = nil
	self.old_pos = self.object:getpos()
	self.object:setvelocity({x=0, y=0, z=0})
	self.velocity = 0;
end

function elevatorindustrial:organice()
	if not self.pos then
		self.pos = self.object:getpos()
	end
	if not self.floor_pos then
		self.floor_pos = elevator_func:get_floor_pos(self.object:getyaw(), self.pos)	
	end
	self.floorlist = elevator_func:get_floors(self.pos, self.floor_pos)
	self.calling_floors = elevator_func:get_calling_floors(self.floorlist)
	
	if #self.calling_floors > 0 then
		if self.target == nil then
			if self.old_target and elevator_doors.get_door_status(self.old_target) ~= 0 then
				return
			end
			if self.pos.y == self.calling_floors[1].pos.y then
				return
			end
			if #self.calling_floors > 0 then
				--self.old_target = self.target --why?
				self:move_to(self.calling_floors[1].pos)
			end
		end
	end
end

function elevatorindustrial:add_calling(calling_pos)
	if self.pos == nil then
		self.pos = self.object:getpos()
	end
	local meta = minetest.get_meta(calling_pos)
	if self.pos.y == calling_pos.y then
		meta:set_string("calling", "false")
		meta:set_int("order", -1)
		local name = minetest.get_node(calling_pos).name
		name = name:sub(0,name:len()-4)
		elevator_doors.open_door(calling_pos, 1, name, name.."_t_1", name.."_b_2", name.."_t_2", {1,2,3,0}, 1)
		self:organice()
		return
	end
	local round_pos = elevator_func:round_pos(self.pos)	
	if self.floor_pos == nil then
		self.floor_pos = elevator_func:get_floor_pos(self.object:getyaw(), round_pos)	
	end
	self.floorlist = elevator_func:get_floors(round_pos, self.floor_pos)
	self.calling_floors = elevator_func:get_calling_floors(self.floorlist)
	local calling_h = #self.calling_floors+1
	local meta = minetest.get_meta(calling_pos)
	meta:set_string("calling", "true")
	meta:set_int("order", calling_h)
	self:organice()
end

function elevatorindustrial:on_step(dtime)
	if self.target ~= nil then
		self.pos = self.object:getpos()
		
		self.pos.y = self.pos.y
		if self.target.y ~= self.pos.y then
			local diff = 0
			if self.target.y > self.pos.y then
				diff = self.target.y - self.pos.y
			elseif self.target.y < self.pos.y then
				diff = self.pos.y - self.target.y
			end
			if self.target.y > self.pos.y then
				if self.velocity <= 0 then
					self.velocity = 0.1
				end
				if diff > math.abs(self.velocity) then
					self.velocity = self.velocity*2
				else
					self.velocity = self.velocity/2
					if diff < 0.2 then
						elevatorindustrial:stop_at_target(self, elevator_func:round_pos(self.pos))
					end
				end
			elseif self.target.y < self.pos.y then
				if self.velocity >= 0 then
					self.velocity = -0.1
				end
				if diff > math.abs(self.velocity) then
					self.velocity = self.velocity*2
				else
					self.velocity = self.velocity/2
					if diff < 0.2 then
						elevatorindustrial:stop_at_target(self, elevator_func:round_pos(self.pos))
					end
				end
			end
			
			if math.abs(self.velocity) > self.speed_limit then
				if self.velocity > 0 then
					self.velocity = self.speed_limit
				else
					self.velocity = self.speed_limit * -1
				end
			end

			self.object:setvelocity({x=0, y=self.velocity, z=0})
			self.old_pos = self.object:getpos()
			self.old_velocity = self.velocity
		else
			self.target = nil
			self.velocity = 0
			self.old_pos = self.object:getpos()
			self.old_velocity = self.velocity
			self.object:setvelocity({x=0, y=self.velocity, z=0})
			self:organice()
		end
	else
		if self.velocity ~= 0 then	
			self.velocity = 0
			self.old_pos = self.object:getpos()
			self.old_velocity = self.velocity
			self.object:setvelocity({x=0, y=self.velocity, z=0})
		end
	end
end

function elevator:stop_at_target(self, round_pos)
	self.velocity = 0
	self.object:setvelocity({x=0, y=0, z=0})
	self.object:moveto({x=round_pos.x, y=self.target.y, z=round_pos.z})
	local name = minetest.get_node(self.target).name
	name = name:sub(0,name:len()-4)
	self.old_target = self.target
	self.target.y = self.target.y
	elevator_doors.open_door(self.target, 1, name, name.."_t_1", name.."_b_2", name.."_t_2", {1,2,3,0}, 1)
	local meta = minetest.get_meta(self.target)
	meta:set_string("calling", "false")
	meta:set_int("order", -1)
	self.floorlist = elevator_func:get_floors(round_pos, self.floor_pos)
	self.calling_floors = elevator_func:get_calling_floors(self.floorlist)
	local floorname = nil
	for i=1, #self.calling_floors, 1 do
		meta = minetest.get_meta(self.calling_floors[i].pos)
		meta:set_int("order",i)
	end
	self.target = nil
	self.pos = self.object:getpos()
	local pos = elevator_func:round_pos(self.pos)
	pos.y = pos.y - 1
	if minetest.get_node(pos).name == "air" then
		minetest.set_node(pos, {name="fancy_elevator:ground"})
	end
	self:organice()
end

function elevatorindustrial:stop_at_target(self, round_pos)
	self.velocity = 0
	self.object:setvelocity({x=0, y=0, z=0})
	self.object:moveto({x=round_pos.x, y=self.target.y, z=round_pos.z})
	local name = minetest.get_node(self.target).name
	name = name:sub(0,name:len()-4)
	self.old_target = self.target
	self.target.y = self.target.y
	elevator_doors.open_door(self.target, 1, name, name.."_t_1", name.."_b_2", name.."_t_2", {1,2,3,0}, 1)
	local meta = minetest.get_meta(self.target)
	meta:set_string("calling", "false")
	meta:set_int("order", -1)
	self.floorlist = elevator_func:get_floors(round_pos, self.floor_pos)
	self.calling_floors = elevator_func:get_calling_floors(self.floorlist)
	local floorname = nil
	for i=1, #self.calling_floors, 1 do
		meta = minetest.get_meta(self.calling_floors[i].pos)
		meta:set_int("order",i)
	end
	self.target = nil
	self.pos = self.object:getpos()
	local pos = elevator_func:round_pos(self.pos)
	pos.y = pos.y - 1
	if minetest.get_node(pos).name == "air" then
		minetest.set_node(pos, {name="fancy_elevator:ground"})
	end
	self:organice()
end
