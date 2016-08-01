--advtrains by orwell96, see readme.txt
local print=function(t) minetest.log("action", t) minetest.chat_send_all(t) end

function advtrains.dirCoordSet(coord, dir)
	local x=0
	local z=0
	--local dir=(dirx+2)%8
	if(dir==6) then
		x=-1
	elseif (dir==7) then
		x=-1
		z=1
	elseif (dir==0) then
		z=1
	elseif (dir==1) then
		z=1
		x=1
	elseif (dir==2) then
		x=1
	elseif (dir==3) then
		x=1
		z=-1
	elseif (dir==4) then
		z=-1
	elseif (dir==5) then
		z=-1
		x=-1
	else
		error("advtrains: in helpers.lua/dirCoordSet() given dir="..(dir or "nil"))
	end


	return {x=coord.x+x, y=coord.y, z=coord.z+z}
end
function advtrains.dirToCoord(dir)
	return advtrains.dirCoordSet({x=0, y=0, z=0}, dir)
end

function advtrains.maxN(list, expectstart)
	local n=expectstart or 0
	while list[n] do
		n=n+1
	end
	return n-1
end

function advtrains.minN(list, expectstart)
	local n=expectstart or 0
	while list[n] do
		n=n-1
	end
	return n+1
end

--vertical_transmit:
--[[
rely1, rely2 tell to which height the connections are pointed to. 1 means it will go up the next node

]]

function advtrains.conway(midreal, prev, traintype)--in order prev,mid,return
	local mid=advtrains.round_vector_floor_y(midreal)
	local drives_on=advtrains.all_traintypes[traintype].drives_on
	
	if not advtrains.get_rail_info_at(advtrains.round_vector_floor_y(prev), traintype) then
		return nil
	end
	
	local midnode_ok, middir1, middir2, midrely1, midrely2=advtrains.get_rail_info_at(advtrains.round_vector_floor_y(mid), traintype)
	if not midnode_ok then
		return nil 
	end
	
	local next, chkdir, chkrely, y_offset
	y_offset=0
	--print("[advtrains] in order mid1,mid2",middir1,middir2)
	--try if it is dir1
	local cor1=advtrains.dirCoordSet(mid, middir2)--<<<<
	if math.floor(cor1.x+0.5)==math.floor(prev.x+0.5) and math.floor(cor1.z+0.5)==math.floor(prev.z+0.5) then--this was previous
		next=advtrains.dirCoordSet(mid, middir1)
		if midrely1>=1 then
			next.y=next.y+1
			--print("[advtrains]found midrely1 to be >=1: next is now "..(next and minetest.pos_to_string(next) or "nil"))
			y_offset=1
		end
		chkdir=middir1
		chkrely=midrely1
		--print("[advtrains]dir2 applied next pos:",minetest.pos_to_string(next),"(chkdir is ",chkdir,")")
	end
	--dir2???
	local cor2=advtrains.dirCoordSet(mid, middir1)--<<<<
	if math.floor(cor2.x+0.5)==math.floor(prev.x+0.5) and math.floor(cor2.z+0.5)==math.floor(prev.z+0.5) then
		next=advtrains.dirCoordSet(mid, middir2)--dir2 wird �berpr�ft, alles gut.
		if midrely2>=1 then
			next.y=next.y+1
			--print("[advtrains]found midrely2 to be >=1: next is now "..(next and minetest.pos_to_string(next) or "nil"))
			y_offset=1
		end
		chkdir=middir2
		chkrely=midrely2
		--print("[advtrains] dir2 applied next pos:",minetest.pos_to_string(next),"(chkdir is ",chkdir,")")
	end
	--print("[advtrains]dir applied next pos: "..(next and minetest.pos_to_string(next) or "nil").."(chkdir is "..(chkdir or "nil")..", y-offset "..y_offset..")")
	--is there a next
	if not next then
		--print("[advtrains]in conway: no next rail(nil), returning!")
		return nil
	end
	
	local nextnode_ok, nextdir1, nextdir2, nextrely1, nextrely2, nextrailheight=advtrains.get_rail_info_at(advtrains.round_vector_floor_y(next), traintype)
	
	--is it a rail?
	if(not nextnode_ok) then
		--print("[advtrains]in conway: next "..minetest.pos_to_string(next).." not a rail, trying one node below!")
		next.y=next.y-1
		y_offset=y_offset-1
		
		nextnode_ok, nextdir1, nextdir2, nextrely1, nextrely2, nextrailheight=advtrains.get_rail_info_at(advtrains.round_vector_floor_y(next), traintype)
		if(not nextnode_ok) then
			--print("[advtrains]in conway: one below "..minetest.pos_to_string(next).." is not a rail either, returning!")
			return nil
		end
	end
	
	--is this next rail connecting to the mid?
	if not ( (((nextdir1+4)%8)==chkdir and nextrely1==chkrely-y_offset) or (((nextdir2+4)%8)==chkdir and nextrely2==chkrely-y_offset) ) then
		--print("[advtrains]in conway: next "..minetest.pos_to_string(next).." not connecting, trying one node below!")
		next.y=next.y-1
		y_offset=y_offset-1
		
		nextnode_ok, nextdir1, nextdir2, nextrely1, nextrely2, nextrailheight=advtrains.get_rail_info_at(advtrains.round_vector_floor_y(next), traintype)
		if(not nextnode_ok) then
			--print("[advtrains]in conway: (at connecting if check again) one below "..minetest.pos_to_string(next).." is not a rail either, returning!")
			return nil
		end
		if not ( (((nextdir1+4)%8)==chkdir and nextrely1==chkrely) or (((nextdir2+4)%8)==chkdir and nextrely2==chkrely) ) then
			--print("[advtrains]in conway: one below "..minetest.pos_to_string(next).." rail not connecting, returning!")
			--print("[advtrains] in order mid1,2,next1,2,chkdir "..middir1.." "..middir2.." "..nextdir1.." "..nextdir2.." "..chkdir)
			return nil
		end
	end
	
	--print("[advtrains]conway found rail.")
	return vector.add(advtrains.round_vector_floor_y(next), {x=0, y=nextrailheight, z=0}), chkdir
