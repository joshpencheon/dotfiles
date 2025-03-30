require("mason").setup()
require("mason-lspconfig").setup()

vim.o.wildmode = 'longest,list'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.pumheight = 8

-- Defer diagnostics that arrive in insert mode:
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = false
  }
)

-- Use a sharp border with `FloatBorder` highlights:
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded"
  }
)

-- dump out to: lua print(vim.lsp.get_log_path())
-- vim.lsp.set_log_level("TRACE")

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>cs', function() require('telescope.builtin').lsp_document_symbols() end, opts)
  vim.keymap.set('n', '<leader>cS', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end, opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format()' ]]
end

require('lspconfig.ui.windows').default_options.border = 'rounded'

-- nvim-cmp supports additional completion capabilities
-- beyond those built in to NeoVim's LSP.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig['clangd'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig['emmet_language_server'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig['eslint'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig['html'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "eruby", "html", "templ" }
}
lspconfig['gopls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig['lua_ls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig['pyright'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig['rust_analyzer'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" }
    }
  },
}
lspconfig['ruby_lsp'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  -- RubyLSP should set up a "composed bundle" itself
  -- cmd = { "bundle", "exec", "ruby-lsp" }
}
lspconfig['tailwindcss'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig['terraformls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig['tflint'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
lspconfig['ts_ls'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local snippy = require 'snippy'

-- Support expanding ${VISUAL} snippets
vim.keymap.set('x', '<Tab>', require('snippy.mapping').cut_text, { remap = true })
vim.keymap.set('s', '<Tab>', snippy.next, { remap = true })
vim.keymap.set('s', '<S-Tab>', snippy.previous, { remap = true })
vim.keymap.set('s', '<BS>', '<c-o>c', { remap = true })

-- nvim-cmp setup
local cmp = require 'cmp'
local compare = require 'cmp.config.compare'

-- Use treesitter to highlight docs floating window
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cmp_docs',
  callback = function()
    vim.treesitter.start(0, 'markdown')
  end,
})

-- cmp's "custom" entries view uses `vim.fn.setcmdline`
-- when selecting an item when suggesting cmdline completions.
-- However, this doesn't seem to trigger the "cmdline_show"
-- event (which it should), which is needed by Noice's
-- externalised cmdline UI for it to know it needs to redraw.
-- This hacky wrapper wiggles the cursor to force a redraw.
local keymap = require('cmp.utils.keymap')
local force_cmdline_redraw = function(cmp_action)
  local original_cmp_action = cmp[cmp_action]
  cmp[cmp_action] = function()
    original_cmp_action()

    vim.api.nvim_feedkeys(keymap.t(' <bs>'), 'ni', false)
  end
end
force_cmdline_redraw("select_next_item")
force_cmdline_redraw("select_previous_item")

local should_insert_whitespace = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

cmp.setup {
  completion = {
    autocomplete = false,
    completeopt = vim.o.completeopt,
  },
  experimental = {
    ghost_text = true
  },
  view = {
    entries = {
      name = 'custom',
      selection_order = 'near_cursor'
    }
  },
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_jump(1) then
        snippy.next()
      elseif snippy.can_expand() then
        snippy.expand()
      elseif should_insert_whitespace() then
        fallback()
      else
        cmp.complete()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end,
  },
  sources = {
    {
      name = 'buffer',
      option = {
        -- complete from all buffers:
        get_bufnrs = function() return vim.api.nvim_list_bufs() end
      }
    },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'snippy' },
    -- set group index to 0 to skip loading LuaLS completions:
    { name = 'lazydev', group_index = 0 },
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      compare.kind, -- demote buffer-based "Text" objects below LSP-provided suggestions
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.sort_text,
      compare.length,
      compare.order,
    },
  },
}

cmp.setup.filetype('gitcommit', {
  sources = {
    { name = 'buffer' },
  }
})

-- Use buffer source for `/`
cmp.setup.cmdline('/', {
  completion = {
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
    },
  },
  sources = {
    { name = 'buffer' }
  },
  mapping = cmp.mapping.preset.cmdline()
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  completion = {
    keyword_length = 2,
    autocomplete = {
      cmp.TriggerEvent.TextChanged,
    },
  },
  sources = cmp.config.sources({
    { name = 'path', option = { trailing_slash = true } }
  }, {
    { name = 'cmdline', option = { treat_trailing_slash = false } }
  }),
  mapping = cmp.mapping.preset.cmdline({
    ['<CR>'] = {
      c = function(fallback)
        if cmp.get_active_entry() then cmp.confirm() end
        fallback()
      end
    },
  })
})
