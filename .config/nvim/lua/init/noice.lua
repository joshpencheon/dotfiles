require('noice').setup({
  cmdline = {
    view = "cmdline",
    format = {
      cmdline = { icon = " :" },
      search_down = { icon = " ⌄" },
      search_up = { icon = " ⌃" },
      filter = { icon = " $" },
      lua = { icon = " ☾" },
      help = { icon = " ?" },
      input = { icon = "" },
    },
  },
  messages = {
    view_search = 'mini',
  },
  format = {
    level = {
      icons = {
        error = "✖",
        warn = "▼",
        info = "●",
      },
    },
  },
  popupmenu = {
    enabled = false,
  },
  views = {
    mini = {
      position = {
        row = -1,
        col = 0,
      },
      size = {
        width = "100%",
      },
      win_options = {
        winblend = 0,
      },
    },
  },
  -- Attempt to get ':!' filter output printing again:
  routes = {
    {
      view = "mini",
      filter = {
        event = "msg_show",
        kind = { "shell_out", "shell_err" },
      },
    },
  }
})
