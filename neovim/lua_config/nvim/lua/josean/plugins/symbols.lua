-- import symbols-outline.nvim plugin safely
local setup, symbols = pcall(require, "symbols-uotline")
if not setup then
  return
end

--configure/enable symbols-outline
symbols.setup()
