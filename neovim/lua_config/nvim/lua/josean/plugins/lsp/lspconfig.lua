-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  print("lspconfig not found!") -- print error if colorscheme not installed
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  print("cmp_nvim_lsp not found!") -- print error if colorscheme not installed
end

-- -- import typescript plugin safely
-- local typescript_setup, typescript = pcall(require, "typescript")
-- if not typescript_setup then
--   -- return
-- end

-- import rust plugin safely
local rust_setup, rust = pcall(require, "rust-tools")
if not rust_setup then
  print("rust-tools not found!") -- print error if colorscheme not installed
end

rust.setup()

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  -- keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
  keymap.set("n", "gf", "<cmd>Lspsaga finder def+ref+imp<CR>", opts) -- show definition, references
  keymap.set("n", "gfd", "<cmd>Lspsaga finder def<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gtd", "<cmd>Lspsaga goto_definition<CR>", opts) -- see definition and make edits in window
  -- Peek type definition
  -- You can edit the file containing the type definition in the floating window
  -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
  -- It also supports tagstack
  -- Use <C-t> to jump back
  keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", opts)
  keymap.set("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  -- keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
  keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
  -- LSP finder - Find the symbol's definition
  -- If there is no definition, it will instead be hidden
  -- When you use an action in finder like "open vsplit",
  -- you can use <C-t> to jump back
  keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
  -- Call hierarchy
  keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
  keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)
  keymap.set("n", "<leader>tr", "<cmd>Lspsaga term_toggle<cr>") -- list current changes per file with diff preview ["gs" for git status]

  -- -- typescript specific keymaps (e.g. rename file and update imports)
  -- if client.name == "tsserver" then
  --   keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
  --   keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
  --   keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
  -- end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure html server
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- -- configure typescript server with plugin
-- typescript.setup({
--   server = {
--     capabilities = capabilities,
--     on_attach = on_attach,
--   },
-- })

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- -- configure lua server (with special settings)
-- lspconfig["sumneko_lua"].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = { -- custom settings for lua
--     Lua = {
--       -- make the language server recognize "vim" global
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         -- make language server aware of runtime files
--         library = {
--           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--           [vim.fn.stdpath("config") .. "/lua"] = true,
--         },
--       },
--     },
--   },
-- })

-- -- who even uses this?
-- rust.setup(config({
--   cmd = { "rustup", "run", "nightly", "rust-analyzer" },
--   --[[
--     settings = {
--         rust = {
--             unstable_features = true,
--             build_on_save = false,
--             all_features = true,
--         },
--     }
--     --]]
-- }))

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        diagnostics = {
          enable = true,
          disabled = { "unresolved-proc-macro" },
          enableExperimental = true,
        },
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require("rust-tools").setup(opts)
