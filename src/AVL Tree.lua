-- https://www.geeksforgeeks.org/avl-tree-set-1-insertion/
local Tree = {}

--[[
	Constructs a Node
	@param Value	The weight to give to the node in the tree
	@param Extra	Optional. The extra data to store into the node
	@return A Node
]]
Node = function(Value, Extra)
	local self = {}

	self.Value = Value
	self.Extra = Extra
	self.Left = nil
	self.Right = nil
	self.Height = 1

	return self
end

--[[
	Insert a new node below a root
	@param Root		The ancestor node to insert below
	@param Value	The value to create a new with
	@param Extra	Optional. The extra data to insert into the new node
	@returns the new root of the tree
]]
function Tree.Insert(Root, Value, Extra)
	-- Creates a root if the tree's root does not exist
	if Root == nil then
		return Node(Value, Extra)
	end

	-- Inserts to the left or right of the root
	if Value < Root.Value then
		Root.Left = Tree.Insert(Root.Left, Value, Extra)
	else
		Root.Right = Tree.Insert(Root.Right, Value, Extra)
	end

	-- Update the height of the ancestor node
	Root.Height = 1 + math.max(
		Tree.GetHeight(Root.Left),
		Tree.GetHeight(Root.Right)
	)

	-- Get the balance factor
	local Balance = GetBalance(Root)

	-- If unbalanced, balance using the 4 cases
	-- Left Left
	if (Balance > 1) and (Value < Root.Left.Value) then
		 return RightRotate(Root)
	end

	-- Right Right
	if (Balance < -1) and (Value > Root.Right.Value) then
		return LeftRotate(Root)
	end

	-- Left Right
	if (Balance > 1) and (Value > Root.Left.Value) then
		Root.Left = LeftRotate(Root.Left)
		return RightRotate(Root)
	end

	-- Right Left
	if (Balance < -1) and (Value < Root.Right.Value) then
		Root.Right = RightRotate(Root.Right)
		return LeftRotate(Root)
	end

	return Root
end

--[[
	Gets the height of a node
	@param Node		The node
	@return Node.Height or 0 if the node does not exist
]]
function Tree.GetHeight(Node)
	if Node == nil then
		return 0
	else
		return Node.Height
	end
end

--[[
	Gets a value from the tree
	@param Root		The Root of the tree
	@return The node or nil
]]
function Tree.Get(Root, Value)
	if (Root == nil) or (Value == Root.Value) then
		return Root
	end

	if Value < Root.Value then
		return Tree.Get(Root.Left, Value)
	else
		return Tree.Get(Root.Right, Value)
	end
end

--[[
	Gets the balance of a node
	@param Node		The Node
	@return how much higher the left branch is compared to the right branch
]]
function GetBalance(Node)
	if Node == nil then
		return 0
	else
		return Tree.GetHeight(Node.Left) - Tree.GetHeight(Node.Right)
	end
end

--[[
	Rotates to make the Node0.Left the new ancestor
	@param Node0	The initial ancestor node
	@return the new ancestor node
]]
function RightRotate(Node0)
	local Node1 = Node0.Left
	local Node2 = Node1.Right

	-- Rotate
	Node1.Right = Node0
	Node0.Left = Node2

	-- Update heights
	Node1.Height = 1 + math.max(
		Tree.GetHeight(Node1.Left),
		Tree.GetHeight(Node1.Right)
	)
	Node0.Height = 1 + math.max(
		Tree.GetHeight(Node0.Left),
		Tree.GetHeight(Node0.Right)
	)

	return Node1
end

--[[
	Rotates to make the Node0.Right the new ancestor
	@param Node0	The initial ancestor node
	@return the new ancestor node
]]
function LeftRotate(Node0)
	local Node1 = Node0.Right
	local Node2 = Node1.Left

	-- Rotate
	Node1.Left = Node0
	Node0.Right = Node2

	-- Update heights
	Node1.Height = 1 + math.max(
		Tree.GetHeight(Node1.Left),
		Tree.GetHeight(Node1.Right)
	)
	Node0.Height = 1 + math.max(
		Tree.GetHeight(Node0.Left),
		Tree.GetHeight(Node0.Right)
	)

	return Node1
end

return Tree
