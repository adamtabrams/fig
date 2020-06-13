"### Plug ########################################
if ! filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tomtom/tcomment_vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yggdroot/indentline'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
call plug#end()

"### Plugins #####################################
let g:fzf_layout = { 'down': '~70%' }
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=? GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

let g:ale_fixers = {
    \   'go':         ['goimports'],
    \   'rust':       ['rustfmt'],
    \   'python':     ['black'],
    \   'vue':        ['prettier'],
    \   'javascript': ['prettier']
    \}

let g:ale_rust_rls_config = {
    \   'rust': {
    \     'clippy_preference': 'on'
    \   }
    \ }

let g:rustlint1 = ['rls', 'cargo']
let g:rustlint2 = ['rls', 'cargo', 'rustc']

let g:ale_linters = {
    \   'go': ['gopls', 'gobuild', 'golangci-lint'],
    \   'rust': g:rustlint1
    \}

let g:ale_go_golangci_lint_options = "--enable-all -D lll,gomnd -E EXC0002 --skip-files _test.go"
let g:ale_rust_ignore_error_codes = ['E0601']

let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 0

let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0
let g:go_imports_mode = "gopls"
let g:go_gopls_complete_unimported = v:true
let g:go_gopls_deep_completion = v:true
let g:go_gopls_matcher = "fuzzy"

let g:solarized_termtrans = 1
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"

let g:airline_powerline_fonts = 1
let g:airline_solarized_bg = "dark"

let g:indentLine_char = '│'

let g:racer_insert_paren = 1
let g:racer_experimental_completer = 1

"### Settings ####################################
set fileformats=unix,mac,dos
set wildmode=longest,list,full
set clipboard+=unnamedplus
set spelllang=en_us
set shell=/bin/zsh
set history=200
set mouse=a
set go=a
set scrolloff=2
set inccommand=split
set tabstop=4 shiftwidth=4 expandtab shiftround
set foldmethod=indent foldlevelstart=99 foldnestmax=3
set ignorecase smartcase fileignorecase wildignorecase
set number relativenumber
set splitbelow splitright
set nohlsearch
set hidden
set background=dark
set iskeyword+=-
set nojoinspaces
colorscheme solarized
syntax enable
highlight! link MatchParen SpellBad

"### Autocmds ####################################
autocmd TermOpen           *              setlocal nonu nornu
autocmd TermOpen           *              IndentLinesDisable
autocmd TermOpen           *              startinsert
autocmd BufWritePre        *              %s:\s\+$::e
autocmd BufNewFile,BufRead *              set formatoptions-=o conceallevel=0
autocmd BufNewFile,BufRead Jenkinsfile    setlocal filetype=groovy
autocmd BufNewFile,BufRead *.mom          setlocal filetype=groff
autocmd FileType           yaml,json      set tabstop=2 shiftwidth=2
autocmd FileType           json,markdown  IndentLinesDisable
autocmd FileType           markdown       setlocal spell

"### Functions ##################################
function! ResizeMode()
    let key = nr2char(getchar())
    while key != "q" && key != "\<ESC>"
        if key == "h"
            vertical resize -5
        elseif key == "l"
            vertical resize +5
        elseif key == "j"
            resize +5
        elseif key == "k"
            resize -5
        elseif key == "="
            wincmd =
        endif
        redraw
        let key = nr2char(getchar())
    endwhile
    return ""
endfunction

function! GetMotion()
    let a = getchar()
    let b = ""
    let c = ""
    if a >= char2nr("0") && a <= char2nr("9")
        let b = GetMotion()
    elseif a == char2nr("i") || a == char2nr("a")
        let c = getchar()
    elseif a == char2nr("t") || a == char2nr("f")
        let c = getchar()
    elseif a == char2nr("T") || a == char2nr("F")
        let c = getchar()
    endif
    return nr2char(a) . b . nr2char(c)
endfunction

