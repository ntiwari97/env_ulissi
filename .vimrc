" Plugins via Vundle
filetype off                        " not sure what it does. needed for Vundle I think
set rtp+=~/.vim/bundle/Vundle.vim   " set the runtime path to include Vundle and initialize
call vundle#begin()                 " Put Vundle plugin commands after this
Plugin 'gmarik/Vundle.vim'                  " let Vundle manage Vundle...?
Plugin 'vim-scripts/indentpython.vim'       " More indenting help via plugin
Plugin 'ajmwagar/vim-deus'                  " Colorscheme
Plugin 'w0rp/ale'                           " Use Ale as style/python checker
let g:ale_linters = {'python':['flake8']}   " Only use Pylint when looking at Python
call vundle#end()                   " Put Vundle plugin commands before this
filetype plugin indent on           " Finish of Vundling. Not sure what this does

" Highlighting, tabs, etc.
syntax on                           " Enable syntax highlighting
set background=dark                 " Change highlighting to be friendly with black screen
silent! colors deus                 " Color scheme
set t_Co=256                        " Set correct colors inside Docker image
set number                          " Paired with above, this shows hybrid line number
set tabstop=4                       " how many spaces to add when tabbing
set softtabstop=4                   " I dunno, really. But it's consistent with tabstop
set shiftwidth=4                    " I dunno, really. But it's consistent with tabstop
set expandtab                       " don't use actual tab character (ctrl-v)
set fileformats=unix,dos,mac        " set fileformats so they play nice with Github
set splitbelow                      " when I split windows, put new ones on the bottom
set splitright                      " when I split windows, put new ones on the right
set backspace=indent,eol,start      " fix backspace...?

" Now VIM will use the system's clipboard instead of its own
set clipboard^=unnamed,unnamedplus
"set clipboard=unnamedplus

" Temporarily disable highlighting (for use after hlsearch)
set hlsearch
nnoremap <silent> <space> :nohls<cr>
" F3 now eliminates all trailing whitespace in the document
nnoremap <silent> <F3> :%s/\s\+$//e<cr>
" Remap the toggling so that cntrl+direction just jumps to the window
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Another save button
nnoremap <C-c> :w!<cr>

" Some things to make Python life easier
augroup py
    autocmd!
    autocmd FileType python setlocal foldmethod=indent foldlevel=0
    autocmd FileType python highlight OverLength ctermbg=236
    autocmd FileType python match OverLength /\%101v.\+/
augroup END

" Turn on spell checker some file types
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md  set ft=markdown
augroup md
    autocmd!
    autocmd FileType markdown setlocal spell spelllang=en_us
augroup END

