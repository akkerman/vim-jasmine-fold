function! JasmineFolds()
    let thisline = getline(v:lnum)
    if match(thisline, '^\s*\(f\|x\)\?\(describe\|it\)(') >=0
        return ">1"
    elseif match(thisline, '^\s*\(after\|before\)\(Each\|All\)') >= 0
        return ">2"
    else
        return "="
    endif
endfunction

function! JasmineFoldText()
    let thisline = getline(v:foldstart)
    let replacement = ' '

    if match(thisline, '\(describe\|it\)') >=0
        let thisline = substitute(thisline, '^\(\s*\)\(.\+\)("\(.\+\)".*', '\2\1\3 ', '')
        let thisline = substitute(thisline, '^\(\s*\)\(.\+\)(''\(.\+\)''.*', '\2\1\3 ', '')
        if match(thisline, '^\(f\|x\)') >=0
            let thisline = substitute(thisline, '^\(f\|x\)\?\S\+', '\1', '')
        else
            let thisline = substitute(thisline, '^\(f\|x\)\?\S\+', ' ', '')
        endif
    endif

    return thisline
endfunction

setlocal foldmethod=expr
setlocal foldexpr=JasmineFolds()
setlocal foldtext=JasmineFoldText()
setlocal foldcolumn=4
setlocal foldminlines=0
