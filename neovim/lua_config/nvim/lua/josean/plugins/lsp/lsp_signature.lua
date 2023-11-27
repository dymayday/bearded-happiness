-- import lspsignature plugin safely
local status, lspsignature = pcall(require, "lsp_signature")
if not status then
  print("lsp_signature.config not found!") -- print error if the plugin is not installed
end

-- configure lspsignature
lspsignature.setup({
  close_timeout = 500, -- close floating window after ms when laster parameter is entered
  timer_interval = 100, -- default timer check interval set to lower value if you want to reduce latency
  always_trigger = true, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
  auto_close_after = 1, -- autoclose signature float win after x sec, disabled if nil.
})
