" Config file for Neovim ONLY. Michael Dodis.
" If this kills sb it's not me I swear.

" TOUR:
" I disabled line numbers, and wraping (confuzles the hell out'a me).
" Line numbers take up too much space in big files, and besides the
" offseted line numbers, they are useless. Look at the bottom right instead.
" You might find yourself wondering: "why is it that the only dep this fucking
" idiot has is a colorscheme? Do I see tpope/commentary pasted right into the
" init.vim file ?!"
" Yes. FIGHT ME!

" SHORTCUTS:
" <leader>m : usually the equivalent make command
" <F5>      : The "run" command
" <leader>\ : Search with silver searcher
" <leader>t : Switch tab
" <C-n>     : Show next result in quickfix
" <C-p>     : Show previous result in quickfix
" <leader>o : Toggle quickfix window (really useful for me)
" <C-o>     : Quick goto file (or buffer if it exists)
" <leader>h : :e <current_file_wo_extension>
" Of course, by default the leader key is \, which I've kept, because
" it reminds me that it's there. Windows reminds me of that key as well.
" Damn you, Windows.

" COLORS: {{{
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
syntax on
let g:colors_name = ""
set termguicolors
colorscheme NeoSolarized

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" automatically open netrw
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

" }}}
" COMMON: {{{

set foldmethod=marker
set foldmarker={{{,}}}

autocmd BufWritePre * %s/\s\+$//e
set nonumber " Look at the bottom left
set showcmd  " I don't know why
set mouse=a  " Mouse is sometimes good for browsing
syntax on
" Only use the system clipboard.
" Why would Anyone. Ever. Use. The.
" Vim clipboard!?
set clipboard=unnamedplus
" Make quick search better
set nohlsearch
set incsearch
" Make indenting normal
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set autoindent
set nowrap
set cursorline

if has('win32')
  " Windows filesystem
  set directory=$HOME\VimBackups\swaps,$HOME\VimBackups,C:\VimBackups,.
  set backupdir=$HOME\VimBackups\backups,$HOME\VimBackups,C:\VimBackups,.
  if exists("&undodir")
      set undodir=$HOME\VimBackups\undofiles,$HOME\VimBackups,C:\VimBackups,.
  endif
  if has("gui_running")
    set guifont=Inconsolata:h12:cANSI
  endif
  let g:cxxcompiler = "msvc"
  set grepprg=ag\ --nogroup\ --nocolor
  " let &shell='cmd.exe /k d:\\work\\shell.bat script'
  " let &shellcmdflag='/s /c d:\\work\\shell.bat'
else
  " POSIX filesystem
  set directory=$HOME/.backups/swaps,$HOME/.backups,$HOME/tmp,.
  set backupdir=$HOME/.backups/backups,$HOME/.backups,$HOME/tmp,.
  if exists("&undodir")
      set undodir=$HOME/.backups/undofiles,$HOME/.backups,$HOME/tmp,.
  endif
  let g:cxxcompiler = "gcc"
endif

" }}}
" STATUSLINE: {{{
"" Statusline Config, change dictionairy as needed
"" NOTE: Stolen from: https://gist.github.com/meskarune/57b613907ebd1df67eb7bdb83c6e6641
let g:currentmode={
    \ 'n'  : 'Normal',      'no' : 'Normal·Operator Pending',   'v'  : 'Visual',    'V'  : 'V·Line',
    \ '' : 'V·Block',     's'  : 'Select',                    'S'  : 'S·Line',    '^S' : 'S·Block',
    \ 'i'  : 'Insert',      'R'  : 'Replace',                   'Rv' : 'V·Replace', 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',      'ce' : 'Ex',                        'r'  : 'Prompt',    'rm' : 'More',
    \ 'r?' : 'Confirm',     '!'  : 'Shell',                     't'  : 'Terminal'}

