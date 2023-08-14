local status_lsp, lsp = pcall(require, "lsp-zero")
if not status_lsp then
  return
end

local status_lspconfig, lspconfig = pcall(require, "lspconfig")
if not status_lspconfig then
  return
end

local lsp_servers = {
  "bashls", -- Bash
  "dockerls", -- Docker
  "elixirls", -- Elixir
  "graphql", -- GraphQL
  "html", -- HTML
  "jsonls", -- JSON
  "lua_ls", -- Lua
  "marksman", -- Markdown
  "pyright", -- Python
  "rust_analyzer", -- Rust
  "sqlls", -- SQL
  "tailwindcss", -- Tailwind CSS
  "terraformls", -- Terraform
  "taplo", -- TOML
  "tsserver", -- TypeScript / JavaScript
  "vimls", -- VIM
  "yamlls", -- YAML
}

local tool_servers = {
  -- Formatters
  "autoflake",
  "black",
  "isort",
  "prettierd",
  "stylua",
  -- Linters
  "flake8",
  "mypy",
}

lsp.preset("recommended")
lsp.ensure_installed(lsp_servers)

-- Shell Scripts
lsp.configure("bashls", {
  filetypes = { "fish", "sh", "bash" },
})

-- GraphQL
lsp.configure("graphql", {
  filetypes = { "graphql" },
})

-- Tailwind CSS
lsp.configure("tailwindcss", {
  root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
})

-- Lua
lsp.configure("lua_ls", {
  settings = {
    Lua = {
      telemetry = {
        enable = false,
      },
      runtime = {
        -- Tell the Language Server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      -- Get the Language Server to recognize the "vim" global
      diagnostics = {
        globals = { "vim" },
        disable = { "need-check-nil" },
      },
      workspace = {
        -- Make the Server aware of Neovim Runtime Files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
})

-- Python
lsp.configure("pyright", {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
  },
})

-- Here we set up keymaps. You can change them if you already have specifics for these functions, or just want to try another keymap.
local function lsp_keymaps(bufnr)
  local opts = { buffer = bufnr, remap = false }
  local map = vim.keymap.set

  map("n", "gr", "<cmd>Lspsaga lsp_finder<cr>", opts) -- Show Definition, References
  map("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts) -- See Definition and Make Edits in Window
  map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts) -- Go to Declaration
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts) -- Go to Implementation
  map("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<cr>", opts) -- Show Diagnostics for Line
  map("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<cr>", opts) -- Show Diagnostics for Cursor
  map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts) -- Jump to Previous Diagnostic in Buffer
  map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts) -- Jump to Next Diagnostic in Buffer
  map("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts) -- Show Documentation for what is Under Cursor
  map("n", "<leader>o", "<cmd>LSoutlineToggle<cr>", opts) -- See Outline on Right Hand Side
end

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- Only use Null-LS for formatting instead of LSP Server
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

local augroup_format = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

lsp.on_attach(function(client, bufnr)
  lsp_keymaps(bufnr)

  if client.supports_method("textDocument/formatting") or client.name == "pyright" then
    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup_format,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end)

-- Setup Completion
local status_cmp, cmp = pcall(require, "cmp")
if not status_cmp then
  return
end

local status_lspkind, lspkind = pcall(require, "lspkind")
if not status_lspkind then
  return
end

local status_luasnip, luasnip = pcall(require, "luasnip")
if not status_luasnip then
  return
end

-- Snippet Engine
luasnip.config.set_config({
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",
})

require("luasnip.loaders.from_vscode").lazy_load()

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),
  ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  ["<C-e>"] = cmp.mapping.abort(),

  -- Accept currently selected item. If none selected, `select` first item.
  -- Set `select` to `false` to only confirm explicitly selected items.
  ["<CR>"] = cmp.mapping.confirm({ select = true }),
  ["<C-y"] = cmp.mapping.confirm({ select = true }),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif check_backspace() then
      fallback()
    else
      fallback()
    end
  end),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end),
})

local cmp_formatting = {
  fields = { "kind", "abbr", "menu" },
  format = lspkind.cmp_format({
    mode = "symbol",
    maxwidth = 50,
  }),
}

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  formatting = cmp_formatting,
})

lsp.setup()

-- Setup Formatters and Linters
local status_mason_tool_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
if not status_mason_tool_installer then
  return
end

mason_tool_installer.setup({
  ensure_installed = tool_servers,
})

-- Setup Null-LS
local status_null_ls, null_ls = pcall(require, "null-ls")
if not status_null_ls then
  return
end

local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = true,
  sources = {
    code_actions.eslint_d,
    diagnostics.credo, -- Elixir
    diagnostics.fish,
    diagnostics.flake8,
    -- diagnostics.mypy,
    -- formatting.autoflake,
    formatting.black,
    formatting.isort,
    formatting.mix, -- Elixir
    formatting.prettierd, -- JS/TS
    formatting.stylua, -- Lua
  },
})

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

-- LSP Status UI
local status_fidget, fidget = pcall(require, "fidget")
if not status_fidget then
  return
end

fidget.setup({
  text = {
    done = "✔ ", -- character shown when all tasks are complete
  },
  window = {
    blend = 0,
  },
})
