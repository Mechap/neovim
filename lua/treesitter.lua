require 'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "all",

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = { "javascript" },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    ident = {
        enable = true
    }
}
-- latex
vim.cmd [[ hi! link @text.environment GruvboxAqua ]]
vim.cmd [[ hi! link @text.environment.name GruvboxYellow ]]
vim.cmd [[ hi! link @namespace GruvboxPurpleBold ]]
vim.cmd [[ hi! link @lsp.type.namespace GruvboxPurpleBold ]]
vim.cmd [[ hi! link @text.math GruvboxOrange ]]
vim.cmd [[ hi! link @attribute GruvboxOrange ]]
vim.cmd [[ hi! link @variable GruvboxFg0 ]]
vim.cmd [[ hi! link @type.qualifier GruvboxRed ]]
vim.cmd [[ hi! link @type.builtin GruvboxRed ]]
vim.cmd [[ hi! link @type GruvboxYellow ]]
vim.cmd [[ hi! link texOnlyMath GruvboxFg0 ]]

vim.cmd [[ hi! link cStructure GruvboxRed ]]
vim.cmd [[ hi! link cStorageClass GruvboxRed ]]


--[[
require('spellsitter').setup({
    enable = false,
})
]]
-- vim.cmd [[ set spelllang=fr ]]
vim.o.spell = false
