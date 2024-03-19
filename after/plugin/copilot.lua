local opts = { noremap = true, silent = true }

vim.keymap.set('i', '<leader>]', '<Plug>(copilot-next)', opts)
vim.keymap.set('i', '<leader>[', '<Plug>(copilot-previous)', opts)
vim.keymap.set('i', '<leader>/', '<Plug>(copilot-suggest)', opts)
vim.keymap.set('i', '<leader>q', '<Plug>(copilot-ask)', opts)
