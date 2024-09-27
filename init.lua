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

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim',       tag = "legacy", opts = {} },
      -- {
      --   "SmiteshP/nvim-navbuddy",
      --   dependencies = {
      --     "SmiteshP/nvim-navic",
      --     "MunifTanjim/nui.nvim"
      --   },
      --  opts = { lsp = { auto_attach = true } }
      -- },
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
      'quangnguyen30192/cmp-nvim-ultisnips'
    },
  },

  -- Useful plugin to show you pending keybinds.
  'rafamadriz/friendly-snippets',
  { 'folke/which-key.nvim',  opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
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
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>ghp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']g', function()
          if vim.wo.diff then return ']g' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ 'n', 'v' }, '[g', function()
          if vim.wo.diff then return '[g' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },
  { "rebelot/kanagawa.nvim", opts = { transparent = true } },
  {
    "scottmckendry/cyberdream.nvim",
    opts = {
      transparent = true,
    },
    lazy = false,
    priority = 1000,
  },
  {
    "nyoom-engineering/oxocarbon.nvim"
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "night",    -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true, -- Enable this to disable setting the background color
        -- terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = {},
          functions = { bold = true },
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          -- sidebars = "transparent",    -- style for sidebars, see below
          sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
          floats = "transparent",      -- style for floating windows
        },
        -- day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        -- hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        -- dim_inactive = false,             -- dims inactive windows
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      })
    end
  },
  {
    "xero/evangelion.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
    init = function()
      vim.cmd.colorscheme("evangelion")
    end,
  },

  -- {
  --   -- Set lualine as statusline
  --   'nvim-lualine/lualine.nvim',
  --   opts = {
  --     options = {
  --       theme = 'tokyonight',
  --       section_separators = { left = '', right = '' },
  --       component_separators = { left = '|', right = '|' },
  --     },
  --   },
  -- },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
    end,
    opts = function()
      -- evangelion colors
      local colors = require("evangelion.unit01").get()
      -- size display logic
      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width_first = function()
          return vim.fn.winwidth(0) > 80
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 70
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end,
      }
      -- auto change color according to neovims mode
      local mode_color = {
        n = { bg = colors.longingus, fg = colors.kaworu },
        i = { bg = colors.dummyplug, fg = colors.core },
        v = { bg = colors.kaworu, fg = colors.core },
        [""] = { bg = colors.kaworu, fg = colors.core },
        V = { bg = colors.kaworu, fg = colors.core },
        c = { bg = colors.lcl, fg = colors.core },
        no = { bg = colors.kaworu, fg = colors.core },
        s = { bg = colors.lcl, fg = colors.core },
        S = { bg = colors.lcl, fg = colors.core },
        [""] = { bg = colors.lcl, fg = colors.core },
        ic = { bg = colors.lcl, fg = colors.core },
        R = { bg = colors.lcl, fg = colors.core },
        Rv = { bg = colors.lcl, fg = colors.core },
        cv = { bg = colors.lcl, fg = colors.core },
        ce = { bg = colors.lcl, fg = colors.core },
        r = { bg = colors.nerv, fg = colors.core },
        rm = { bg = colors.nerv, fg = colors.core },
        ["r?"] = { bg = colors.nerv, fg = colors.core },
        ["!"] = { bg = colors.nerv, fg = colors.core },
        t = { bg = colors.kaworu, fg = colors.core },
      }
      -- config
      local config = {
        options = {
          -- remove default sections and component separators
          component_separators = "",
          section_separators = "",
          theme = {
            -- setting defaults to statusline
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
          },
        },
        sections = {
          -- clear defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- clear for later use
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          -- clear defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- clear for later use
          lualine_c = {},
          lualine_x = {},
        },
      }

      -- insert active component in lualine_c at left section
      local function active_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- insert inactive component in lualine_c at left section
      local function inactive_left(component)
        table.insert(config.inactive_sections.lualine_c, component)
      end

      -- insert active component in lualine_x at right section
      local function active_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      -- insert inactive component in lualine_x at right section
      local function inactive_right(component)
        table.insert(config.inactive_sections.lualine_x, component)
      end

      -- dump object contents
      local function dump(o)
        if type(o) == "table" then
          local s = ""
          for k, v in pairs(o) do
            if type(k) ~= "number" then
              k = '"' .. k .. '"'
            end
            s = s .. dump(v) .. ","
          end
          return s
        else
          return tostring(o)
        end
      end

      -- active left section
      active_left({
        function()
          local icon
          local ok, devicons = pcall(require, "nvim-web-devicons")
          if ok then
            icon = devicons.get_icon(vim.fn.expand("%:t"))
            if icon == nil then
              icon = devicons.get_icon_by_filetype(vim.bo.filetype)
            end
          else
            if vim.fn.exists("*WebDevIconsGetFileTypeSymbol") > 0 then
              icon = vim.fn.WebDevIconsGetFileTypeSymbol()
            end
          end
          if icon == nil then
            icon = ""
          end
          return icon:gsub("%s+", "")
        end,
        color = function()
          return { bg = mode_color[vim.fn.mode()].bg, fg = mode_color[vim.fn.mode()].fg }
        end,
        padding = { left = 1, right = 1 },
        separator = { right = "▓▒░" },
      })
      active_left({
        "filename",
        cond = conditions.buffer_not_empty,
        color = function()
          return { bg = mode_color[vim.fn.mode()].bg, fg = mode_color[vim.fn.mode()].fg }
        end,
        padding = { left = 1, right = 1 },
        separator = { right = "▓▒░" },
        symbols = {
          modified = "󰶻 ",
          readonly = " ",
          unnamed = " ",
          newfile = " ",
        },
      })
      active_left({
        "branch",
        icon = "",
        color = { bg = colors.unit01, fg = colors.rei },
        padding = { left = 0, right = 1 },
        separator = { right = "▓▒░", left = "░▒▓" },
      })

      -- inactive left section
      inactive_left({
        function()
          return ""
        end,
        cond = conditions.buffer_not_empty,
        color = { bg = colors.core, fg = colors.fog },
        padding = { left = 1, right = 1 },
      })
      inactive_left({
        "filename",
        cond = conditions.buffer_not_empty,
        color = { bg = colors.core, fg = colors.fog },
        padding = { left = 1, right = 1 },
        separator = { right = "▓▒░" },
        symbols = {
          modified = "",
          readonly = "",
          unnamed = "",
          newfile = "",
        },
      })

      -- active right section
      active_right({
        function()
          if vim.lsp.get_clients then
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            local clients_list = {}
            for _, client in pairs(clients) do
              if not clients_list[client.name] then
                table.insert(clients_list, client.name)
              end
            end
            local lsp_lbl = dump(clients_list):gsub("(.*),", "%1")
            return lsp_lbl:gsub(",", ", ")
          end
        end,
        icon = " ",
        color = { bg = colors.kaji, fg = colors.core },
        padding = { left = 1, right = 1 },
        cond = conditions.hide_in_width_first,
        separator = { right = "▓▒░", left = "░▒▓" },
      })

      active_right({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          error = { fg = colors.core },
          info = { fg = colors.core },
          warn = { fg = colors.core },
        },
        colounit01 = false,
        color = { bg = colors.lcl, fg = colors.core },
        padding = { left = 1, right = 1 },
        separator = { right = "▓▒░", left = "░▒▓" },
      })
      active_right({
        "searchcount",
        color = { bg = colors.dummyplug, fg = colors.rei },
        padding = { left = 1, right = 1 },
        separator = { right = "▓▒░", left = "░▒▓" },
      })
      active_right({
        "location",
        color = { bg = colors.mari, fg = colors.rei },
        padding = { left = 1, right = 0 },
        separator = { left = "░▒▓" },
      })
      active_right({
        function()
          local cur = vim.fn.line(".")
          local total = vim.fn.line("$")
          return string.format("%2d%%%%", math.floor(cur / total * 100))
        end,
        color = { bg = colors.mari, fg = colors.rei },
        padding = { left = 1, right = 1 },
        cond = conditions.hide_in_width,
        separator = { right = "▓▒░" },
      })
      active_right({
        "o:encoding",
        fmt = string.upper,
        cond = conditions.hide_in_width,
        padding = { left = 1, right = 1 },
        color = { bg = colors.unit01, fg = colors.core },
      })
      active_right({
        "fileformat",
        fmt = string.lower,
        icons_enabled = false,
        cond = conditions.hide_in_width,
        color = { bg = colors.unit01, fg = colors.core },
        separator = { right = "▓▒░" },
        padding = { left = 0, right = 1 },
      })

      -- inactive right section
      inactive_right({
        "location",
        color = { bg = colors.core, fg = colors.fog },
        padding = { left = 1, right = 0 },
        separator = { left = "░▒▓" },
      })
      inactive_right({
        "progress",
        color = { bg = colors.core, fg = colors.fog },
        cond = conditions.hide_in_width,
        padding = { left = 1, right = 1 },
        separator = { right = "▓▒░" },
      })
      inactive_right({
        "fileformat",
        fmt = string.lower,
        icons_enabled = false,
        cond = conditions.hide_in_width,
        color = { bg = colors.core, fg = colors.fog },
        separator = { right = "▓▒░" },
        padding = { left = 0, right = 1 },
      })
      return config
    end,
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
      indent = {
        -- char = "|"
      },
      exclude = { filetypes = { "terminal", "dashboard" } },
      scope = {
        show_start = true,
        show_end = false
      }
      -- show_end_of_line = true,
      -- show_current_context_start = true,
      -- show_current_context = true,
      -- show_trailing_blankline_indent = false,
    },
  },

  { 'numToStr/Comment.nvim',         opts = {} },
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      'andrew-george/telescope-themes',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  'nvim-treesitter/nvim-treesitter',
  { 'romgrk/barbar.nvim',     dependencies = 'nvim-tree/nvim-web-devicons' },
  'sirver/ultisnips',

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fb',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

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

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
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
  defaults = require('telescope.themes').get_ivy({
    path_display = { "smart" },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  }),
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_ivy({
        layout_config = { height = 0.30 },
      })
    },
  }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
