local git = require 'gitsigns'
-- fuigitive
vim.keymap.set('n', '<leader>gw', ':Git<CR>', { desc = 'Git Status' })
vim.keymap.set('n', '<leader>gg', ':lua _LAZYGIT_TOGGLE()<CR>', { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>gj', git.next_hunk, { desc = 'Next Hunk' })
vim.keymap.set('n', '<leader>gk', git.prev_hunk, { desc = 'Prev Hunk' })
vim.keymap.set('n', '<leader>gl', git.blame_line, { desc = 'Blame' })
vim.keymap.set('n', '<leader>gp', git.preview_hunk, { desc = 'Preview Hunk' })
vim.keymap.set('n', '<leader>gr', git.reset_hunk, { desc = 'Reset Hunk' })
vim.keymap.set('n', '<leader>gR', git.reset_buffer, { desc = 'Reset Buffer' })
vim.keymap.set('n', '<leader>gs', git.stage_hunk, { desc = 'Stage Hunk' })
vim.keymap.set('n', '<leader>gu', git.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
vim.keymap.set('n', '<leader>gP', ':Git pull<CR>', { desc = 'Git pull' })
vim.keymap.set('n', '<leader>gu', ':Git fetch --all<CR>', { desc = 'Fetch All' })
vim.keymap.set('n', '<leader>gB', function()
    local branch = vim.fn.input 'Branch name: '
    if branch ~= '' then
        vim.cmd('Git checkout -b' .. branch)
    end
end, { desc = 'Checkout to a new branch' })
vim.keymap.set('n', '<leader>go', ':Telescope git_status<CR>', { desc = 'Open changed file' })
vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { desc = 'Checkout branch' })
vim.keymap.set('n', '<leader>gc', ':Telescope git_commits<CR>', { desc = 'Checkout commit' })
vim.keymap.set('n', '<leader>gdd', ':Gitsigns diffthis HEAD<CR>', { desc = 'Diff with head' })
vim.keymap.set('n', '<leader>gt', ':UndotreeToggle<CR>', { desc = 'undo tree' })

vim.keymap.set('n', '<leader>gds', ':Gvdiffsplit!<CR>', { desc = 'Git Diff Split' })
--check if is gvdiffsplit screen create a function to call diffget//3 and diffget//2
vim.keymap.set('n', '<leader>gdp', ':diffget //3<CR>', { desc = 'Diffget//3' })
vim.keymap.set('n', '<leader>gdc', ':diffget //2<CR>', { desc = 'Diffget//2' })
