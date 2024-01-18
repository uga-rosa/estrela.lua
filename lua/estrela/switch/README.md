# switch.lua

Implementation of switch/case/default statements.

# Usage

Don't forget to execute the function returned by `call/default`.

```lua
local switch = require("estrela.switch")

local result
local x = 3
switch(x)
  :case(1)
  :case(2)
  :call(function()
    result = "x is one or two"
  end)
  :case(3)
  :call(function()
    result = "x is three"
  end)
  :default(function()
    result = "x is larger than three"
  end)()

print(result)
-- output: x is three
```