pcall(require('telescope').load_extension, 'projects')
pcall(require('telescope').load_extension, 'possession')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').current_buffer_fuzzy_find,
  { desc = '[space] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sdd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').resume, { desc = '[S]earch [R]resume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
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
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']C'] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[C'] = '@class.outer',
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
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
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
  local vmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  vmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>sds', require('telescope.builtin').lsp_document_symbols, '[S]earch [D]oc [S]ymbols')
  nmap('<leader>sws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch [W]orkspace [S]ymbols')
  nmap('<leader>li', vim.lsp.buf.incoming_calls, '[L]ist [I]ncoming calls')
  nmap('<leader>lo', vim.lsp.buf.outgoing_calls, '[L]ist [O]utgoing calls')

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
  -- local augroup_id = vim.api.nvim_create_augroup(
  --   "FormatModificationsDocumentFormattingGroup",
  --   { clear = false }
  -- )
  -- vim.api.nvim_clear_autocmds({ group = augroup_id, buffer = bufnr })

  -- vim.api.nvim_create_autocmd(
  --   { "BufWritePre" },
  --   {
  --     group = augroup_id,
  --     buffer = bufnr,
  --     callback = function()
  --       local lsp_format_modifications = require "lsp-format-modifications"
  --       lsp_format_modifications.format_modifications(client, bufnr)
  --     end,
  --   }
  -- )
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  lemminx = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  jdtls = {
    java = {
      -- jdt = {
      --   ls = {
      --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
      --   }
      -- },
      project = {
        referencedLibraries = {
          '/Users/sagar/dependency-jars/*.jar'
        },
      },
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all' -- literals, all, none
        }
      },
      format = {
        enabled = true,
        -- settings = {
        --   profile = 'asdf'
        -- },
      }
    },
    signatureHelp = {
      enabled = true,
    },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      },
    },
    contentProvider = {
      preferred = 'fernflower',
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      }
    },
    codeGeneration = {
      toString = {
        template =
        '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
      useBlocks = true,
    },
  },

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
    if server_name == "jdtls" then
      return
    end
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
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
      border = "rounded",
      documentation = "native"
    }
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
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
    ["J"] = cmp.mapping(function(fallback)
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
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
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
    { name = "codeium" },
    { name = "ultisnips" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
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
require "user.keymap"

-- VimTex
vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_view_method = "zathura"
vim.o.conceallevel = 1
vim.g.tex_conceal = "abdmg"
vim.cmd("let g:UltiSnipsSnippetDirectories = ['/home/cyk/.config/nvim/latex-snippets']")

require 'treesitter-context'.setup {
  enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20,     -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
-- require('nvim-navbuddy').setup({
--   window = {
--     size = "90%",
--   }
-- })
vim.keymap.set("n", "[tc", function()
  require("treesitter-context").go_to_context()
end, { silent = true })

vim.cmd.colorscheme 'evangelion'
vim.cmd("hi TreesitterContext guibg=None")
vim.cmd("hi Comment guibg=None")
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
