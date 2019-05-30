"" Configuration file for Neovim
"" I have accumulated all of these from around the
"" internet, and I don't know vimscript particularly well!
"" Michael Dodis

"" vim-plug """"""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'yuttie/comfortable-motion.vim'
Plug 'itchyny/lightline.vim'
call plug#end()
""""""""""""""""""""""""""""""""""""""""

"" Smooth Scrolling
let g:comfortable_motion_interval = 10.6
let g:comfortable_motion_friction = 200.0
let g:comfortable_motion_air_drag = 4.0
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

"" Line Nubmers aren't useful 
set nonumber
syntax on

"" Only use the system clipboard.
"" Why would _anyone_. Ever. Use. The.
"" Vim clipboard!?
set clipboard   +=unnamedplus

"" Make indenting normal
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set autoindent
set nowrap      " My son has turned into a wrapper!


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
else
    " POSIX filesystem
    set directory=$HOME/.backups/swaps,$HOME/.backups,$HOME/tmp,.
    set backupdir=$HOME/.backups/backups,$HOME/.backups,$HOME/tmp,.
    if exists("&undodir")
        set undodir=$HOME/.backups/undofiles,$HOME/.backups,$HOME/tmp,.
    endif
    let g:cxxcompiler = "gcc"
endif

"" Make quick search better
set nohlsearch
set incsearch

"" Statusline
set laststatus=2

set wildmenu
"" Ignore common non-text files
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico     " Images
set wildignore+=*.pdf,*.psd                             " Documents
set wildignore+=*.so,*.o,*.lib,*.dll,*.pdb              " object files
set wildignore+=node_modules/*,bower_components/*       "directories

"" Use the Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"" Start vim in split mode!
"autocmd VimEnter * wincmd v

let g:netrw_banner=0    " disable banner
set path+=**            " clever'r completion
set ignorecase smartcase
" unfuck whitespace
nnoremap <F4> :retab<CR>:%s/\s\+$//e<CR><C-o>

" quickfix
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
    endif
  endif
endfunction

"" InsertTimeofDay
function! InsertTimeofDay()
    execute 'read !date "+\%D \%H:\%M"'
endfunction
command ITDay call InsertTimeofDay()

"""""""""""""
"KEYBINDINGS"
"""""""""""""
"" Toggle quickfix
"nnoremap <C-g><C-o> <Plug>window:quickfix:loop
"" Makefiles
nnoremap <leader>m      :silent make \|redraw!<cr>
nnoremap <F6>           :silent make clean\|redraw!
nnoremap <F5>           :!make run<cr><cr>
"" search and goto functionality
nnoremap <C-p>          :drop **/*
nnoremap <C-o>          <C-w>w
nnoremap <leader>\      :grep<space>
"" Make space useful
noremap <space>         v
noremap <c-space>       <c-v>
"" Shortcuts for next result
nnoremap <C-n>          :cn<cr>
nnoremap <C-l>          :cp<cr>
"" Close windows faster
nnoremap <C-c>          :q<cr>
"" Quickfix Window from :: https://gist.github.com/tacahiroy/3984661
nnoremap <silent> <leader>o    :<C-u>silent call <SID>toggle_qf_list()<Cr>

"""""""""""""
"  C & C++  "
"""""""""""""
"" Help with going to corresponding file
"" On _each_ enter file, set global var to file base name
"" then just do the drop; on \-h

function! SetCXXErrformat()
    if g:cxxcompiler == "gcc"
        setlocal errorformat="%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GIn file included from %f:%l:%c:,%-GIn file included from %f:%l:%c\,,%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-G%*[ ]from %f:%l:%c,%-G%*[ ]from %f:%l:,%-G%*[ ]from %f:%l\,,%-G%*[ ]from %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\,line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory %*[`']%f',%X%*\a[%*\d]: Leaving directory %*[`']%f',%D%*\a: Entering directory %*[`']%f',%X%*\a: Leaving directory %*[`']%f',%DMaking %*\a in %f,%f|%l| %m"
    else
        setlocal errorformat=%*[0-9]%*[>]\ %#%f(%l):\ %m
    endif
endfunction

augroup group_c_cpp
    autocmd!
    autocmd BufNewFile,BufEnter *.c,*.cpp,*.h,*.hpp,*.cc    :let g:AA_switch=expand("%:t:r")
    autocmd Filetype            c,cpp                       nnoremap <buffer> <leader>c I//<esc>
    autocmd Filetype            c,cpp                       nnoremap <leader>h :drop **/<C-r>=g:AA_switch<cr>

    autocmd Filetype            c,cpp                       :call SetCXXErrformat()
augroup END

"""""""""""""
" Markdown  "
"""""""""""""
"" Github flavored markdown with md2pdf [https://github.com/walwe/md2pdf]
"" Preview setup with zathura 
augroup group_markdown_preview
    autocmd!
    autocmd Filetype            markdown                    setlocal makeprg=md2pdf\ %
    autocmd Filetype            markdown                    nnoremap <f5> :!zathura %:r.pdf & disown<CR><CR>
augroup END
