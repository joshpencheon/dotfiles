-- Low-invasive diagnostics via builtin:
vim.diagnostic.config {
  float = true,
  severity_sort = true,
  signs = false,
  underline = true,
  update_in_insert = false,
  virtual_text = false
}

vim.api.nvim_create_autocmd("CursorHold,CursorHoldI", {
    pattern = "*",
    callback = function(args)
      vim.diagnostic.open_float({ scope = "cursor" }, { focus = false })
    end,
    desc = "Show floating window with any LSP diagnostics under the cursor",
})

-- Use trouble for more details:
require("trouble").setup {
    icons = false,
    fold_open = "▾",
    fold_closed = "▸",
    indent_lines = true,
    signs = {
        error       = "error",
        warning     = "warn",
        hint        = "hint",
        information = "info"
    },
    use_diagnostic_signs = false
}
