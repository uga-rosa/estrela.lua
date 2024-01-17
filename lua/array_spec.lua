local Array = require("array")

describe("Test for array.lua", function()
  it("new()", function()
    local a = Array.new({ 1, 2, 3 })
    assert.same(Array, getmetatable(a))
    assert.same(3, #a)
  end)

  it("from()", function()
    local a = { 1, 2, 3 }
    local b = Array.from(a, "x * 2")
    assert.same({ 1, 2, 3 }, a)
    assert.same({ 2, 4, 6 }, b)
    assert.same(Array, getmetatable(b))
  end)

  it("isArray()", function()
    assert.same(true, Array.isArray({ 1, 2, 3 }))
    assert.same(false, Array.isArray({ a = "a", 1, 2, 3 }))
  end)

  it("length()", function()
    assert.same(3, Array.new({ 1, 2, 3 }):length())
  end)

  it("concat()", function()
    local a = Array.new({ 1, 2, 3 })
    assert.same({ 1, 2, 3, 4, 5, 6 }, a:concat(4, { 5, 6 }))
    assert.same({ 1, 2, 3 }, a)
  end)

  it("copyWithin()", function()
    local a = Array.new({ "a", "b", "c", "d", "e" })
    assert.same({ "d", "b", "c", "d", "e" }, a:copyWithin(1, 4, 4))
    assert.same({ "d", "d", "e", "d", "e" }, a:copyWithin(2, 4))
    assert.same({ "d", "d", "e", "d", "e" }, a)
  end)

  it("every()", function()
    assert.same(false, Array.new({ 12, 5, 8, 130, 44 }):every("x >= 10"))
    assert.same(true, Array.new({ 12, 5, 8, 130, 44 }):every("x >= 10 or i >= 2"))
  end)

  it("fill()", function()
    local a = Array.new({ 1, 2, 3, 4 })
    assert.same({ 1, 2, 0, 0 }, a:fill(0, 3, 4))
    assert.same({ 1, 5, 5, 5 }, a:fill(5, 2))
    assert.same({ 6, 6, 6, 6 }, a:fill(6))
  end)

  it("filter()", function()
    assert.same({ 8, 11, 7 }, Array.new({ 5, 5, 8, 11, 7 }):filter("x > 6"))
  end)

  it("find()", function()
    assert.same(12, Array.new({ 5, 12, 8, 130, 44 }):find("x > 10"))
  end)

  it("findIndex()", function()
    assert.same(4, Array.new({ 5, 12, 8, 130, 44 }):findIndex("x > 13"))
  end)

  it("findLast()", function()
    assert.same(130, Array.new({ 5, 12, 8, 130, 44 }):findLast("x > 45"))
  end)

  it("findLastIndex()", function()
    assert.same(4, Array.new({ 5, 12, 8, 130, 44 }):findLastIndex("x > 45"))
  end)

  it("flat()", function()
    local a = Array.new({ 0, 1, 2, { 3, 4 } })
    assert.same({ 0, 1, 2, 3, 4 }, a:flat())
    local b = Array.new({ 0, 1, { 2, { 3, { 4, 5 } } } })
    assert.same({ 0, 1, 2, { 3, { 4, 5 } } }, b:flat())
    assert.same({ 0, 1, 2, 3, { 4, 5 } }, b:flat(2))
    assert.same({ 0, 1, 2, 3, 4, 5 }, b:flat(math.huge))
  end)

  describe("flatMap()", function()
    it("success", function()
      assert.same({ 1, 2, 2, 1 }, Array.new({ 1, 2, 1 }):flatMap("x == 2 and { 2, 2 } or 1"))
    end)

    it("more efficient than map() and flat()", function()
      local flatMapTime = os.clock()
      for _ = 1, 10000 do
        Array.new({ 1, 2, 1 }):flatMap("x == 2 and { 2, 2 } or 1")
      end
      flatMapTime = (os.clock() - flatMapTime) * 1000
      local mapAndFlatTime = os.clock()
      for _ = 1, 10000 do
        Array.new({ 1, 2, 1 }):map("x == 2 and { 2, 2 } or 1"):flat()
      end
      mapAndFlatTime = (os.clock() - mapAndFlatTime) * 1000
      assert(
        flatMapTime < mapAndFlatTime,
        ("flatMap(): %d ms, map() and flat(): %d ms"):format(flatMapTime, mapAndFlatTime)
      )
    end)
  end)

  it("forEach()", function()
    local str = ""
    Array.new({ "a", "b", "c" }):forEach(function(x, i)
      str = str .. x .. i
    end)
    assert.same("a1b2c3", str)
  end)

  it("includes()", function()
    assert.same(true, Array.new({ 1, 2, 3 }):includes(2))
    local a = Array.new({ "cat", "dog", "bat" })
    assert.same(true, a:includes("cat"))
    assert.same(false, a:includes("at"))
  end)

  it("indexOf()", function()
    local a = Array.new({ "ant", "bison", "camel", "duck", "bison" })
    assert.same(2, a:indexOf("bison"))
    assert.same(5, a:indexOf("bison", 3))
    assert.same(-1, a:indexOf("giraffe"))
  end)

  it("lastIndexOf()", function()
    local a = Array.new({ "Dodo", "Tiger", "Penguin", "Dodo" })
    assert.same(4, a:lastIndexOf("Dodo"))
    assert.same(-1, a:lastIndexOf("Dragon"))
  end)

  it("map()", function()
    assert.same({ 2, 8, 18, 32 }, Array.new({ 1, 4, 9, 16 }):map("x * 2"))
  end)

  it("pop()", function()
    local a = Array.new({ 1, 2, 3 })
    assert.same(3, a:pop())
    assert.same({ 1, 2 }, a)
  end)

  it("push()", function()
    local a = Array.new({ "pigs", "goats", "sheep" })
    assert.same(4, a:push("cows"))
    assert.same({ "pigs", "goats", "sheep", "cows" }, a)
  end)

  it("reduce()", function()
    local a = Array.from({ { 0, 1 }, { 2, 3 }, { 4, 5 } }, Array.new)
    assert.same({ 4, 5, 2, 3, 0, 1 }, a:reduceRight("acc:concat(cur)"))
  end)

  it("reverse()", function()
    local a = Array.new({ "one", "two", "three" })
    assert.same({ "three", "two", "one" }, a:reverse())
    assert.same({ "three", "two", "one" }, a)
  end)

  it("shift()", function()
    local a = Array.new({ 1, 2, 3 })
    assert.same(1, a:shift())
    assert.same({ 2, 3 }, a)
  end)

  it("slice()", function()
    local a = Array.new({ "ant", "bison", "camel", "duck", "elephant" })
    assert.same({ "camel", "duck", "elephant" }, a:slice(3))
    assert.same({ "camel", "duck" }, a:slice(3, 4))
    assert.same({ "ant", "bison", "camel", "duck", "elephant" }, a:slice())
  end)

  it("some()", function()
    local a = Array.new({ 1, 2, 3, 4, 5 })
    assert.same(true, a:some("x % 2 == 0"))
    assert.same(false, a:some("x > 5"))
  end)

  it("sort()", function()
    local a = Array.new({ 3, 4, 2 })
    assert.same({ 2, 3, 4 }, a:sort())
    assert.same({ 2, 3, 4 }, a)
  end)

  it("splice()", function()
    local a = Array.new({ "Jan", "March", "April", "June" })
    assert.same({ "Jan", "Feb", "March", "April", "June" }, a:splice(2, 0, "Feb"))
    assert.same({ "Jan", "Feb", "March", "April", "June" }, a)
    assert.same({ "Jan", "Feb", "March", "April", "May" }, a:splice(5, 1, "May"))
    assert.same({ "Jan", "Feb", "March", "April", "May" }, a)
  end)

  it("toReversed()", function()
    local a = Array.new({ 1, 2, 3, 4 })
    assert.same({ 4, 3, 2, 1 }, a:toReversed())
    assert.same({ 1, 2, 3, 4 }, a)
  end)

  it("toSorted()", function()
    local a = Array.new({ 3, 2, 4 })
    assert.same({ 2, 3, 4 }, a:toSorted())
    assert.same({ 3, 2, 4 }, a)
  end)

  it("toSpliced()", function()
    local a = Array.new({ "Jan", "March", "April", "June" })
    assert.same({ "Jan", "Feb", "March", "April", "June" }, a:toSpliced(2, 0, "Feb"))
    assert.same({ "Jan", "March", "April", "June" }, a)
  end)

  it("unshift()", function()
    local a = Array.new({ 1, 2, 3 })
    assert.same(5, a:unshift(4, 5))
    assert.same({ 4, 5, 1, 2, 3 }, a)
  end)

  it("with()", function()
    local a = Array.new({ 1, 2, 3, 4 })
    assert.same({ 1, 5, 3, 4 }, a:with(2, 5))
    assert.same({ 1, 2, 3, 4 }, a)
  end)
end)
