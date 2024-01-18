local try = require("estrela.try")

try(function()
    print("hello")
    error("raise error!")
  end)
  :catch(function(e)
    print("catch: " .. e)
  end)
  :finally(function()
    print("finally")
  end)()