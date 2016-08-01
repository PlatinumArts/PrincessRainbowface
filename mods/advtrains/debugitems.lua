
minetest.register_tool("advtrains:1",
	{
		description = "1",
		groups = {cracky=1}, -- key=name, value=rating; rating=1..3.
		inventory_image = "drwho_screwdriver.png",
		wield_image = "drwho_screwdriver.png",
		stack_max = 1,
		range = 7.0,
	on_use = function(itemstack, user, pointed_thing)
	pos1=pointed_thing.under
end,
})
minetest.register_tool("advtrains:2",
	{
		description = "2",
		groups = {cracky=1}, -- key=name, value=rating; rating=1..3.
		inventory_image = "drwho_screwdriver.png",
		wield_image = "drwho_screwdriver.png",
		stack_max = 1,
		range = 7.0,
		on_use = function(itemstack, user, pointed_thing)
		pos2=pointed_thing.under
	end,
})
minetest.register_tool("advtrains:3",
	{
		description = "3",
		groups = {cracky=1}, -- key=name, value=rating; rating=1..3.
		inventory_image = "drwho_screwdriver.png",
		wield_image = "drwho_screwdriver.png",
		stack_max = 1,
		range = 7.0,
		on_use = function(itemstack, user, pointed_thing)
		pos3=pointed_thing.under
	end,
})
minetest.register_tool("advtrains:4",
	{
		description = "4",
		groups = {cracky=1}, -- key=name, value=rating; rating=1..3.
		inventory_image = "drwho_screwdriver.png",
		wield_image = "drwho_screwdriver.png",
		stack_max = 1,
		range = 7.0,
		on_use = function(itemstack, user, pointed_thing)
		pos4=pointed_thing.under
	end,
})
core.register_chatcommand("mad", {
	params="",
	description="",
	privs={},
	func = function(name, param)
	return true, advtrains.get_wagon_yaw(pos1, pos2, pos3, pos4, tonumber(param))*360/(2*math.pi)
end,
})

advtrains.firstobject=nil
minetest.register_tool("advtrains:connect",
{
	description = "connect wagons tool",
	groups = {cracky=1}, -- key=name, value=rating; rating=1..3.
	inventory_image = "drwho_screwdriver.png",
	wield_image = "drwho_screwdriver.png",
	stack_max = 1,
	range = 7.0,
		
	on_place = function(itemstack, placer, pointed_thing)
	
	end,
	--[[
	^ Shall place item and return the leftover itemstack
	^ default: minetest.item_place ]]
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type=="object" then
			local luaent=pointed_thing.ref:get_luaentity()
			if luaent and luaent.is_wagon then
				if advtrains.firstobject then
					minetest.chat_send_all("connect second object "..luaent.unique_id)
					advtrains.connect_wagons(luaent, advtrains.firstobject)
					minetest.chat_send_all("done")
					advtrains.firstobject=nil
				else
					advtrains.firstobject=luaent
					minetest.chat_send_all("connect first object "..luaent.unique_id)
				end
			end
		end
	end,
--[[
^  default: nil
^ Function must return either nil if no item shall be removed from
inventory, or an itemstack to replace the original itemstack.
e.g. itemstack:take_item(); return itemstack
^ Otherwise, the function is free to do what it wants.
^ The default functions handle regular use cases.
]]
})
minetest.register_tool("advtrains:tunnelborer",
{
	description = "tunnelborer",
	groups = {cracky=1}, -- key=name, value=rating; rating=1..3.
	inventory_image = "drwho_screwdriver.png",
	wield_image = "drwho_screwdriver.png",
	stack_max = 1,
	range = 7.0,
		
	on_place = function(itemstack, placer, pointed_thing)
	
	end,
	--[[
	^ Shall place item and return the leftover itemstack
	^ default: minetest.item_place ]]
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type=="node" then
			for x=-1,1 do
				for y=-1,1 do
					for z=-1,1 do
						minetest.remove_node(vector.add(pointed_thing.under, {x=x, y=y, z=z}))
					end
				end
			end
		end
	end,
--[[
^  default: nil
^ Function must return either nil if no item shall be removed from
inventory, or an itemstack to replace the original itemstack.
e.g. itemstack:take_item(); return itemstack
^ Otherwise, the function is free to do what it wants.
^ The default functions handle regular use cases.
]]
}
) 
