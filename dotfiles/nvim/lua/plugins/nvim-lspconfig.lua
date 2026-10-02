return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers.bashls = {}

    opts.servers.tailwindcss = vim.tbl_deep_extend("force", opts.servers.tailwindcss or {}, {
      filetypes = {
        "html",
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "templ",
        "astro",
        "svelte",
      },
      init_options = {
        userLanguages = {
          templ = "html",
        },
      },
    })

    -- Configure gopls with build tags
    opts.servers.gopls = vim.tbl_deep_extend("force", opts.servers.gopls or {}, {
      settings = {
        gopls = {
          buildFlags = { "-tags=integration,e2e" },
        },
      },
    })
  end,
}
