local material = {}
local block = {}
local make_ok = false
local anzahl = 0
local material2 = {}
local stone = {}
local deco = {}


local color_tab = {
{"black", 	"Black",		"dye:black"},
{"blue", 	"Blue",			"dye:blue"},
{"brown", 	"Brown",		"dye:brown"},
{"cyan", 	"Cyan",			"dye:cyan"},
{"dark_green", 	"Dark Green",		"dye:dark_green"},
{"dark_grey", 	"Dark Grey",		"dye:dark_grey"},
{"green", 	"Green",		"dye:green"},
{"grey", 	"Grey",			"dye:grey"},
{"magenta", 	"Magenta",		"dye:magenta"},
{"orange",	"Orange",		"dye:orange"},
{"pink", 	"Pink",			"dye:pink"},
{"red", 	"Red",			"dye:red"},
{"violet", 	"Violet",		"dye:violet"},
{"white", 	"White",		"dye:white"},
{"yellow", 	"Yellow",		"dye:yellow"},
{"cement", 	"",		""},
}

minetest.register_node('mylandscaping:machine', {
	description = 'concrete forms',
	drawtype = 'mesh',
	mesh = 'mylandscaping_cement_mixer.obj',
	tiles = {
		{name='mylandscaping_tex3.png'},{name='mylandscaping_tex1.png'},{name='default_gravel.png'},{name='mylandscaping_tex2.png'}},
	groups = {oddly_breakable_by_hand=2},
	paramtype = 'light',
	paramtype2 = 'facedir',
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 1.1, 0.5, 0.5},
			{1.1, -0.5, -0.1, 1.5, -0.3, 0.5}
		}
	},
	collision_box = {
		type = 'fixed',
		fixed = {
			{-0.5, -0.5, -0.5, 1.1, 0.5, 0.5},
			{1.1, -0.5, -0.1, 1.5, -0.3, 0.5}
		}
	},