set laststatus=2
set noshowmode
set statusline=
set statusline+=%#TermCursor#\ %{toupper(g:currentmode[mode()])}\  " The current mode
set statusline+=                                      " Separator
set statusline+=%t%m%r%h%w\                         " File name, modified, readonly, helpfile, preview
set statusline+=                                      " Separator
set statusline+=                                     " Separator
set statusline+=%=                                       " Right Side
set statusline+=                                     " Separator
set statusline+=\ %c\:%02l/%L\                " Line number / total lines, percentage of document

set wildmenu
hi WildMenu ctermfg=3 ctermbg=0
"" Ignore common non-text files
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico     " Images
set wildignore+=*.pdf,*.psd                             " Documents
set wildignore+=*.so,*.o,*.lib,*.dll,*.pdb              " object files
set wildignore+=node_modules/*,bower_components/*       "directories
" }}}
" GREPING: {{{
"" Use the Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" }}}
" EXTRA: {{{
set path+=**            " clever'r completion
set ignorecase smartcase
set exrc " add .nvimrc file to your project's root folder for project-specific stuff
" quickfix window
function! s:redir(cmd)
  redir => res
  execute a:cmd
  redir END

  return res
endfunction

"" Toggle quickfix list
function! s:toggle_qf_list()
  let bufs = s:redir('buffers')
  let l = matchstr(split(bufs, '\n'), '[\t ]*\d\+[\t ]\+.\+[\t ]\+"\[Quickfix\ List\]"')

  let winnr = -1
  if !empty(l)
    let bufnbr = matchstr(l, '[\t ]*\zs\d\+\ze[\t ]\+')
    let winnr = bufwinnr(str2nr(bufnbr, 10))
  endif

  if !empty(getqflist())
    if winnr == -1
      copen
    else
      cclose
      norm =
    endif
  endif
endfunction

"" Quickfix completely bottom
autocmd FileType qf wincmd J
command! -bar -range Mirror <line1>,<line2>call setline('.', join(reverse(split(getline('.'), '\zs')), ''))

"" InsertTimeofDay
function! InsertTimeofDay()
    execute 'read !date "+\%D \%H:\%M"'
endfunction
command! Itod call InsertTimeofDay()
" }}}
" KEYMAPS: {{{
" Makefiles
nnoremap <leader>m      :silent make \|redraw!<cr>
" search and goto functionality
nnoremap <C-o>          :drop **/*
nnoremap <leader>\      :grep<space>
" Make space useful
noremap <space>         v
noremap <c-space>       <c-v>
nnoremap v              <nop>
nnoremap <C-v>          <nop>
" Shortcuts for next result
nnoremap <C-n>          :cn<cr>
nnoremap <C-p>          :cp<cr>
" Close windows faster
"nnoremap <C-c>          :q<cr>
nnoremap <C-k>           {
nnoremap <C-j>           }
nnoremap { <nop>
nnoremap } <nop>
nnoremap { zo
nnoremap } zc
" Smoother scrolling
map <C-U> 20<C-Y>
map <C-D> 20<C-E>
" Quickfix Window from: https://gist.github.com/tacahiroy/3984661
nnoremap <silent> <leader>o    :<C-u>silent call <SID>toggle_qf_list()<Cr>
" TABS
nnoremap = :tabnext<CR>
nnoremap - :tabprevious<CR>
nnoremap + :tabnew<cr>
nnoremap _ :tabclose<cr>

tnoremap <Esc> <C-\><C-n>
" }}}
" CPP: {{{
function! SetCXXErrformat()
    if g:cxxcompiler == "gcc"
      " copied from default errorformat
      setlocal errorformat="%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GIn file included from %f:%l:%c:,%-GIn file included from %f:%l:%c\,,%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-G%*[ ]from %f:%l:%c,%-G%*[ ]from %f:%l:,%-G%*[ ]from %f:%l\,,%-G%*[ ]from %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\,line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory %*[`']%f',%X%*\a[%*\d]: Leaving directory %*[`']%f',%D%*\a: Entering directory %*[`']%f',%X%*\a: Leaving directory %*[`']%f',%DMaking %*\a in %f,%f|%l| %m"
    endif
