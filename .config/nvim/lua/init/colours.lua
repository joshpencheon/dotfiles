require('kanagawa').setup({
    -- transparent = true,         -- do not set background color
    -- dimInactive = true,         -- dim inactive window `:h hl-NormalNC`
    colors = {
      theme = {
        all = {
          ui = {
            bg = "black",
            bg_gutter = "none",
            float = {
              bg = "none",
              bg_border = "none"
            }
          }
        }
      }
    },
    overrides = function(colors)
      local theme = colors.theme
      local palette = colors.palette
      return {
        TelescopeNormal = { bg = theme.ui.bg },

        -- Custom colours for the tabline:
        TabLine = { fg = theme.ui.bg_p2, bg = theme.ui.bg },
        TabLineSel = { fg = theme.ui.fg, bg = theme.ui.bg, bold = true },
        TabLineFill = { link = 'TabLine' },

        Whitespace  = { fg = theme.ui.bg_p1 },

        -- Custom style for the magic statusbar:
        StatusLineInsert = { fg = palette.sumiInk0, bg = palette.dragonGreen },
        StatusLineVisual = { fg = palette.sumiInk0, bg = palette.springBlue },
        StatusLineReplace = { fg = palette.sumiInk0, bg = palette.waveRed },
        StatusLineCommand = { fg = palette.sumiInk0, bg = palette.dragonOrange },
        StatusLineGit = { fg = palette.dragonGreen, bg = theme.ui.bg_m3 },
        StatusLineHost = { fg = theme.ui.special, bg = theme.ui.bg_m3 },
      }
    end
})

vim.cmd [[
colorscheme kanagawa

set termguicolors
set noshowmode " Don't show '--INSERT--' etc
]]
