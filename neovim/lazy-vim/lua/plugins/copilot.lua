-- return {
--   {
--     "github/copilot.vim",
--     -- event = "InsertEnter", -- Load when entering insert mode
--   },
-- }

return {
  "zbirenbaum/copilot.lua",
  optional = true,
  opts = function()
    require("copilot.api").status = require("copilot.status")
  end,
}
