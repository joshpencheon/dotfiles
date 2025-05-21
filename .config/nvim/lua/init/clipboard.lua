-- A note on clipboards: NeoVim's default clipboard provider will
-- try and use `pbcopy` on macOS, but will eventually fall back to
-- tmux's buffer.
--
-- Because we prefer the unnamedplus register, NeoVim will yank to
-- and paste from one of these clipboard buffers by default.
--
-- It is already the case that tmux will use OSC52 codes to tell the
-- terminal emulator to try to update the client clipboard; NeoVim has
-- also had native since 0.10 - emitting OSC52 codes when yanking into
-- the unnamed register. This means things mostly 'just work' when
-- accessing NeoVim over SSH.

-- Use system (+ selection) clipboard by default:
vim.opt.clipboard:prepend { "unnamed", "unnamedplus" }

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function() vim.highlight.on_yank({timeout = 500}) end,
    desc = "Visually highlight yanked region",
    group = vim.api.nvim_create_augroup("YankHighlight", {})
})

-- Don't yank as you paste in visual mode:
vim.keymap.set('v', 'p', '"_dP', { silent = true })
