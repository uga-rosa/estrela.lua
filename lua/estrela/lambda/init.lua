local load = loadstring or load

local chunk = [[
return function(%s)
  return %s
end
]]

---@param str string
---@return function
local function lambda(str)
  local arg, body = str:match("(.*):(.*)")
  return assert(load(chunk:format(arg, body)))()
end

return lambda
