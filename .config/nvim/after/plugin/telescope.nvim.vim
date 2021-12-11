lua << EOF
local telescope = require('telescope')
local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    previewer = true,
    prompt_prefix = "", -- bug with backspace

    mappings = {
      i = {
        ["<ESC>"] = actions.close,
      },
    }
  }
}

telescope.load_extension('fzf')
EOF

nnoremap <leader>OO <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>AA <cmd>lua require('telescope.builtin').live_grep()<cr>
