local neotest = require('neotest')

neotest.setup({
  adapters = {
    require('neotest-rspec')
  },
  -- Discovery can be VERY slow on large projects
  discovery = { enabled = false },
  -- Disable adding separate diagnostics
  diagnostic = { enabled = false },
  icons = {
    failed = '✘',
    passed = '✔',
    running = '➜',
    running_animated ={'⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'},
    skipped = '✘',
    unknown = '◌',
    watching = '○'
  },
})

vim.keymap.set('n', '<leader>sr', function()
  neotest.run.run()
end, { desc = 'run nearest test', silent = true })
vim.keymap.set('n', '<leader>sa', function()
  neotest.run.run(vim.fn.expand('%'))
end, { desc = 'run all tests in file', silent = true })
vim.keymap.set('n', '<leader>st', function()
  neotest.summary.toggle()
end, { desc = 'toggle neotest summary pane', silent = true })
vim.keymap.set('n', '<leader>ss', function()
  neotest.output.open({ short = true })
end, { desc = 'show floating window for nearest test result', silent = true })
vim.keymap.set('n', '[s', function()
  neotest.jump.prev({ status = 'failed' })
end, { desc = 'jump to the previous failing test', silent = true })
vim.keymap.set('n', ']s', function()
  neotest.jump.next({ status = 'failed' })
end, { desc = 'jump to the next failing test', silent = true })
