--local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.opt.completeopt = 'menu,menuone,noselect' -- better autocompletion experience

--require("lsp-format").setup {}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


local navic = require("nvim-navic")

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    client.server_capabilities.semanticTokensProvider = true

    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- Set some keybinds conditional on server capabilities
    --[[
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.server_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
  ]]
    -- Set autocommands conditional on server_capabilities
    --[[
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspRefrenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
	]]
    --[[, false)
  end]]
    --require 'lsp_signature'.setup()
    require("lsp-format").on_attach(client)

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

-- Latex lsp
require 'lspconfig'.texlab.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.ltex.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Cmake help
require 'lspconfig'.cmake.setup {}

-- Python setup
require 'lspconfig'.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- ocaml setup
require 'lspconfig'.ocamllsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.hls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "haskell-language-server-wrapper-1.9.0.0", "--lsp" }
    --cmd = { "haskell-language-server-9.2.5\~1.9.1.0", "--lsp" }
}

-- Rust setup
require('rust-tools').setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
})

require('clangd_extensions').setup {
    server = {
        -- options to pass to nvim-lspconfig
        -- i.e. the arguments to require("lspconfig").clangd.setup({})
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "clangd", "--background-index", "-header-insertion=never" }
    },
    extensions = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            only_current_line = false,
            only_current_line_autocmd = "CursorHold",
            show_parameter_hints = true,
            show_parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
            priority = 100,
        },
    },
    ast = {
        role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
        },
        kind_icons = {
            Compound = "",
            Recovery = "",
            TranslationUnit = "",
            PackExpansion = "",
            TemplateTypeParm = "",
            TemplateTemplateParm = "",
            TemplateParamObject = "",
        },
        highlights = {
            detail = "Comment",
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}

require 'lspconfig'.gopls.setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
})

require('neodev').setup()
require 'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Replace"
            }
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
}

--[[
require("clangd_extensions").setup {
    server = {
        -- options to pass to nvim-lspconfig
        -- i.e. the arguments to require("lspconfig").clangd.setup({})
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {"clangd", "--background-index", "-header-insertion=never"}
    },
    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- Whether to show hover actions inside the hover window
        -- This overrides the default hover handler
        hover_with_actions = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- whether to show variable name before type hints with the inlay hints or not
            show_variable_name = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
        },
    }
}
]]
--local luadev = require('lua-dev').setup({})
--lspconfig.sumneko_lua.setup(luadev)

-- luasnip setup
local luasnip = require 'luasnip'
require("luasnip/loaders/from_vscode").lazy_load()

--[[
luasnip.config.set_config({
    history = true,
    update_events = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})
]]
-- nvim-cmp setup
local lspkind = require('lspkind')

--[[
local cmp = require 'cmp'
cmp.setup {
spippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            with_text = false,
        })
    }
}
]]
local cmp = require 'cmp'

local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
}

local cmp_window = require('cmp.utils.window')
function cmp_window:has_scrollbar()
    return false
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    window = {
        documentation = {
            --border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
            winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
        },
        completion = {
            scrollbar = '|',
            --border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
            winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
            scrollbar = false,
        }
    },
    experimental = {
        ghost_text = true,
    },
    formatting = {
        format = function(_, vim_item)
            vim_item.kind = (kind_icons[vim_item.kind] or '') .. ' ' .. vim_item.kind
            return vim_item
        end,
        --[[
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = '...',
            --preset = 'codicons',
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
            })
        }),
        ]]
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    }),
    sources = cmp.config.sources({
        -- { name = 'latex_symbolx' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    }),
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            options = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})

--vim.cmd([[ autocmd InsertLeave * lua if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] then require("luasnip").unlink_current() end ]])

vim.cmd([[hi! link DiagnosticSignWarn GruvboxYellow]])
vim.cmd([[hi! link DiagnosticSignError GruvboxRed]])
vim.cmd([[hi! link DiagnosticSignHint GruvboxAqua]])
vim.cmd([[hi! link DiagnosticSignInfo GruvboxBlue]])

--[[
local saga = require 'lspsaga'
lspsaga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  rename_output_qflist = {
    enable = false,
    auto_open_qflist = false,
  },
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
  diagnostic_message_format = "%m %c",
  highlight_prefix = false,
}
]]
-- lsp provider to find the cursor word definition and reference
-- vim.cmd([[nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>]])

--vim.cmd([[hi! link LspSagaDocTruncateLine GruvboxFg0]])
--vim.cmd([[hi! link LspSagaShTruncateLine GruvboxFg0]])
--vim.cmd([[hi! link LspSagaCodeActionTruncateLine GruvboxFg0]])
