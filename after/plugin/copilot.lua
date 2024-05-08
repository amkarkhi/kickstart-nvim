local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

vim.g.copilot_proxy = 'http://127.0.0.1:8119'
vim.g.copilot_workspace_folders = { vim.fn.getcwd() }

vim.keymap.set('i', '<leader>]', '<Plug>(copilot-next)', opts 'Copilot: Next suggestion')
vim.keymap.set('i', '<leader>[', '<Plug>(copilot-previous)', opts 'Copilot: Previous suggestion')
vim.keymap.set('i', '<leader>/', '<Plug>(copilot-suggest)', opts 'Copilot: Suggest')

vim.keymap.set('i', '<C-.>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-,>', '<Plug>(copilot-accept-line)')