endfunction
" I always forget about these
function! BindCSnippets()
    iabbrev 2inc #include
    iabbrev 2for for (i = 0; i < n; ++i)<cr>{<cr><cr>}
    iabbrev 2cas case A:<cr><backspace>{<cr>} break;<esc>kk0ellxi<backspace>
    iabbrev 2pcs (*)<esc>hi
    iabbrev 2main int main(int argc, char* argv[])<cr>{<cr>return 0;<cr>}<esc>kki<tab><backspace>
endfunction

augroup group_c_cpp
    autocmd!
    autocmd BufNewFile,BufEnter *.c,*.cpp,*.h,*.hpp,*.cc    :let g:AA_switch=expand("%:t:r")
    autocmd Filetype            c,cpp                       nnoremap <buffer> <leader>c I//<esc>
    autocmd Filetype            c,cpp                       nnoremap <leader>h :drop **/<C-r>=g:AA_switch<cr>
    autocmd Filetype            c,cpp                       :call SetCXXErrformat()
    autocmd Filetype            c,cpp                       setlocal makeprg=make

    autocmd Filetype            c,cpp                       :nnoremap <F5> :!make run > output & disown<cr><cr>
    autocmd Filetype            c,cpp                       :nnoremap <F6> :silent make clean\|redraw!
    " NOTE: comment this to disable "snippets"
    autocmd Filetype            c,cpp                       call BindCSnippets()
augroup END

augroup group_rustlang
    autocmd!
    autocmd Filetype            rust                        setlocal makeprg=cargo\ build
    autocmd Filetype            rust                        setlocal errorformat=
                                                                                \%-G,
                                                                                \%-Gerror:\ aborting\ %.%#,
                                                                                \%-Gerror:\ Could\ not\ compile\ %.%#,
                                                                                \%Eerror:\ %m,
                                                                                \%Eerror[E%n]:\ %m,
                                                                                \%Wwarning:\ %m,
                                                                                \%Inote:\ %m,
                                                                                \%C\ %#-->\ %f:%l:%c,
                                                                                \%E\ \ left:%m,%C\ right:%m\ %f:%l:%c,%Z
    autocmd Filetype            rust                        :nnoremap <F5> :!cargo run<cr>
