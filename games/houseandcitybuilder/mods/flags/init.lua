-- flags by bas080 -- revised by TumeniNodes on June 7 2016 Ver 1.2

--nodes and crafts

local hue = "white"
local hue2 = "White"

minetest.register_craft( {
  output = "flags:black 16",
  recipe = {
    {"wool:black", "wool:black", "wool:black"},
    {"wool:black", "wool:black", "wool:black"},
  },
})

minetest.register_craft( {
  output = "flags:blue 16",
  recipe = {
    {"wool:blue", "wool:blue", "wool:blue"},
    {"wool:blue", "wool:blue", "wool:blue"},
  },
})

minetest.register_craft( {
  output = "flags:brown 16",
  recipe = {
    {"wool:brown", "wool:brown", "wool:brown"},
    {"wool:brown", "wool:brown", "wool:brown"},
  },
})

minetest.register_craft( {
  output = "flags:cyan 16",
  recipe = {
    {"wool:cyan", "wool:cyan", "wool:cyan"},
    {"wool:cyan", "wool:cyan", "wool:cyan"},
  },
})

minetest.register_craft( {
  output = "flags:dark_green 16",
  recipe = {
    {"wool:dark_green", "wool:dark_green", "wool:dark_green"},
    {"wool:dark_green", "wool:dark_green", "wool:dark_green"},
  },
})

minetest.register_craft( {
  output = "flags:dark_grey 16",
  recipe = {
    {"wool:dark_grey", "wool:dark_grey", "wool:dark_grey"},
    {"wool:dark_grey", "wool:dark_grey", "wool:dark_grey"},
  },
})

minetest.register_craft( {
  output = "flags:green 16",
  recipe = {
    {"wool:green", "wool:green", "wool:green"},
    {"wool:green", "wool:green", "wool:green"},
  },
})

minetest.register_craft( {
  output = "flags:grey 16",
  recipe = {
    {"wool:grey", "wool:grey", "wool:grey"},
    {"wool:grey", "wool:grey", "wool:grey"},
  },
})

minetest.register_craft( {
  output = "flags:magenta 16",
  recipe = {
    {"wool:magenta", "wool:magenta", "wool:magenta"},
    {"wool:magenta", "wool:magenta", "wool:magenta"},
  },
})

minetest.register_craft( {
  output = "flags:orange 16",
  recipe = {
    {"wool:orange", "wool:orange", "wool:orange"},
    {"wool:orange", "wool:orange", "wool:orange"},
  },
})

minetest.register_craft( {
  output = "flags:pink 16",
  recipe = {
    {"wool:pink", "wool:pink", "wool:pink"},
    {"wool:pink", "wool:pink", "wool:pink"},
  },
})

minetest.register_craft( {
  output = "flags:red 16",
  recipe = {
    {"wool:red", "wool:red", "wool:red"},
    {"wool:red", "wool:red", "wool:red"},
  },
})

minetest.register_craft( {
  output = "flags:violet 16",
  recipe = {
    {"wool:violet", "wool:violet", "wool:violet"},
    {"wool:violet", "wool:violet", "wool:violet"},
  },
})

minetest.register_craft( {
  output = "flags:white 16",
  recipe = {
    {"wool:white", "wool:white", "wool:white"},
    {"wool:white", "wool:white", "wool:white"},
  },
})

minetest.register_craft( {
  output = "flags:yellow 16",
  recipe = {
    {"wool:yellow", "wool:yellow", "wool:yellow"},
    {"wool:yellow", "wool:yellow", "wool:yellow"},
  },
})

minetest.register_node("flags:flagpost", {
	description = "Flag Post",
	drawtype = "nodebox",
	tiles = {"flags_brass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, -0.4375, 0.5, 0.0625},
		}
	}
})

minetest.register_node("flags:flagposttop", {
	description = "Flag Post Top",
	drawtype = "nodebox",
	tiles = {"flags_brass.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, -0.4375, 0.5, 0.0625},
			{-0.5625, 0.5, -0.0625, -0.375, 0.625, 0.125},
		}
	}
})

