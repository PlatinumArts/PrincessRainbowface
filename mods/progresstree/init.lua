
progress_tree = {}

-- A progress tree is a map from string names to nodes in adjacency list
-- representation.

local tree_methods = {}
local tree_metatab = { __index = tree_methods }

function progress_tree.new_tree()
	local ret = {}
	setmetatable(ret, tree_metatab)
	return ret
end


-- A node is a table with these fields:
--  - children - A list of child nodes
--  - parents - A list of parent nodes

local node_methods = {}
local node_metatab = { __index = node_methods }

function progress_tree.new_node(parents)
	local ret = { children = {},
		      parents = parents,
		    }
	setmetatable(ret, node_metatab)

	return ret
end


-- Adds one node, and takes a list of parents. Each parent must be in the tree
-- already.
function tree_methods.add(self, name, parents)
	for i, parent in ipairs(parents) do
		if not self[parent] then
			local err_msg = "[progress_tree]"
				.. " Node " .. name ..
				" is child of nonexistent parent " .. parent
			error(err_msg)
		end
	end

	if self[name] then
		error("[progress_tree] Duplicate node " .. name)
	end

	self[name] = progress_tree.new_node(parents)

	for i, parent in ipairs(parents) do
		table.insert(self[parent].children, name)
	end
end


-- Each player can ahve data related to their completion of the tree, namely a table
-- with these fields:
--  - tree - The original tree this data tracks
--  - remaining_deps - A map from node names to the number of unfulfilled
--    prerequisite nodes.
--  - available - A set { ["node1"] = true, ["node2"] = true, ... } of nodes
--    that have no prerequisites left to fulfill, and have not been taken yet
--  - learned - A set of nodes the player has taken already.

local pd_methods = {}
local pd_metatab = { __index = pd_methods }


-- Argument is the tree to create the data against. learned is an optional
-- argument for a set of initial learned techs.
function progress_tree.new_player_data(tree, learned)
	local data = { tree = tree,
		       remaining_deps = {},
		       available = {},
		       learned = {},
		     }
	setmetatable(data, pd_metatab)

	for name, node in pairs(tree) do
		local rem_deps = #(node.parents)
		data.remaining_deps[name] = rem_deps
		if rem_deps == 0 then
			data.available[name] = true
		end
	end

	if learned then
		for k in pairs(learned) do
			data:learn(k)
		end
	end
	
	return data
end


tree_methods.new_player_data = progress_tree.new_player_data
		

-- Serialization to a string
function pd_methods.serialize(self)
	return minetest.serialize(self.learned)
end


-- Deserialization. Data can only be deserialized against a particular tree.
-- Returns nil on failure.
function progress_tree.deserialize_player_data(tree, learned_string)
	local learned = minetest.deserialize(learned_string)
	if not learned then return end

	return progress_tree.new_player_data(tree, learned)
end


tree_methods.deserialize_player_data = progress_tree.deserialize_player_data


-- Tells whether the tech is already learned
function pd_methods.knows(self, name)
	return self.learned[name] == true -- Want false when not in
end


-- Tells whether the tech is learnable with the current level of techs.
function pd_methods.can_learn(self, name)
	return (not self.learned[name]) and self.available[name] == true
end


-- Learn a new tech. Returns true on success, returns false on failure. It can
-- fail if the tech doesn't exist or if it is already learned. It does not fail
-- if it is learned out of order, so use can_learn if you want to be sure.
function pd_methods.learn(self, name)
	if self:knows(name) then return false end

	local node = self.tree[name]
	if not node then return false end

	local children = node.children

	-- Decrement the remaining deps for each child
	for i, child in ipairs(children) do
		local new_rem = self.remaining_deps[child] - 1

		-- If the player learned it out of order, don't put it as
		-- available.
		if new_rem == 0 and not self:knows(child) then
			self.available[child] = true
		end
		self.remaining_deps[child] = new_rem
	end

	self.learned[name] = true
	self.available[name] = nil
end


if minetest.get_modpath("default") then
	dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/test.lua")
end
