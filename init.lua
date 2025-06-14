--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

require 'amin.options'
require 'amin.keymap'
require 'amin.autocmd'
require 'amin.plugins'
require 'amin.commands'

-- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

-- vim.cmd 'colorscheme catppuccin-mocha'
-- vim.cmd 'colorscheme catppuccin-mocha'
vim.cmd 'colorscheme tokyonight-moon'

vim.g['clang_format#detect_style_file'] = 1
-- vim.g.have_nerd_font = true
-- vim.cmd 'colorscheme tokyonight'

-- vim: ts=2 sts=2 sw=2 et
