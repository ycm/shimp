vim9script


g:shimp_options = {
    headers: ['h', 'hpp'],
    sources: ['c', 'cpp'],
    header_dirs: ['.', 'include'],
    source_dirs: ['.', 'src'],
}


def SearchInPath(path: string, stem: string, target_is_source: number, mode: string): bool
    var dirs = (target_is_source) ? g:shimp_options.source_dirs : g:shimp_options.header_dirs
    var exts = (target_is_source) ? g:shimp_options.sources : g:shimp_options.headers
    for d in dirs
        for e in exts
            var p = $'{path}/{d}'
            if !isdirectory(p)
                continue
            endif
            p = $'{p}/{stem}.{e}'
            if filereadable(p)
                p = fnamemodify(p, ":~:.")
                if mode == 'open'
                    execute $':e {p}'
                elseif mode == 'left' || mode == 'right'
                    execute $':vs {p}'
                elseif mode == 'top' || mode == 'below'
                    execute $':split {p}'
                endif
                echom $'[shimp] switched to {p}'
                return true
            endif
        endfor
    endfor
    return false
enddef


export def Toggle(mode: string = 'open')
    var stem = expand('%:t:r')
    var ext = expand('%:e')
    var target_is_source = -1

    if g:shimp_options.headers->index(ext) >= 0
        target_is_source = 1
    elseif g:shimp_options.sources->index(ext) >= 0
        target_is_source = 0
    endif

    if target_is_source == -1
        echom $"[shimp] {expand('%:t')} is invalid."
        return
    endif

    var sr = &splitright
    var sb = &splitbelow
    if mode == 'right'
        set splitright
    elseif mode == 'left'
        set nosplitright
    elseif mode == 'below'
        set splitbelow
    elseif mode == 'top'
        set nosplitbelow
    endif

    var success = false

    var modifier = '%:p:h'
    var path = expand(modifier)
    while true
        if SearchInPath(path, stem, target_is_source, mode)
            success = true
            break
        endif
        modifier = modifier .. ':h'
        var new_path = expand(modifier)
        if new_path == path
            break
        endif
        path = new_path
    endwhile

    if sr
        set splitright
    else
        set nosplitright
    endif
    if sb
        set splitbelow
    else
        set nosplitbelow
    endif

    if !success
        echom "No matching header/implementation found"
    endif
enddef
