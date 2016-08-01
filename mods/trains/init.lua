--revision 2 
--worry about speed, worry about direction
--if it hits a t then swap the z with x direction
--if it hits a point where there is no rail in direction, check for t, then check for turn,
--when past center point of end rail, turn how far it is past the center into the turn (z to x) or (x to z)
--eventually make it so you can push them
--eventually make it so you can connect them
--make this mod totally physical, no clicking to move, etc, push it, or use control panel
--then do furnace carts to push as a starter, try to make this super in depth, 
--rewrite this to use voxel manip, and open up a 3x3 box to do logic

--let's start off
--[[
the goal is

make a stick spawn a basic prototype of a minecart which uses moveto interpolated to give the illusion of movement
without creating extreme scenarios which can cause minecarts to go flying clientside, 
just stopping via clientside until catchup, which is much neater and more digestable mentally
]]--

--Minecart prototype
--MAKE IT BASIC

--direction == pos - lastpos vector
--randomize turning for single carts?
--stop moveto if no rail at pos,and cancel whole collision detection if not on rail
cart_link = {}

local minecart   = {
	physical     = true,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "mesh",
	mesh = "cart.x",
	visual_size = {x=1, y=1},
	textures = {"cart.png"},
	automatic_face_movement_dir = 0.0,
	
	direction    = {x=0,y=0,z=0},
	speed        = 0, --dpt (distance per tick, speed measurement)
}
--punch function
function minecart.on_punch(self)
	self.object:remove()
end

--right click function
function minecart.on_rightclick(self, clicker)
	--set_direction(self)
	--sneak to link minecarts
	if clicker:get_player_control().sneak == true then
		if cart_link[clicker:get_player_name()] == nil then
			cart_link[clicker:get_player_name()] = self.object:get_luaentity()
		else
			self.leader = cart_link[clicker:get_player_name()]
			cart_link[clicker:get_player_name()] = nil
			self.speed     = 0.2
			minetest.chat_send_player(clicker:get_player_name(), "Carts linked!")
		end
	else
		if self.speed ~= 0 then
			self.speed = 0
		else
			self.speed     = 0.2
			clicker:set_attach(self.object, "", {x=0,y=0,z=0}, {x=0,y=0,z=0})
		end
	end
end

--when the minecart is created in world
function minecart.on_activate(self, staticdata, dtime_s)
	set_direction(self)
end

--what the minecart does in the world
function minecart.on_step(self, dtime)
	roll(self)
end

minetest.register_entity("trains:minecart", minecart)



