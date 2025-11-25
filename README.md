### nvim-formatterconfig

nvim-formatterconfig is a collection of formatter configurations for
[conform.nvim].

Smartly enables and disables formatters based on context cues.

[conform.nvim]: https://github.com/stevearc/conform.nvim

### Instalation

Using [lazy.nvim]

```lua
return {
    "skeletony007/nvim-formatterconfig",

    dependencies = { "stevearc/conform.nvim" },
}
```

[lazy.nvim]: https://github.com/folke/lazy.nvim

### Usage

Enable a particular formatter:

```lua
require("formatterconfig").stylua.setup()
```

using available formatter names (`:help conform-formatters`).

### Acknowledgements

- [nvim-lspconfig] for the plugin structure
- [nvimdev/guard.nvim] for the simple user config

[nvim-lspconfig]:
https://github.com/neovim/nvim-lspconfig/tree/4ea9083b6d3dff4ddc6da17c51334c3255b7eba5
[nvimdev/guard.nvim]: https://github.com/nvimdev/guard.nvim
