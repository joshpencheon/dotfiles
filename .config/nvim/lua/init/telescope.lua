local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local telescope_custom_actions = {}

-- From: https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1225975038
function telescope_custom_actions.multiopen(prompt_bufnr, method)
    local edit_file_cmd_map = {
        vertical = "vsplit",
        horizontal = "split",
        tab = "tabedit",
        default = "edit",
    }
    local edit_buf_cmd_map = {
        vertical = "vert sbuffer",
        horizontal = "sbuffer",
        tab = "tab sbuffer",
        default = "buffer",
    }
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 1 then
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, picker.original_win_id)

        for i, entry in ipairs(multi_selection) do
            local filename, row, col

            if entry.path or entry.filename then
                filename = entry.path or entry.filename

                row = entry.row or entry.lnum
                col = vim.F.if_nil(entry.col, 1)
            elseif not entry.bufnr then
                local value = entry.value
                if not value then
                    return
                end

                if type(value) == "table" then
                    value = entry.display
                end

                local sections = vim.split(value, ":")

                filename = sections[1]
                row = tonumber(sections[2])
                col = tonumber(sections[3])
            end

            local entry_bufnr = entry.bufnr

            if entry_bufnr then
                if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                    vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
                end
                local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
                pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
            else
                local command = i == 1 and "edit" or edit_file_cmd_map[method]
                if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                    filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                    pcall(vim.cmd, string.format("%s %s", command, filename))
                end
            end

            if row and col then
                pcall(vim.api.nvim_win_set_cursor, 0, { row, col - 1 })
            end
        end
    else
        actions["select_" .. method](prompt_bufnr)
    end
end

function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    telescope_custom_actions.multiopen(prompt_bufnr, "vertical")
end
function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
    telescope_custom_actions.multiopen(prompt_bufnr, "horizontal")
end
function telescope_custom_actions.multi_selection_open(prompt_bufnr)
    telescope_custom_actions.multiopen(prompt_bufnr, "default")
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
    local in_git_repo = vim.fn.systemlist"git rev-parse --is-inside-work-tree"[1] == 'true'
    if in_git_repo then
        builtin.git_files(args)
    else
        builtin.find_files(args)
    end
end

--Add leader shortcuts
vim.keymap.set('n', '<leader>w', [[<cmd>w<CR>]], { silent = true })
vim.keymap.set('n', '<leader>q', [[<cmd>bd<CR>]], { silent = true })

vim.keymap.set('n', '<leader>b', builtin.buffers, { silent = true })
vim.keymap.set('n', '<leader>o', git_or_find_files, { silent = true })
vim.keymap.set('n', '<leader>O', function() builtin.find_files({previewer = false}) end, { silent = true })
vim.keymap.set('n', '<leader>p', function() builtin.oldfiles({cwd_only = true}) end, { silent = true })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { silent = true })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { silent = true })
vim.keymap.set('n', '<leader>A', builtin.grep_string, { silent = true })
vim.keymap.set('n', '<leader>a', builtin.live_grep, { silent = true })
vim.keymap.set("n", "<leader>t", [[<cmd>TroubleToggle<cr>]], { silent = true })

