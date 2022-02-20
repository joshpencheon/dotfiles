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
