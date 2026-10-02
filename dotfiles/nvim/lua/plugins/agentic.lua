return {
  "carlos-algms/agentic.nvim",

  opts = {
    -- Any ACP-compatible provider works. Built-in: "claude-agent-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp" | "copilot-acp" | "auggie-acp" | "mistral-vibe-acp" | "cline-acp" | "goose-acp"
    provider = "codex-acp", -- setting the name here is all you need to get started
    acp_providers = {
      ["codex-acp"] = {
        command = "codex-acp",
        args = {
          "-c",
          'model_reasoning_effort="medium"',
          "-c",
          'model_verbosity="low"',
          "-c",
          'personality="pragmatic"',
          "-c",
          'approval_policy="on-request"',
          "-c",
          'sandbox_mode="workspace-write"',
          "-c",
          'plan_mode_reasoning_effort="high"',
          "-c",
          'service_tier="fast"',
          "-c",
          'web_search="live"',
        },
      },
      ["opencode-acp"] = {
        command = "opencode",
        args = { "acp" },
      },
    },
    keymaps = {
      widget = {
        change_mode = {
          {
            "<leader>am",
            mode = { "i", "n", "v" },
          },
        },
        switch_model = "<leader>aM",
        change_thought_level = "<leader>at",
        open_options = "<leader>ao",
        switch_provider = "<leader>ap",
        select_session = "<leader>as",
        next_session = "<leader>a]",
        prev_session = "<leader>a[",
        destroy_session = "<leader>aD",
      },
    },
  },

  keys = {
    { "<leader>a", group = "Agentic" },
    {
      "<leader>aa",
      function()
        require("agentic").toggle()
      end,
      mode = { "n", "v" },
      desc = "Toggle Agentic Chat",
    },
    {
      "<leader>aq",
      function()
        require("agentic").close()
      end,
      mode = { "n", "v" },
      desc = "Close Agentic Chat",
    },
    {
      "<leader>ac",
      function()
        require("agentic").add_selection_or_file_to_context()
      end,
      mode = { "n", "v" },
      desc = "Add file or selection to Agentic context",
    },
    {
      "<leader>ap",
      function()
        require("agentic").switch_provider()
      end,
      mode = { "n", "v" },
      desc = "Switch Agentic provider",
    },
    {
      "<leader>aP",
      function()
        require("agentic").new_session_with_provider()
      end,
      mode = { "n", "v" },
      desc = "New Agentic session with provider",
    },

    {
      "<leader>an",
      function()
        require("agentic").new_session()
      end,
      mode = { "n", "v" },
      desc = "New Agentic Session",
    },
    {
      "<leader>as",
      function()
        require("agentic").select_session()
      end,
      mode = { "n", "v" },
      desc = "Select Agentic session",
    },
    {
      "<leader>a]",
      function()
        require("agentic").next_session()
      end,
      mode = { "n", "v" },
      desc = "Next Agentic session",
    },
    {
      "<leader>a[",
      function()
        require("agentic").prev_session()
      end,
      mode = { "n", "v" },
      desc = "Previous Agentic session",
    },
    {
      "<leader>ar", -- ai Restore
      function()
        require("agentic").restore_session()
      end,
      desc = "Agentic Restore session",
      silent = true,
      mode = { "n", "v" },
    },
    {
      "<leader>al",
      function()
        require("agentic").rotate_layout()
      end,
      desc = "Rotate Agentic layout",
      mode = { "n", "v" },
    },
    {
      "<leader>ax",
      function()
        require("agentic").stop_generation()
      end,
      desc = "Stop Agentic generation",
      mode = { "n", "v" },
    },
    {
      "<leader>ad", -- ai Diagnostics
      function()
        require("agentic").add_current_line_diagnostics()
      end,
      desc = "Add current line diagnostic to Agentic",
      mode = { "n" },
    },
    {
      "<leader>aD", -- ai all Diagnostics
      function()
        require("agentic").add_buffer_diagnostics()
      end,
      desc = "Add all buffer diagnostics to Agentic",
      mode = { "n" },
    },
  },
}
