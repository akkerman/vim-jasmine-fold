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
        let thisline = substitute(thisline, '^\(\s*\)\(f\|x\)\?\(describe\|it\)("\(.\+\)".*',  '\2\1\4 ', '')
        let thisline = substitute(thisline, '^\(\s*\)\(f\|x\)\?\(describe\|it\)(''\(.\+\)''.*', '\2\1\4 ', '')
    endif

    return thisline
endfunction

setlocal foldmethod=expr
setlocal foldexpr=JasmineFolds()
setlocal foldtext=JasmineFoldText()
setlocal foldcolumn=4
setlocal foldminlines=0
