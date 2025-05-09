-- Low-invasive diagnostics via builtin:
vim.diagnostic.config {
  float = {
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
    focusable = false
  },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = false
}

vim.cmd [[
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticSignWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticSignInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticSignHint
]]

vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float({ scope = "cursor" }, { focus = false })
    end,
    desc = "Show floating window with any LSP diagnostics under the cursor",
})

-- Use trouble for more details:
require("trouble").setup {
  icons = {
    indent = {
      middle = " ",
      last = " ",
      top = " ",
      ws = "│  ",
      fold_open = "▾",
      fold_closed = "▸",
    },
  },
  modes = {
    diagnostics = {
      groups = {
        { "filename", format = "{file_icon} {basename:Title} {count}" },
      },
    },
  },
}

vim.keymap.set("n", "<leader>t", [[<cmd>Trouble diagnostics toggle<cr>]], { silent = true })
vim.keymap.set("n", "<leader>T", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { silent = true })

vim.keymap.set('n', ']t', function()
  vim.diagnostic.jump({ count = 1, float = false })
end, { desc = 'Jump to the next troublesome diagnostic' })

vim.keymap.set('n', '[t', function()
  vim.diagnostic.jump({ count = -1, float = false })
end, { desc = 'Jump to the previous troublesome diagnostic' })
