local lambda = require("estrela.lambda")

describe("test for lambda", function()
  it("add", function()
    local add = lambda("x, y: x + y")
    assert(3, add(1, 2))
  end)
end)
