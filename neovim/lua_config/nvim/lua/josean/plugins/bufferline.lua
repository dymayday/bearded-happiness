-- import telescope plugin safely
local bufferline_setup, bufferline = pcall(require, "bufferline.nvim")
if not bufferline_setup then
  return
end

-- enable bufferline
bufferline.setup()
