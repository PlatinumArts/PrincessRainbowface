
local test_tree = progress_tree.new_tree()

test_tree:add("rock", {})
test_tree:add("wood", {})
test_tree:add("plant", {})
test_tree:add("axe", {"rock", "wood"})
test_tree:add("plank", {"wood"})
test_tree:add("plankaxe", {"axe", "plank"})
test_tree:add("wheat", {"plant"})

local data = progress_tree.new_player_data(test_tree, {"wood"})

local infos = {
	rock = {x=0, y=0, texture="default_stone.png", desc="Rock"},
	wood = {x=1.5, y=0, texture="default_tree.png", desc="Wood"},
	plant = {x=5, y=0, texture="default_grass.png", desc="Plant"},
	axe = {x=1, y=1.5, texture="default_tool_stoneaxe.png", desc="Axe"},
	plank = {x=2.5, y=1.5, texture="default_stick.png", desc="Plank"},
	plankaxe = {x=2, y=3, texture="default_tool_woodaxe.png", desc="Plank Axe"},
	wheat = {x=5, y=1.5, texture="farming_wheat.png", desc="Wheat"},
}


local function build_formspec()
	local formspec = "size[8,8]"
	local nodes = {}

	for k in pairs(data.learned) do
		local info = infos[k]
		local texture = info.texture .. "^progress_tree_check.png^[colorize:#00FF00:50"
		local fs = "image_button[" .. info.x .. "," .. info.y .. ";1,1;"
			.. minetest.formspec_escape(texture) .. ";" .. k .. ";]"
		local tooltip = "tooltip[" .. k .. ";" .. info.desc .. "]"
		table.insert(nodes, fs)
		table.insert(nodes, tooltip)
	end

	for k in pairs(data.available) do
		local info = infos[k]
		local fs = "image_button[" .. info.x .. "," .. info.y .. ";1,1;" .. info.texture
			.. ";" .. k .. ";]"
		local tooltip = "tooltip[" .. k .. ";" .. info.desc .. "]"
		table.insert(nodes, fs)
		table.insert(nodes, tooltip)
	end

	formspec = formspec .. table.concat(nodes)

	return formspec
end


local function show(player)
	minetest.show_formspec(player:get_player_name(), "progress_tree:test", build_formspec())
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "progress_tree:test" then return end

	for node in pairs(data.available) do
		if fields[node] then
			data:learn(node)
		end
	end

	if not fields["quit"] then
		show(player)
	end
end)


minetest.register_craftitem("progress_tree:test_book", {
	description = "Ultimate Techs",
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "default_book.png",

	on_use = function(itemstack, player)
		show(player)
	end,
})
