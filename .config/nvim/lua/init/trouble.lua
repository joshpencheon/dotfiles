-- Low-invasive diagnostics via builtin:
vim.diagnostic.config {
  float = {
    focusable = false
  },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = false
}

function vim.diagnostic.toggle()
  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end

vim.cmd [[
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint
]]

vim.api.nvim_create_autocmd({"CursorHold","CursorHoldI"}, {
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
    use_diagnostic_signs = false,
    cycle_results = false
}

vim.keymap.set("n", "<leader>t", [[<cmd>TroubleToggle<cr>]], { silent = true })
vim.keymap.set("n", "<leader>T", vim.diagnostic.toggle, { silent = true })
