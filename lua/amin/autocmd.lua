-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- run on startup and wait for a key to be pressed
-- vim.api.nvim_create_autocmd('loginEvent', {
--   desc = 'Run on startup and wait for a key to be pressed',
--   group = vim.api.nvim_create_augroup('kickstart-wait-for-key', { clear = true }),
--   pattern = 'VimEnter',
--   callback = function()
--     vim.cmd 'startinsert'
--     print 'Press any key to continue'
--   end,
-- })
--

vim.api.nvim_command 'autocmd ColorScheme * highlight brakpointhl guibg=#8B4500'
vim.api.nvim_command 'autocmd ColorScheme * highlight debugCurrent guibg=#004545'
vim.api.nvim_command 'autocmd ColorScheme * highlight debugError guibg=#8B0000'
