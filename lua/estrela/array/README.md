# array.lua

Lua's list manipulation library, strongly inspired by JS's Array.prototype.

# Features

No special edits are made to the Array instance except for the addition of a metatable.
So, to the extent that this is not a problem, it can be handled just like a simple Lua list (e.g., looping in `ipairs()`).

Lua does not have a concise lambda expression.
Anonymous functions are available, but they are often too exaggerated to write very simple processes (like `function(x) return x * 2 end`).
As an alternative, strings can be used in callback functions.

All indices accept negative numbers, and both are included when indicating a range.
-1 means the last element of an array. Generally corrected to `i + #self - 1`.

# Examples

```lua
local Array = require("estrela.array")

-- `x` is the element of each array, `i` is its index, and `self` gives access to the array itself.
local a1 = Array.new({ 1, 2, 3 }):map("x * 2")
print(a1)
-- Array[ 2, 4, 6 ]

-- `acc` is the value resulting from the previous call to callbackFn.
-- `cur` is the value of the current element.
local sum = Array.new({ 1, 2, 3, 4 }):reduce("acc + cur")
print(sum)
-- 10

-- Change the last two element to 5.
local a2 = Array.new({ 1, 2, 3, 4 }):fill(5, -2)
print(a2)
-- Array[ 1, 2, 5, 5 ]
```
