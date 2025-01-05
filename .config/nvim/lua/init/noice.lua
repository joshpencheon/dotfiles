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
      win_options = {
        winblend = 0,
      },
    },
  },
})
