--- Sets the given sign with the given properties
-- @param properties - object
-- {
--     name - sign group name
--     sign - sign string
--     highlight_group - highlight group to be applied to the sing
-- }
local function apply_sign(properties)
  vim.cmd(
      "sign define " .. properties.name .. " text=" .. properties.sign .. " texthl=" .. properties.highlight_group
  )
end

--- Sets the given sign or list of signs with the given properties
-- @param properties - object
-- {
--     name - sign group name
--     sign - sign string
--     highlight_group - highlight group to be applied to the sing
--     list -- list of multiple signs to set
-- }
return function(properties)
  -- Set a single sign
  if properties.list == nil then
      apply_sign(properties)

      return
  end

  -- Set a list of sign
  for _, value in ipairs(properties.list) do
      apply_sign(value)
  end
end
