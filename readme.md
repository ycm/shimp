# shimp

A tiny script that **s**witches between **h**eader and **imp**lementation. Does not care about project structure, code definitions, etc. Just greedily traverses up the path and looks for a matching filename.

## Install

Requires Vim9.

```vim
Plug 'ycm/shimp'
```

## Usage

```vim
:ShimpToggle [open|left|right|top|below]
```

Also see `:h shimp`.
