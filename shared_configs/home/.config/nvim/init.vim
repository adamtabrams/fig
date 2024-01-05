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
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

"### Plugins #####################################
let g:fzf_layout = { 'down': '~70%' }
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-p']

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=? GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Bindings
    \ call fzf#vim#grep('grep --line-number "ma[p]" ~/.config/nvim/init.vim -- '.shellescape(<q-args>), 0,
    \ fzf#vim#with_preview({'options': ['--delimiter=:', '--with-nth=3..']}), <bang>0)

let g:ale_fixers = {
    \   'go':         ['goimports', 'gofumpt'],
    \   'rust':       ['rustfmt'],
    \   'python':     ['black'],
    \   'vue':        ['prettier'],
    \   'javascript': ['prettier']
    \}
    " \   'go':         ['goimports'],
    " \   'go':         ['goimports', 'golines', 'gofumpt'],

let g:ale_rust_rls_config = {
    \   'rust': {
    \     'clippy_preference': 'on'
    \   }
    \ }

let g:ale_linters = {
    \   'go': ['golangci-lint'],
    \   'rust': ['rls', 'cargo']
    \}
    " \   'go': ['gopls', 'gobuild', 'golangci-lint'],
    " \   'rust': ['rls', 'cargo', 'rustc']

" let g:ale_go_golangci_lint_options = "--enable-all -D lll,gomnd -E EXC0002 --skip-files _test.go"
let g:ale_go_golangci_lint_options = "--config ~/.golangci.yaml"
let g:ale_go_golangci_lint_package = 1
let g:ale_rust_ignore_error_codes = ['E0601']
let g:ale_hover_cursor = 0
let g:ale_virtualtext_cursor = 1

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
" let g:go_doc_popup_window = 1

let g:racer_insert_paren = 1
let g:racer_experimental_completer = 1

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

let g:EasyMotion_keys = "xwchmuloriaefds"

autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
autocmd TermLeave * AirlineRefresh
autocmd TermOpen * setlocal laststatus=0 noshowmode noruler
  \| autocmd TermClose * setlocal laststatus=2 showmode ruler

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
" syntax enable
highlight! link MatchParen SpellBad
highlight! link EasyMotionTarget2First EasyMotionTargetDefault

"### Lua #########################################

" lua << EOF
" require'nvim-treesitter.configs'.setup {
"     highlight = { enable = true },
"     indent = { enable = true },
"     incremental_selection = { enable = true },
"     textobjects = { enable = true },
"     -- folding = { enable = true },
"     locals = { enable = true },
" }

" vim.lsp.start({
"     name = 'golang-lsp',
"     cmd = {'gopls'},
"     root_dir = vim.fs.dirname(vim.fs.find({'go.mod'}, { upward = true })[1]),
" })

" -- vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc()"
" EOF

" set omnifunc=v:lua.vim.lsp.omnifunc()
" " set omnifunc=vim.lsp.omnifunc()

"### Autocmds ####################################
autocmd BufWritePre  *  %s:\s\+$::e
autocmd TermOpen     *  setlocal nonu nornu | IndentLinesDisable | startinsert

autocmd BufNewFile,BufRead  *                set formatoptions-=o conceallevel=0
autocmd BufNewFile,BufRead  Jenkinsfile*     setlocal filetype=groovy
autocmd BufNewFile,BufRead  *.mom            setlocal filetype=groff
autocmd BufNewFile,BufRead  *.avsc           setlocal filetype=json
autocmd BufNewFile,BufRead  calcurse-note*   setlocal filetype=markdown

autocmd FileType  yaml,json,markdown       set ts=2 sw=2
autocmd FileType  json,markdown,text,help  IndentLinesDisable
" autocmd FileType  markdown                 setlocal spell lbr
" autocmd FileType  markdown,text            setlocal spell lbr

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
    set paste
    exe 'norm "_c'.motion.trim(getreg("+"), "\<c-J>")."\<ESC>"
    set nopaste
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

