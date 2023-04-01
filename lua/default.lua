local options = {
    backup = false,                          -- creates a backup file
    clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
    cmdheight = 2,                           -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0,                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                  -- the encoding written to a file
    hidden = true,                           -- required to keep multiple buffers and open multiple buffers
    hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    mouse = "a",                             -- allow the mouse to be used in neovim
    pumheight = 10,                          -- pop up menu height
    showmode = true,                         -- we don't need to see things like -- INSERT -- anymore
    showtabline = 1,                         -- always show tabs
    smartcase = true,                        -- smart case
    smartindent = true,                      -- make indenting smarter again
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of current window
    swapfile = false,                        -- creates a swapfile
    termguicolors = true,                    -- set term gui colors (most terminals support this)
    timeoutlen = 100,                        -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true,                         -- enable persistent undo
    updatetime = 300,                        -- faster completion (4000ms default)
    writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true,                        -- convert tabs to spaces
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation
    tabstop = 4,                             -- insert 2 spaces for a tab
    cursorline = false,                      -- highlight the current line
    number = true,                           -- set numbered lines
    relativenumber = false,                  -- set relative numbered lines
    numberwidth = 2,                         -- set number column width to 2 {default 4}
    signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
    wrap = true,                             -- display lines as one long line
    linebreak = true,                        -- display lines as one long line
    scrolloff = 8,                           -- is one of my fav
    sidescrolloff = 8,
    --guifont = "monospace:h17", -- the font used in graphical neovim applications
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"

vim.opt.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode

--vim.o.laststatus = 0

--vim.cmd([[ set laststatus = 0 ]])
--vim.cmd([[ set tabline=0 ]])
--vim.cmd([[ hi! link TabLineFill GruvboxFg0 ]])

require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        operators = true,
        comments = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true,    -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
})

vim.cmd([[colorscheme gruvbox]])

vim.cmd([[highlight clear SignColumn]])

vim.cmd([[hi! link VertSplit GruvboxFg0]])

--vim.cmd([[set laststatus=0]])

-- Telescope keymap
vim.api.nvim_set_keymap("n", "fe", ":Telescope file_browser<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fv", ":Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fb", ":Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "ft", ":Telescope treesitter<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fd", ":Telescope lsp_document_symbols<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fr", ":Telescope lsp_references<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fs", ":Telescope lsp_dynamic_workspace_symbols<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fg", ":Telescope git_status<CR>", { noremap = true })

-- Latex compilation
-- vim.api.nvim_set_keymap("n", "le", ":!make<CR>", { noremap = true })

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = false,
    show_end_of_line = true,
    buftype_exclude = { "terminal", "mini" },
    filetype_exclude = { "dashboard", "packer", "mini", "alpha", "haskell" },
}

vim.cmd([[ hi! link IndentBlanklineContextChar GruvboxFg0 ]])

-- map helper
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map(
    "n",
    "<C-l>",
    [[ (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n" <BAR> redraw<CR>]],
    { silent = true, expr = true }
)


--[[
vim.g.dashboard_custom_section = {
a = {
description = { "  Find File          " },
command = "Telescope find_files",
},
b = {
description = { "  New File           " },
command = ":ene!",
},
c = {
description = { "  Recent Projects    " },
command = "Telescope projects",
},
d = {
description = { "  Recently Used Files" },
command = "Telescope oldfiles",
},
}
vim.g.dashboard_custom_footer = {"to the stars!!!1!"}
vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_executive = "telescope"
--vim.g.dashboard_preview_command = 'chafa -c 256 --fg-only --symbols braille'
--vim.g.dashboard_preview_file = './LAINHADN3.gif'
vim.g.dashboard_preview_file_height = 23
vim.g.dashboard_preview_file_width = 28
]]
vim.cmd([[hi PmenuSbar guibg=none]])
vim.cmd([[hi PmenuThumb guibg=none]])

vim.cmd([[ hi! link NormalFloat GruvboxFg0 ]])
vim.cmd([[ hi! link NoiceCmdlinePopupBorder GruvboxAqua ]])
vim.cmd([[ hi! link NoiceCmdlineIcon GruvboxAqua ]])
--vim.cmd([[ hi! link CursorLine GruvboxFg0 ]])
--vim.cmd([[ hi! link CursorLineNr GruvboxFg0 ]])

-- require 'nvim-tree'.setup {}

vim.cmd([[ set guifont=JetbrainsMono\ Nerd\ Font:h11 ]])

vim.o.termguicolors = true
vim.o.cursorline = false
vim.o.number = true
vim.o.relativenumber = true

vim.cmd([[set spell]])
vim.cmd([[set spelllang=fr]])

require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key"
            }
        }
    },
    pickers = {
        -- Default configuration for builtin pickers goes here: picker_name = { picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
            theme = "ivy",
        },
        lsp_document_symbols = {
            theme = "ivy",
        },
        live_grep = {
            theme = "ivy",
        },
        treesitter = {
            theme = "ivy",
        },
        git_status = {
            theme = "ivy",
        }
    },
    extensions = {
        file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    }
}

