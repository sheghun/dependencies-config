---@type ChadrcConfig
---@class ChadrcConfig
local M = {}

M.base46 = {
  theme = "everforest",
  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },

  transparency = true,
}

M.ui = {
  statusline = {
    modules = {
      file = function()
        local filename = vim.fn.expand "%:."
        return "%#StatusLine#" .. filename -- Basic styling
        -- Or with custom highlight:
        -- return "%#CustomHighlight#" .. filename
      end,
    },
  },
}

M.plugins = "custom.plugins"

return M
