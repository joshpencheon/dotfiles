require("mason").setup()
require("mason-lspconfig").setup()

vim.diagnostic.config({
  -- Defer diagnostics that arrive in insert mode:
  update_in_insert = false,
})

vim.lsp.config('*', {
  -- LSP settings:
  on_attach = function(_, bufnr)
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
  end,

  -- nvim-cmp supports additional completion capabilities
  -- beyond those built in to NeoVim's LSP:
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('html', {
  filetypes = { "eruby", "html", "templ" }
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" }
    }
  },
})
