--revision 2 
--worry about speed, worry about direction
--if it hits a t then swap the z with x direction
--if it hits a point where there is no rail in direction, check for t, then check for turn,
--when past center point of end rail, turn how far it is past the center into the turn (z to x) or (x to z)
--eventually make it so you can push them
--eventually make it so you can connect them
--make this mod totally physical, no clicking to move, etc, push it, or use control panel
--then do furnace carts to push as a starter, try to make this super in depth, 


--let's start off
--[[
the goal is

make a stick spawn a basic prototype of a minecart which uses moveto interpolated to give the illusion of movement
without creating extreme scenarios which can cause minecarts to go flying clientside, 
just stopping via clientside until catchup, which is much neater and more digestable mentally
]]--

--Minecart prototype
--MAKE IT BASIC

local minecart   = {
	physical     = true,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}, -- fill up the node
	visual       = "cube",
	textures     = {"default_wood.png"},
	
	direction    = {x=0,y=0,z=0},
	speed        = 0, --dpt (distance per tick, speed measurement)
}

--right click function
function minecart.on_rightclick(self, clicker)
	local pos = self.object:getpos()
	--if self.direction.x == 0 and self.direction.z == 0 then
		self.direction = set_direction(clicker:getpos(), pos)
		self.speed     = 0.1
	--end
end

--when the minecart is created in world
function minecart.on_activate(self, staticdata, dtime_s)
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

	local x = math.floor((pos.x + direction.x) + 0.5)
	local y = math.floor((pos.y + direction.y) + 0.5) --the center of the node
	local z = math.floor((pos.z + direction.z) + 0.5)
	-----
	local speedx = pos.x + (direction.x * speed)
	local speedy = pos.y + (direction.y * speed) --the speed moveto uses to move the minecart
	local speedz = pos.z + (direction.z * speed)
	-----
	local forwardnode = minetest.get_node({x=x,y=y,z=z}).name --the node 1 space in front of it
	----
	local movement  = {x=speedx,y=speedy,z=speedz}
	
	if forwardnode == "default:rail" then
		--move the cart forwards
		movement = {x=speedx,y=speedy,z=speedz}
	else--if nothing in front of it and it's past the center of the node, try to turn 
		
		if math.abs(direction.x) > 0 then
			if ((direction.x > 0) and (pos.x > math.floor(pos.x + 0.5))) or ((direction.x < 0) and (pos.x < math.floor(pos.x + 0.5))) then
				local overhang = pos.x - math.floor(pos.x + 0.5) -- how much past the center the cart is, (add to next dir
				
				local left  = minetest.get_node({x=pos.x,y=pos.y,z=pos.z + 1}).name
				local right = minetest.get_node({x=pos.x,y=pos.y,z=pos.z - 1}).name
				
				if left == "default:rail" then
					direction.x = 0
					direction.z = 1
					--reset on the center of the rail and compensate for overhang 
					--"turn simulation" will look nice with auto rotate and multiple carts
					movement = {x=math.floor(pos.x + 0.5),y=pos.y,z=pos.z + speed + overhang}
				elseif right == "default:rail" then
					direction.x = 0
					direction.z = -1
					movement = {x=math.floor(pos.x + 0.5),y=pos.y,z=pos.z - speed - overhang} 
				end
			end
		--[[
		elseif math.abs(direction.z) > 0 then
			if ((direction.z > 0) and (pos.z > math.floor(pos.z + 0.5))) or ((direction.z < 0) and (pos.z < math.floor(pos.z + 0.5))) then
				local overhang = pos.z - math.floor(pos.z + 0.5) -- how much past the center the cart is, (add to next dir

				local left  = minetest.get_node({x=pos.x + 1,y=pos.y,z=pos.z}).name
				local right = minetest.get_node({x=pos.x - 1,y=pos.y,z=pos.z}).name
				
				if left == "default:rail" then
					direction.x = 1
					direction.z = 0
					movement = {x=pos.x + speed + overhang,y=pos.y,z=math.floor(pos.z + 0.5)} 
				elseif right == "default:rail" then
					direction.x = -1
					direction.z = 0
					movement = {x=pos.x - speed - overhang,y=pos.y,z=math.floor(pos.z + 0.5)} 
				end
			end
			]]--
		end
	end
	
	self.object:moveto(movement)
	self.object:get_luaentity().direction = direction
end





function set_direction(clickerpos,selfpos)
	local x     = clickerpos.x - selfpos.x
	local z     = clickerpos.z - selfpos.z
	local table = {x=0,y=0,z=0}
	
	table = {x=math.random(-1,1),y=0,z=0}
	return(table)
end






minetest.override_item("default:stick", {
	on_place = function(itemstack, placer, pointed_thing)
		local nodename = minetest.get_node(pointed_thing.under).name
		
		if nodename == "default:rail" then
			minetest.add_entity(pointed_thing.under, "trains:minecart")
		end
	end,
})
