local function call(self, ...)
  local ok, errmsg = pcall(self._try, ...)
  if not ok and self._catch then
    self._catch(errmsg)
  end
  if self._finally then
    self._finally()
  end
  if not ok and self._catch == nil then
    error(errmsg)
  end
end

local M = {}

---@param callback function
function M.try(callback)
  return setmetatable({
    _try = callback,
  }, {
    __index = {
      catch = M.catch,
      finally = M.finally,
    },
  })
end

---@param callback fun(errmsg: string)
function M:catch(callback)
  return setmetatable({
    _try = self._try,
    _catch = callback,
  }, {
    __index = {
      finally = M.finally,
    },
    __call = call,
  })
end

---@param callback function
function M:finally(callback)
  return setmetatable({
    _try = self._try,
    _catch = self._catch,
    _finally = callback,
  }, {
    __call = call,
  })
end

return M.try