function! ChangeReplace(...)
    let motion = get(a:, 1)
    if a:0 == 0
        let motion = GetMotion()
    endif
    let save_cursor = getcurpos()
    exe 'norm "_c'.motion.trim(getreg("+"), "\<c-J>")."\<ESC>mm"
    call setpos(".", save_cursor)
    norm ='m
    call setpos(".", save_cursor)
    call repeat#set(":call ChangeReplace('".motion."')\<CR>",-1)
    return ""
endfunction

function! CleverTab()
    if pumvisible()
        return "\<c-n>"
    elseif strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    endif
    return "\<c-n>"
endfunction

function! OmniTab()
    if pumvisible()
        return "\<c-p>"
    endif
    return "\<c-x>\<c-o>"
endfunction

function! CompletionStatus()
    call complete(col('.'), ['✔', '●', '◐', '○', '✖', ' '])
    return ""
endfunc

function! AlignWithMark()
    call repeat#set("i\<c-r>=AlignWithMark()\<CR>\<ESC>",-1)
    return "\<c-r>=repeat(' ',col(\"'m\")-col('.'))\<CR>\<ESC>"
endfunction

"### Remappings ##################################
"--- Hotfix --------------------------------------
cnoremap 3636  <c-u>undo<CR>

"--- Should-Be-Defaults --------------------------
cnoremap w!!    execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
nnoremap c      "_c
nnoremap Y      y$
inoremap <c-v>  <c-o>p
tnoremap <c-\>  <c-\><c-n>
tmap     <c-w>  <c-\><c-w>

"--- Functions -----------------------------------
nnoremap <silent> <c-w>r   <c-w>t:call ResizeMode()<CR>
nnoremap <silent> <c-w>R   :call ResizeMode()<CR>

inoremap <silent> <c-c>    <c-r>=CompletionStatus()<CR>

nnoremap <silent> gC       :call ChangeReplace()<CR>

inoremap <silent> <Tab>    <c-r>=CleverTab()<CR>
inoremap <silent> <s-Tab>  <c-r>=OmniTab()<CR>

nnoremap <silent> gA       i<c-r>=AlignWithMark()<CR><ESC>
vnoremap <silent> gA       I<c-r>=AlignWithMark()<CR><ESC>

"--- Testing -------------------------------------
nnoremap <silent> gw  :w<CR>
nnoremap <silent> gN  :tabnext<CR>
nnoremap <silent> gP  :tabprevious<CR>
nnoremap <c-d>        <c-d>zz
nnoremap <c-u>        <c-u>zz

"--- Autocomplete --------------------------------
inoremap <c-f>  <c-x><c-f>
inoremap <c-l>  <c-x><c-l>
inoremap <c-b>  <c-x><c-p>
"^ <c-x><c-p> block complete (continue completing where left off)

"--- Splits/Buffers ------------------------------
nnoremap <silent> gn   :bn<CR>
nnoremap <silent> gp   :bp<CR>
nnoremap <silent> gbd  :bd<CR>
nnoremap <silent> gbD  :bd \| sbn<CR>

"--- Writing -------------------------------------
cnoremap <silent> Essayon   Goyo  \| ALEDisableBuffer \| setlocal fo+=a tw=81 nospell<CR>
cnoremap <silent> Essayoff  Goyo! \| ALEEnableBuffer  \| setlocal fo-=a tw=0  spell<CR>

"--- Coding --------------------------------------
nnoremap goq  <c-w>j<c-w>q
nnoremap gs   :%s//g<Left><Left>
nnoremap gS   :%s/<c-r><c-w>//g<Left><Left>
nnoremap gth  :set hlsearch!<CR>
nnoremap gtl  :IndentLinesToggle<CR>

