# viaduct by [pithydon]

Connected node bridges for Minetest.

[forum link]

code license: unlicense

texture license: WTFPL

see LICENSE.txt

mod api:

```lua
viaduct.register_wood_bridge("recipe:node", {item definition})

viaduct.register_rope_bridge("recipe:node", {item definition})
```

examples

```lua
viaduct.register_wood_bridge("default:wood", {
	description = "Wooden Bridge",
	tiles = {"default_wood.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	stick = "groups:stick",
})
```
stick is used to define what to use in the craft recipe for rails.

Any part of the item definition can also be blank.

```lua
viaduct.register_wood_bridge("default:wood", {})
```

New bridges will be added to group bridge. Bridges will connect to anything in group bridge.

[pithydon]: <https://github.com/pithydon>
[forum link]: <https://forum.minetest.net/viewtopic.php?f=11&t=14559>
