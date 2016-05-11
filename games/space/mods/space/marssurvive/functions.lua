
-- clear player data
minetest.register_on_leaveplayer(function(player)
	marssurvive.player_sp[player:get_player_name()]=nil
end)

-- place air2 if near to it (or it will messup with corrently)
minetest.register_on_dignode(function(pos, oldnode, digger)
		if pos.y<space.y then return end
    		local np=minetest.find_node_near(pos, 1,{"space:air"})
		if np~=nil then
			minetest.set_node(pos, {name = "space:air"})
		end
end)
function marssurvive_replacenode(pos)
    	local np=minetest.find_node_near(pos, 1,{"space:air"})
	if np~=nil then
		minetest.set_node(pos, {name = "space:air"})
	else
		minetest.set_node(pos, {name = "air"})
	end
end

minetest.register_globalstep(function(dtime)
	marssurvive.breath_timer=marssurvive.breath_timer+dtime
	if marssurvive.breath_timer<2 then return end
	marssurvive.breath_timer=0
	for i, player in pairs(minetest.get_connected_players()) do
		local l=player:getpos()

		if l.y>space.y then

		local n=minetest.get_node({x=l.x,y=l.y+2,z=l.z}).name
		if marssurvive.player_sp[player:get_player_name()].sp==1 then 			--(have spacesuit)
			local a=player:get_inventory()
			if n=="space:air" and  a:get_stack("main", 1):get_name()=="marssurvive:sp" and a:get_stack("main", 1):get_wear()>0 then
				local w=a:get_stack("main", 1):get_wear()- (65534/20)
				if w<0 then w=0 end
				a:set_stack("main", 1,ItemStack({name="marssurvive:sp",wear=w}))
			elseif n~="space:air" and a:get_stack("main", 1):get_name()=="marssurvive:sp" then
				if a:get_stack("main", 1):get_name()~="" and a:get_stack("main", 1):get_wear()<65533 then
					player:set_breath(11)
					local w=a:get_stack("main", 1):get_wear()+ (65534/900)
					if w>65533 then w=65533 end
					a:set_stack("main", 1,ItemStack({name="marssurvive:sp",wear=w}))
				elseif a:get_stack("main", 1):get_name()=="marssurvive:sp" and a:get_stack("main", 1):get_wear()>=65533 then
					local have_more=0
					for i=0,32,1 do
						if a:get_stack("main", i):get_name()=="marssurvive:air_gassbotte" then
							local c=a:get_stack("main", i):get_count()-1
							a:set_stack("main", i,ItemStack({name="marssurvive:air_gassbotte",count=c}))
							a:set_stack("main", 1,ItemStack({name="marssurvive:sp",wear=0}))
							minetest.sound_play("marssurvive_pff", {pos=pos, gain = 1, max_hear_distance = 8,}) 
							have_more=1
							if c<4 and c>1 then minetest.chat_send_player(player:get_player_name(), "Warning: You have air gassbottes left: " .. c) end
							if c==0 then minetest.chat_send_player(player:get_player_name(), "Warning: You have none gassbottes!") end
							break
						end
					end
					if have_more==0 then
						marssurvive.player_sp[player:get_player_name()].sp=0
						minetest.chat_send_player(player:get_player_name(), "Warning: You are out of air!")
					end
				end
			end
		elseif marssurvive.player_sp[player:get_player_name()].sp==0 and					--(set up spacesuit)
		player:get_inventory():get_stack("main", 1):get_name()=="marssurvive:sp" and
		player:get_inventory():get_stack("main", 1):get_wear()<65533 then
			marssurvive.player_sp[player:get_player_name()].sp=1
			marssurvive.tmpuser=player
			local m=minetest.env:add_entity(player:getpos(), "marssurvive:sp1")
			m:set_attach(player, "", {x=0,y=-3,z=0}, {x=0,y=0,z=0})
			marssurvive.player_sp[player:get_player_name()].skin=player:get_properties().textures
			player:set_properties({visual = "mesh",textures = {"marssurvive_sp2.png"},visual_size = {x=1, y=1}})
		elseif n=="air" and n~="ignore" then								--(no spacesuit and in default air: lose 8 hp)
			player:set_hp(player:get_hp()-8)
		elseif n~="space:air" and n~="ignore" then						--(no spacesuit and inside something else: lose 1 hp)
			player:set_hp(player:get_hp()-1)
		elseif marssurvive.player_sp[player:get_player_name()].sp==0 and					--(set up spacesuit inair but empty)
			n=="space:air" and
			player:get_inventory():get_stack("main", 1):get_name()=="marssurvive:sp" and
			player:get_inventory():get_stack("main", 1):get_wear()>=65533 then
			marssurvive.player_sp[player:get_player_name()].sp=1
		end
		end
	end
end)