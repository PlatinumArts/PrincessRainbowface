


-- PLAYER JOIN MESSAGE
minetest.register_on_joinplayer(function(player)
	minetest.chat_send_all("Welcome "..player:get_player_name().."! Press I for your inventory!  Press escape to open the game menu.")
end)

-- HITTING A BRICK CREATES A GLOBAL MESSAGE
minetest.register_on_punchnode(
	function(pos, node, puncher)
		if node.name == "default:brick" then
			local name = puncher:get_player_name()
			minetest.chat_send_all("Hey " .. name .. ", why are you hitting me?")
		end
	end	
)


--[[  ADDED TO WASTEMOD MOD :)
-- ADDED WASTE
minetest.register_craftitem("mikesmod:waste", {
	description = "Waste",
	inventory_image = "mikesmod_waste.png",
	--groups={waste},
})

-- BLERTS CODE FOR GIVING A PLAYER AN ITEM EVERY DAY  
local players = {}

local fname = core.get_worldpath().."/players/dailyitems.txt"

-- check if file exists,
-- if not: create it,
-- if yes: read it
local f = io.open(fname, "r")
if f then
   players = core.deserialize(f:read('*all'))
   --print(core.serialize(players))
else
   f = io.open(fname, "w")
   f:write()
end
io.close(f)

-- when player joins
core.register_on_joinplayer(function(player)
   local pname = player:get_player_name()

   --get seconds since epoch
   local t = os.time()

   -- check if player exists in data,
   -- if not: add player and time data,
   if not players[pname] then
      players[pname] = {}
      players[pname].last = t
   end

   --days since last log in/number of items to give
   local d = math.floor((t - players[pname].last) / 86400)

   --give player items
   if d >= 1 then
      player:get_inventory():add_item('main', 'mikesmod:waste '..d)
   end

   --set player last log in to now
   players[pname].last = t
end)

-- write data back to file
local write_data = function()
   local f = io.open(fname, "w")
   f:write(core.serialize(players))
   io.close(f)
end

-- write data on server shutdown
minetest.register_on_shutdown(function()
    write_data()
end)

-- write data to file every five minutes
local timer = 0
minetest.register_globalstep(function(dtime)
   timer = timer + dtime;
   if timer >= 300 then
      write_data()
   end
end)

END OF BLERT'S CODE AND WASTE MOD
]]--

--[[
minetest.register_on_item_eat(
	function(hp_change, replace_with_item, itemstack, user, pointed_thing)
	itemstack:take_item()
	itemstack:add_item('mikesmod:waste')
	return itemstack
end
)

-- PLAY CODE
--[[
minetest.after(10,
	function(params)
		minetest.chat_send_all(" Welcome to the Modern City Builder Gametype.  Press I for your inventory!  Press escape to open the game menu.")
	end
)
--]]

--[[
if gametime == 6000
for _,player in ipairs(minetest.get_connected_players()) do
	local name = player:get_player_name()
	set_wielded_item(Waste)
--]]