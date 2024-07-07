-- vim.g.copilot_proxy = 'http://127.0.0.1:8119'

-- vim.g.copilot_proxy = Proxy

vim.g.copilot_workspace_folders = { vim.fn.getcwd() }

vim.keymap.set('i', '<leader>]', '<Plug>(copilot-next)')
vim.keymap.set('i', '<leader>[', '<Plug>(copilot-previous)')
vim.keymap.set('i', '<leader>/', '<Plug>(copilot-suggest)')

vim.keymap.set('i', '<C-.>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-,>', '<Plug>(copilot-accept-line)')
