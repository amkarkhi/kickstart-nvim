local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- keymap('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- keymap('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- keymap('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- keymap('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- resize windows with hjkl
keymap('n', '<C-Up>', ':resize +2<CR>', { desc = 'Resize window height +2', silent = true })
keymap('n', '<C-Down>', ':resize -2<CR>', { desc = 'Resize window height -2', silent = true })
keymap('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Resize window width -2', silent = true })
keymap('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Resize window width +2', silent = true })

-- Press jk fast to exit insert mode
keymap('i', 'jk', '<ESC>', opts)
keymap('i', 'kj', '<ESC>', opts)

-- Stay in indent mode
keymap('v', '<', '<gv^', opts)
keymap('v', '>', '>gv^', opts)

-- Move text up and down
-- keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
-- keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)
keymap('v', 'p', '"_dP', opts)

-- Visual Block --
-- Move text up and down
-- keymap('x', '<A-j>', ":m '>+1<CR>gv=gv", opts)
-- keymap('x', 'J', ":m '>+1<CR>gv=gv", opts)
-- keymap('x', 'K', ":m '<-2<CR>gv=gv", opts)
-- keymap('x', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- prime
keymap('n', 'J', 'mzJ`z', opts)
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)
keymap('n', 'n', 'nzzzv', opts)
keymap('n', 'N', 'Nzzzv', opts)

keymap('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

keymap('n', '[c', function()
    require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true })

keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Explorer' })
