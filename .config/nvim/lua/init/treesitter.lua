local installed_parsers = { 'html', 'css', 'javascript', 'ruby', 'rust', 'vimdoc', 'markdown', 'yaml' }

require('nvim-treesitter').install(installed_parsers)

vim.api.nvim_create_autocmd('FileType', {
  pattern = installed_parsers,
  callback = function()
    -- Enable highlighting:
    vim.treesitter.start()
    -- Enable indentation:
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    -- Enable folding:
    vim.wo[0][0].foldmethod = 'expr'
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})

require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    selection_modes = {
      ['@block.outer'] = 'V', -- Linewise selection of outer blocks
    },
  },
  move = {
    set_jumps = true,
  },
}

local select = require('nvim-treesitter-textobjects.select')

vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ab', function() select.select_textobject('@block.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ib', function() select.select_textobject('@block.inner', 'textobjects') end)

require('treesitter-context').setup {
  enable = true,
  max_lines = vim.o.scrolloff,
  line_numbers = true,
  multiline_threshold = 1,
  trim_scope = 'outer',
  mode = 'topline',
}
