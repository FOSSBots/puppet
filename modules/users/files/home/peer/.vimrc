runtime! debian.vim
syntax on
set background=dark

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set showcmd            " Show (partial) command in status line.
set showmatch          " Show matching brackets.
set smartcase          " Do smart case matching
set incsearch          " Incremental search
set autowrite          " Automatically save before commands like :next and :make
set mouse=
