return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    -- TODO remove lazy part once this is a dependent of lsp-config
    opts = {
      ensure_installed = {
        'stylua',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  {
    'neovim/nvim-lspconfig',
    branch = 'master',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'j-hui/fidget.nvim',
      'folke/neodev.nvim',
    },
    opts = {},
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- This function gets run when an LSP connects to a particular buffer.
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end
        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
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
        gopls = {
          gopls = {
            gofumpt = true,
            usePlaceholders = true,
            semanticTokens = true,
          },
        },
        pyright = {},
        rust_analyzer = {},
        tsserver = {},
        html = { filetypes = { 'html', 'twig', 'hbs' } },

        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = {
              globals = { 'vim' },
            },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      }

      -- require('fidget').setup()
      require('mason-lspconfig').setup({

        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            })
          end,
        },
      })
    end,
  },

  {
    'glepnir/lspsaga.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        show_file = false,
      },
    },
  },
}
