# nvim

A Neovim config built on the built-in plugin manager (`vim.pack`) and the
built-in LSP config loader (`lsp/`). No lazy.nvim, no nvim-lspconfig.

Requires **Neovim 0.12+** (`vim.pack`, `vim.hl.on_yank`, `lsp/` directory).

## Layout

```
init.lua                 leader keys, then the three requires below
lsp/<server>.lua         one file per language server, read by vim.lsp.enable()
lua/config/
  init.lua               requires options, keymaps, autocmds
  options.lua            editor options
  keymaps.lua            mappings that need no plugin
  autocmds.lua           autocommands
  lsp.lua                diagnostics, LspAttach mappings, vim.lsp.enable()
lua/plugins/
  init.lua               the load order
  <plugin>.lua           one file per plugin: vim.pack.add() + its setup
lua/util/lazy.lua        helpers for deferring work off the startup path
```

`init.lua` requires things in this order, and the order matters:

1. `config` — options, keymaps, autocmds.
2. `plugins` — every plugin spec and its configuration.
3. `config.lsp` — last, because enabling the servers has to happen after
   blink.cmp has published its completion capabilities.

Inside `lua/plugins/init.lua` the files are listed in dependency order rather
than alphabetically: the colorscheme first (everything else themes against it),
which-key last (its groups are registered once every mapping exists).

## How loading works

`vim.pack.add()` runs eagerly for every plugin — it only checks the plugin
directory and extends `'runtimepath'`, which is cheap. The expensive part is
each plugin's `require(...).setup(...)`, and that is what gets deferred, using
the three helpers in `lua/util/lazy.lua`:

| helper | when it runs | used for |
| --- | --- | --- |
| `lazy.later(fn)` | just after the first screen is drawn | statusline, tabline, git signs, completion, formatters, linters, mason, LSP |
| `lazy.on(events, fn)` | first time an event fires | autopairs (`InsertEnter`) |
| `lazy.once(fn)` | first time a mapping is pressed | fzf-lua, nvim-tree, alternate-toggler |

Eager on purpose: **catppuccin** (colorscheme), **treesitter** (highlighting has
to be up before the first draw), **snacks** (`bigfile`/`quickfile` must precede
the first buffer read, the dashboard must precede `VimEnter`), and **oil**
(takes over directory buffers, so `nvim .` needs it configured already).

## Tooling

| concern | plugin |
| --- | --- |
| completion | blink.cmp |
| pickers | fzf-lua |
| formatting | conform.nvim (format on save, toggleable) |
| linting | nvim-lint |
| tool installation | mason + mason-tool-installer |
| tree | nvim-tree (`<leader>e`), oil (`-`) |

Language servers are declared one per file in `lsp/` and switched on by the
`servers` list in `lua/config/lsp.lua`. TypeScript is handled by
typescript-tools, Rust by rustaceanvim; neither goes through that list.

Everything mason installs is listed in `lua/plugins/mason.lua`. Keep that list
in sync with `lsp/`, the `formatters_by_ft` table in `lua/plugins/conform.lua`,
and `linters_by_ft` in `lua/plugins/lint.lua`.

## Keymaps

Leader is `<Space>`. `<leader>sk` searches every mapping; which-key shows the
groups below as you type.

| prefix | group |
| --- | --- |
| `<leader>s` | Search (fzf-lua) |
| `<leader>h` | Git hunk (gitsigns, normal + visual) |
| `<leader>e` | Explorer (nvim-tree) |
| `<leader>b` | Buffer (bufferline) |
| `<leader>f` | Format (conform) |
| `<leader>t` | Toggle |
| `<leader>p` | Packages (`vim.pack`) |
| `<leader>S` | Session (persistence) |

Notable single mappings: `-` opens oil in the parent directory, `<C-\>` toggles
the terminal, `<S-h>` / `<S-l>` cycle buffers, `jk` leaves insert mode,
`<leader>l` lints the current file, `<leader>q` opens the diagnostics loclist.

LSP mappings are buffer-local and follow Neovim's `gr` defaults (`:help
lsp-defaults`), pointed at fzf-lua pickers: `grd` definition, `grt` type
definition, `grr` references, `gri` implementation, `grD` declaration, `grn`
rename, `gra` code action, `gO` document symbols, `gW` workspace symbols.

## Managing plugins

* `<leader>ps` — `vim.pack.update()`; review the confirmation buffer, `:w` to
  apply or `:q` to discard.
* `<leader>pl` — the same buffer offline, as a way to browse what is installed.
* `nvim-pack-lock.json` is committed. It is what pins revisions across machines,
  so commit it whenever an update is confirmed.
* To remove a plugin: delete its `vim.pack.add()` spec, restart, then
  `:lua vim.pack.del({ "<name>" })`.
