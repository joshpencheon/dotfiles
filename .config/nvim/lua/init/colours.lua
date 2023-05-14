vim.cmd [[
  let g:srcery_inverse=0
  colorscheme srcery

  set termguicolors
  set noshowmode " Don't show '--INSERT--' etc

  highlight Normal         guibg=black
  highlight LineNr         guibg=black
  highlight CursorLine     guibg=black
  highlight CursorLineNr   guibg=black
  highlight VertSplit      guibg=black guifg=#918175

  highlight Visual guibg=darkgreen

  highlight TabLineSel    guifg=white    guibg=black gui=bold
  highlight TabLineActive guifg=#999999  guibg=black gui=NONE
  highlight TabLine       guifg=#555555  guibg=black gui=NONE
  highlight TabLineFill   guibg=black

  highlight Statusline     guifg=white   guibg=#191919 gui=bold
  highlight StatusLineGit  guifg=#98BC37 guibg=#191919 gui=bold
  highlight StatusLineHost guifg=#5A41BA guibg=#191919 gui=bold
  highlight StatuslineNC   guifg=#555555 guibg=#191919 gui=NONE

  highlight StatusLine_insert  guibg=skyblue    gui=bold guifg=black
  highlight StatusLine_visual  guibg=darkgreen  gui=bold
  highlight StatusLine_replace guibg=darkred    gui=bold
  highlight StatusLine_command guibg=darkorange gui=bold guifg=black

  highlight TermCursor   guifg=#BB0000
  highlight TermCursorNC guibg=#550000

  highlight NonText    guifg=#333333
  highlight SpecialKey guifg=#333333

  highlight DiagnosticError guifg=Black guibg=Red3
  highlight DiagnosticWarn  guifg=Black guibg=DarkOrange3
  highlight DiagnosticInfo  guifg=Black guibg=LightBlue3
  highlight DiagnosticHint  guifg=Black guibg=SlateGrey

  highlight SignColumn guibg=black

  highlight IncSearch guibg=#333333

  highlight GitSignsAdd    guifg=green
  highlight GitSignsChange guifg=yellow
  highlight GitSignsDelete guifg=red
]]


