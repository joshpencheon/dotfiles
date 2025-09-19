require("mason").setup()
require("mason-lspconfig").setup()

vim.diagnostic.config({
  -- Defer diagnostics that arrive in insert mode:
  update_in_insert = false,
})

-- LSP settings
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

-- nvim-cmp supports additional completion capabilities
-- beyond those built in to NeoVim's LSP.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('clangd', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config('emmet_language_server', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config('eslint', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config('html', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "eruby", "html", "templ" }
})
vim.lsp.config('gopls', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config('lua_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config('pyright', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config('rust_analyzer', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" }
    }
  },
})
vim.lsp.config('ruby_lsp', {
  on_attach = on_attach,
  capabilities = capabilities,
  -- RubyLSP should set up a "composed bundle" itself
  -- cmd = { "bundle", "exec", "ruby-lsp" }
})
vim.lsp.config('tailwindcss', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config('terraformls', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config('tflint', {
  on_attach = on_attach,
  capabilities = capabilities,
})
vim.lsp.config('ts_ls', {
  on_attach = on_attach,
  capabilities = capabilities,
})
