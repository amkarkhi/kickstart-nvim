vim.ui.input = require 'snacks.input'
vim.ui.select = require 'snacks.picker.select'

vim.api.nvim_create_user_command('NotifierHistory', function()
    require('snacks').notifier.show_history()
end, { desc = 'Show notification history' })
