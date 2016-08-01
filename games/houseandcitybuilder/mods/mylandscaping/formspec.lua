form =
	'size[10,10;]'..
	'background[-0.15,-0.25;10.40,10.75;mylandscaping_background.png]'..
	'button[0,0;2.5,1;retain;Retaining Walls]'..
	'button[2.5,0;2.5,1;column;Columns]'..
	'button[5,0;2.5,1;patio;Patio Pavers]'..
	'button[7.5,0;2.5,1;deco;Deco Walls]'

input =
	'label[3,4.5;Input]'..
	'list[current_name;input;3,5;1,1;]'..
	'label[4,4.5;Dye]'..
	'list[current_name;dye;4,5;1,1;]'..
	--Output
	'label[6,4.5;Output]'..
	'list[current_name;output;6,5;1,1;]'..
	--Players Inven
	'list[current_player;main;1,6;8,4;]'

retaining_walls =
	form..
	'label[1,2.75;Freeport]'..
	'label[1,3.75;Madison]'..
	'label[1,1.75;Adaridge]'..
	--Freeport walls
	'item_image_button[3,2.5;1,1;mylandscaping:fwall_left_cement;fwall1; ]'..
	'item_image_button[4,2.5;1,1;mylandscaping:fwall_middle_cement;fwall2; ]'..
	'item_image_button[5,2.5;1,1;mylandscaping:fwall_right_cement;fwall3; ]'..
	'item_image_button[6,2.5;1,1;mylandscaping:fwall_corner_cement;fwall4; ]'..
	--Madison walls
	'item_image_button[3,3.5;1,1;mylandscaping:mwall_middle_cement;mwall1; ]'..
	'item_image_button[4,3.5;1,1;mylandscaping:mwall_icorner_cement;mwall2; ]'..
	'item_image_button[5,3.5;1,1;mylandscaping:mwall_ocorner_cement;mwall3; ]'..
	--Adaridge walls
	'item_image_button[3,1.5;1,1;mylandscaping:awall_left_cement;awall1; ]'..
	'item_image_button[4,1.5;1,1;mylandscaping:awall_middle_cement;awall2; ]'..
	'item_image_button[5,1.5;1,1;mylandscaping:awall_right_cement;awall3; ]'..
	'item_image_button[6,1.5;1,1;mylandscaping:awall_icorner_cement;awall4; ]'..
	'item_image_button[7,1.5;1,1;mylandscaping:awall_ocorner_cement;awall5; ]'..
	input

columns = --Although all the columns are in the wall files they get their own menu.
	form..
	'label[.75,1;Columns are compatible with all walls.]'..
	'label[.75,2.75;Freeport]'..
	'label[.75,3.75;Madison]'..
	'label[.75,1.75;Adaridge]'..
	'item_image_button[2,2.5;1,1;mylandscaping:fwall_column_m_t_cement;fcolumn1; ]'..
	'item_image_button[3,2.5;1,1;mylandscaping:fwall_column_ic_t_cement;fcolumn2; ]'..
	'item_image_button[4,2.5;1,1;mylandscaping:fwall_column_oc_t_cement;fcolumn3; ]'..
	'item_image_button[2,1.5;1,1;mylandscaping:awall_column_m_t_cement;acolumn1; ]'..
	'item_image_button[3,1.5;1,1;mylandscaping:awall_column_ic_t_cement;acolumn2; ]'..
	'item_image_button[4,1.5;1,1;mylandscaping:awall_column_oc_t_cement;acolumn3; ]'..
	'label[6.5,1;Column toppers]'..
	'item_image_button[6,1.5;1,1;mylandscaping:column_t_sphere_cement;column_sphere; ]'..
	'item_image_button[7,1.5;1,1;mylandscaping:column_t_dragon_cement;column_dragon; ]'..
	'item_image_button[8,1.5;1,1;mylandscaping:column_t_suzanne_cement;column_suzanne; ]'..
	'item_image_button[9,1.5;1,1;mylandscaping:column_t_cross_cement;column_cross; ]'..
	input

patio_pavers =
	form..
	'label[1,1.5;Place pavers on top of sand]'..
	'label[1,2;to achieve best fit, and to be]'..
	'label[1,2.5;able to place patio decorations.]'..
	'item_image_button[5.5,1.5;1,1;mylandscaping:stone_squarecement;patio1; ]'..
	'item_image_button[6.5,1.5;1,1;mylandscaping:stone_square_smcement;patio2; ]'..
	'item_image_button[7.5,1.5;1,1;mylandscaping:stone_square_xsmcement;patio7; ]'..
	'item_image_button[8.5,1.5;1,1;mylandscaping:stone_paverscement;patio3; ]'..
	'item_image_button[6,2.5;1,1;mylandscaping:stone_ashlarcement;patio4; ]'..
	'item_image_button[7,2.5;1,1;mylandscaping:stone_flagstonecement;patio5; ]'..
	'item_image_button[8,2.5;1,1;mylandscaping:stone_pinwheelcement;patio6; ]'..
	input

deco_walls =
	form..
	'image_button[2,1.5;1,1;mylandscaping_deco_scallop.png;deco1;]'..
	'tooltip[deco1;Scalloped decorative wall]'..
	'image_button[3,1.5;1,1;mylandscaping_deco_flat.png;deco2;]'..
	'tooltip[deco2;Flat decorative wall]'..
	'image_button[4,1.5;1,1;mylandscaping_deco_peak.png;deco3;]'..
	'tooltip[deco3;Peaked decorative wall]'..
	'image_button[5,1.5;1,1;mylandscaping_deco_random.png;deco4;]'..
	'tooltip[deco4;Random decorative wall]'..
	'image_button[6,1.5;1,1;mylandscaping_deco_column.png;deco5;]'..
	'tooltip[deco5;Decorative column]'..
	input