can_dig = function(pos,player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	if player:get_player_name() == meta:get_string("owner") and
	   inv:is_empty("input") and
	   inv:is_empty("input") and
	   inv:is_empty("output") then
		return true
	else
	return false
	end


end,

after_place_node = function(pos, placer, itemstack)
	local meta = minetest.get_meta(pos)
	meta:set_string("owner",placer:get_player_name())
	meta:set_string("infotext","Concrete Mixer (owned by "..placer:get_player_name()..")")
	end,

on_construct = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", retaining_walls)
	meta:set_string("infotext", "Concrete Mixer")
	local inv = meta:get_inventory()
	inv:set_size("input", 1)
	inv:set_size("output", 1)
	inv:set_size("dye", 1)
end,

on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if fields['retain'] then
		meta:set_string('formspec', retaining_walls)
		end
	if fields['patio'] then
		meta:set_string('formspec', patio_pavers)
		end
	if fields['deco'] then
		meta:set_string('formspec', deco_walls)
		end
	if fields['column'] then
		meta:set_string('formspec', columns)
		end

for i in ipairs (color_tab) do
local col = color_tab[i][1]
local coldesc = color_tab[i][2]
local dyecol = color_tab[i][3]

if fields["awall1"]
or fields["awall2"]
or fields["awall3"]
or fields["awall4"]
or fields["awall5"]
then

	if fields["awall1"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:awall_left_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["awall2"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:awall_middle_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["awall3"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:awall_right_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["awall4"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:awall_icorner_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["awall5"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:awall_ocorner_"
		if inv:is_empty("input") then
			return
		end
	end
		local instack = inv:get_stack("input", 1)
		local outstack = inv:get_stack("output", 1)
		local dyestack = inv:get_stack("dye", 1)
---------------------------------------------------------------------

	if instack:get_name()== "mylandscaping:concrete_bag" and
	   dyestack:get_name()== dyecol then
				material = col
				make_ok = true
	end
	 if instack:get_name()== "myconcrete:concrete" and
	   dyestack:get_name()== dyecol then
				material = col
				make_ok = true
	end
---------------------------------------------------------------------
		if make_ok == true then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("output",block..col)
			end
			instack:take_item()
			inv:set_stack("input",1,instack)
			if dyestack:get_name() == "dye:"..col then
			dyestack:take_item()
			inv:set_stack("dye",1,dyestack)
			end
		end
end
---------------------------------------------------------------------
if fields["fwall1"]
or fields["fwall2"]
or fields["fwall3"]
or fields["fwall4"]
then

	if fields["fwall1"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:fwall_left_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["fwall2"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:fwall_middle_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["fwall3"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:fwall_right_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["fwall4"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:fwall_corner_"
		if inv:is_empty("input") then
			return
		end
	end
		local instack = inv:get_stack("input", 1)
		local outstack = inv:get_stack("output", 1)
		local dyestack = inv:get_stack("dye", 1)
---------------------------------------------------------------------

	if instack:get_name()== "mylandscaping:concrete_bag" and
	   dyestack:get_name()== dyecol then
				material = col
				make_ok = true
	end
	 if instack:get_name()== "myconcrete:concrete" and
	   dyestack:get_name()== dyecol then
				material = col
				make_ok = true
	end
---------------------------------------------------------------------
		if make_ok == true then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("output",block..col)
			end
			instack:take_item()
			inv:set_stack("input",1,instack)
			if dyestack:get_name() == "dye:"..col then
			dyestack:take_item()
			inv:set_stack("dye",1,dyestack)
			end
		end
end
---------------------------------------------------------------------
if fields["mwall1"]
or fields["mwall2"]
or fields["mwall3"]
then

	if fields["mwall1"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:mwall_middle_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["mwall2"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:mwall_icorner_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["mwall3"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:mwall_ocorner_"
		if inv:is_empty("input") then
			return
		end
	end
		local instack = inv:get_stack("input", 1)
		local outstack = inv:get_stack("output", 1)
		local dyestack = inv:get_stack("dye", 1)
---------------------------------------------------------------------

	if instack:get_name()== "mylandscaping:concrete_bag" and
	   dyestack:get_name()== dyecol then
				material = col
				make_ok = true
	end
	 if instack:get_name()== "myconcrete:concrete" and
	   dyestack:get_name()== dyecol then
				material = col
				make_ok = true
	end
---------------------------------------------------------------------
		if make_ok == true then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("output",block..col)
			end
			instack:take_item()
			inv:set_stack("input",1,instack)
			if dyestack:get_name() == "dye:"..col then
			dyestack:take_item()
			inv:set_stack("dye",1,dyestack)
			end
		end
end
---------------------------------------------------------------------
--all columns here, possible decorative caps too.
if fields['acolumn1']
or fields['acolumn2']
or fields['acolumn3']
or fields['fcolumn1']
or fields['fcolumn2']
or fields['fcolumn3']
or fields['mcolumn1']
or fields['mcolumn2']
or fields['mcolumn3']
or fields['column_sphere']
or fields['column_dragon']
or fields['column_suzanne']
or fields['column_cross']
then
	if fields["acolumn1"] then
		make_ok = false
		anzahl = 1
		block = "mylandscaping:awall_column_m_t_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["acolumn2"] then
		make_ok = false
		anzahl = 1
		block = "mylandscaping:awall_column_ic_t_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["acolumn3"] then
		make_ok = false
		anzahl = 1
		block = "mylandscaping:awall_column_oc_t_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["fcolumn1"] then
		make_ok = false
		anzahl = 1
		block = "mylandscaping:fwall_column_m_t_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["fcolumn2"] then
		make_ok = false
		anzahl = 1
		block = "mylandscaping:fwall_column_ic_t_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["fcolumn3"] then
		make_ok = false
		anzahl = 1
		block = "mylandscaping:fwall_column_oc_t_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["column_sphere"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:column_t_sphere_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["column_dragon"] then
		make_ok = false
		anzahl = 1
		block = "mylandscaping:column_t_dragon_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["column_suzanne"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:column_t_suzanne_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["column_cross"] then
		make_ok = false
		anzahl = 2
		block = "mylandscaping:column_t_cross_"
		if inv:is_empty("input") then
			return
		end
	end
		local instack = inv:get_stack("input", 1)
		local outstack = inv:get_stack("output", 1)
		local dyestack = inv:get_stack("dye", 1)
---------------------------------------------------------------------

	if instack:get_name()== "mylandscaping:concrete_bag" and
	   dyestack:get_name()== dyecol then
				material = col
				make_ok = true
	end
	 if instack:get_name()== "myconcrete:concrete" and
	   dyestack:get_name()== dyecol then
				material = col
				make_ok = true
	end
		if make_ok == true then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("output",block..col)
			end
			instack:take_item()
			inv:set_stack("input",1,instack)
			if dyestack:get_name() == "dye:"..col then
			dyestack:take_item()
			inv:set_stack("dye",1,dyestack)
			end
		end
end

if fields["patio1"]
or fields["patio2"]
or fields["patio3"]
or fields["patio4"]
or fields["patio5"]
or fields["patio6"]
or fields["patio7"]
then

	if fields["patio1"] then
		make_ok = false
		anzahl = 3
		stone = "mylandscaping:stone_square"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["patio2"] then
		make_ok = false
		anzahl = 3
		stone = "mylandscaping:stone_square_sm"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["patio7"] then
		make_ok = false
		anzahl = 3
		stone = "mylandscaping:stone_square_xsm"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["patio3"] then
		make_ok = false
		anzahl = 3
		stone = "mylandscaping:stone_pavers"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["patio4"] then
		make_ok = false
		anzahl = 3
		stone = "mylandscaping:stone_ashlar"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["patio5"] then
		make_ok = false
		anzahl = 3
		stone = "mylandscaping:stone_flagstone"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["patio6"] then
		make_ok = false
		anzahl = 3
		stone = "mylandscaping:stone_pinwheel"
		if inv:is_empty("input") then
			return
		end
	end
		local instack = inv:get_stack("input", 1)
		local outstack = inv:get_stack("output", 1)
		local dyestack = inv:get_stack("dye", 1)

	if instack:get_name()== "mylandscaping:concrete_bag" and
	   dyestack:get_name()== dyecol then
				make_ok = true

	end
	if instack:get_name()== "myconcrete:concrete" and
	   dyestack:get_name()== dyecol then
				make_ok = true

	end
---------------------------------------------------------------------
		if make_ok == true then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("output",stone..col)
			end
			dyestack:take_item()
			inv:set_stack("dye",1,dyestack)
			instack:take_item()
			inv:set_stack("input",1,instack)
		end
end
---------------------------------------------------------------------
if fields["deco1"]
or fields["deco2"]
or fields["deco3"]
or fields['deco4']
or fields['deco5']
then

	if fields["deco1"] then
		make_ok = false
		anzahl = 4
		deco = "mylandscaping:deco_wall_s_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["deco2"] then
		make_ok = false
		anzahl = 4
		deco = "mylandscaping:deco_wall_f_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["deco3"] then
		make_ok = false
		anzahl = 4
		deco = "mylandscaping:deco_wall_p_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["deco4"] then
		make_ok = false
		anzahl = 4
		deco = "mylandscaping:deco_wall_r_"
		if inv:is_empty("input") then
			return
		end
	end
	if fields["deco5"] then
		make_ok = false
		anzahl = 4
		deco = "mylandscaping:deco_column_"
		if inv:is_empty("input") then
			return
		end
	end

		local instack = inv:get_stack("input", 1)
		local outstack = inv:get_stack("output", 1)
		local dyestack = inv:get_stack("dye", 1)

	if instack:get_name()== "mylandscaping:concrete_bag" and
	   dyestack:get_name()== dyecol then
				make_ok = true

	end
	if instack:get_name()== "myconcrete:concrete" and
	   dyestack:get_name()== dyecol then
				make_ok = true
	end
---------------------------------------------------------------------
	if make_ok == true then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("output",deco..col)
			end
			dyestack:take_item()
			inv:set_stack("dye",1,dyestack)
			instack:take_item()
			inv:set_stack("input",1,instack)
		end
end
end
end
})
