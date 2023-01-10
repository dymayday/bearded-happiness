-- import symbols-outline.nvim plugin safely
local setup, symbols = pcall(require, "symbols-outline")
if not setup then
  print("symbols-outline not found!") -- print error if colorscheme not installed
  return
end

--configure/enable symbols-outline
symbols.setup()
