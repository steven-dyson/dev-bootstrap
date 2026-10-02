return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint-cli2" },
      go = { "golangcilint" },
      env = { "dotenv_linter" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")

    -- Configure linters by filetype
    lint.linters_by_ft = opts.linters_by_ft or {}

    -- Customize golangcilint to include build tags
    local golangcilint = require("lint.linters.golangcilint")
    table.insert(golangcilint.args, "--build-tags=integration,e2e")
  end,
}
