--- Sets the given terminal keymap
-- @param properties - object
-- {
--     key - key that triggers the terminal keymap
--     actions - action that gets fired on key press
-- }
local function apply_terminal_keymap(properties)
  local action = ""

  -- If there is a list of actions, concatenate them into a single string
  if type(properties.actions) ~= "string" and table.getn(properties.actions) ~= 0 then
      for _, value in ipairs(properties.actions) do
          action = action .. " " .. value
      end
  else
      action = properties.actions
  end

  vim.cmd(":tnoremap " .. properties.key .. " " .. action)
end

--- Sets the given terminal keymap or list of terminal keymaps
-- @param properties - object
-- {
--     key - key that triggers the keymap
--     actions - action that gets fired on key press
--     list -- list of multiple terminal keymaps to set
-- }
return function(properties)
  -- Set a single terminal keymap
  if properties.list == nil then
      apply_terminal_keymap(properties)

      return
  end

  -- Set a list of terminal keymaps
  for _, value in ipairs(properties.list) do
      apply_terminal_keymap(value)
  end
end
