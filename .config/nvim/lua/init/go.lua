require('go').setup()

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function(args)
      require('go.format').goimport()
    end,
    desc = "Run gofmt + goimport on save",
    group = vim.api.nvim_create_augroup("GoImport", {})
})
