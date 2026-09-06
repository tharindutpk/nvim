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

### Per language

| language | server | formatter | linter |
| --- | --- | --- | --- |
| TypeScript / JS / React | typescript-tools | prettierd | biome |
| Svelte | svelte-language-server | prettierd | biome |
| Python | ruff + ty | ruff | ruff |
| Rust | rustaceanvim | rust-analyzer | rust-analyzer |
| Go | gopls | goimports + gofumpt | gopls |
| C / C++ | clangd | clang-format | clangd |
| Bash | bash-language-server | shfmt | shellcheck |
| SQL | — | sql-formatter | — |
| Lua | lua_ls | stylua | — |

**biome lints, prettier formats.** Splitting them this way keeps one formatter
across `.ts` and `.svelte` — biome does not format Svelte markup, so using it
for both would leave the two halves of a component in different styles. With no
`biome.json` in the project, biome lints against its recommended rules.

SQL gets a parser and a formatter but no language server: the useful SQL
servers want a live database connection, which is more setup than it is worth
here.

Everything mason installs is listed in `lua/plugins/mason.lua`. Keep that list
in sync with `lsp/`, the `formatters_by_ft` table in `lua/plugins/conform.lua`,
and `linters_by_ft` in `lua/plugins/lint.lua`.

## Keymaps

Leader is `<Space>`. `<leader>sk` searches every mapping; which-key shows the
groups below as you type.

| prefix | group |
| --- | --- |
| `<leader>s` | Search (fzf-lua) |
| `<leader>g` | Git changesets (diffview, normal + visual) |
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

## Reviewing changes

gitsigns handles the hunk in front of you; diffview handles the changeset.

| mapping | what it opens |
| --- | --- |
| `<leader>gd` | every uncommitted change, file panel on the left |
| `<leader>gm` | this branch against its merge base with `origin/HEAD` |
| `<leader>gh` | the history of the current file (visual mode: of the selection) |
| `<leader>gH` | the history of the whole branch |
| `<leader>gq` | close |

Inside a diffview: `<Tab>` and `<S-Tab>` step through files, `q` closes,
`<leader>e` and `<leader>b` toggle the panel. `:DiffviewOpen` takes any git
revision argument — `HEAD~3`, `main..feature`, `v1.0..v2.0`.

Conflicts open in a three-way layout (`diff3_mixed`), with `<leader>co`,
`<leader>ct` and `<leader>cb` choosing ours, theirs or base, and `]x` / `[x`
jumping between conflicts.

## Snippets

Expansion is Nvim's native `vim.snippet`; blink.cmp surfaces the candidates.
Two sources feed it, both picked up automatically:

* **friendly-snippets** — the community library, covering every language here.
* **`snippets/` in this repo** — personal ones, in VS Code snippet format.
  `snippets/<filetype>.json` applies to that filetype; `snippets/all.json`
  applies everywhere.

```json
{
  "Snippet name shown in the menu": {
    "prefix": "trigger",
    "body": ["line one $1", "line two $0"],
    "description": "What it does"
  }
}
```

`$1`, `$2`, … are tab stops, `$0` is where the cursor ends up, `${1:default}`
gives a placeholder, and `$CURRENT_YEAR` and friends are filled in on expand.
`<Tab>` and `<S-Tab>` move between stops. Files are read on first completion in
a buffer, so a new snippet needs a restart or a new buffer to appear.

LSP snippets work too — completing a Go function expands its signature with tab
stops, because blink publishes snippet capability to every server.

## Managing plugins

* `<leader>ps` — `vim.pack.update()`; review the confirmation buffer, `:w` to
  apply or `:q` to discard.
* `<leader>pl` — the same buffer offline, as a way to browse what is installed.
* `nvim-pack-lock.json` is committed. It is what pins revisions across machines,
  so commit it whenever an update is confirmed.
* To remove a plugin: delete its `vim.pack.add()` spec, restart, then
  `:lua vim.pack.del({ "<name>" })`.
