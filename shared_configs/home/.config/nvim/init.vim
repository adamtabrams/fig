"### Plug ########################################
if ! filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'overcache/NeoSolarized'
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
let g:ale_hover_cursor = 0

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
let g:go_imports_mode = "gopls"
let g:go_gopls_complete_unimported = v:true
let g:go_gopls_deep_completion = v:true
let g:go_gopls_matcher = "fuzzy"
let g:go_doc_popup_window = 1

let g:neosolarized_contrast = "high"
let g:neosolarized_visibility = "high"

let g:airline_powerline_fonts = 1
let g:airline_solarized_bg = "dark"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" tracked file is modified: ''
let g:airline_symbols.dirty = "\ue00a"
" file is not tracked: ''
let g:airline_symbols.notexists = "\ue009"

let g:indentLine_char = '│'

let g:racer_insert_paren = 1
let g:racer_experimental_completer = 1

let g:EasyMotion_keys = "ohlurfdaies"

"### Settings ####################################
set fileformats=unix,mac,dos
set wildmode=longest,list,full
set clipboard+=unnamedplus
set spelllang=en_us
set shell=/bin/zsh
set history=200
set mouse=a
set go=a
set scrolloff=5
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
set termguicolors
colorscheme NeoSolarized
syntax enable
highlight! link MatchParen SpellBad

"### Autocmds ####################################
autocmd BufWritePre  *  %s:\s\+$::e
autocmd TermOpen     *  setlocal nonu nornu | IndentLinesDisable | startinsert

autocmd BufNewFile,BufRead  *                set formatoptions-=o conceallevel=0
autocmd BufNewFile,BufRead  Jenkinsfile      setlocal filetype=groovy
autocmd BufNewFile,BufRead  *.mom            setlocal filetype=groff
autocmd BufNewFile,BufRead  *.avsc           setlocal filetype=json
autocmd BufNewFile,BufRead  calcurse-note*   setlocal filetype=markdown

autocmd FileType  yaml,json                set ts=2 sw=2
autocmd FileType  json,markdown,text,help  IndentLinesDisable
autocmd FileType  markdown,text            setlocal spell lbr

let g:loaded_netrw = 1
autocmd BufEnter * if isdirectory(expand('%')) | call DelBufferOrQuit()

"### Functions ##################################
function! ResizeMode()
    let saved_win = win_getid(winnr())
    exe "norm \<c-w>t"
    let char = getcharstr()
    while char != "q" && char != "\<ESC>"
        if char == "h" || char == "\<Left>"
            vertical resize -5
        elseif char == "l" || char == "\<Right>"
            vertical resize +5
        elseif char == "j" || char == "\<Down>"
            resize +5
        elseif char == "k" || char == "\<Up>"
            resize -5
        elseif char == "="
            wincmd =
        endif
        redraw
        let char = getcharstr()
    endwhile
    call win_gotoid(saved_win)
    return ""
endfunction

function! GetMotion()
    let a = getcharstr()
    let b = ""
    if a >= "0" && a <= "9"
        let b = GetMotion()
    elseif a == "i" || a == "a" || a == "t" || a == "f" || a == "T" || a == "F"
        let b = getcharstr()
    endif
    return a . b
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

function! YankAppend(...)
    let motion = get(a:, 1)
    if a:0 == 0
        let motion = GetMotion()
    endif
    let regA = @a
    let @a = @+
    exe 'norm "Ay'.motion
    let @+ = @a
    let @a = regA
    call repeat#set(":call YankAppend('".motion."')\<CR>",-1)
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

function! TempTerm(...)
    let command = get(a:, 1)
    exe "autocmd TermClose * ++once b#|bd!#"
    exe "terminal ".command
    return ""
endfunction

function! DelBufferOrQuit()
    if len(getbufinfo({"buflisted":1})) == 1
        exe "q"
    else
        let closedbufname = bufname()
        exe "b#|bw!#"
        echo "closed buffer: ".closedbufname
    endif
    return ""
endfunction

function! GitFileUrl()
    let repo_url = substitute(FugitiveRemoteUrl(), "\.git$", "", "")
    let branch = FugitiveHead()
    let tree = substitute(FugitivePath(), "^".FugitiveWorkTree(), "", "")
    let line = line(".")
    return repo_url."/blob/".branch.tree."\\#L".line
endfunction

"### Remappings ##################################
"--- Functions -----------------------------------
nnoremap <silent> gC       :call ChangeReplace()<CR>
nnoremap <silent> gy       :call YankAppend()<CR>

nnoremap <silent> gh       :let @+ = GitFileUrl()<CR>
nnoremap <silent> gH       :silent exe "!open ".GitFileUrl()<CR>

nnoremap <silent> gA       i<c-r>=AlignWithMark()<CR><ESC>
vnoremap <silent> gA       I<c-r>=AlignWithMark()<CR><ESC>

nnoremap <silent> <c-w>r   :call ResizeMode()<CR>

inoremap <silent> <c-c>    <c-r>=CompletionStatus()<CR>

inoremap <silent> <Tab>    <c-r>=CleverTab()<CR>
inoremap <silent> <s-Tab>  <c-r>=OmniTab()<CR>

