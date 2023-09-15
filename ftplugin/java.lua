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
  local _, _ = pcall(vim.lsp.codelens.refresh)
  require("jdtls").setup_dap({ hotcodereplace = "auto" })
  local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
  if status_ok then
    jdtls_dap.setup_dap_main_class_configs()
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
local config = {
  cmd = { '/opt/homebrew/bin/jdtls' },

  -- cmd = {
  --
  --   "java", -- or '/path/to/java17_or_newer/bin/java'
  --   -- depends on if `java` is in your $PATH env variable and if it points to the right version.
  --
  --   "-javaagent:/home/jake/.local/share/java/lombok.jar",
  --   -- '-Xbootclasspath/a:/home/jake/.local/share/java/lombok.jar',
  --   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  --   "-Dosgi.bundles.defaultStartLevel=4",
  --   "-Declipse.product=org.eclipse.jdt.ls.core.product",
  --   -- '-noverify',
  --   "-Xms1g",
  --   "--add-modules=ALL-SYSTEM",
  --   "--add-opens",
  --   "java.base/java.util=ALL-UNNAMED",
  --   "--add-opens",
  --   "java.base/java.lang=ALL-UNNAMED",
  --   "-jar",
  --   vim.fn.glob("/Users/sagar/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
  --   -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
  --   -- Must point to the                                                     Change this to
  --   -- eclipse.jdt.ls installation                                           the actual version
  --
  --   "-configuration",
  --   "/Users/sagar/.local/share/nvim/lsp_servers/jdtls/config_mac",
  --   -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
  --   -- Must point to the                      Change to one of `linux`, `win` or `mac`
  --   -- eclipse.jdt.ls installation            Depending on your system.
  --
  --   -- See `data directory configuration` section in the README
  -- },
  --
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  settings = {
    java = {
      signatureHelp = { enabled = true },
    },
    contentProvider = { preferred = 'fernflower' },
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  on_attach = on_attach,
  init_options = {
    bundles = {
      vim.fn.glob("/Users/sagar/java-debug-adapter/extension/server/*jar")
    },
  },
}
require('jdtls').start_or_attach(config)

-- require('jdtls.dap').setup_dap_main_class_configs()
