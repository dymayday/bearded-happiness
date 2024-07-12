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
  print("rust-tools not found!") -- print error if rust not installed
end

rust.setup()

-- -- import go plugin safely
-- local go_setup, go = pcall(require, "go")
-- if not go_setup then
--   print("go not found!") -- print error if go not installed
-- end
-- go.setup()

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
  keymap.set("n", "<leader>.", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>,", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  -- keymap.set("n", "<leader>k", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
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
  -- keymap.set("n", "<leader>tr", "<cmd>Lspsaga term_toggle<cr>") -- list current changes per file with diff preview ["gs" for git status]

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
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
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

-- configure go server
lspconfig["gopls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- lspconfig["solidity"] = {
--   default_config = {
--     cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
--     filetypes = { "solidity" },
--     root_dir = lspconfig["util"].find_git_ancestor,
--     single_file_support = true,
--   },
-- }

lspconfig["solidity"].setup({
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_dir = lspconfig["util"].find_git_ancestor,
  single_file_support = true,
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

-- import go plugin safely
local M = {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
  },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  config = function()
    local icons = require("core.utils.icons")
    require("go").setup({
      -- NOTE: all LSP and formatting related options are disabeld.
      -- NOTE: is not related to core.plugins.lsp
      -- NOTE: manages LSP on its own
      go = "go", -- go command, can be go[default] or go1.18beta1
      goimport = "gopls", -- goimport command, can be gopls[default] or goimport
      fillstruct = "gopls", -- can be nil (use fillstruct, slower) and gopls
      gofmt = "gofumpt", -- gofmt cmd,
      max_line_len = 120, -- max line length in goline format
      tag_transform = false, -- tag_transfer  check gomodifytags for details
      test_template = "", -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
      test_template_dir = "", -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
      comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ       
      icons = { breakpoint = icons.ui.Yoga, currentpos = icons.ui.RunningMan },
      verbose = false, -- output loginf in messages
      lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
      -- false: do nothing
      -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
      --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
      lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
      lsp_diag_underline = false,
      lsp_on_attach = function(client, bufnr)
        -- attach my LSP configs keybindings
        require("core.plugins.lsp.keys").on_attach(client, bufnr)
        local wk = require("which-key")
        local default_options = { silent = true }
        -- wk.register({
        --   c = {
        --     name = "Coding",
        --     a = { "<cmd>GoCodeAction<cr>", "Code action" },
        --     e = { "<cmd>GoIfErr<cr>", "Add if err" },
        --     h = {
        --       name = "Helper",
        --       a = { "<cmd>GoAddTag<cr>", "Add tags to struct" },
        --       r = { "<cmd>GoRMTag<cr>", "Remove tags to struct" },
        --       c = { "<cmd>GoCoverage<cr>", "Test coverage" },
        --       g = { "<cmd>lua require('go.comment').gen()<cr>", "Generate comment" },
        --       v = { "<cmd>GoVet<cr>", "Go vet" },
        --       t = { "<cmd>GoModTidy<cr>", "Go mod tidy" },
        --       i = { "<cmd>GoModInit<cr>", "Go mod init" },
        --     },
        --     i = { "<cmd>GoToggleInlay<cr>", "Toggle inlay" },
        --     l = { "<cmd>GoLint<cr>", "Run linter" },
        --     o = { "<cmd>GoPkgOutline<cr>", "Outline" },
        --     r = { "<cmd>GoRun<cr>", "Run" },
        --     s = { "<cmd>GoFillStruct<cr>", "Autofill struct" },
        --     t = {
        --       name = "Tests",
        --       r = { "<cmd>GoTest<cr>", "Run tests" },
        --       a = { "<cmd>GoAlt!<cr>", "Open alt file" },
        --       s = { "<cmd>GoAltS!<cr>", "Open alt file in split" },
        --       v = { "<cmd>GoAltV!<cr>", "Open alt file in vertical split" },
        --       u = { "<cmd>GoTestFunc<cr>", "Run test for current func" },
        --       f = { "<cmd>GoTestFile<cr>", "Run test for current file" },
        --     },
        --     x = {
        --       name = "Code Lens",
        --       l = { "<cmd>GoCodeLenAct<cr>", "Toggle Lens" },
        --       a = { "<cmd>GoCodeAction<cr>", "Code Action" },
        --     },
        --   },
        -- }, { prefix = "<leader>", mode = "n", default_options })
        wk.register({
          c = {
            -- name = "Coding",
            j = { "<cmd>'<,'>GoJson2Struct<cr>", "Json to struct" },
          },
        }, { prefix = "<leader>", mode = "v", default_options })
      end, -- nil: use on_attach function defined in go/lsp.lua,
      --      when lsp_cfg is true
      -- if lsp_on_attach is a function: use this function as on_attach function for gopls
      lsp_codelens = true, -- set to false to disable codelens, true by default
      lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
      lsp_diag_hdlr = true, -- hook lsp diag handler
      lsp_diag_virtual_text = { space = 0, prefix = icons.arrows.Diamond }, -- virtual text setup
      lsp_diag_signs = true,
      lsp_diag_update_in_insert = true,
      lsp_document_formatting = false,
      -- set to true: use gopls to format
      -- false if you want to use other formatter tool(e.g. efm, nulls)
      lsp_inlay_hints = {
        enable = true,
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show variable name before type hints with the inlay hints or not
        -- default: false
        show_variable_name = true,
        -- prefix for parameter hints
        parameter_hints_prefix = " ",
        show_parameter_hints = true,
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 6,
        -- The color of the hints
        highlight = "Comment",
      },
      gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
      gopls_remote_auto = true, -- add -remote=auto to gopls
      gocoverage_sign = "█",
      dap_debug = false, -- set to false to disable dap
      dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
      -- false: do not use keymap in go/dap.lua.  you must define your own.
      dap_debug_gui = false, -- set to true to enable dap gui, highly recommended
      dap_debug_vt = false, -- set to true to enable dap virtual text
      build_tags = "", -- set default build tags
      textobjects = true, -- enable default text jobects through treesittter-text-objects
      test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
      run_in_floaterm = false, -- set to true to run in float window.
      -- float term recommended if you use richgo/ginkgo with terminal color
      luasnip = true,
    })
  end,
}

return M
