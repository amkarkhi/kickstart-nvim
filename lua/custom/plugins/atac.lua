local function find_file_in_dir(dir, filename)
    local handle = io.popen('find "' .. dir .. '"-type d -name "' .. filename .. '"')
    if not handle then
        return nil
    end
    local result = handle:read '*a'
    handle:close()
    if not result or result == '' then
        return nil
    end
    return result:match '^%s*(.-)%s*$' -- Trim whitespace
end

return {
    'NachoNievaG/atac.nvim',
    dependencies = { 'akinsho/toggleterm.nvim' },
    config = function()
        local current_dir = vim.fn.getcwd()
        local atac_dir = find_file_in_dir(current_dir, '.env.atac')
        if atac_dir and vim.fn.isdirectory(atac_dir) == 1 then
            atac_dir = atac_dir
        else
            atac_dir = current_dir .. '/docs/rest'
            vim.fn.mkdir(atac_dir, 'p')
        end
        print(atac_dir)
        require('atac').setup {
            dir = atac_dir, -- By default, the dir will be set as /tmp/atac
        }
    end,
}
