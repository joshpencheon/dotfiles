require('codecompanion').setup({
  ignore_warnings = true, -- for upcoming v18
  strategies = {
    chat = {
      keymaps = {
        send = {
          modes = { n = "<C-CR>", i = "<C-CR>" },
        },
        close = {
          modes = { n = "q", i = "<C-q>" },
        },
      },
    },
  },
})

vim.keymap.set('n', '<leader>cc', [[<cmd>CodeCompanionChat<cr>]], { silent = true })
vim.keymap.set('v', 'cc', [[<cmd>CodeCompanion<cr>]], { silent = true })
