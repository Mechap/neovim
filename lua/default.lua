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
    showmode = true,                        -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,                         -- always show tabs
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
    cursorline = false,                       -- highlight the current line
    number = true,                           -- set numbered lines
    relativenumber = false,                  -- set relative numbered lines
    numberwidth = 2,                         -- set number column width to 2 {default 4}
    signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
    wrap = false,                            -- display lines as one long line
    scrolloff = 8,                           -- is one of my fav
    sidescrolloff = 8,
    guifont = "monospace:h17",               -- the font used in graphical neovim applications
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"

vim.opt.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.cmd([[highlight clear SignColumn]])

--vim.cmd([[set laststatus=0]])

-- Telescope keymap
vim.api.nvim_set_keymap("n", "fe", ":Telescope fd<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fb", ":Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "ft", ":Telescope treesitter<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fd", ":Telescope lsp_document_symbols<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fr", ":Telescope lsp_references<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fs", ":Telescope lsp_dynamic_workspace_symbols<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "fg", ":Telescope git_status<CR>", { noremap = true })

-- Latex compilation
vim.api.nvim_set_keymap("n", "le", ":!zsh ./compile.sh<CR>", { noremap = true })

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    --show_current_context_start = true,
    show_end_of_line = true,
    buftype_exclude = { "terminal" },
    filetype_exclude = { "dashboard" },
}

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
vim.g.dashboard_preview_command = 'chafa -c 256 --fg-only --symbols braille'
vim.g.dashboard_preview_file = '~/.config/nvim/LAINHADN3.gif'
vim.g.dashboard_preview_file_height = 23
vim.g.dashboard_preview_file_width = 28

vim.cmd([[hi PmenuSbar guibg=none]])
vim.cmd([[hi PmenuThumb guibg=none]])

require'nvim-tree'.setup {
}
