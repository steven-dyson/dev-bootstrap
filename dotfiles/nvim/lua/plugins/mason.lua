return {
  "mason-org/mason.nvim",
  opts = {
    ensure_installed = {
      -- Formatters
      "stylua",
      "prettier",
      "prettierd",
      "gofumpt",
      "goimports",
      "shfmt",
      "sqlfluff",
      "taplo",
      -- Linters
      "markdownlint-cli2",
      "markdown-toc",
      "golangci-lint",
      "dotenv-linter",
      "shellcheck",
      "hadolint",
      "trivy",
      "vacuum",
      -- LSP Servers
      "lua-language-server",
      "gopls",
      "bash-language-server",
      "tailwindcss-language-server",
      "svelte-language-server",
      "astro-language-server",
      "vtsls",
      "pyright",
      "marksman",
      "templ",
      -- DAP
      "delve",
      "debugpy",
    },
  },
}
