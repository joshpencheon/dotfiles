local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = #picker:get_multi_selection()
    if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
    end
    actions.send_selected_to_qflist(prompt_bufnr)
    vim.cmd("cfdo " .. open_cmd)
end
function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "split")
end
function telescope_custom_actions.multi_selection_open(prompt_bufnr)
    telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
        ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<CR>"] = telescope_custom_actions.multi_selection_open,
        ["<C-x>"] = telescope_custom_actions.multi_selection_open_split,
        ["<C-v>"] = telescope_custom_actions.multi_selection_open_vsplit,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
    },
  },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

local builtin = require('telescope.builtin')

function git_or_find_files(args)
    if not pcall(builtin.git_files, args) then
        builtin.find_files(args)
    end
end

--Add leader shortcuts
vim.keymap.set('n', '<leader>w', [[<cmd>w<CR>]], { silent = true })

vim.keymap.set('n', '<leader>b', builtin.buffers, { silent = true })
vim.keymap.set('n', '<leader>o', git_or_find_files, { silent = true })
vim.keymap.set('n', '<leader>O', function() builtin.find_files({previewer = false}) end, { silent = true })
vim.keymap.set('n', '<leader>p', builtin.oldfiles, { silent = true })
vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { silent = true })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { silent = true })
vim.keymap.set('n', '<leader>A', builtin.grep_string, { silent = true })
vim.keymap.set('n', '<leader>a', builtin.live_grep, { silent = true })