augroup END
" }}}
" MARKDOWN: {{{
"" Github flavored markdown with md2pdf [https://github.com/walwe/md2pdf]
"" Preview setup with zathura
augroup group_markdown_preview
    autocmd!
    autocmd Filetype            markdown                    setlocal makeprg=md2pdf\ %
    autocmd Filetype            markdown                    nnoremap <f5> :!zathura %:r.pdf & disown<CR><CR>
    autocmd Filetype            markdown                    set spell
augroup END

augroup group_highlight
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
    autocmd WinEnter,VimEnter * :silent! call matchadd('Question', 'NOTE', -1)
augroup END
" }}}
" PLUGINS {{{
"   tpope/commentary {{{
" commentary.vim - Comment stuff out
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.3
" GetLatestVimScripts: 3695 1 :AutoInstall: commentary.vim

if exists("g:loaded_commentary") || v:version < 700
  finish
endif
let g:loaded_commentary = 1

function! s:surroundings() abort
  return split(get(b:, 'commentary_format', substitute(substitute(substitute(
        \ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', '') ,'%s\ze\S', '%s ', '')), '%s', 1)
endfunction

function! s:strip_white_space(l,r,line) abort
  let [l, r] = [a:l, a:r]
  if l[-1:] ==# ' ' && stridx(a:line,l) == -1 && stridx(a:line,l[0:-2]) == 0
    let l = l[:-2]
  endif
  if r[0] ==# ' ' && a:line[-strlen(r):] != r && a:line[1-strlen(r):] == r[1:]
    let r = r[1:]
  endif
  return [l, r]
endfunction

function! s:go(...) abort
  if !a:0
    let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
    return 'g@'
  elseif a:0 > 1
    let [lnum1, lnum2] = [a:1, a:2]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif

  let [l, r] = s:surroundings()
  let uncomment = 2
  for lnum in range(lnum1,lnum2)
    let line = matchstr(getline(lnum),'\S.*\s\@<!')
    let [l, r] = s:strip_white_space(l,r,line)
    if len(line) && (stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let uncomment = 0
    endif
  endfor

  if get(b:, 'commentary_startofline')
    let indent = '^'
  else
    let indent = '^\s*'
  endif

  for lnum in range(lnum1,lnum2)
    let line = getline(lnum)
    if strlen(r) > 2 && l.r !~# '\\'
      let line = substitute(line,
            \'\M' . substitute(l, '\ze\S\s*$', '\\zs\\d\\*\\ze', '') . '\|' . substitute(r, '\S\zs', '\\zs\\d\\*\\ze', ''),
            \'\=substitute(submatch(0)+1-uncomment,"^0$\\|^-\\d*$","","")','g')
    endif
    if uncomment
      let line = substitute(line,'\S.*\s\@<!','\=submatch(0)[strlen(l):-strlen(r)-1]','')
    else
      let line = substitute(line,'^\%('.matchstr(getline(lnum1),indent).'\|\s*\)\zs.*\S\@<=','\=l.submatch(0).r','')
    endif
    call setline(lnum,line)
  endfor
  let modelines = &modelines
  try
    set modelines=0
    silent doautocmd User CommentaryPost
  finally
    let &modelines = modelines
  endtry
  return ''
endfunction

function! s:textobject(inner) abort
  let [l, r] = s:surroundings()
  let lnums = [line('.')+1, line('.')-2]
  for [index, dir, bound, line] in [[0, -1, 1, ''], [1, 1, line('$'), '']]
    while lnums[index] != bound && line ==# '' || !(stridx(line,l) || line[strlen(line)-strlen(r) : -1] != r)
      let lnums[index] += dir
      let line = matchstr(getline(lnums[index]+dir),'\S.*\s\@<!')
      let [l, r] = s:strip_white_space(l,r,line)
    endwhile
  endfor
  while (a:inner || lnums[1] != line('$')) && empty(getline(lnums[0]))
    let lnums[0] += 1
  endwhile
  while a:inner && empty(getline(lnums[1]))
    let lnums[1] -= 1
  endwhile
  if lnums[0] <= lnums[1]
    execute 'normal! 'lnums[0].'GV'.lnums[1].'G'
  endif
endfunction

command! -range -bar Commentary call s:go(<line1>,<line2>)
xnoremap <expr>   <Plug>Commentary     <SID>go()
nnoremap <expr>   <Plug>Commentary     <SID>go()
nnoremap <expr>   <Plug>CommentaryLine <SID>go() . '_'
onoremap <silent> <Plug>Commentary        :<C-U>call <SID>textobject(get(v:, 'operator', '') ==# 'c')<CR>
nnoremap <silent> <Plug>ChangeCommentary c:<C-U>call <SID>textobject(1)<CR>
nmap <silent> <Plug>CommentaryUndo :echoerr "Change your <Plug>CommentaryUndo map to <Plug>Commentary<Plug>Commentary"<CR>

if !hasmapto('<Plug>Commentary') || maparg('gc','n') ==# ''
  xmap gc  <Plug>Commentary
  nmap gc  <Plug>Commentary
  omap gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
  if maparg('c','n') ==# '' && !exists('v:operator')
    nmap cgc <Plug>ChangeCommentary
  endif
  nmap gcu <Plug>Commentary<Plug>Commentary
endif

" vim:set et sw=2:
"   }}}
" }}}
