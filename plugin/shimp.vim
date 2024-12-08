if !has('vim9script') || v:version < 900
    finish
endif

vim9script

if get(g:, 'loaded_shimp', false)
    finish
endif
g:loaded_harpy = true

import autoload '../autoload/shimp.vim'

command! -nargs=? ShimpToggle shimp.Toggle(<f-args>)
