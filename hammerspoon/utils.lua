local module = {}

-- capitalize string
module.capitalize = function(str)
  return str:gsub("^%l", string.upper)
end

return module