end

function advtrains.round_vector_floor_y(vec)
	return {x=math.floor(vec.x+0.5), y=math.floor(vec.y), z=math.floor(vec.z+0.5)}
end

function advtrains.yawToDirection(yaw, conn1, conn2)
	if not conn1 or not conn2 then
		error("given nil to yawToDirection: conn1="..(conn1 or "nil").." conn2="..(conn1 or "nil"))
	end
	local yaw1=math.pi*(conn1/4)
	local yaw2=math.pi*(conn2/4)
	if advtrains.minAngleDiffRad(yaw, yaw1)<advtrains.minAngleDiffRad(yaw, yaw2) then--change to > if weird behavior
		return conn2
	else
		return conn1
	end
end

function advtrains.minAngleDiffRad(r1, r2)
	local try1=r2-r1
	local try2=(r2+2*math.pi)-r1
	local try3=r2-(r1+2*math.pi)
	if math.min(math.abs(try1), math.abs(try2), math.abs(try3))==math.abs(try1) then
		return try1
	end
	if math.min(math.abs(try1), math.abs(try2), math.abs(try3))==math.abs(try2) then
		return try2
	end
	if math.min(math.abs(try1), math.abs(try2), math.abs(try3))==math.abs(try3) then
		return try3
	end
end
function advtrains.dumppath(path)
	if not path then print("dumppath: no path(nil)") return end
	local min=advtrains.minN(path)
	local max=advtrains.maxN(path)
	for i=min, max do print("["..i.."] "..(path[i] and minetest.pos_to_string(path[i]) or "nil")) end
end

function advtrains.merge_tables(a, ...)
	local new={}
	for _,t in ipairs({a,...}) do
		for k,v in pairs(t) do new[k]=v end
	end
	return new
end
function advtrains.yaw_from_3_positions(prev, curr, next)
	local pts=minetest.pos_to_string
	--print("p3 "..pts(prev)..pts(curr)..pts(next))
	local prev2curr=math.atan2((curr.x-prev.x), (prev.z-curr.z))
	local curr2next=math.atan2((next.x-curr.x), (curr.z-next.z))
	--print("y3 "..(prev2curr*360/(2*math.pi)).." "..(curr2next*360/(2*math.pi)))
	return prev2curr+(advtrains.minAngleDiffRad(prev2curr, curr2next)/2)
end
function advtrains.get_wagon_yaw(front, first, second, back, pct)
	local pts=minetest.pos_to_string
	--print("p "..pts(front)..pts(first)..pts(second)..pts(back))
	local y2=advtrains.yaw_from_3_positions(second, first, front)
	local y1=advtrains.yaw_from_3_positions(back, second, first)
	--print("y "..(y1*360/(2*math.pi)).." "..(y2*360/(2*math.pi)))
	return y1+advtrains.minAngleDiffRad(y1, y2)*pct
end
function advtrains.get_real_index_position(path, index)
	if not path or not index then return end
	
	local first_pos=path[math.floor(index)]
	local second_pos=path[math.floor(index)+1]
	
	if not first_pos or not second_pos then return nil end
	
	local factor=index-math.floor(index)
	local actual_pos={x=first_pos.x-(first_pos.x-second_pos.x)*factor, y=first_pos.y-(first_pos.y-second_pos.y)*factor, z=first_pos.z-(first_pos.z-second_pos.z)*factor,}
	return actual_pos
end
function advtrains.pos_median(pos1, pos2)
	return {x=pos1.x-(pos1.x-pos2.x)*0.5, y=pos1.y-(pos1.y-pos2.y)*0.5, z=pos1.z-(pos1.z-pos2.z)*0.5}
end
function advtrains.abs_ceil(i)
	return math.ceil(math.abs(i))*math.sign(i)
end