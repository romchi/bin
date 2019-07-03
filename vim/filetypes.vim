"=====================================================                                                                                                                                                
" Languages support
"=====================================================
filetype plugin indent on
" --- Python ---
autocmd FileType python set completeopt-=preview tabstop=4 shiftwidth=4 " раскомментируйте, в случае, если не надо, чтобы jedi-vim показывал документацию по методу/классу
"autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 formatoptions+=croq softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

"" --- JavaScript ---
"let javascript_enable_domhtmlcss=1
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd BufNewFile,BufRead *.json setlocal ft=javascript

" --- HTML ---
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

" --- template language support (SGML / XML too) ---
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType html,xhtml,xml,htmldjango,eruby,mako setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
"autocmd bufnewfile,bufread *.rhtml setlocal ft=eruby
"autocmd BufNewFile,BufRead *.mako setlocal ft=mako 
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python

" Dockerfile
"autocmd BufRead,BufNewFile Dockerfile* set ft=Dockerfile
"autocmd BufRead,BufNewFile Dockerfile setf Dockerfile
"autocmd BufRead,BufNewFile *.dock setf Dockerfile
"autocmd BufRead,BufNewFile *.[Dd]ockerfile setf Dockerfile

" docker-compose.yml
autocmd BufRead,BufNewFile docker-compose*.{yaml,yml}* set ft=docker-compose

let html_no_rendering=1
let g:closetag_default_xml=1
let g:sparkupNextMapping='<c-l>'
autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
"autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/scripts/closetag.vim

"autocmd FileType html,htmldjango,eruby,mako let b:closetag_html_style=1
"autocmd FileType html,xhtml,xml,htmldjango,eruby,mako source ~/.vim/scripts/closetag.vim

" --- CSS ---
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

"  при переходе за границу в 80 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
augroup vimrc_autocmds
autocmd!                                                                                                                                                                                          
  autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
  autocmd FileType ruby,python,javascript,c,cpp match Excess /\%120v.*/
  autocmd FileType ruby,python,javascript,c,cpp set nowrap
augroup END