require("telescope").load_extension "file_browser"

vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

vim.cmd [[ set autochdir ]]

local home = os.getenv('HOME')
--[[
require('dashboard').setup {
    theme = 'doom',
    config = {
        header = {
            '                                                              ',
            '    ⢀⣀⣤⣤⣤⠤⢤⣤⣤⣤⣤⣄⣀⡀           ⢀⣠⣤⣄⡀            ⣀⣀⣀⣤⣤⣤⣤⣤⣤⣤⣤⣀⡀   ',
            ' ⢀⣤⠚⠩⠁⡄ ⠠⣤⠒⠒⣂ ⢈⣨⣭⣿⠛⠶⣦⣤⣄⡀   ⢠⣾⡟⠉⠉⠝⠿⠇    ⢀⣠⡤⠔⠒⣻⠟⠋⠩⠉⢁⣀⡀  ⣶  ⠙⡛⠷  ',
            ' ⠸⢟⡠⠒⢊⡤  ⠋⣠ ⠈⣉⣉⣉⣉⣀⣛⣿⡒⠭⡿⢿⣷⣤⣤⣀⣽⣇⣴⠆⣴⡃⢀⣠⣤⠴⣚⣫⡥ ⠒⠛⠁⣀⣉⣉⣙⢏⡉  ⢀⣼⣤⣜⠳⡦⠂  ',
            '   ⠐⠚⠫⣤⠖⢣⣤⡕ ⠉⣩⣤⠔ ⠂⣋⣭⣥⣤⠴⠛⣛⠈⢩⣿⠿⠛⢉  ⡐⠞⠫⢍⠙⣓⠢⠴⣥⣍⣙⠛⢓⡢⢤⣬⠉⠅ ⣤⡜⢛⠻⠛⠉⠁   ',
            '      ⠘⢔⢎⣡⡔⠂⣠⡿⠁⠒⢛⡻⢛⣩⠅  ⠉  ⠚⣯⣄⢠⣿⢀⣾⠇ ⠓ ⠁⠂⠈⠍⠐⠈⡉⣿⠛⣛⠛⠉⣤⣰⣿⣿⡟⠛⠁      ',
            '        ⠙⠛⠐⠚⠋ ⠒⣲⡿⠇⣋        ⢺⡏⠈⣀ ⠉⠈        ⠙⢿⠟⢰⣖⡢ ⠂⠒⠚⠉         ',
            '             ⣴⠛⠅⢀⣾⠟⢃       ⢹⠃⠠⠁⠈⠩         ⢠⣿ ⣀⢹⣿⡷             ',
            '             ⢿⣤⢚⣫⠅         ⢸⠇ ⢚ ⢀         ⣸⡇ ⠉⣿⣿⠇             ',
            '             ⠈⠛⢻⣥⡚⠔⣠⢣⣄⡀    ⢸⡇ ⢘ ⠈ ⠠⠈    ⣀⣰⡿⣧⣄⠾⠋⠁              ',
            '                ⠈⠑⠁        ⠘⣿⡀⣈⣀    ⠈  ⠈⠙⠁                    ',
            '                            ⠘⣷⠁                               ',
            '                             ⠙⣤                               ',
            '                              ⠛⠂                              ',
            '                                                              '
        },
        center = {
            {
                icon = '  ',
                icon_hi = 'Title',
                desc = 'New File                       ',
                desc_hi = 'String',
                key = 'n',
                keymap = 'LDR n',
                key_hi = 'Number',
                action = 'enew'
            },

            {
                icon = ' ',
                icon_hi = 'Title',
                desc = 'Neovim config',
                desc_hi = 'String',
                key = 'nc',
                keymap = 'LDR nc',
                key_hi = 'Number',
                action = 'e ~/.config/nvim'
            },

            {
                icon = '  ',
                icon_hi = 'Title',
                desc = 'Competitive',
                desc_hi = 'String',
                key = 'c',
                keymap = 'LDR c',
                key_hi = 'Number',
                action = 'CphReceive'
            },

            {
                icon = '  ',
                icon_hi = 'Title',
                desc = 'Find Files',
                desc_hi = 'String',
                key = 'f',
                keymap = 'LDR f',
                key_hi = 'Number',
                action = 'Telescope find_files'
            },

            {
                icon = '  ',
                icon_hi = 'Title',
                desc = 'Find History',
                desc_hi = 'String',
                key = 'o',
                keymap = 'LDR o',
                key_hi = 'Number',
                action = 'Telescope oldfiles'
            },
        },
    }
}
--local db = require('dashboard')
-- linux
--db.preview_command = 'chafa -c 256 --fg-only --symbols braille'
--
--db.preview_file_path = home .. '/.config/nvim/LAINHADN3.gif'
--db.preview_file_height = 23
--db.preview_file_width = 28
--db.custom_center = {
--[[
{ icon = '  ',
desc = 'Recently latest session                  ',
shortcut = 'SPC s l',
action = 'SessionLoad' },
{ icon = '  ',
desc = 'Recently opened files                   ',
action = 'DashboardFindHistory',
shortcut = 'SPC f h' },
]]
--[[
{ icon = '  ',
desc = 'Find  File                              ',
action = 'Telescope find_files find_command=rg,--hidden,--files',
shortcut = 'SPC f f' },
{ icon = '  ',
desc = 'File Browser                            ',
action = 'Telescope file_browser',
shortcut = 'SPC f b' },
{ icon = '  ',
desc = 'Find  word                              ',
action = 'Telescope live_grep',
shortcut = 'SPC f w' },
{ icon = '  ',
desc = 'Open Personal dotfiles                  ',
action = 'o /.config/nvim/',
shortcut = 'SPC f d' },
}
]]
--db.custom_header = {
--    [[                               ]],
--    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣴⣦⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
--    [[⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀ ]],
--    [[⠀⠀⠀⠀⣠⣾⣿⣿⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣶⡀⠀⠀⠀⠀ ]],
--    [[⠀⠀⠀⣴⣿⣿⠟⠁⠀⠀⠀⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣦⠀⠀⠀ ]],
--    [[⠀⠀⣼⣿⣿⠋⠀⠀⠀⠀⠀⠛⠛⢻⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣧⠀⠀ ]],
--    [[⠀⢸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⡇⠀ ]],
--    [[⠀⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠀ ]],
--    [[⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡟⢹⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⠀ ]],
--    [[⠀⣿⣿⣷⠀⠀⠀⠀⠀⠀⣰⣿⣿⠏⠀⠀⢻⣿⣿⡄⠀⠀⠀⠀⠀⠀⣿⣿⡿⠀ ]],
--    [[⠀⢸⣿⣿⡆⠀⠀⠀⠀⣴⣿⡿⠃⠀⠀⠀⠈⢿⣿⣷⣤⣤⡆⠀⠀⣰⣿⣿⠇⠀ ]],
--    [[⠀⠀⢻⣿⣿⣄⠀⠀⠾⠿⠿⠁⠀⠀⠀⠀⠀⠘⣿⣿⡿⠿⠛⠀⣰⣿⣿⡟⠀⠀ ]],
--    [[⠀⠀⠀⠻⣿⣿⣧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠏⠀⠀⠀ ]],
--    [[⠀⠀⠀⠀⠈⠻⣿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⠟⠁⠀⠀⠀⠀ ]],
--    [[⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀ ]],
--    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
--}

--db.custom_header = {
--    [[                                   ]],
--    [[        ⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀  ]],
--    [[      ⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷ ]],
--    [[     ⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿ ]],
--    [[    ⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿ ]],
--    [[  ⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿ ]],
--    [[ ⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿ ]],
--    [[ ⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟ ]],
--    [[ ⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣ ]],
--    [[ ⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾ ]],
--    [[ ⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿ ]],
--    [[ ⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿ ]],
--    [[ ⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿ ]],
--    [[ ⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿ ]],
--    [[  ⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋  ⣾⡌⢠⣿⡿⠃ ]],
--    [[ ⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉            ]],
--    [[                                   ]],
--}

--vim.cmd([[ hi! link DashboardHeader GruvboxGreen ]])


--db.hide_statusline = true
--db.hide_tabline = true
--db.hide_winbar = true

--require 'alpha'.setup(require 'alpha.themes.dashboard'.config)

require('noice').setup({
    cmdline = {
        enabled = false,        -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {},              -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = {
            -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
            -- view: (default is cmdline view)
            -- opts: any options passed to the view
            -- icon_hl_group: optional hl_group for the icon
            -- title: set to anything or empty string to hide
            cmdline = { pattern = "^:", icon = "", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
            lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
            input = {}, -- Used by input()
            -- lua = false, -- to disable a format, set to `false`
        },
    },
    messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = false,             -- enables the Noice messages UI
        view = "notify",             -- default view for messages
        view_error = "notify",       -- view for errors
        view_warn = "notify",        -- view for warnings
        view_history = "messages",   -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
    },
    popupmenu = {
        enabled = false, -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "nui", -- backend to use to show regular cmdline completions
        ---@type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
    },
    -- default options for require('noice').redirect
    -- see the section on Command Redirection
    ---@type NoiceRouteConfig
    redirect = {
        view = "popup",
        filter = { event = "msg_show" },
    },
    notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = false,
        view = "notify",
    },
    lsp = {
        progress = {
            enabled = false,
        },
        override = {
            -- override the default lsp markdown formatter with Noice
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            -- override the lsp markdown formatter with Noice
            ["vim.lsp.util.stylize_markdown"] = true,
            -- override cmp documentation with Noice (needs the other options to work)
            ["cmp.entry.get_documentation"] = true,
        },
        hover = {
            enabled = true,
            view = nil, -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {},  -- merged with defaults from documentation
        },
        signature = {
            enabled = true,
            auto_open = {
                enabled = true,
                trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                throttle = 50,  -- Debounce lsp signature help request by 50ms
            },
            view = nil,         -- when nil, use defaults from documentation
            ---@type NoiceViewOptions
            opts = {},          -- merged with defaults from documentation
        },
        message = {
            -- Messages shown by lsp servers
            enabled = true,
            view = "notify",
            opts = {},
        },
        -- defaults for hover and signature help
        documentation = {
            view = "hover",
            ---@type NoiceViewOptions
            opts = {
                lang = "markdown",
                replace = true,
                render = "plain",
                format = { "{message}" },
                win_options = { concealcursor = "n", conceallevel = 3 },
            },
        },
    },
    markdown = {
        hover = {
            ["|(%S-)|"] = vim.cmd.help,                       -- vim help links
            ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
        },
        highlights = {
            ["|%S-|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
        },
    },
    health = {
        checker = true, -- Disable if you don't want health checks to run
    },
    smart_move = {
        -- noice tries to move out of the way of existing floating windows.
        enabled = true, -- you can disable this behaviour here
        -- add any filetypes here, that shouldn't trigger smart move.
        excluded_filetypes = { "notify" },
    },
    ---@type NoicePresets
    presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = false,        -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
    -- throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    ---@type NoiceConfigViews
    views = {}, ---@see section on views
    ---@type NoiceRouteConfig[true = {}, --- @see section on routes
    ---@type table<string, NoiceFilter>
    status = {}, --- @see section on statusline components
    ---@type NoiceFormatOptions
    format = {}, --- @see section on formatting
})

require("leap").add_default_mappings()
require('neoscroll').setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
        '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = true,     -- Disable "Performance Mode" on all buffers.
})

require("smoothcursor").setup {
    autostart = true,
    cursor = "",          -- cursor shape (need nerd font)
    texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
    linehl = nil,            -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
    type = "default",        -- define cursor movement calculate function, "default" or "exp" (exponential).
    fancy = {
        enable = false,      -- enable fancy mode
        head = { cursor = "", texthl = "SmoothCursor", linehl = nil },
        body = {
            { cursor = "", texthl = "GruvboxRed" },
            { cursor = "", texthl = "GruvboxOrange" },
            { cursor = "●", texthl = "GruvboxYellow" },
            { cursor = "●", texthl = "GruvboxGreen" },
            { cursor = "•", texthl = "GruvboxAqua" },
            { cursor = ".",   texthl = "GruvboxBlue" },
            { cursor = ".",   texthl = "GruvboxPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" }
    },
    speed = 25,               -- max is 100 to stick to your current position
    intervals = 35,           -- tick interval
    priority = 10,            -- set marker priority
    timeout = 3000,           -- timout for animation
    threshold = 3,            -- animate if threshold lines jump
    enabled_filetypes = nil,  -- example: { "lua", "vim" }
    disabled_filetypes = nil, -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
}

--[[
require('fm-nvim').setup {
-- (Vim) Command used to open files
edit_cmd = "edit",

-- See `Q&A` for more info
on_close = {},
on_open = {},

-- UI Options
ui = {
-- Default UI (can be "split" or "float")
default = "float",

float = {
-- Floating window border (see ':h nvim_open_win')
border = "none",

-- Highlight group for floating window/border (see ':h winhl')
float_hl  = "Normal",
border_hl = "FloatBorder",

-- Floating Window Transparency (see ':h winblend')
blend = 0,

-- Num from 0 - 1 for measurements
height = 0.8,
width  = 0.8,

-- X and Y Axis of Window
x = 0.5,
y = 0.5
},

split = {
-- Direction of split
direction = "topleft",

-- Size of split
size = 24
}
},

-- Terminal commands used w/ file manager (have to be in your $PATH)
cmds = {
lf_cmd          = "lf", -- eg: lf_cmd = "lf -command 'set hidden'"
fm_cmd          = "fm",
nnn_cmd         = "nnn",
fff_cmd         = "fff",
twf_cmd         = "twf",
fzf_cmd         = "fzf", -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
fzy_cmd         = "find . | fzy",
xplr_cmd        = "xplr",
vifm_cmd        = "vifm",
skim_cmd        = "sk",
broot_cmd       = "broot",
gitui_cmd       = "gitui",
ranger_cmd      = "ranger",
joshuto_cmd     = "joshuto",
lazygit_cmd     = "lazygit",
neomutt_cmd     = "neomutt",
taskwarrior_cmd = "taskwarrior-tui"
},

-- Mappings used with the plugin
mappings = {
vert_split = "<C-v>",
horz_split = "<C-h>",
tabedit    = "<C-t>",
edit       = "<C-e>",
ESC        = "<ESC>"
},

-- Path to broot config
broot_conf = vim.fn.stdpath("data") .. "/site/pack/packer/start/fm-nvim/assets/broot_conf.hjson"
}
]]
--vim.cmd([[ au BufWrite * :Autoformat ]])
vim.cmd([[ let g:formatdef_latexindent = '"latexindent -m -l localSettings.yaml -"' ]])
--vim.cmd([[ autocmd FileType vim,tex let b:autoformat_autoindent=0 ]])
