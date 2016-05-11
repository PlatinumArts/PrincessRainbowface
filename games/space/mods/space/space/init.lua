space={timer=0,player={},y=2000,y2=4000}
dofile(minetest.get_modpath("space") .. "/mapgen.lua")
space.setgrav=function(player,grav)
	player:set_physics_override({gravity=grav})
	local aa= 1 - ((1-grav)*0.4)
	player:set_physics_override({jump=aa})
end

minetest.register_globalstep(function(dtime)
	space.timer=space.timer+dtime
	if space.timer<5 then return end
	space.timer=0
	local pos
	local name
	for i, player in pairs(minetest.get_connected_players()) do
		pos=player:getpos().y
		name=player:get_player_name()
		if pos<space.y and space.player[name]~=0 then
			space.toggle(player)
		elseif pos<space.y2 and space.player[name]~=1 then
			space.toggle(player)
		elseif pos>space.y2 and space.player[name]~=2 then
			space.toggle(player)
		end
	end
end)

space.toggle=function(player)
	local name=player:get_player_name()
	local pos=player:getpos().y
	if pos<space.y then
		space.player[name]=0
		space.setgrav(player,1)
		minetest.after(0.1,function()
			player:set_sky({r=0, g=0, b=0},"regular",{})
		end)
	elseif pos<space.y2 then
		space.player[name]=1
		space.setgrav(player,0.1)
		minetest.after(0.1,function()
			player:set_sky({r=0, g=0, b=0},"skybox",{"space_sky.png","space_sky2.png","space_sky.png","space_sky.png","space_sky.png","space_sky.png"})
		end)
	elseif pos>space.y2 then
		space.player[name]=2
		space.setgrav(player,0.1)
		minetest.after(0.1,function()
			player:set_sky({r=0, g=0, b=0},"skybox",{"space_sky.png","space_sky.png","space_sky.png","space_sky.png","space_sky.png","space_sky.png"})
		end)
	end
end
minetest.register_on_respawnplayer(function(player)
	minetest.after(0.1,function()
		space.toggle(player)
	end)
end)
minetest.register_on_leaveplayer(function(player)
	local name=player:get_player_name()
	space.player[name]=nil
end)
minetest.register_on_joinplayer(function(player)
	local name=player:get_player_name()
	space.player[name]=0
	minetest.after(0.1,function()
		space.toggle(player)
	end)
end)

minetest.register_craft({
	output = "space:water",
	recipe = {
		{"default:ice"},
	}
})
