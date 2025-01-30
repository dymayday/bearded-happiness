Parse_curl_args_func = function(opts, code_opts)
  return {
    url = opts.endpoint .. "/chat/completions",
    headers = {
      ["Accept"] = "application/json",
      ["Content-Type"] = "application/json",
    },
    body = {
      model = opts.model,
      messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
      max_tokens = 2048,
      stream = true,
    },
  }
end

Parse_response_data_func = function(data_stream, event_state, opts)
  require("avante.providers").openai.parse_response(data_stream, event_state, opts)
end

local create_avante_config = function(model, url)
  return {
    ["api_key_name"] = "",
    endpoint = url,
    model = model,
    parse_curl_args = Parse_curl_args_func,
    parse_response_data = Parse_response_data_func,
  }
end

local create_ollama_config = function(host, model)
  return create_avante_config(model, string.format("http://%s:11434/v1", host))
end

local create_openai_config = function(model)
  local oai = create_avante_config(model, "https://api.openai.com/v1/")
  oai["api_key_name"] = "OPENAI_API_KEY"
  return oai
end

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = "qwen",
    openai = {
      model = "o1-preview",
    },
    vendors = {
      ---@type AvanteProvider
      qwen = create_ollama_config("vale", "qwen2.5-coder:32b"),
      codestral = create_ollama_config("vale", "codestral"),
      commandR = create_ollama_config("vale", "command-r"),
      yi = create_ollama_config("vale", "yi:34b"),
      ---@type AvanteProvider
      o1 = create_openai_config("o1-preview"),
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
-- return {
--   "yetone/avante.nvim",
--   event = "VeryLazy",
--   lazy = false,
--   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
--   opts = {
--     -- add any opts here
--   },
--   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
--   build = "make",
--   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
--   dependencies = {
--     "stevearc/dressing.nvim",
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--     --- The below dependencies are optional,
--     "echasnovski/mini.pick", -- for file_selector provider mini.pick
--     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
--     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
--     "ibhagwan/fzf-lua", -- for file_selector provider fzf
--     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
--     "zbirenbaum/copilot.lua", -- for providers='copilot'
--     {
--       -- support for image pasting
--       "HakonHarnes/img-clip.nvim",
--       event = "VeryLazy",
--       opts = {
--         provider = "ollama",
--         vendors = {
--           ollama = {
--             __inherited_from = "openai",
--             api_key_name = "",
--             endpoint = "http://127.0.0.1:11434/v1",
--             model = "deepseek-coder-v2:16b",
--           },
--         },
--         -- recommended settings
--         default = {
--           embed_image_as_base64 = false,
--           prompt_for_file_name = false,
--           drag_and_drop = {
--             insert_mode = true,
--           },
--           -- required for Windows users
--           use_absolute_path = true,
--         },
--       },
--     },
--     {
--       -- Make sure to set this up properly if you have lazy=true
--       "MeanderingProgrammer/render-markdown.nvim",
--       opts = {
--         file_types = { "markdown", "Avante" },
--       },
--       ft = { "markdown", "Avante" },
--     },
--   },
-- }
