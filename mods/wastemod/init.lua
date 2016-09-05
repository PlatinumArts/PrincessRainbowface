
-- ADDED WASTE
minetest.register_craftitem("wastemod:waste", {
	description = "Waste",
	inventory_image = "wastemod_waste.png",
	--groups={waste},
})




-- A HUGE THANKS TO blert2112 FOR HIS HELP WITH THIS CODE!!!

--local harm = 2  Don't use yet, tie with being poisoned?

local timer = 0
core.register_globalstep(function(dtime)
   timer = timer + dtime;
   if timer >= 600 then
      local players = core.get_connected_players()
      for i = 1,#players do
         local name = players[i]:get_player_name()
         core.chat_send_player(name, "You don't feel so good :(")
         		
		 --[[   Remove hurt stuff for now and make it poison
         local inv = players[i]:get_inventory()
         if inv:contains_item("main", "wastemod:waste") then
            hp = players[i]:get_hp()
            players[i]:set_hp(hp - harm)
         end
         --]]
		 
         players[i]:get_inventory():add_item("main", "wastemod:waste")
      end
      timer = 0
   end
end)

--BLERT'S DON'T HAVE WASTE IN INVENTORY CODE
--[[
local harm = 2

local timer = 0
core.register_globalstep(function(dtime)
   timer = timer + dtime;
   if timer >= 10 then
      local players = core.get_connected_players()
      for i = 1,#players do
         local name = players[i]:get_player_name()
         core.chat_send_player(name, "You don't feel so good :(")
         
         local inv = players[i]:get_inventory()
         if inv:contains_item("main", "wastemod:waste") then
            hp = players[i]:get_hp()
            players[i]:set_hp(hp - harm)
         end
         
         players[i]:get_inventory():add_item("main", "wastemod:waste")
      end
      timer = 0
   end
end)
--]]


--Super Abbreviated and simplified - gives a player an item every 10 minutes
--[[
core.register_on_joinplayer(function(player)
local pname = player:get_player_name()
   
   -- Give player item every ten minutes
local num_items = 1
local timer = 0
core.register_globalstep(function(dtime)
   timer = timer + dtime;
   -- do every ten minutes (600 seconds)
   if timer >= 600 then
   --minetest.chat_send_all("You don't feel so good.")
   minetest.chat_send_player(pname, "You don't feel so good :(") --tell each individual player it instead of global chat
   player:get_inventory():add_item("main", "wastemod:waste "..num_items)
    timer = 0
   end
end)
end)
 
--]]
 
--blert2112's CODE FOR GIVING A PLAYER AN ITEM A DAY (WASTE IN THIS CASE)
--[[
-- initialize player last login time table
local players = {}

-- build path for data file
local fname = core.get_worldpath().."/dailyitems.txt"

-- function to write data back to file
local write_file = function()
   -- open file for write
   local f = io.open(fname, "w")
   -- convert player table to string
   local data_string = core.serialize(players)
   -- write data string to file
   f:write(data_string)
   -- close file
   io.close(f)
   -- set file variable to nil to avoid memory leak
   f = nil
end

-- check if file exists
local f = io.open(fname, "r")
if f then   -- file exists
   -- read file and store string
   local data_string = f:read("*all")
   -- convert string into table
   players = core.deserialize(data_string)
   io.close(f)
   f = nil
else      -- file does not exist
   write_file()
end

-- when player joins
core.register_on_joinplayer(function(player)
   -- get the player name
   local pname = player:get_player_name()

   --get seconds since epoch
   local t = os.time()

   -- check if player exists in data
   if not players[pname] then
      -- player is not in table, add player and login time to table
      players[pname] = {}
      players[pname].last = t
   end

   -- days since last log in/number of items to give
   -- (time_now - player_last_login_time) / seconds_in_a_day, rounded down
   local num_items = math.floor((t - players[pname].last) / 86400)

   -- give player items
   if num_items >= 1 then
      player:get_inventory():add_item("main", "default:cobble "..num_items)
   end

   -- change player last login time to now in table
   players[pname].last = t
end)

-- write data on server shutdown
core.register_on_shutdown(function()
    write_file()
end)

-- write data to file every five minutes
local timer = 0
core.register_globalstep(function(dtime)
   timer = timer + dtime;
   -- do every five minutes (300 seconds)
   if timer >= 300 then
      write_file()
      timer = 0
   end
end)

--]]

--[[
-- blert2112's OLD CODE FOR GIVING A PLAYER AN ITEM EVERY DAY (WASTE IN THIS CASE) Main change is this one crashes on a new world because no players folder yet 
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
      player:get_inventory():add_item('main', 'wastemod:waste '..d)
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
   if timer >= 10 then
      write_data()
   end
end)
]]--