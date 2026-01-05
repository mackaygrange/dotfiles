require('lualine').setup
{
    options =
    {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes =
        {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh =
        {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections =
    {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff'},
        lualine_c =
        {
            {
                'diagnostics',
                sources = {'nvim_lsp'},
                sections = {'error', 'warn', 'info', 'hint'},
                diagnostics_color =
                {
                    error = 'DiagnosticError',
                    warn = 'DiagnosticWarn',
                    info = 'DiagnosticInfo',
                    hint = 'DiagnosticHing',
                },
                symbols =
                {
                    error = '',
                    warn = '',
                    info = '',
                    hint = '󰌵',
                },
                colored = false,
                update_in_insert = true,
                always_visible = false,
            },
            {'filename', path = 0, file_status = true, shorting_target = 40},
        },
        lualine_x = { {'encoding', fmt = string.upper }, 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections =
    {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {'lazy', 'fugitive', 'mason', 'neo-tree'},
}
