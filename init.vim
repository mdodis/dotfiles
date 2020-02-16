" Configuration file for Neovim
" I have accumulated all of these from around the
" internet, and I don't know vimscript particularly well!
" So, be careful please.
" Michael Dodis

" TOUR:
" I disabled line numbers, and wraping (confuzles the hell out'a me).
" Line numbers take up too much space in big files, and besides the
" offseted line numbers, they are useless. Look at the bottom right instead.
" The only plugin currently is comfortable motion. For the looks obviously.
" Disable as needed.

" Tested On two linux machines (Arch and Fedora), works with zero
" extra configuration (st and gnome-terminal)

" SHORTCUTS:
" <leader>m : usually the equivalent make command
" <F5>      : The "run" command
" <leader>\ : Search with silver searcher
" <C-n>     : Show next result in quickfix
" <C-p>     : Show previous result in quickfix
" <leader>o : Toggle quickfix window (really useful for me)
" <C-o>     : Quick goto file (or buffer if it exists)
" <leader>h : Hack to make switching from header to source easier;
" Of course, by default the leader key is \, which I've kept, because
" it reminds me that it's there

" SNIPPETS:
" I have a difficult time typing some char sequences in C
" for example the for loop, or even better a cast to a pointer.
" They require Shift+<char> 3 times! now just type: 2pcs

" UPDATE: 05/31/19
" * Removed Lightline plugin, for portability reasons
" * Added "snippet" support (leader key is 2)
" - Considering removing comfortable_motion as well

" UPDATE: 06/02/19
" * Removed comfortable_motion

" UPDATE: 06/03/19
" * Added C-j C-k to move between paragraphs
" * Added C-s to save everything
" * Added C-f to search (just in case I get used to it)
" * Added mouse=a to enable visual mode mouse
" * Added simple netrw config to open "explorer" tree.
"         I don't know were I'd use this, but oh well.
"         Just for ricing's sake I guess.
" * Added folding because I just learned about it
" * Removed netrw stuff, it caused problems with exiting

" COLORS: {{{
"set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
syntax on
let g:colors_name = ""

hi Comment term=bold ctermfg=Red
hi Normal ctermfg=Grey
hi Constant term=underline ctermfg=Yellow
hi Special term=bold ctermfg=yellow
hi Identifier term=underline ctermfg=Grey
hi Statement term=standout ctermfg=Blue
hi PreProc term=underline ctermfg=Grey
hi Type term=underline ctermfg=White
hi Visual term=reverse ctermfg=Black ctermbg=Grey
hi Search term=reverse ctermfg=Black ctermbg=Cyan gui=NONE guifg=Black guibg=Cyan
hi Tag term=bold ctermfg=DarkGreen guifg=DarkGreen
hi Error term=reverse ctermfg=15 ctermbg=9 guibg=Red guifg=White
hi Todo term=standout ctermbg=Yellow ctermfg=Black guifg=Blue guibg=Yellow
hi  StatusLine term=bold cterm=bold,standout ctermfg=Yellow ctermbg=Gray
hi! link MoreMsg Comment
hi! link ErrorMsg Visual
hi! link WarningMsg ErrorMsg
hi! link Question Comment
hi link String	Constant
hi link Character	Constant
hi link Number	Constant
hi link Boolean	Constant
hi link Float		Number
hi link Function	Identifier
hi link Conditional	Statement
hi link Repeat	Statement
hi link Label		Statement
hi link Operator	Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	Identifier
hi link Define	Identifier
hi link Macro		Identifier
hi link PreCondit	Identifier
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special
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
nnoremap <C-c>          :q<cr>
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

" }}}
" CPP: {{{
function! SetCXXErrformat()
    if g:cxxcompiler == "gcc"
        " copied from default errorformat
        setlocal errorformat="%*[^"]"%f"%*\D%l: %m,"%f"%*\D%l: %m,%-G%f:%l: (Each undeclared identifier is reported only once,%-G%f:%l: for each function it appears in.),%-GIn file included from %f:%l:%c:,%-GIn file included from %f:%l:%c\,,%-GIn file included from %f:%l:%c,%-GIn file included from %f:%l,%-G%*[ ]from %f:%l:%c,%-G%*[ ]from %f:%l:,%-G%*[ ]from %f:%l\,,%-G%*[ ]from %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,"%f"\,line %l%*\D%c%*[^ ] %m,%D%*\a[%*\d]: Entering directory %*[`']%f',%X%*\a[%*\d]: Leaving directory %*[`']%f',%D%*\a: Entering directory %*[`']%f',%X%*\a: Leaving directory %*[`']%f',%DMaking %*\a in %f,%f|%l| %m"
    else
        " NOTE: untested! Maybe once I get nvim setup on Windows. Maybe.
        setlocal errorformat=%*[0-9]%*[>]\ %#%f(%l):\ %m
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
" }}}
" Markdown: {{{
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
