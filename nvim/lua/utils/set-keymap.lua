--- Sets the given keymap with the given properties
-- @param properties - object
-- {
--     modes - modes when the keymap can trigger
--     key - key that triggers the keymap
--     actions - action/s that gets fired on key press
--     options -- options to be applied for the keymap
-- }
local function apply_keymap(properties)
  local modes = properties.modes or { "n" }
  local options = properties.options or { noremap = true, silent = true, desc = properties.description }

  vim.keymap.set(modes, properties.key, properties.actions, options)
end

--- Sets the given keymap or list of keymaps with the given properties
-- @param properties - object
-- {
--     modes - modes when the keymap can trigger
--     key - key that triggers the keymap
--     actions - action/s that gets fired on key press
--     options -- options to be applied for the keymap
--     list -- list of multiple keymaps to set
-- }
return function(properties)
  -- Set a single keymap
  if properties.list == nil then
      apply_keymap(properties)

      return
  end

  -- Set a list of keymaps
  for _, value in ipairs(properties.list) do
      apply_keymap(value)
  end
end
