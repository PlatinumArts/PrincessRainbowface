
minetest.register_node("more_stuff:question_block", {
	description = "SMB Question Block",
	tiles = {
		{name="smb_question_block_top_animated.bmp", "smb_question_block_animated.bmp", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=1,5}},
		},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"size[15,15]"..
				"list[current_name;main;0,4;9,5;]"..
				"list[current_player;main;0,10;8,4;]")
		meta:set_string("infotext", "SMB Question Block")
		local inv = meta:get_inventory()
		inv:set_size("main", 1*1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,
})




local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("more_stuff:nyan_dog"{
        description = "Nyan Dog",
        tile_images = {"nyan_dog_side.png","nyan_dog_top.png", "nyan_dog_face"},
        groups = {"oddly_breakable_by_hand=3"},
        paramtype2 = "facedir",
})

minetest.register_craft({
        output = ' "more_stuff:nyan_dog" 12'
        recipe = {
        {"rainbowmod:rainbow_block", "rainbowmod:rainbow_block"},
        }
})
