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
:ShimpToggle
```
(no other features)

Sample keymap: `nnoremap <silent> <leader>sh :ShimpToggle<cr>`

## Config
Defaults:
```
g:shimp_options = {
    headers: ['h', 'hpp'],
    sources: ['c', 'cpp', 'cc'],
    header_dirs: ['.', 'include'],
    source_dirs: ['.', 'src'],
}
```

To add other extensions/directories, either modify `plugin/shimp.vim` or modify the options after shimp loads (e.g. put something in `after/` or manually modify `g:shimp_options`).

Example:
```
vim9script
# in after/
g:shimp_options.headers = ['h']
g:shimp_options.sources->add('cc')
# etc.
```

## TODOs

- [ ] split to a window