minetest.register_node("flags:"..hue, {
  description = hue2 .. " flag",
  drawtype = "torchlike",
  inventory_image = "flags_item_"..hue..".png",
  wield_image = "flags_item_"..hue..".png",
  tiles = {
    {name="flags_"..hue..".png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
    {name="flags_"..hue..".png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
    {name="flags_"..hue..".png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}}
  },
  paramtype = "light",
  paramtype2 = "wallmounted",
  sunlight_propagates = true,
  walkable = false,
  selection_box = {
  type = "wallmounted",
    wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
    wall_bottom = {0, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
    wall_side = {-0.5, -0.3, -0.1, 0.5, 0.3, 0.1},
  },
  groups = {dig_immediate=3, attached=1},
  legacy_wallmounted = true,
  sounds = default.node_sound_defaults(),
})

local function register_flag(hue, hue2)
  minetest.register_craft( {
    type = "shapeless",
    output = "flags:" .. hue,
    recipe = {
      "flags:" .. "white",
      "unifieddyes:" .. hue,
    },
	})

  minetest.register_node("flags:"..hue, {
    description = hue2 .. " flag",
    drawtype = "torchlike",
    inventory_image = "flags_item_"..hue..".png",
    wield_image = "flags_item_"..hue..".png",
    tiles = {
      {name="flags_"..hue..".png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
      {name="flags_"..hue..".png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
      {name="flags_"..hue..".png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}}
    },
    paramtype = "light",
    paramtype2 = "wallmounted",
    sunlight_propagates = true,
    walkable = false,
    selection_box = {
    type = "wallmounted",
      wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
      wall_bottom = {0, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
      wall_side = {-0.5, -0.3, -0.1, 0.5, 0.3, 0.1},
    },
    groups = {dig_immediate=3, attached=1},
    legacy_wallmounted = true,
    sounds = default.node_sound_defaults(),
  })
end

register_flag("light_aqua", "Light_Aqua")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("aqua", "Aqua")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("aqua_s50", "Aqua_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_aqua", "Medium_Aqua")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_aqua_s50", "Medium_Aqua_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_aqua", "Dark_Aqua")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_aqua_s50", "Dark_Aqua_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("black", "Black")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("blue", "Blue")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("blue_s50", "Blue_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_blue", "Light_Blue")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_blue", "Medium_Blue")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_blue_s50", "Medium_Blue_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_blue", "Dark_Blue")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_blue_s50", "Dark_Blue_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_skyblue", "Light_Skyblue")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("skyblue", "Skyblue")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("skyblue_s50", "Skyblue_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_skyblue", "Medium_Skyblue")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_skyblue_s50", "Medium_Skyblue_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_skyblue", "Dark_Skyblue")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_skyblue_s50", "Dark_Skyblue_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("brown", "Brown")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_cyan", "Light_Cyan")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("cyan", "Cyan")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("cyan_s50", "Cyan_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_cyan", "Medium_Cyan")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_cyan_s50", "Medium_Cyan_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_cyan", "Dark_Cyan")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_cyan_s50", "Dark_Cyan_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_green", "Light_Green")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("green", "Green")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("green_s50", "Green_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_green", "Medium_Green")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_green_s50", "Medium_Green_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_green", "Dark_Green")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_green_s50", "Dark_Green_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("lightgrey", "Lightgrey")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("grey", "Grey")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_grey", "Dark_grey")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_lime", "Light_Lime")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("lime", "Lime")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("lime_s50", "Lime_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_lime", "Medium_Lime")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_lime_s50", "Medium_Lime_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_lime", "Dark_Lime")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_lime_s50", "Dark_Lime_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_magenta", "Light_Magenta")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("magenta", "Magenta")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("magenta_s50", "Magenta_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_magenta", "Medium_Magenta")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_magenta_s50", "Medium_Magenta_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_magenta", "Dark_Magenta")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_magenta_s50", "Dark_Magenta_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_orange", "Light_Orange")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("orange", "Orange")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("orange_s50", "Orange_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_orange", "Medium_Orange")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_orange_s50", "Medium_Orange_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_orange", "Dark_Orange")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_orange_s50", "Dark_Orange_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("pink", "Pink")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_red", "Light_Red")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("red", "Red")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("red_s50", "Red_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_red", "Medium_Red")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_red_s50", "Medium_Red_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_red", "Dark_Red")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_red_s50", "Dark_Red_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_redviolet", "Light_Redviolet")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("redviolet", "Redviolet")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("redviolet_s50", "Redviolet_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_redviolet", "Medium_Redviolet")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_redviolet_s50", "Medium_Redviolet_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_redviolet", "Dark_Redviolet")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_redviolet_s50", "Dark_Redviolet_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_violet", "Light_Violet")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("violet", "Violet")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("violet_s50", "Violet_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_violet", "Medium_Violet")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_violet_s50", "Medium_Violet_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_violet", "Dark_Violet")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_violet_s50", "Dark_Violet_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("light_yellow", "Light_Yellow")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("yellow", "Yellow")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("yellow_s50", "Yellow_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_yellow", "Medium_Yellow")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("medium_yellow_s50", "Medium_Yellow_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_yellow", "Dark_Yellow")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

register_flag("dark_yellow_s50", "Dark_Yellow_s50")

for i = 1, 12 do
  local hue = hue
  local hue2 = hue2
  register_flag(hue, hue2)
end

print("[flags] Loaded!")