function! YankComment(...)
    let motion = get(a:, 1)
    if a:0 == 0
        let motion = GetMotion()
    endif
    norm mp
    if motion == "c"
        norm yy
    elseif motion == "ip"
        norm yap
    else
        exe 'norm y'.motion
    endif
    norm 'p
    " exe 'norm gc'.motion
    exe 'norm yc'.motion
    call repeat#set(":call YankComment('".motion."')\<CR>",-1)
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
    exe "terminal ".command
    return ""
endfunction

function! DelBufferOrQuit()
    if len(getbufinfo({"buflisted":1})) == 1
        exe "q"
    else
        let closedbufname = bufname()
        exe "bd! ".closedbufname
        echo "closed buffer: ".closedbufname
    endif
    return ""
endfunction

function! GitFileUrl()
    let repo_url = substitute(FugitiveRemoteUrl(), "\.git$", "", "")
    let branch = FugitiveHead()
    let tree = substitute(FugitivePath(), "^".FugitiveWorkTree(), "", "")
    let line = line(".")
    return repo_url."/blob/".branch.tree."#L".line
endfunction

"### Bindings ####################################
let mapleader = ","

"--- Should-Be-Defaults --------------------------
nnoremap <silent> c      "_c
nnoremap <silent> Y      y$
nnoremap <silent> C      "_C
nnoremap <silent> x      "_x
tmap     <silent> <c-w>  <c-\><c-w>
tnoremap <silent> <c-\>  <c-\><c-n>
inoremap <silent> <c-f>  <c-x><c-f>
inoremap <silent> <c-l>  <c-x><c-l>
inoremap <silent> <c-b>  <c-x><c-p>
"^ <c-x><c-p> block complete (continue completing where left off)

"--- Functions -----------------------------------
" TODO test auto yank with every comment
" nnoremap <silent> yc   :call YankComment()<CR>
let g:tcomment_opleader1 = 'yc'
nnoremap <silent> gc   :call YankComment()<CR>
" TODO improve implementation if keeping
nnoremap <silent> gy   :call YankAppend()<CR>
nnoremap <silent> gr   :call ChangeReplace()<CR>
nnoremap <silent> gR   :call ChangeReplace("$")<CR>
nnoremap <silent> grr  :call ChangeReplace("c")<CR>
nnoremap <silent> ga   i<c-r>=AlignWithMark()<CR><ESC>
vnoremap <silent> ga   I<c-r>=AlignWithMark()<CR><ESC>

nnoremap <silent> gt  :call TempTerm(" ")<CR>
nnoremap <silent> gL  :call TempTerm("lazygit")<CR>
nnoremap <silent> gl  :call TempTerm("lf")<CR>

nnoremap <silent> <c-w>r   :call ResizeMode()<CR>
inoremap <silent> <c-c>    <c-r>=CompletionStatus()<CR>
inoremap <silent> <Tab>    <c-r>=CleverTab()<CR>
inoremap <silent> <s-Tab>  <c-r>=OmniTab()<CR>

