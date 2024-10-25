require('kanagawa').setup({
    -- transparent = true,         -- do not set background color
    -- dimInactive = true,         -- dim inactive window `:h hl-NormalNC`
    colors = {
      theme = {
        all = {
          ui = {
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
        TabLine = { fg = theme.ui.nontext, bg = theme.ui.bg },
        TabLineSel = { fg = theme.ui.fg, bg = theme.ui.bg, bold = true },
        TabLineFill = { link = 'TabLine' },

        Whitespace  = { fg = theme.ui.bg_p2 },

        -- Custom style for the magic statusbar:
        StatusLine = { fg = theme.ui.fg, bg = theme.ui.bg_m3 },
        StatusLineInsert = { fg = palette.sumiInk0, bg = palette.springGreen },
        StatusLineVisual = { fg = palette.sumiInk0, bg = palette.springBlue },
        StatusLineReplace = { fg = palette.sumiInk0, bg = palette.waveRed },
        StatusLineCommand = { fg = palette.sumiInk0, bg = palette.surimiOrange },
        StatusLineGit = { fg = palette.dragonGreen, bg = theme.ui.bg_m3 },
        StatusLineHost = { fg = theme.ui.special, bg = theme.ui.bg_m3 },

        -- Draw a line under Treesitter Context showing code nesting:
        TreesitterContext = { link = 'Normal' },
        TreesitterContextBottom = { underline = true, sp = theme.ui.nontext },
        TreesitterContextLineNumber = { link = "LineNr" }
      }
    end
})

-- Deprioritise LSP-provided highlights (prefer treesitter for now)
vim.highlight.priorities.semantic_tokens = 75

vim.cmd [[
colorscheme kanagawa

set termguicolors
set noshowmode " Don't show '--INSERT--' etc
]]
