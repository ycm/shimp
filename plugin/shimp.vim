vim9script

g:shimp_options = {
    headers: ['h', 'hpp'],
    sources: ['c', 'cpp'],
    header_dirs: ['.', 'include'],
    source_dirs: ['.', 'src'],
}

def ShimpSearchInPath(path: string, stem: string, target_is_source: number): bool
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
                execute $':e {p}'
                echom $'Shimp: switched to {p}'
                return true
            endif
        endfor
    endfor
    return false
enddef

export def ShimpToggle()
    var stem = expand('%:t:r')
    var ext = expand('%:e')
    var target_is_source = -1

    if g:shimp_options.headers->index(ext) >= 0
        target_is_source = 1
    elseif g:shimp_options.sources->index(ext) >= 0
        target_is_source = 0
    endif

    if target_is_source == -1
        echom $"Shimp: {expand('%:t')} is invalid."
        return
    endif

    var modifier = '%:p:h'
    var path = expand(modifier)
    while true
        if ShimpSearchInPath(path, stem, target_is_source)
            return
        endif
        modifier = modifier .. ':h'
        var new_path = expand(modifier)
        if new_path == path
            break
        endif
        path = new_path
    endwhile
    echom "No matching header/implementation found"
enddef

command! ShimpToggle ShimpToggle()
