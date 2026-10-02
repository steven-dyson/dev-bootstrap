return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}

    local parsers = {
      "templ",
      "http",
      "svelte",
      "html",
      "css",
      "javascript",
      "typescript",
      "sql",
    }

    for _, parser in ipairs(parsers) do
      if not vim.tbl_contains(opts.ensure_installed, parser) then
        table.insert(opts.ensure_installed, parser)
      end
    end

    opts.auto_install = true

    -- Use SQL parser for SOQL files
    vim.treesitter.language.register("sql", "soql")
  end,
}
