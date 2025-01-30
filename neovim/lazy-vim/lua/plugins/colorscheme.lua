return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "medium" -- Options: "soft", "medium", "hard"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}
