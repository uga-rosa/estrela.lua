# lambda.lua

Generating a function from a string.

Syntax like python's lambda function

# Usage

Generate a function from string `{arg}:{body}`.

```lua
local lambda = require("estrela.lambda")

local add = lambda "x, y: x + y"

-- Same as:
--
-- local add = function(x, y)
--   return x + y
-- end
```
