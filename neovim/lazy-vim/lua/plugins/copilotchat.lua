return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      max_tokens = 128000, -- Default is usually around 2000, adjust as needed
      model = "claude-3.7-sonnet",
      temperature = 0.2, -- Adjust creativity level : 0 to 0.3 is better for coding.
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