"--- Surround ------------------------------------
" nmap <silent> gs   ys
nmap <silent> g'   ysiW"
nmap <silent> dsf  dt(ds(

"--- Saving --------------------------------------
cnoremap W!  execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
nnoremap <silent> gw     :w<CR>
nnoremap <silent> gW     ZZ
nnoremap <silent> gQ     ZQ

"--- Buffers -------------------------------------
nnoremap <silent> gn  :bn<CR>
nnoremap <silent> gp  :bp<CR>
nnoremap <silent> gq  :bd<CR>

"--- Coding --------------------------------------
nnoremap <Leader>s  :%s//g<Left><Left>
nnoremap <Leader>S  :%s/<c-r><c-w>//g<Left><Left>

nnoremap <silent> <Leader>g  :let @+ = GitFileUrl()<CR>
nnoremap <silent> <Leader>G  :silent exe "!open ".escape(GitFileUrl(), "#")<CR>

nnoremap <silent> <Leader><Leader>h  :set hlsearch!<CR>
nnoremap <silent> <Leader><Leader>i  :IndentLinesToggle<CR>

"--- Ale Linting ---------------------------------
nnoremap <silent> <Leader>n  :ALENextWrap<CR>
nnoremap <silent> <Leader>p  :ALEPreviousWrap<CR>
nnoremap <silent> <Leader>f  :ALEFix<CR>
nnoremap <silent> <Leader>d  :ALEDetail<CR>

"--- Vim-Go --------------------------------------
augroup go
    autocmd!
    autocmd FileType go IndentLinesDisable
    autocmd FileType go highlight link Whitespace Conceal
    autocmd FileType go set list listchars=tab:\|\ "keep trailing space

    autocmd FileType go nmap gd  :GoDef<CR>
    autocmd FileType go nmap gD  :sp<CR>:GoDef<CR>

    autocmd FileType go nmap <Leader>i  :GoInfo<CR>
    autocmd FileType go nmap <Leader>I  :GoSameIdsToggle<CR>
    autocmd FileType go nmap <Leader>t  :GoTest!<CR>
    autocmd FileType go nmap <Leader>T  :GoTestFunc!<CR>
    autocmd FileType go nmap <Leader>a  :GoAlternate<CR>
    autocmd FileType go nmap <Leader>A  :e <c-r>%<LEFT><LEFT><LEFT>_test<CR>
    autocmd FileType go nmap <Leader>c  :GoCoverageToggle<CR>
    autocmd FileType go nmap <Leader>C  :GoCoverageBrowser<CR>
    autocmd FileType go nmap <Leader>r  :GoRun %<CR>
    autocmd FileType go nmap <Leader>R  :GoRun %<Space>
    autocmd FileType go nmap <Leader>b  :GoTestCompile<CR>

    autocmd FileType go nmap <Leader><Leader>i  :set list!<CR>
    autocmd FileType go nmap <silent> <Leader>o   :silent exe "!open ".
        \ substitute('<c-r><c-l>', '^.*"\([^/]*/[^/]*/[^/]*\)\(.*\)"', 'https://\1/tree/master\2', '')<CR>
augroup END

"--- Vim-Rust ------------------------------------
augroup Racer
    autocmd!
    autocmd FileType rust nmap gd   <Plug>(rust-def)
    autocmd FileType rust nmap gD   <Plug>(rust-def-split)
    autocmd FileType rust nmap K    <Plug>(rust-doc)

    autocmd FileType rust nmap <Leader>t  :Ctest<CR>
    autocmd FileType rust nmap <Leader>T  :RustTest<CR>
    autocmd FileType rust nmap <Leader>r  :Crun<CR>
    autocmd FileType rust nmap <Leader>R  :Crun<Space>
    autocmd FileType rust nmap <Leader>b  :Cbuild<CR>
augroup END

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

autocmd FileType text nnoremap <Leader>n  ]s
autocmd FileType text nnoremap <Leader>p  [s
autocmd FileType text nnoremap <Leader>f  z=
autocmd FileType text nnoremap <Leader>F  :spellrepall<CR>

"--- Fzf -----------------------------------------
let maplocalleader = "\<Space>"

nnoremap <LocalLeader><LocalLeader>s  :GFiles?<CR>
nnoremap <LocalLeader><LocalLeader>g  :GFiles<CR>
nnoremap <LocalLeader><LocalLeader>f  :Files<CR>
nnoremap <LocalLeader><LocalLeader>.  :Files ../
nnoremap <LocalLeader><LocalLeader>/  :BLines<CR>
nnoremap <LocalLeader><LocalLeader>l  :Lines<CR>
nnoremap <LocalLeader><LocalLeader>r  :Rg<CR>
nnoremap <LocalLeader><LocalLeader>b  :Buffers<CR>
nnoremap <LocalLeader><LocalLeader>m  :Maps<CR>
nnoremap <LocalLeader><LocalLeader>h  :Helptags<CR>
nnoremap <LocalLeader><LocalLeader>t  :Filetypes<CR>
" nnoremap <LocalLeader><LocalLeader>T  :set filetype=<CR>
nnoremap <LocalLeader><LocalLeader>?  :Bindings<CR>

"--- Easy Motion ---------------------------------
nmap <LocalLeader>g  <Plug>(easymotion-overwin-w)
nmap <LocalLeader>a  <Plug>(easymotion-jumptoanywhere)
nmap <LocalLeader>f  <Plug>(easymotion-bd-wl)
nmap <LocalLeader>l  <Plug>(easymotion-sol-bd-jk)
