-- A note on clipboards: NeoVim's default clipboard provider will
-- try and use `pbcopy` on macOS, but will eventually fall back to
-- tmux's buffer.
--
-- Because we prefer the unnamedplus register, NeoVim will yank to
-- and paste from one of these clipboard buffers by default.
--
-- It is already the case that tmux will use OSC52 codes to tell iTerm
-- to try to update the client clipboard; we use a plugin to do something
-- similar in NeoVim - emitting OSC52 codes when yanking into the unnamed
-- register. This means things mostly 'just work' when accessing NeoVim
-- over SSH.

-- Use system (+ selection) clipboard by default:
vim.cmd [[ set clipboard^=unnamed,unnamedplus ]]

vim.cmd [[
  let g:oscyank_silent=1

  " Automatically emit the OSC52 control sequence when yanking:
  augroup oscyank
    autocmd!
    autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif
  augroup END
]]

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout = 500})
  augroup end
]]

-- Don't yank as you paste in visual mode:
vim.cmd [[
  vnoremap p "_dP
]]
