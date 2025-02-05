local prompts = {
  -- Code related prompts
  Commit = "Generate a Conventional Commits style commit message for the following changes. Use a compact and terse style. For things like dependencies and other verbose changes, bundle these changes into an overall change description. These are the changes:",
  Explain = "Please explain how the following code works.",
  Review = "You are a world-class software engineer. You have been assigned to review the following code. You will provide actionable feedback while having a supportive tone. Focus on issues and problems, not mincing words. Highlight the issues and address each separately. If one issue is very similar to another, group them together. If one issue has effect on another, explain how. Give feedback on things that could be refactored or improved with common design patterns. Also, ensure any new code has tests if applicable (i.e. not for dependencies, version changes, configuration, or similar). These are the changes:",
  IntegrationTest = "You are a world-class software engineer. You have been asked to write appropriate integration tests using JEST for the changes. Tests should only be made for our source code, not for dependencies, version changes, configuration, or similar. We are aiming for full code coverage, if possible. If there are no applicable changes, don't write any tests. Only provide code, no explanations. These are the changes:",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    event = "VeryLazy",
    opts = {
      show_help = "no",
      prompts = prompts,
      model = 'claude-3.5-sonnet', -- GPT model to use, see ':CopilotChatModels' for available models
    },
    keys = {
      { "<leader>ccb", ":CopilotChatBuffer<cr>",      desc = "CopilotChat - Buffer" },
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>",   desc = "CopilotChat - Generate tests" },
      {
        "<leader>ccT",
        "<cmd>CopilotChatVsplitToggle<cr>",
        desc = "CopilotChat - Toggle Vsplit", -- Toggle vertical split
      },
      {
        "<leader>ccv",
        ":CopilotChatVisual",
        mode = "x",
        desc = "CopilotChat - Open in vertical split",
      },
      {
        "<leader>ccc",
        ":CopilotChatToggle<CR>",
        mode = { "n", "x" },
        desc = "CopilotChat - Run in-place code",
      },
      {
        -- Get a fix for the diagnostic message under the cursor.
        "<leader>ccf",
        "<cmd>CopilotChatFixDiagnostic<cr>",
        desc = "CopilotChat - Fix diagnostic",
      },
    }
  },
}
