-- Detect environment: work vs home
local function is_work_env()
  -- Check for work-specific environment variable or hostname pattern
  -- local work_indicator = os.getenv("WORK_ENV") or os.getenv("SNOWFLAKE_HOME")
  local work_indicator = true
  print(work_indicator)
  if work_indicator then
    return true
  end

  -- Check hostname for work patterns (customize as needed)
  local handle = io.popen("hostname")
  if handle then
    local hostname = handle:read("*a"):lower()
    handle:close()
    -- Adjust these patterns to match your work machine hostnames
    if hostname:match("work") or hostname:match("corp") or hostname:match("enterprise") then
      return true
    end
  end

  return false
end

local default_provider = is_work_env() and "claude-agent-acp" or "codex-acp"

--print(default_provider)

return {
  "carlos-algms/agentic.nvim",

  opts = {
    provider = default_provider,

    acp_providers = {
      ["claude-agent-acp"] = {
        name = "Claude Agent",
        command = "claude-agent-acp",
        args = {},
      },
      ["codex-acp"] = {
        name = "Codex",
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
      ["snowflake-cortex-acp"] = {
        name = "Snowflake Cortex",
        command = "cortex",
        args = { "acp", "serve", "--connection", "cortex-pat" },
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
