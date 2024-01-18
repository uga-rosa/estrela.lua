local Array = require("estrela.array")

---@param self estrela.switch
local function run(self)
  for _, stmt in ipairs(self._stmt) do
    if stmt.cases:includes(self._var) then
      stmt.call(self._var)
      return
    end
  end
  self._default(self._var)
end

---@class estrela.switch
---@field _var unknown
---@field _stmt estrela.array
---@field _tmp_cases estrela.array
---@field _default? function
local M = {}

function M.switch(var)
  return setmetatable({
    _var = var,
    _stmt = Array.new(),
    _tmp_cases = Array.new(),
    _default = nil,
  }, {
    __index = {
      case = M.case,
      call = M.call,
      default = M.default,
    },
    __call = run,
  })
end

---@param case unknown
function M:case(case)
  self._tmp_cases:push(case)
  return self
end

---@param callback function
function M:call(callback)
  self._stmt:push({
    cases = self._tmp_cases,
    call = callback,
  })
  self._tmp_cases = Array.new()
  return self
end

---@param callback function
function M:default(callback)
  self._default = callback
  return setmetatable(self, {
    __call = run,
  })
end

return M.switch