"--- Should-Be-Defaults --------------------------
nnoremap <silent> gw     :w<CR>
nnoremap <silent> c      "_c
nnoremap <silent> Y      y$
nnoremap <silent> C      "_C
nnoremap <silent> x      "_x
tnoremap <silent> <c-\>  <c-\><c-n>
tmap     <silent> <c-w>  <c-\><c-w>

cnoremap W!  execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"--- Testing -------------------------------------
nnoremap <silent> gW     ZZ
nnoremap <silent> gQ     ZQ

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
function! s:goyo_enter()
    " setlocal fo+=a tw=81 lbr nospell
    setlocal lbr nospell
    nnoremap j  gj
    nnoremap k  gk
    ALEDisableBuffer
    setlocal eventignore=FocusGained
endfunction

function! s:goyo_leave()
    setlocal lbr spell
    ALEEnableBuffer
    setlocal eventignore=
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

autocmd FileType text nnoremap gan  ]s
autocmd FileType text nnoremap gap  [s
autocmd FileType text nnoremap gaf  z=
autocmd FileType text nnoremap gaF  :spellrepall<CR>

"--- Coding --------------------------------------
nnoremap goq  <c-w>j<c-w>q
nnoremap gs   :%s//g<Left><Left>
nnoremap gS   :%s/<c-r><c-w>//g<Left><Left>
nnoremap gth  :set hlsearch!<CR>
nnoremap gtl  :IndentLinesToggle<CR>

"--- Surround ------------------------------------
nmap <silent> dsf  dt(ds(
nmap <silent> dsm  dt[ds[
nmap <silent> dsl  dt{ds{
nmap <silent> dsv  dt<ds<
nmap <silent> g'   ysiW"

"--- Ale Linting ---------------------------------
nnoremap <silent> gaa  :ALEFirst<CR>
nnoremap <silent> gan  :ALENextWrap<CR>
nnoremap <silent> gap  :ALEPreviousWrap<CR>
nnoremap <silent> gaf  :ALEFix<CR>
nnoremap <silent> gad  :ALEDetail<CR>

"--- Vim-Go --------------------------------------
autocmd FileType go nnoremap gd   :GoDef<CR>
autocmd FileType go nnoremap gD   :sp<CR>:GoDef<CR>
autocmd FileType go nnoremap goi  :GoInfo<CR>
autocmd FileType go nnoremap goI  :GoSameIdsToggle<CR>
autocmd FileType go nnoremap got  :GoTest!<CR>
autocmd FileType go nnoremap goT  :GoTestFunc!<CR>
autocmd FileType go nnoremap goa  :GoAlternate<CR>
autocmd FileType go nnoremap goA  :e <c-r>%<LEFT><LEFT><LEFT>_test<CR>
autocmd FileType go nnoremap goc  :GoCoverageToggle<CR>
autocmd FileType go nnoremap goC  :GoCoverageBrowser<CR>
autocmd FileType go nnoremap gor  :GoRun %<CR>
autocmd FileType go nnoremap goR  :GoRun %<Space>
autocmd FileType go nnoremap gob  :GoTestCompile<CR>
autocmd FileType go nnoremap gtl  :set list!<CR>

autocmd FileType go nnoremap <silent> goo  :silent exe "!open ".
    \ substitute('<c-r><c-l>', '^.*"\([^/]*/[^/]*/[^/]*\)\(.*\)"', 'https://\1/tree/master\2', '')<CR>

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
nnoremap <silent> <Leader>t  :call TempTerm(" ")<CR>
nnoremap <silent> <Leader>L  :call TempTerm("lazygit")<CR>
nnoremap <silent> <Leader>l  :call TempTerm("lf")<CR>

"--- Fzf -----------------------------------------
let maplocalleader = "\<Space>"
nnoremap <LocalLeader>g  :GFiles<CR>
nnoremap <LocalLeader>s  :GFiles?<CR>
nnoremap <LocalLeader>c  :Files<CR>
nnoremap <LocalLeader>L  :Lines<CR>
nnoremap <LocalLeader>t  :Filetypes<CR>
nnoremap <LocalLeader>T  :set filetype=<CR>
nnoremap <LocalLeader>b  :Buffers<CR>
nnoremap <LocalLeader>w  :Windows<CR>
nnoremap <LocalLeader>r  :Rg<CR>
nnoremap <LocalLeader>h  :History<CR>
nnoremap <LocalLeader>m  :Maps<CR>
nnoremap <LocalLeader>/  :BLines<CR>
nnoremap <LocalLeader>'  :Marks<CR>
nnoremap <LocalLeader>:  :Commands<CR>
nnoremap <LocalLeader>?  :Helptags<CR>
nnoremap <LocalLeader>~  :Files ~
nnoremap <LocalLeader>.  :Files ../

"--- Easy Motion ---------------------------------
nmap <LocalLeader><LocalLeader>  <Plug>(easymotion-overwin-w)
nmap <LocalLeader>a              <Plug>(easymotion-jumptoanywhere)
nmap <LocalLeader>f              <Plug>(easymotion-bd-wl)
nmap <LocalLeader>l              <Plug>(easymotion-sol-bd-jk)
