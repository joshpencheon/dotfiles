-- use system (+ selection) clipboard by default, unless
-- running in an SSH session; in which case, nvim 0.11+
-- will automatically enable the OSC52 clipboard provider
-- for the unnamed registers.
if not vim.env.SSH_TTY then
  vim.opt.clipboard:prepend { "unnamed", "unnamedplus" }
end

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function() vim.highlight.on_yank({timeout = 500}) end,
    desc = "Visually highlight yanked region",
    group = vim.api.nvim_create_augroup("YankHighlight", {})
})

-- Don't yank as you paste in visual mode:
vim.keymap.set('v', 'p', '"_dP', { silent = true })
