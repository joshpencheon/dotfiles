require("oil").setup({
  skip_confirm_for_simple_edits = true,
  prompt_save_on_select_new_entry = false,
  win_options = {
    number = false,
  },
  preview_win = {
    win_options = {
      number = true
    },
  },
  float = {
    max_width = 0.8,
    max_height = 0.9,
    preview_split = "above"
  },
  keymaps = {
    ['<leader>w'] = "<CMD>write<CR>",
  },
})

vim.keymap.set("n", "-", "<CMD>Oil --float<CR>",
  { desc = "Open parent directory" })
