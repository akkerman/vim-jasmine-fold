function! JasmineFolds()
    let thisline = getline(v:lnum)
    if match(thisline, '\v^\s*(f|x)?(describe|it)\(') >=0
        return ">1"
    elseif match(thisline, '\v^\s*(describe|it)\.(todo|skip|only)\(') >= 0
        return ">1"
    elseif match(thisline, '\v^\s*(after|before)(Each|All)') >= 0
        return ">2"
    else
        return "="
    endif
endfunction

function! JasmineFoldText()
    let thisline = getline(v:foldstart)
    "                 (1  )(2  ) (3          )  (4   )(5 )
    let pattern = '\v^(\s*)(f|x)?(describe|it)\(("|'')(.+)\4.*'
    let thisline = substitute(thisline, pattern, '\2\1\5', '')
    let thisline = substitute(thisline, '\v^(f|x) ', '\1', '')

    "                    (1  )(2          ) (3             )   (4  )(5 )
    let newPattern = '\v^(\s*)(describe|it).(todo|skip|only)\(("|'')(.+)\4.*'
    let thisline = substitute(thisline, newPattern, '\3\1\5', '')
    let thisline = substitute(thisline, '\v^todo ', 'T', '')
    let thisline = substitute(thisline, '\v^only ', 'f', '')
    let thisline = substitute(thisline, '\v^skip ', 'x', '')

    return thisline
endfunction

setlocal foldmethod=expr
setlocal foldexpr=JasmineFolds()
setlocal foldtext=JasmineFoldText()
setlocal foldcolumn=4
setlocal foldminlines=0
" the following line has an intentional trailing space
setlocal fillchars=fold:\ 
