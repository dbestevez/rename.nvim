# rename.nvim

A small Neovim plugin that renames the current file without leaving the editor.

It provides a simple `:Rename` command that renames the current file, creates missing parent directories when needed, and updates the current buffer to the new location.

## Features

* Rename the current file with a single command.
* Automatically creates missing parent directories.
* Supports relative and absolute paths.
* Configurable command name.
* Lightweight and dependency-free.

## Installation

### Using `vim.pack` (Neovim 0.12+)

```lua
vim.pack.add({
    "https://github.com/dbestevez/rename.nvim",
})

require("rename").setup()
```

### Using lazy.nvim

```lua
{
    "dbestevez/rename.nvim",
    config = function()
        require("rename").setup()
    end,
}
```

### Using packer.nvim

```lua
use {
    "dbestevez/rename.nvim",
    config = function()
        require("rename").setup()
    end,
}
```

## Configuration

Default configuration:

```lua
require("rename").setup({
    command = "Rename",
    relative_to_current_file = true,
})
```

### Options

| Option                     | Type      | Default    | Description                                                                                        |
| -------------------------- | --------- | ---------- | -------------------------------------------------------------------------------------------------- |
| `command`                  | `string`  | `"Rename"` | Name of the user command.                                                                          |
| `relative_to_current_file` | `boolean` | `true`     | Resolve relative paths from the current file's directory instead of the current working directory. |

## Usage

Rename the current file:

```vim
:Rename new-name.lua
```

Rename and move the file to another directory:

```vim
:Rename ../utils/helpers.lua
```

Use an absolute path:

```vim
:Rename ~/Projects/my-plugin/lua/plugin.lua
```

If the destination directory does not exist, it will be created automatically.

## API

### `setup(opts)`

Initializes the plugin.

### `rename(path)`

Renames the current file to `path`.

This function is also available from Lua:

```lua
require("rename").rename("new/path/file.lua")
```

## Limitations

This plugin only renames files on disk and updates the current buffer.

It does **not** update imports, references or project metadata. For language-aware renames, use your language server if it supports file rename operations.

## License

MIT
