-- import lspsaga safely
local saga_status, lspsaga = pcall(require, "lspsaga")
if not saga_status then
  print("lsp_saga not found!") -- print error if lspsaga not installed
end

-- saga.init_lsp_saga({
lspsaga.setup({
  -- keybinds for navigation in lspsaga window
  move_in_saga = { prev = "<C-k>", next = "<C-j>" },
  -- use enter to open file with finder
  finder_action_keys = {
    open = "<CR>",
  },
  -- use enter to open file with definition preview
  definition_action_keys = {
    edit = "<CR>",
  },
})

-- Config example from https://github.com/LoneExile/nvim/blob/main/lua/user/lsp/integrate/lspSaga.lua
local config = {
  preview = {
    lines_above = 0,
    lines_below = 10,
  },
  scroll_preview = {
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  request_timeout = 20000,
  finder = {
    layout = { "float" },
    edit = { "o", "<CR>" },
    vsplit = "v",
    split = "h",
    tabe = "t",
    tabnew = "r",
    quit = { "q", "<ESC>" },
  },
  definition = {
    edit = "<C-w>oo",
    vsplit = "<C-w>ov",
    split = "<C-w>os",
    tabe = "<C-w>ot",
    quit = "q",
    close = "<Esc>",
  },
  code_action = {
    num_shortcut = true,
    keys = {
      quit = "q",
      exec = "<CR>",
    },
  },
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
    debounce = 3,
  },
  diagnostic = {
    twice_into = false,
    show_code_action = true,
    show_source = true,
    keys = {
      exec_action = "o",
      quit = "q",
    },
  },
  rename = {
    quit = "<C-c>",
    exec = "<CR>",
    in_select = true,
  },
  outline = {
    win_position = "right",
    win_with = "",
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = "o",
      expand_collapse = "u",
      quit = "q",
    },
  },
  callhierarchy = {
    show_detail = false,
    keys = {
      edit = "e",
      vsplit = "s",
      split = "i",
      tabe = "t",
      jump = "o",
      quit = "q",
      expand_collapse = "u",
    },
  },
  symbol_in_winbar = {
    enable = false,
    separator = " ",
    hide_keyword = true,
    show_file = false,
    folder_level = 2,
  },
  ui = {
    theme = "round",
    -- border type can be single,double,rounded,solid,shadow.
    border = "rounded",
    winblend = 0,
    expand = "",
    collapse = "",
    preview = " ",
    code_action = "💡",
    diagnostic = "🐞",
    incoming = " ",
    outgoing = " ",
    colors = {
      --float window normal bakcground color
      normal_bg = "none",
      --title background color
      title_bg = "#afd700",
      red = "#e95678",
      magenta = "#b33076",
      orange = "#FF8700",
      yellow = "#f7bb3b",
      green = "#afd700",
      cyan = "",
      blue = "#61afef",
      purple = "#CBA6F7",
      white = "#d1d4cf",
      black = "#1c1c19",
    },
    kind = {},
  },
}
-- lspsaga.setup(config)
