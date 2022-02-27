-- Magic status bar style:
vim.cmd [[
  function! MagicStatus(n, focus)
    let mode   = mode()
    let active = winnr() == a:n

    if a:focus == 0
      " de-emphasise all status lines when Vim looses focus
      let group = 'StatusLineNC'
      let git_group = group
    elseif active
      " Style just the status line of the active window:
      if mode == 'i'
        let group     = 'StatusLine_insert'
        let git_group = group
      elseif mode == 'v' || mode == 'V' || mode == "\<C-v>"
        let group = 'StatusLine_visual'
        let git_group = group
      elseif mode == 'r' || mode == 'R'
        let group = 'StatusLine_replace'
        let git_group = group
      elseif mode == 'c'
        let group = 'StatusLine_command'
        let git_group = group
      else
        let group     = 'StatusLine'
        let git_group = 'StatusLineGit'
      endif
    else
      " de-emphasise all non-active windows.
      let group = 'StatusLineNC'
      let git_group = group
    endif

    return '%#' . group . '#' . (active ? '»' : '«') . ' %f ' . (active ? '«' : '»') . (active ? '%=%#' . git_group . '#%{fugitive#head(8)}%#' . group . '#  %l:%v ' : '')
  endfunction

  function! s:RefreshStatuses(focus)
    for nr in range(1, winnr('$'))
      call setwinvar(nr, '&statusline', '%!MagicStatus(' . nr . ', ' . a:focus .')')
    endfor
  endfunction

  augroup status
    autocmd!
    autocmd FocusLost                                              * call <SID>RefreshStatuses(0)
    autocmd FocusGained,VimEnter,WinEnter,BufWinEnter,CmdlineEnter * call <SID>RefreshStatuses(1)
  augroup END
]]

