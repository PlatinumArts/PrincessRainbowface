 
advtrains.hud = {}

minetest.register_on_leaveplayer(function(player)
advtrains.hud[player:get_player_name()] = nil
end)

function advtrains.set_trainhud(name, text)
	local hud = advtrains.hud[name]
	local player=minetest.get_player_by_name(name)
	if not hud then
		hud = {}
		advtrains.hud[name] = hud
		hud.id = player:hud_add({
			hud_elem_type = "text",
			name = "ADVTRAINS",
			number = 0xFFFFFF,
			position = {x=0.5, y=0.7},
			offset = {x=0, y=0},
			text = text,
			scale = {x=200, y=60},
			alignment = {x=0, y=0},
		})
		hud.oldText=text
		return
	elseif hud.oldText ~= text then
		player:hud_change(hud.id, "text", text)
		hud.oldText=text
	end
end
function advtrains.hud_train_format(train, flip)
	local fct=1
	if flip then fct=-1 end
	if not train then return "" end
	local max=advtrains.all_traintypes[train.traintype].max_speed or 10
	local vel=advtrains.abs_ceil(train.velocity)*fct
	local tvel=advtrains.abs_ceil(train.tarvelocity)*fct
	local firstLine, secondLine
	if vel<0 then
		firstLine="Speed: <"..string.rep("_", vel+max)..string.rep("+", -vel).."|"..string.rep("_", max)..">"
	else
		firstLine="Speed: <"..string.rep("_", max).."|"..string.rep("+", vel)..string.rep("_", max-vel)..">"
	end
	if tvel<0 then
		secondLine="Target: <"..string.rep("_", tvel+max)..string.rep("+", -tvel).."|"..string.rep("_", max)..">"
	else
		secondLine="Target: <"..string.rep("_", max).."|"..string.rep("+", tvel)..string.rep("_", max-tvel)..">"
	end
	if vel==0 then
		return firstLine.."\n"..secondLine.."\nup for forward, down for backward, use to get off train.  "
	elseif vel<0 then
		return firstLine.."\n"..secondLine.."\nPress up to decelerate, down to accelerate, sneak to stop."
	elseif vel>0 then
		return firstLine.."\n"..secondLine.."\nPress up to accelerate, down to decelerate, sneak to stop."
	end
end