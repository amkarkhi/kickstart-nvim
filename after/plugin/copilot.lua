local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

vim.g.copilot_proxy = 'socks5://127.0.0.1:8086'
vim.g.copilot_workspace_folders = { vim.fn.getcwd() }

vim.keymap.set('i', '<leader>]', '<Plug>(copilot-next)', opts 'Copilot: Next suggestion')
vim.keymap.set('i', '<leader>[', '<Plug>(copilot-previous)', opts 'Copilot: Previous suggestion')
vim.keymap.set('i', '<leader>/', '<Plug>(copilot-suggest)', opts 'Copilot: Suggest')

vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)', opts 'Copilot: Accept word')
vim.keymap.set('i', '<C-K>', '<Plug>(copilot-accept-line)', opts 'Copilot: Accept line')
