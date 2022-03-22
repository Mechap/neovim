--[[
local filename = require('tabby.filename')
local util = require('tabby.util')

local hl_tabline = util.extract_nvim_hl('GruvboxAqua')
local hl_normal = util.extract_nvim_hl('GruvboxGreen')
local hl_tabline_sel = util.extract_nvim_hl('GruvboxOrange')
local hl_tabline_fill = util.extract_nvim_hl('TabLineFill')

local function tab_label(tabid, active)
    local icon = active and '' or ''
    local number = vim.api.nvim_tabpage_get_number(tabid)
    local name = util.get_tab_name(tabid)
    return string.format(' %s %d: %s ', icon, number, name)
end

local function tab_label_no_fallback(tabid, active)
    local icon = active and '' or ''
    local fallback = function()
        return ''
    end
    local number = vim.api.nvim_tabpage_get_number(tabid)
    local name = util.get_tab_name(tabid, fallback)
    if name == '' then
        return string.format(' %s %d ', icon, number)
    end
    return string.format(' %s %d: %s ', icon, number, name)
end

local function win_label(winid, top)
    local icon = top and '' or ''
    return string.format(' %s %s ', icon, filename.unique(winid))
end

-- presets
local presets = {
    active_wins_at_tail = {
        hl = 'TabLineFill',
        layout = 'active_wins_at_tail',
        head = {
            { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
            { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        active_tab = {
            label = function(tabid)
                return {
                    tab_label(tabid, true),
                    hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
        },
        inactive_tab = {
            label = function(tabid)
                return {
                    tab_label(tabid),
                    hl = { fg = hl_tabline.fg, bg = hl_tabline.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        top_win = {
            label = function(winid)
                return {
                    win_label(winid, true),
                    hl = 'TabLine',
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        win = {
            label = function(winid)
                return {
                    win_label(winid),
                    hl = 'TabLine',
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        tail = {
            { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
        },
    },
    active_wins_at_end = {
        hl = 'TabLineFill',
        layout = 'active_wins_at_end',
        head = {
            { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
            { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        active_tab = {
            label = function(tabid)
                return {
                    tab_label(tabid, true),
                    hl = { fg = hl_normal.fg, bg = hl_normal.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_normal.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_normal.bg, bg = hl_tabline_fill.bg } },
        },
        inactive_tab = {
            label = function(tabid)
                return {
                    tab_label(tabid),
                    hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
        },
        top_win = {
            label = function(winid)
                return {
                    win_label(winid, true),
                    hl = 'TabLine',
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        win = {
            label = function(winid)
                return {
                    win_label(winid),
                    hl = 'TabLine',
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
    },
    active_tab_with_wins = {
        hl = 'TabLineFill',
        layout = 'active_tab_with_wins',
        head = {
            { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg, style = 'italic' } },
            { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        active_tab = {
            label = function(tabid)
                return {
                    tab_label(tabid, true),
                    hl = { fg = hl_normal.fg, bg = hl_normal.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_normal.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_normal.bg, bg = hl_tabline_fill.bg } },
        },
        inactive_tab = {
            label = function(tabid)
                return {
                    tab_label(tabid),
                    hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
        },
        top_win = {
            label = function(winid)
                return {
                    win_label(winid, true),
                    hl = 'TabLine',
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        win = {
            label = function(winid)
                return {
                    win_label(winid),
                    hl = 'TabLine',
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
    },
    tab_with_top_win = {
        hl = 'TabLineFill',
        layout = 'tab_with_top_win',
        head = {
            { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg, style = 'italic' } },
            { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        active_tab = {
            label = function(tabid)
                return {
                    tab_label_no_fallback(tabid, true),
                    hl = { fg = hl_normal.fg, bg = hl_normal.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_normal.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_normal.bg, bg = hl_tabline_fill.bg } },
        },
        inactive_tab = {
            label = function(tabid)
                return {
                    tab_label_no_fallback(tabid),
                    hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
        },
        active_win = {
            label = function(winid)
                return {
                    win_label(winid, true),
                    hl = 'TabLine',
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        win = {
            label = function(winid)
                return {
                    win_label(winid),
                    hl = 'TabLine',
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
    },
    tab_only = {
        hl = 'TabLineFill',
        layout = 'tab_only',
        head = {
            { '  ', hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
            { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        active_tab = {
            label = function(tabid)
                return {
                    tab_label(tabid, true),
                    hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
        },
        inactive_tab = {
            label = function(tabid)
                return {
                    tab_label(tabid, false),
                    hl = { fg = hl_tabline.fg, bg = hl_tabline.bg, style = 'bold' },
                }
            end,
            left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
            right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
    },
}

require("tabby").setup({
    tabline = presets.active_wins_at_end,
})
]]

--vim.cmd([[hi! link TabLineFill GruvboxYellow]])

local palette = {
    accent = '#83a598', -- blue
    accent_sec = '#a89984', -- fg4
    bg = '#3c3836', -- bg1
    bg_sec = '#504945', -- bg2
    fg = '#d5c4a1', -- fg2
    fg_sec = '#bdae93', -- fg3
}

local filename = require('tabby.filename')
local cwd = function()
    return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
end
local tabname = function(tabid)
    return vim.api.nvim_tabpage_get_number(tabid)
end
local line = {
    hl = { fg = palette.fg, bg = palette.bg },
    layout = 'active_wins_at_tail',
    head = {
        { cwd, hl = { fg = palette.bg, bg = palette.accent } },
        { '', hl = { fg = palette.accent, bg = palette.bg } },
    },
    active_tab = {
        label = function(tabid)
            return {
                '  ' .. tabname(tabid) .. ' ',
                hl = { fg = palette.bg, bg = palette.accent_sec, style = 'bold' },
            }
        end,
        left_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
        right_sep = { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
    },
    inactive_tab = {
        label = function(tabid)
            return {
                '  ' .. tabname(tabid) .. ' ',
                hl = { fg = palette.fg, bg = palette.bg_sec, style = 'bold' },
            }
        end,
        left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
        right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
    },
    top_win = {
        label = function(winid)
            return {
                '  ' .. filename.unique(winid) .. ' ',
                hl = { fg = palette.fg, bg = palette.bg_sec },
            }
        end,
        left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
        right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
    },
    win = {
        label = function(winid)
            return {
                '  ' .. filename.unique(winid) .. ' ',
                hl = { fg = palette.fg, bg = palette.bg_sec },
            }
        end,
        left_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
        right_sep = { '', hl = { fg = palette.bg_sec, bg = palette.bg } },
    },
    tail = {
        { '', hl = { fg = palette.accent_sec, bg = palette.bg } },
        { '  ', hl = { fg = palette.bg, bg = palette.accent_sec } },
    },
}
require('tabby').setup({ tabline = line })

vim.api.nvim_set_keymap("n", "ta", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "to", ":tabonly<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tn", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "tp", ":tabp<CR>", { noremap = true })
