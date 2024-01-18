local switch = require("estrela.switch")

describe("test for switch.lua", function()
  it("single case for one call", function()
    local result
    local x = 1
    switch(x)
      :case(1)
      :call(function()
        result = "x is one"
      end)
      :case(2)
      :call(function()
        result = "x is two"
      end)()
    assert.same("x is one", result)
  end)

  it("double case for one call", function()
    local result
    local x = 2
    switch(x)
      :case(1)
      :case(2)
      :call(function()
        result = "x is one or two"
      end)
      :case(3)
      :call(function()
        result = "x is three"
      end)()
    assert.same("x is one or two", result)
  end)

  it("default", function()
    local result
    local x = 4
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
    assert.same("x is larger than three", result)
  end)
end)
