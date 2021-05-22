# AVL_Tree
AVL_Tree is a Lua implementation of AVL Trees. See [GeekForGeeks AVL Trees](https://www.geeksforgeeks.org/avl-tree-set-1-insertion/) and [Wikipedia AVL Trees](https://en.wikipedia.org/wiki/AVL_tree) for information on AVL Trees.

## Install
To install, ```clone``` into the repository and use require.

## Example
```lua
local AVL = require("AVL_Tree")

-- Initializes the AVL Tree and inserts values
local Root
Root = AVL.Insert(Root, 1)
Root = AVL.Insert(Root, 2)
Root = AVL.Insert(Root, 3, "kiwis") -- Nodes may store extra data along with the value
Root = AVL.Insert(Root, 4, "austrailian jalapenos")
Root = AVL.Insert(Root, 4) -- Duplicate values are allowed, but will be treated as a value greater than the previously inserted value

-- Gets the first Node with the value 4 and outputs the Extra data
Node = AVL.Get(Root, 4)
print(Node.Extra)
```
