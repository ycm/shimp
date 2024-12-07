# shimp

**S**witch between **h**eader and **imp**lementation. Does not care about project structure, code definitions, etc. Just greedily traverses up the path and looks for a matching filename.

## Setup

Requires Vim9.

Manually install, or install with any package manager, e.g. ![vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'ycm/shimp'
```

## Usage

```vim
:ShimpToggle [open|left|right|top|below]
```

See `:h shimp` or `:h ShimpToggle` for more info.

## TODOs

- [x] split to a window
