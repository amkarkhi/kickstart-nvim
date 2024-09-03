vim.opt.spell = false

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'go', 'markdown', 'text' },
    callback = function()
        vim.opt.spell = true
        vim.opt.spelllang = 'en_us'
        vim.opt.spelloptions = 'camel'
        vim.opt.spellcapcheck = ''
        vim.api.nvim_command 'highlight SpellBad gui=undercurl guisp=clear'
    end,
})

vim.opt.spellfile = vim.fn.expand '~/.config/nvim/spell/en.utf-8.add'
