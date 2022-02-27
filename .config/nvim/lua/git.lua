-- Inline git blame (could this also be done with the signs plugin?)
vim.g.gitblame_message_template = ' « <date>: <summary> [<sha>]'
vim.g.gitblame_date_format = '%r'
vim.g.gitblame_highlight_group = 'GitBlame'

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '∙' },
    change = { text = '∙' },
    delete = { text = '∙' },
    topdelete = { text = '∙' },
    changedelete = { text = '∙' },
  },
}

