local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local colors = {
    bg = '#202328',
    fg = '#bbc2cf',
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#98be65',
    orange = '#FF8800',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#51afef',
    red = '#ec5f67',
}

local mode_color = {
    n = colors.red,
    i = colors.green,
    v = colors.blue,
    [''] = colors.blue,
    V = colors.blue,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red,
}

local setColorByMode = function()
    return { fg = mode_color[vim.fn.mode()], bg = colors.bg }
end

local setReverseColorByMode = function()
    return { fg = colors.bg, bg = mode_color[vim.fn.mode()] }
end

local diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    sections = { 'error', 'warn' },
    symbols = { error = ' ', warn = ' ' },
    colored = false,
    update_in_insert = false,
    always_visible = true,
    color = setColorByMode,
}

local diff = {
    'diff',
    colored = false,
    symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
    cond = hide_in_width,
}
local obsession = {
    '%{ObsessionStatus("  ","")}',
    color = setColorByMode,
    padding = { left = 0, right = 0 },
}

local mode = {
    'mode',
    fmt = function(str)
        return ' ' .. str .. '--'
    end,
    color = setColorByMode,
    padding = { left = 0, right = 0 },
}

local filetype = {
    'filetype',
    icons_enabled = true,
    -- icon = nil,
    colored = false,
}

local branch = {
    'branch',
    icons_enabled = true,
    icon = '',
    color = setColorByMode,
    padding = { left = 1, right = 0 },
}

local location = {
    'location',
    padding = 0,
    color = setReverseColorByMode,
}

local progress = function()
    local current_line = vim.fn.line '.'
    local total_lines = vim.fn.line '$'
    local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local ProgressBar = {
    progress,
    color = setReverseColorByMode,
}

local spaces = function()
    return 'spc: ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth')
end

return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline' },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { branch, diagnostics },
            lualine_b = { obsession, mode },
            lualine_c = {},
            -- lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_x = { diff, spaces, 'encoding', filetype, 'fileformat', 'filesize' },
            --lualine_y = { filePath, location },
            lualine_y = { location },
            lualine_z = { ProgressBar },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
            -- lualine_z = { filePath },
        },
        tabline = {},
        extensions = {},
    },
}
