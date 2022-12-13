require('keymaps')
require('plugins')
require('impatient') --Uses impatient plugin to load faster
-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.undofile = true
vim.wo.relativenumber = true

---
-- Old VIM Script Commands
--
-- vim.cmd([[
-- set spell
-- ]])

---
-- Suppress errors in Windows
-- 

vim.notify = function (msg, log_level, _opts)
    if msg:match("exit code") then return end
    if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
    else
    vim.api.nvim_echo({{msg}}, true, {})
    end
  end

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
vim.opt.termguicolors = true
vim.cmd('colorscheme codedark')

---
-- Titus Custom Markdown HUGO Image Insert
---
require'clipboard-image'.setup {
  markdown = {
   img_dir = {"content/images", "%:p:h:t", "%:t:r"},
   img_dir_txt = {"/images", "%:p:h:t", "%:t:r"},
   img_name = function ()
      vim.fn.inputsave()
      local name = vim.fn.input('Name: ')
      vim.fn.inputrestore()

      if name == nil or name == '' then
        return os.date('%y-%m-%d-%H-%M-%S')
      end
      return name
    end,
    img_handler = function ()
        return function (path)
            return os.execute(string.format('~/.scripts/tinypng -s -f %s &', path))
        end
    end
  }
}

-- LSP and Linting Config
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
    'bashls',
    'luau_lsp',
    'marksman'
    -- 'powershell_es',
  },
	automatic_installation = true,
})

require'lspconfig'.bashls.setup{}
require'lspconfig'.luau_lsp.setup{}
require'lspconfig'.marksman.setup{}
-- require'lspconfig'.powershell_es.setup{
--  bundle_path = '~/.local/share/nvim/mason/packages/powershell-editor-services/PowerShellEditorServices/',
--}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "bash", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "" },


    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  -- ...
  rainbow = {
    enable = true,

    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    -- max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  -- ...
  indent = {
    enable = true
  }
}

-- require("null-ls").setup({
-- 	sources = {
-- 			require("null-ls").builtins.formatting.stylua,
-- 			require("null-ls").builtins.code_actions.cspell,
-- 			require("null-ls").builtins.diagnostics.codespell,
-- 			require("null-ls").builtins.completion.spell,
-- 			require("null-ls").builtins.code_actions.proselint,
-- 			require("null-ls").builtins.diagnostics.write_good,
-- 	},
-- })

-- File Explorer nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

--Pretty Status bar
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'codedark',
	},
}

-- Add Ctrl + X and initialize toggle term 
require("toggleterm").setup {
	open_mapping = [[<c-x>]],
	shade_terminals = false
}

-- Quickscope Settings
-- Highlight on f and F keys Set in init.lua
vim.cmd([[
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
  highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=8 cterm=underline
]])

-- Add projects capability to telescope
require('telescope').load_extension('projects')

-- Smarter Indent setup
vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
-- vim.opt.listchars:append "tab:¦"
-- vim.opt.listchars = {tab = '>¦'}

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}


vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#70363A gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#72603D gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#4C613C gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#2B5B61 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#305777 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#633C6E gui=nocombine]]
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
-- End Indent

-- NVIM coc code completion LUA
-------------------------------------------------------------------
local keyset = vim.keymap.set
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.shortmess:append('c') -- don't give |ins-completion-menu| messages.
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
vim.g.coc_global_extensions = {
    'coc-java', 'coc-rust-analyzer', 'coc-html', 'coc-css', 'coc-vimlsp',
    'coc-tsserver', 'coc-snippets', 'coc-emmet', 'coc-json', 'coc-texlab'
}

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end


-- auto complete
local opts = {silent = true, noremap = true, expr = true}
vim.api.nvim_set_keymap("i", "<TAB>",
                        'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.api.nvim_set_keymap("i", "<S-TAB>",
                        [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
vim.api.nvim_set_keymap("i", "<cr>",
                        [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- scroll through documentation
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- go to definition and other things
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
-- eyset("n", "<c-k>", "<Plug>(coc-rename)", {silent = true})
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
keyset("n", "<space>a", "<Plug>(coc-codeaction-cursor)", opts)
keyset("x", "<space>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<space>g", "<Plug>(coc-codelens-action)", opts)
keyset("n", "<space>fc", "<Plug>(coc-fix-current)", opts)
keyset("n", "<space>d", ":<C-u>CocList diagnostics<cr>", opts)
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
keyset("n", "<space>q", ":<C-u>CocList<cr>", opts)

vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

----------------------------------------------------------------------
-- End coc completion lua

-- NVIM coc code completion
------------------------------------
-- vim.cmd([[
--   " use <tab> to trigger completion and navigate to the next complete item
--   function! CheckBackspace() abort
--     let col = col('.') - 1
--     return !col || getline('.')[col - 1]  =~# '\s'
--   endfunction
  
--   inoremap <silent><expr> <Tab>
--         \ coc#pum#visible() ? coc#pum#next(1) :
--         \ CheckBackspace() ? "\<Tab>" :
--         \ coc#refresh()

--         inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
--         inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

--         inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

--   " Use K to show documentation in preview window.
--   nnoremap <silent> K :call ShowDocumentation()<CR>
  
--   function! ShowDocumentation()
--     if CocAction('hasProvider', 'hover')
--       call CocActionAsync('doHover')
--     else
--       call feedkeys('K', 'in')
--     endif
--   endfunction      
-- ]])
