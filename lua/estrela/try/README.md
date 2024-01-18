# try.lua

Implementation of try/catch/finally statements.

# Usage

First, `try` callback is executed.
And if an error occurs, the error message is passed to `catch` callback.
Then, regardless of whether there is an error or not, `finally` callback is executed.

Either or both `catch` and `finally` are required.

Don't forget to execute the function returned by `catch/finally`.
Any arguments passed to it are passed directly to `try` callback.

```lua
local try = require("estrela.try")

-- try/catch
try(function()
    print("try")
    error("raise error!")
  end)
  :catch(function(errmsg)
    print("catched: " .. errmsg)
  end)()

-- try/catch/finally
try(function()
    print("try")
    error("raise error!")
  end)
  :catch(function(errmsg)
    print("catched: " .. errmsg)
  end)
  :finally(function()
    print("finally")
  end)()

-- try/finally
try(function()
    print("try")
    error("raise error!")
  end)
  :finally(function()
    print("finally")
  end)()
```
