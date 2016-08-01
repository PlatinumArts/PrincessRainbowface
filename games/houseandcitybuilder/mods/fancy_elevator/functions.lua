
-- Functions for Elevator Mod --


elevator_func = {}

function elevator_func:is_shaft(pos_get)
	local pos = {x=pos_get.x, y=pos_get.y, z=pos_get.z}
	local nodename = nil
	for varx = -1, 1, 1 do
		for varz = -1, 1, 1 do
			nodename = minetest.get_node({x=pos.x+varx,y=pos.y,z=pos.z+varz}).name
			if not (varx == 0 and varz == 0) then
				if minetest.get_item_group(nodename, "shaft") < 1 then
					return false
				end
			else
				if nodename ~= "air" and nodename ~= "fancy_elevator:ground" then
					return false
				end
			end
		end
	end
	return true
end

function elevator_func:get_floors(pos_get, floor_pos, stay)
	local pos = elevator_func:round_pos(pos_get)
	local floors = {}
	local pos1 = nil
	local meta = nil
	local name = nil
	local elem = nil
	local oldy = nil
	
	if stay ~= nil then
		oldy = pos.y
	end
	
	while elevator_func:is_shaft(pos) do
		pos.y = pos.y+1
	end
	pos.y = pos.y - 1
	while elevator_func:is_shaft(pos) do
		pos1 = minetest.find_node_near(pos, 1, {"group:elevator_door"})
		if pos1 ~= nil then
			if pos1.x == floor_pos.x and pos1.z == floor_pos.z then
				if pos1.y == pos.y then
					if pos1.y ~= oldy then
						meta = minetest.get_meta(pos1)
						if meta ~= nil then
							if meta:get_string("text") ~= "" then
								elem = nil
								elem = {
									text = meta:get_string("text"),
									calling = meta:get_string("calling"),
									order = meta:get_int("order"),
									pos = pos1,
								}
								table.insert(floors,elem)
							end
						end
					end
				end
			end
		end
		pos.y = pos.y-1
	end
	
	return floors
end

function elevator_func:get_elevater(pos_get)
	local pos = {x=pos_get.x, y=pos_get.y, z=pos_get.z}
	local all_objects = nil
	local last_entity = nil
	local elevators = {}
	pos.y = math.floor(pos.y * 1 + 0.5) / 1	
	
	while elevator_func:is_shaft(pos) do
		pos.y = pos.y-1
	end
	pos.y = pos.y + 1
	if pos.name ~= "air" then
		--pos.y = pos.y + 1 --one shaft needs to be under the last door
	end
	local all_objects = nil
	while elevator_func:is_shaft(pos) do
		all_objects = minetest.get_objects_inside_radius(pos, 0.5)
		if all_objects ~= nil then
			for _,obj in pairs(all_objects) do
				local entity = obj:get_luaentity()
				if entity ~= nil and entity ~= last_entity then 
					if entity.name == "fancy_elevator:elevator" then
						table.insert(elevators, entity)
						last_entity = entity
					end
				end
			end
		end
		all_objects = nil
		pos.y = pos.y+1
	end
	local added = 0
	if #elevators > 1 then
		minetest.log("info","In this shaft is more than 1 elevator, please try to use one elevator per shaft")
		for i = 2, #elevators, 1 do
			added = added+1
			elevators[i].object:remove()
			table.remove(elevators, i)
		end
	end
	return elevators, added
end

function elevator_func:get_shaft(pos_get)
	local pos = {x=pos_get.x, y=pos_get.y, z=pos_get.z}
	if elevator_func:is_shaft(pos) then
		return pos
	end
	pos.x = pos_get.x+1
	pos.z = pos_get.z
	if elevator_func:is_shaft(pos) then
		return pos
	end
	pos.x = pos_get.x
	pos.z = pos_get.z+1
	if elevator_func:is_shaft(pos) then
		return pos
	end
	pos.x = pos_get.x-1
	pos.z = pos_get.z
	if elevator_func:is_shaft(pos) then
		return pos
	end
	pos.x = pos_get.x
	pos.z = pos_get.z-1
	if elevator_func:is_shaft(pos) then
		return pos
	end
	return false
end

function elevator_func:add_calling(calling_pos)
	local pos = elevator_func:get_shaft(calling_pos)
	if pos == false then
		return
	end
	local elevators = elevator_func:get_elevater(pos)
	if #elevators == 1 then
		elevators[1]:add_calling(calling_pos)
	end
end

function elevator_func:organice(get_pos)
	if get_pos == nil then
		return
	end
	local elevator_pos = elevator_func:get_shaft(get_pos)
	if elevator_pos == false then
		return
	end
	local elevators = elevator_func:get_elevater(elevator_pos)
	if #elevators == 1 then
		elevators[1]:organice()
	end
end

function elevator_func:get_calling_floors(floorlist)
	local function compare_floorlist(w1,w2)
		if w1.order < w2.order then
			return true
		end
	end
	local calling_floors = {}
	for _,floor in pairs(floorlist) do
		if floor.calling == "true" then
			table.insert(calling_floors, floor)
		end
	end
	table.sort(calling_floors, compare_floorlist)
	return calling_floors
end

function elevator_func:round_pos(pos)
	return {
		x=math.floor(pos.x * 1 + 0.5) / 1, 
		y=math.floor(pos.y * 1 + 0.5) / 1, 
		z=math.floor(pos.z * 1 + 0.5) / 1
	}
end

function elevator_func:round_yaw(yaw, rotation)
 	local degree = elevator_func:get_degree(yaw, rotation)
	while degree < 0 do degree=degree+360 end
	while degree >360 do degree=degree-360 end
	if degree > 0 and degree < 45 then
		degree = 0
	elseif degree > 45 and degree < 135 then
		degree = 90
	elseif degree > 135 and degree < 225 then
		degree = 180
	elseif degree > 225 and degree < 315 then
		degree = 270
	elseif degree > 315 and degree < 361 then
		degree = 0
	end
	return elevator_func:get_yaw(degree)
end

function elevator_func:get_degree(yaw, rotation)
	if not rotation then
		rotation = 0
	end
	local degree = yaw*180/math.pi-rotation
	degree = math.floor(degree * 1 + 0.5) / 1
	return degree
end

function elevator_func:get_yaw(degree)
	return degree/180*math.pi
end

function elevator_func:get_floor_pos(yaw, elevator_pos)
	local pos = elevator_func:round_pos(elevator_pos)
	local degree = elevator_func:get_degree(yaw)
	if degree == 0 then
		return {
			x = pos.x+1,
			z = pos.z
		}
	elseif degree == 90 then
		return {
			x = pos.x,
			z = pos.z+1
		}
	elseif degree == 180 then
		return {
			x = pos.x-1,
			z = pos.z
		}
	else
		return {
			x = pos.x,
			z = pos.z-1
		}
	end
end