"--- Surround ------------------------------------
nmap dsf  dt(ds(
nmap dsm  dt[ds[
nmap dsl  dt{ds{
nmap dsv  dt<ds<
nmap g'   ysiW"

"--- Ale Linting ---------------------------------
nnoremap <silent> gaa  :ALEFirst<CR>
nnoremap <silent> gan  :ALENextWrap<CR>
nnoremap <silent> gap  :ALEPreviousWrap<CR>
nnoremap <silent> gaf  :ALEFix<CR>
nnoremap <silent> gad  :ALEDetail<CR>

"--- Vim-Go --------------------------------------
autocmd FileType go nnoremap goi  :GoInfo<CR>
autocmd FileType go nnoremap got  :GoTest<CR>
autocmd FileType go nnoremap goT  :GoTestFunc!<CR>
autocmd FileType go nnoremap goa  :GoAlternate<CR>
autocmd FileType go nnoremap goA  :e <c-r>%<LEFT><LEFT><LEFT>_test<CR>
autocmd FileType go nnoremap goc  :GoCoverageToggle<CR>
autocmd FileType go nnoremap goC  :GoCoverageBrowser<CR>
autocmd FileType go nnoremap gor  :GoRun %<CR>
autocmd FileType go nnoremap goR  :GoRun %<Space>
autocmd FileType go nnoremap gd   :GoDef<CR>
autocmd FileType go nnoremap gD   :sp<CR>:GoDef<CR>
autocmd FileType go nnoremap gob  :GoTestCompile<CR>
autocmd FileType go nnoremap gtl  :set list!<CR>
autocmd FileType go IndentLinesDisable
autocmd FileType go highlight link Whitespace Conceal
autocmd FileType go set list listchars=tab:\|\ "keep trailing space

"--- Vim-Rust ------------------------------------
augroup Racer
    " autocmd!
    autocmd FileType rust nmap gd   <Plug>(rust-def)
    autocmd FileType rust nmap gD   <Plug>(rust-def-split)
    autocmd FileType rust nmap K    <Plug>(rust-doc)
    autocmd FileType rust nmap gor  :Crun<CR>
    autocmd FileType rust nmap goR  :Crun<Space>
    autocmd FileType rust nmap got  :Ctest<CR>
    autocmd FileType rust nmap goT  :RustTest<CR>
    autocmd FileType rust nmap gob  :Cbuild<CR>
    autocmd FileType rust nmap gtr  :let g:ale_linters['rust'] = g:rustlint1<CR>
    autocmd FileType rust nmap gtR  :let g:ale_linters['rust'] = g:rustlint2<CR>
augroup END

"--- Leader Key ----------------------------------
let mapleader = ","

"--- Fzf -----------------------------------------
let maplocalleader = "\<Space>"
" nnoremap <LocalLeader><LocalLeader>  :Lines<CR>
nnoremap <LocalLeader>l              :Lines<CR>
nnoremap <LocalLeader>f              :Files<CR>
nnoremap <LocalLeader>g              :GFiles<CR>
nnoremap <LocalLeader>s              :GFiles?<CR>
nnoremap <LocalLeader>b              :Buffers<CR>
nnoremap <LocalLeader>w              :Windows<CR>
nnoremap <LocalLeader>r              :Rg<CR>
nnoremap <LocalLeader>h              :History<CR>
nnoremap <LocalLeader>m              :Maps<CR>
nnoremap <LocalLeader>t              :Filetypes<CR>
nnoremap <LocalLeader>T              :set filetype=<CR>
nnoremap <LocalLeader>~              :Files ~
nnoremap <LocalLeader>.              :Files ../
nnoremap <LocalLeader>/              :BLines<CR>
nnoremap <LocalLeader>'              :Marks<CR>
nnoremap <LocalLeader>:              :Commands<CR>
nnoremap <LocalLeader>?              :Helptags<CR>

"--- Easy Motion ---------------------------------
" nmap gf      <Plug>(easymotion-overwin-w)
" nmap gF      <Plug>(easymotion-bd-wl)
" nmap g<c-f>  <Plug>(easymotion-jumptoanywhere)
nmap <LocalLeader><LocalLeader>  <Plug>(easymotion-overwin-w)
nmap <LocalLeader>F              <Plug>(easymotion-bd-wl)
nmap <LocalLeader>A              <Plug>(easymotion-jumptoanywhere)
