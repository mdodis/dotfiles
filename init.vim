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
set clipboard+=unnamedplus

"" Make indenting normal
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

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
autocmd VimEnter * wincmd v

"""""""""""""
"KEYBINDINGS"
"""""""""""""
"" Makefiles
nnoremap <leader>m :silent make \|redraw!\|copen<cr><cr>
nnoremap <F6> :silent make clean\|redraw!\|copen<cr><cr>
nnoremap <F5> :!make run<cr><cr>
"" search and goto functionality
nnoremap <C-p> :drop **/*
nnoremap <C-o> <C-w>w
nnoremap <leader>\ :grep<space>
"" Make space useful
noremap <space> v
noremap <c-space> <c-v>
"" Shortcuts for next result
nnoremap <C-n> :cn<cr>
nnoremap <C-l> :cp<cr>
nnoremap <leader>o :cwindow<cr>
"" Close windows faster
nnoremap <C-c> :q<cr>


"""""""""""""
"  C & C++  "
"""""""""""""
"" Help with going to corresponding file
"" On _each_ enter file, set global var to file base name
"" then just do the drop; on \-h
autocmd BufNewFile,BufEnter * :let g:AA_switch=expand("%:t:r")
nnoremap <leader>h :drop **/<C-r>=g:AA_switch<cr>
