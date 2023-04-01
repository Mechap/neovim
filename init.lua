-- bootstrap lazy
--[[
local lazypath = vim.fn.stdpath("data") .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
]]

require('plugins')
require('default')
require('lsp')
require('tabline')
require('statusline')
require('treesitter')

--[[
vim.api.nvim_set_keymap("n", "ta", ":tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "to", ":tabonly<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tn", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tp", ":tabp<CR>", { noremap = true })
]]

vim.cmd [[ hi! link NoicePopupBorder GruvboxFg0 ]]