--how the minecart moves on the tracks
-- "cart logic"
function roll(self)

	local pos       = self.object:getpos()
	local direction = self.object:get_luaentity().direction
	local speed     = self.object:get_luaentity().speed
	local leader    = self.object:get_luaentity().leader
	
	
	local x = math.floor(pos.x + 0.5)
	local y = math.floor(pos.y + 0.5) --the center of the node
	local z = math.floor(pos.z + 0.5)
	-----
	local speedx = pos.x + (direction.x * speed)
	local speedy = pos.y + (direction.y * speed) --the speed moveto uses to move the minecart
	local speedz = pos.z + (direction.z * speed)
	-----
	--local currentnode = minetest.get_node({x=x,y=y,z=z}).name
	local forwardnode = minetest.get_node({x=speedx,y=y,z=speedz}).name --the node 1 space in front of it
	local upnode      = minetest.get_node({x=speedx+(direction.x),y=speedy+1,z=speedz+(direction.z)}).name    --the node 1 space up + 1 space forwards
	local downnode    = minetest.get_node({x=pos.x+(direction.x/2),y=speedy-1,z=pos.z+(direction.z/2)}).name    --the node 1 space down + 1 space forwards
	local nodeahead   = minetest.get_node({x=pos.x+(direction.x/2),y=pos.y+(direction.y/2),z=pos.z+(direction.z/2)}).name --1 rounded node ahead
	----
	local movement  = {x=pos.x,y=pos.y,z=pos.z}
	
	--reverse direction if collides with players
	--[[
	for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 1)) do
		if object:is_player() then
			local pos2 = object:getpos()
			local difx = pos.x - pos2.x
			local difz = pos.z - pos2.z
			if direction.x > 0 then
				--calculate distance into speed
				if difx < 0 then
					direction.x = -1
				end
			elseif direction.x < 0 then
				--calculate distance into speed
				if difx > 0 then
					direction.x = 1
				end
			elseif direction.z > 0 then
				--calculate distance into speed
				if difz < 0 then
					direction.z = -1
				end
			elseif direction.z < 0 then
				--calculate distance into speed
				if difz > 0 then
					direction.z = 1
				end
			end
		end
	end
	]]--
	--this is the prototype for carts to follow eachother
	
	for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 8)) do
		if object:is_player() == false then
			if leader ~= nil then
				if object:get_luaentity() == leader then
					--print("test")
					local pos2 = object:getpos()
					local difx = pos.x - pos2.x
					local difz = pos.z - pos2.z
					local distance = vector.distance(pos,pos2)
					--cancel the rest of the collision detection
					if distance < 1 then
						return
					end
					if direction.x > 0 then
						--calculate distance into speed
						if difx > 0 then
							direction.x = -1
						end
					elseif direction.x < 0 then
						--calculate distance into speed
						if difx < 0 then
							direction.x = 1
						end
					elseif direction.z > 0 then
						--calculate distance into speed
						if difz > 0 then
							direction.z = -1
						end
					elseif direction.z < 0 then
						--calculate distance into speed
						if difz < 0 then
							direction.z = 1
						end
					end
					--try to correct for t junction
					if math.abs(difx) < speed then
						direction.x = 0
						if difz > 0 then
							direction.z = -1
						elseif difz < 0 then
							direction.z = 1
						end
					elseif math.abs(difz) < speed then
						direction.z = 0
						if difx > 0 then
							direction.x  = -1
						elseif difx < 0 then
							direction.x = 1
						end
					end
				end
			end
		end
	end
	--move minecart down
	if forwardnode ~= "default:rail" and downnode == "default:rail" and direction.y == 0 then
		direction.y = -1
	elseif direction.y == -1 then
		movement = {x=speedx,y=speedy,z=speedz}
		--keep cart on center of rail
		if math.abs(direction.x) > 0 then
			movement.z = z
		elseif math.abs(direction.z) > 0 then
			movement.x = x
		end
		--when it gets to the bottom of the rail, stop moving down
		local noder = minetest.get_node({x=speedx,y=pos.y-0.5-(speed*2),z=speedz}).name
		if noder  ~= "default:rail" then
			direction.y = 0
		end
	--move minecart up
	elseif nodeahead == "default:rail" and upnode == "default:rail" and direction.y == 0 then
		direction.y = 1
	elseif direction.y == 1 then
		movement = {x=speedx,y=speedy,z=speedz}
		--keep cart on center of rail
		if math.abs(direction.x) > 0 then
			movement.z = z
		elseif math.abs(direction.z) > 0 then
			movement.x = x
		end
		--when it gets to the top of the rail, stop moving up
		if minetest.get_node({x=speedx+(direction.x),y=speedy+0.5,z=speedz+(direction.z)}).name ~= "default:rail" then
			direction.y = 0
		end
	--move the cart forwards
	elseif nodeahead == "default:rail" and upnode ~= "default:rail" and direction.y == 0 or (nodeahead ~= "default:rail" and downnode == "default:rail") then --and upnode ~= "default:rail" and downnode ~= "default:rail" and direction.y == 0 then
		if math.abs(speedx) ~= 0 or math.abs(speedz) ~= 0 then
			movement = {x=speedx,y=speedy,z=speedz}
			--keep cart on center of rail
			if math.abs(direction.x) > 0 then
				movement.z = z
			elseif math.abs(direction.z) > 0 then
				movement.x = x
			end
		end
	--turn and handle T junctions
	elseif nodeahead ~= "default:rail" and upnode ~= "default:rail" and downnode ~= "default:rail" then
		if math.abs(direction.x) > 0 then	
			local left  = minetest.get_node({x=pos.x,y=pos.y,z=pos.z + 1}).name
			local right = minetest.get_node({x=pos.x,y=pos.y,z=pos.z - 1}).name
		
			if left == "default:rail" then
				direction.x = 0
				direction.z = 1
			elseif right == "default:rail" then
				direction.x = 0
				direction.z = -1
			end
		elseif math.abs(direction.z) > 0 then	
			local left  = minetest.get_node({x=pos.x + 1,y=pos.y,z=pos.z}).name
			local right = minetest.get_node({x=pos.x - 1,y=pos.y,z=pos.z}).name
			if left == "default:rail" then
				direction.x = 1
				direction.z = 0
			elseif right == "default:rail" then
				direction.x = -1
				direction.z = 0
			end
		end
	end
	
	self.object:moveto(movement)
	self.object:get_luaentity().direction = direction
	self.object:get_luaentity().speed = speed
	
end




--set the minecart's direction
function set_direction(self)
	local pos       = self.object:getpos()
	local left      = minetest.get_node({x=pos.x,y=pos.y,z=pos.z + 1}).name
	local right     = minetest.get_node({x=pos.x,y=pos.y,z=pos.z - 1}).name
	local forward   = minetest.get_node({x=pos.x + 1,y=pos.y,z=pos.z}).name
	local backward  = minetest.get_node({x=pos.x - 1,y=pos.y,z=pos.z}).name
	local direction = {x=0,y=0,z=0}
	if left == "default:rail" then
		direction.z = 1
	elseif right == "default:rail" then
		direction.z = -1
	elseif forward == "default:rail" then
		direction.x = 1
	elseif backward == "default:rail" then
		direction.x = -1
	end
	self.object:get_luaentity().direction = direction
end





minetest.override_item("default:stick", {
	on_place = function(itemstack, placer, pointed_thing)
		local nodename = minetest.get_node(pointed_thing.under).name
		
		if nodename == "default:rail" then
			minetest.add_entity(pointed_thing.under, "trains:minecart")
		end
	end,
})
