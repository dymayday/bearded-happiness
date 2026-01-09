return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    behaviour = {
      enable_cursor_planning_mode = true, -- enable cursor planning mode!
    },
    -- add any opts here
    -- provider = "ollama",
    provider = "copilot",
    providers = {

      copilot = {
        extra_request_body = {
          temperature = 0.2, -- Adjust creativity level : 0 to 0.3 is better for coding.
          max_tokens = 128000, -- Adjust based on your needs
        },
        model = "claude-sonnet-4",
        -- model = "gemini-2.5-pro",
        -- model = "claude-3.7-sonnet",
        -- model = "gpt-4o",
        -- model = "o1",
        -- model = "gemini-2.0-flash",
        -- -- Add your new model here
        -- custom_models = {
        --   ["claude-3.5-sonnet"] = {
        --     endpoint = "https://api.githubcopilot.com",
        --     model = "claude-3.5-sonnet",
        --     timeout = 30000,
        --     temperature = 0.2,
        --     max_tokens = 128000,
        --   },
        --   ["gpt-4o"] = {
        --     endpoint = "https://api.githubcopilot.com",
        --     model = "gpt-4o",
        --     timeout = 30000,
        --     temperature = 0.2,
        --     max_tokens = 128000,
        --   },
        --   ["gpt-o1"] = {
        --     endpoint = "https://api.githubcopilot.com",
        --     model = "o1",
        --     timeout = 30000,
        --     temperature = 0.2,
        --     max_tokens = 128000,
        --   },
        --   ["gemini-2.0-flash"] = {
        --     endpoint = "https://api.githubcopilot.com",
        --     model = "gemini-2.0-flash",
        --     timeout = 30000,
        --     temperature = 0.2,
        --     max_tokens = 128000,
        --   },
        -- },
      },
    },
    -- vendors = {},
    -- ollama = {
    --   __inherited_from = "openai",
    --   api_key_name = "",
    --   endpoint = "http://127.0.0.1:11434",
    --   -- model = "qwen2.5-coder:14b", -- Change this to the local model you have (e.g., `llama2`, `gemma`, etc.)
    --   -- model = "gemma3:27b",
    --   model = "gemma3:12b",
    --   -- model = "deepseek-r1:8b",
    --   max_tokens = 128000, -- Adjust based on your needs
    --   -- model = "qwen2.5-coder:32b",
    --   -- model = "deepseek-coder-v2:16b",
    --   -- max_tokens = 32000, -- Adjust based on your needs
    --   -- temperature = 1.0, -- Adjust creativity level
    --   -- temperature = 0.75, -- Adjust creativity level (lower for more deterministic results)
    --   temperature = 0.2, -- Adjust creativity level : 0 to 0.3 is better for coding.
    --   host = "http://localhost:11434", -- Default Ollama API endpoint
    -- },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
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
