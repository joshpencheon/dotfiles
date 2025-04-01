-- Magic status bar style:
vim.cmd [[
  function! RemoteHost()
    if len($SSH_CLIENT . $SSH_TTY) > 0 && len($TMUX) == 0
      return system("echo -n `whoami`@`hostname -s`")
    else
      return ""
    endif
  endfunc

  function! MagicStatus(n, focus)
    let mode   = mode()
    let active = winnr() == a:n

    if a:focus == 0
      " de-emphasise all status lines when Vim looses focus
      let group = 'StatusLineNC'
      let git_group = group
      let host_group = group
    elseif active
      " Style just the status line of the active window:
      if mode == 'i'
        let group     = 'StatusLineInsert'
        let git_group = group
        let host_group = group
      elseif mode == 'v' || mode == 'V' || mode == "\<C-v>"
        let group = 'StatusLineVisual'
        let git_group = group
        let host_group = group
      elseif mode == 'r' || mode == 'R'
        let group = 'StatusLineReplace'
        let git_group = group
        let host_group = group
      else
        let group     = 'StatusLine'
        let git_group = 'StatusLineGit'
        let host_group = 'StatusLineHost'
      endif
    else
      " de-emphasise all non-active windows.
      let group = 'StatusLineNC'
      let git_group = group
      let host_group = group
    endif

    let relative_path = expand("%:~:.")

    if len(relative_path) > 0
      let title = (active ? '»' : '«') . ' %{expand("%:~:.")} ' . (active ? '«' : '»')
    else
      let title = ""
    endif

    return '%#' . group . '# ' . title . (active ? '%=%#' . git_group . '#%{FugitiveHead(8)}%#' . group . '#  %l:%v %#' . host_group . '#%{RemoteHost()}' : '')
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

