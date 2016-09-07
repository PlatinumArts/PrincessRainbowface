#Progress Trees

This is a library to help implement advancement trees, such as talent trees
or research trees.

Licensed under version 2.1 of the LGPL, or any later version.

API
===
Functions
---------
```progress_tree.new_tree()``` - Creates an empty tree
<br/>
```progress_tree.new_player_data(tree[, learned])``` - Creates an instance of
player advancement data in a particular progress tree. The optional argument
is a set of node names to start off with.
<br/>
```progress_tree.deserialize_player_data(tree, learned_string)``` - Deserializes
player data in relation to a particular tree.

Progress Tree Methods
---------------------
```add(node_name, parents)``` - Adds a new node with the name node_name.
```parents``` is a list of parent node names, which must already exist in
the tree (or you will get an error).
<br/>
```new_player_data(learned)``` - Method version of progress_tree.new_player_data
<br/>
```deserialize_player_data(learned_string)``` - Method version of
progress_tree.deserialize_player_data

Player Data Methods
-------------------
```serialize()``` - Serializes the data to a string
<br/>
```knows(node_name)``` - Determines if the player has learned the node
<br/>
```can_learn(node_name)``` - Determines if the player has completed the prerequisites
for the node
<br/>
```learn(node_name)``` - Adds the given node to the known nodes. It can fail and
return false if the node doesn't exist in the tree, or if it has already been
learned, but will return true if nothing goes wrong. It will not fail if not
all prerequisites have been completed, though.