" --- Visuals & General Behavior ---
syntax on
filetype on
set number
set cursorcolumn
set hlsearch
set showmatch
set textwidth=80
set mouse=a            " Enables mouse clicking and scrolling

" Automatically clear search highlights when entering Insert mode
autocmd InsertEnter * :let @/=""

" --- File Handling ---
set noswapfile
set nobackup

" --- Indentation (2-Space Standard) ---
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent

" --- Status Line ---
set laststatus=2
set statusline=
set statusline+=%#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=%#Todo#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=%#DiffChange#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=%#Visual#
set statusline+=\ %f
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%p%%]
set statusline+=\ %l:%c
set statusline+=\ 

" --- VS Code Style Auto-Closing Pairs ---

" 1. Brackets & Parentheses (Type-through if exists, else create pair)
inoremap <expr> ( strpart(getline('.'), col('.')-1, 1) == '(' ? "\<Right>" : "()\<Left>"
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ')' ? "\<Right>" : ")"
inoremap <expr> [ strpart(getline('.'), col('.')-1, 1) == '[' ? "\<Right>" : "[]\<Left>"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == ']' ? "\<Right>" : "]"

" 2. Curly Braces (The logic stays separate to allow for the 'Enter' expansion)
inoremap { {}<Left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == '}' ? "\<Right>" : "}"

" 3. Quotes (Already consolidated)
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == '"' ? "\<Right>" : "\"\"\<Left>"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''\<Left>"

" 4. Snappiness Fix
" This reduces the wait time for {<CR> or {; from 1s to 0.3s
set timeoutlen=300


" 5. Smart Backspace Function
function! SmartBackspace()
    let l:line = getline('.')
    let l:col = col('.')
    let l:pair = strpart(l:line, l:col - 2, 2)
    if l:pair == '()' || l:pair == '[]' || l:pair == '{}' || l:pair == '""' || l:pair == "''"
        return "\<Left>\<Del>\<Del>"
    else
        return "\<BS>"
    endif
endfunction

inoremap <expr> <BS> SmartBackspace()

" --- Quick Utilities ---

" Press Space then 's' to instantly reload your config
let mapleader = " "
nnoremap <leader>s :source ~/.vimrc<CR>:echo "Config Reloaded!"<CR>