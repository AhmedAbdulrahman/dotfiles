--- Sources the given file name in the plugins folder
-- @param name - string
return function(name)
  require("plugins." .. name)
end
