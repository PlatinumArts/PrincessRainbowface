minetest.after(1,function()
	local pos={x=0,y=space.y+500,z=0}
	local n=minetest.get_node(pos)
	if n and n.name=="ignore" then
		minetest.set_node(pos, {name = "default:stone"})
		local t=minetest.get_modpath("space").."/schematics/space_moon.mts"
		minetest.place_schematic(pos, t)
		minetest.log("Space: Moon spawned")
	end
end)