vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'github/copilot.vim',
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'folke/neodev.nvim',
    },
  },
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'quangnguyen30192/cmp-nvim-ultisnips' },
  },
  'rafamadriz/friendly-snippets',
  { 'folke/which-key.nvim',          opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Theme inspired by Atom
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark_dark'
      vim.cmd("hi PmenuSel guibg = #121121")
    end,
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'horizon',
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
      },
    },
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- See `:help indent_blankline.txt`
    opts = {
      char = '|',
      show_end_of_line = true,
      -- show_current_context_start = true,
      show_current_context = true,
      show_trailing_blankline_indent = false,
    },
  },

  { 'numToStr/Comment.nvim',         opts = {} },
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ":TSUpdate",
  },
  { 'romgrk/barbar.nvim',     dependencies = 'nvim-tree/nvim-web-devicons' },
  'lervag/vimtex',
  'sirver/ultisnips',
  'KeitaNakamura/tex-conceal.vim',

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menu,menuone,noinsert'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim', 'html', 'help' },
  
  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = false,
      -- swap_next = {
      --   ['<leader>a'] = '@parameter.inner',
      -- },
      -- swap_previous = {
      --   ['<leader>A'] = '@parameter.inner',
      -- },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {
  history = true,
}
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
local luasnip_available = pcall(require, "luasnip")
cmp.setup({
  completion = {
    completeopt = 'menu,menuone,noinsert',
    border = "single"
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      if luasnip_available then
        require("luasnip").lsp_expand(args.body)
      end
    end
  },
  window = {
    completion = {
      border = "single",
      side_padding = 0
    },
    documentation = {
      border = "rounded"
    }
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs( -4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-c>"] = cmp.mapping.abort(),
    ['<C-n>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
        vim.wait(500, function()
          return cmp.visible()
        end)
        cmp.select_next_item()
      end
    end,
    ["<Tab>"] = cmp.mapping(function(fallback)
      if not luasnip_available then
        return
      end
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif fallback ~= nil then
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip_available then
        print("luasnip avail")
        if luasnip.jumpable( -1) then
          luasnip.jump( -1)
        elseif fallback ~= nil then
          fallback()
        end
      elseif fallback ~= nil then
        fallback()
      else
        print("luasnip not avail")
      end
    end, { "i", "s" }),
    ["<C-j>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "ultisnips" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  },
  experimental = {
    native_menu = false,
  },
  formatting = {
    format = function(entry, vim_item)
      if pcall(require, "lspkind") then
        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
      end
      vim_item.menu = ({
            npm = "",
            buffer = "﬘",
            nvim_lsp = "",
            luasnip = "",
            nvim_lua = "",
            emoji = "ﲃ",
            latex_symbols = "",
            treesitter = "滑",
            path = "",
            zsh = "",
            spell = "暈",
            rg = "縷",
          })[entry.source.name]
      return vim_item
    end,
  },
})
-- Jump to start/end of line
vim.keymap.set("n", "H", function()
  local current_column = vim.fn.col(".")
  if current_column == 1 then
    vim.cmd.normal("_")
  else
    vim.fn.cursor(".", 1)
  end
end, { silent = true })
vim.keymap.set("n", "L", function()
  local current_column = vim.fn.col(".")
  local end_column = vim.fn.col("$") - 1
  if current_column == end_column then
    vim.cmd.normal("g_")
  else
    vim.fn.cursor(".", end_column)
  end
end, { silent = true })

-- Spell checking
vim.keymap.set("n", "<Leader>sc", ":set spell!<CR>", { silent = true })

-- NeoTree
vim.keymap.set("n", "<Leader>f", ":NeoTreeFocusToggle<CR>", { silent = true })

--Write and Quit
vim.keymap.set({ "n" }, "<C-s>", ":w<CR>", { silent = true })
vim.keymap.set({ "n" }, "<C-x>", ":q!<CR>", { silent = true })

--CodeRunner
vim.keymap.set("n", "<Leader>r", ":RunCode<CR>", { silent = true })

-- System clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], { silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>p", [["+p]], { silent = true })

--Barbar
vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', { silent = true })
vim.keymap.set('n', '<C-c>', '<Cmd>BufferClose<CR>', { silent = true })

-- Leap
vim.keymap.del({ 'x', 'o' }, 'x')
vim.keymap.del({ 'x', 'o' }, 'X')

-- VimTex
vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_view_method = "zathura"
vim.o.conceallevel = 1
vim.g.tex_conceal = "abdmg"
vim.cmd("let g:UltiSnipsSnippetDirectories = ['/home/cyk/.config/nvim/latex-snippets']")
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
