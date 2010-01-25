"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set nowrap      "dont wrap lines
set linebreak   "wrap lines at convenient points

"statusline setup
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%{StatuslineLongLineWarning()}

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

"indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
set list
set listchars=tab:\ \ ,extends:>,precedes:<

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"hide buffers when not displayed
set hidden

if has("gui_running")
		"tell the term has 256 colors
		set t_Co=256

    if has("gui_gnome")
        set term=gnome-256color
        colorscheme desert
    else
        colorscheme vibrantink
        set guitablabel=%M%t
        set lines=40
        set columns=115
    endif
    if has("gui_mac") || has("gui_macvim")
        set guifont=Menlo:h15
    endif
    if has("gui_win32") || has("gui_win32s")
        set guifont=Consolas:h12
				set enc=utf-8
    endif
else
		"dont load csapprox if we no gui support - silences an annoying warning
    let g:CSApprox_loaded = 1
endif

nmap <silent> <Leader>p :NERDTreeToggle<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <C-E> :BufExplorer<cr>
inoremap <C-E> <C-O>:BufExplorer<cr>

"map to fuzzy finder text mate stylez
nnoremap <c-T> :FuzzyFinderTextMate<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"mark syntax errors with :signs
"let g:syntastic_enable_signs=1

"snipmate setup
try
  source ~/vimfiles/snippets/support_functions.vim
catch
  source ~\vimfiles\snippets\support_functions.vim
endtry
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()

    "if we're in a rails env then read in the rails snippets
    if filereadable("./config/environment.rb")
        call ExtractSnips("~/vimfiles/snippets/ruby-rails", "ruby")
        call ExtractSnips("~/vimfiles/snippets/eruby-rails", "eruby")
    endif

    call ExtractSnips("~/vimfiles/snippets/html", "eruby")
    call ExtractSnips("~/vimfiles/snippets/html", "xhtml")
    call ExtractSnips("~/vimfiles/snippets/html", "php")
endfunction

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"source $VIMRUNTIME/mswin.vim
"behave mswin
" Set options and add mapping such that Vim behaves a lot like MS-Windows
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2006 Apr 02

" bail out if this isn't wanted (mrsvim.vim uses this).
if exists("g:skip_loading_mswin") && g:skip_loading_mswin
    finish
endif

" set the 'cpoptions' to its Vim default
if 1	" only do this when compiled with expression evaluation
    let s:save_cpo = &cpoptions
endif
set cpo&vim

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V>		"+gP
map <S-Insert>		"+gP

cmap <C-V>		<C-R>+
cmap <S-Insert>		<C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>		<C-V>
vmap <S-Insert>		<C-V>

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>		<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-[>:update<CR>

" For CTRL-V to work autoselect must be off.
" On Unix we have two selections, autoselect can be used.
if !has("unix")
    set guioptions-=a
endif

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" ALT-left IS 
noremap <A-left> <C-O>
inoremap <A-left> <C-O><C-O>
noremap <A-right> <C-I>
inoremap <A-right> <C-O><C-I>


" Alt-Space is System menu
if has("gui")
    noremap <M-Space> :simalt ~<CR>
    inoremap <M-Space> <C-O>:simalt ~<CR>
    cnoremap <M-Space> <C-C>:simalt ~<CR>
endif

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next Buffer
noremap  <C-Tab>    :e #<CR>
vnoremap <C-Tab>    <C-C>:e #<CR>
inoremap <C-Tab>    <C-O>:e #<CR>

" CTRL-F4 is Close Buffe"r
"noremap  <C-F4>    :bd<CR>
"vnoremap <C-F4>    <C-C>:bd<CR>
"inoremap <C-F4>    <C-O>:bd<CR>
" CTRL-F4 is Close window
map <C-F4> :BufExplorer<CR>d<CR><CR>
imap <C-F4> <C-O>:BufExplorer<CR>d<CR>
vmap <C-F4> <C-C>:BufExplorer<CR>d<CR>


" restore 'cpoptions'
set cpo&
if 1
    let &cpoptions = s:save_cpo
    unlet s:save_cpo
endi
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"设定windows下 gvim 启动时最大化
autocmd GUIEnter * simalt ~x
set guifont=Monaco:h11
set gfw=Fixedsys:h11

" 设置编码 
set enc=utf-8 
set fileencodings=utf-8,chinese,latin-1

" 设置消息提示为中文
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language message zh_CN.utf-8

" 设置文件编码  
set fenc=utf-8  
" 设置文件编码检测类型及支持格式  
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936  
color blackboard




let g:fuzzy_ceiling=20000
let g:fuzzy_matching_limit=25
let g:fuzzy_ignore = "gems/*;log/*;vendor/*;coverage/*;test/coverage/*;"
map <leader>b :FuzzyFinderBuffer<CR>


vmap <F3> "zy/\V<C-R>=escape(@z,'\/')<CR><CR>:%s//<C-R>=escape(@+,'\/')<CR>/gc<left><left><left>

function! RunGrep(keyword)
    let cmd_output = system('grep.rb '.a:keyword)
    call ShowQuickFix(cmd_output)
endfunction
command! -nargs=1 Grep :call RunGrep('<args>')

autocmd  FileType ruby,eruby  call s:XwSetRubyConfig()

" Open the Ruby ApiDock page for the word under cursor, in a new Firefox tab
function! OpenRubyDoc(keyword)
    let url = 'http://apidock.com/ruby/'.a:keyword
    call system(g:browser.url)
endfunction  

" Open the Ruby ApiDock page for the word under cursor, in a new Firefox tab
function! OpenRIDoc(keyword)
    let url=a:keyword
    call system('"rubyhelp.exe" '.url)
endfunction      

" Open the Rails ApiDock page for the word under cursos, in a new Firefox tab
function! OpenRailsDoc(keyword)
    let url = 'http://apidock.com/rails/'.a:keyword
    call system(g:browser.url)
endfunction

function! RunRuby()
    let cmd_output = system('ruby '.expand("%"))
    call ShowQuickFix(cmd_output)
endfunction


function! ShowQuickFix(cmd_output)

    let tmpfile = tempname()

    let old_verbose = &verbose
    set verbose&vim

    exe "redir! > " . tmpfile
    silent echon a:cmd_output
    redir END

    let &verbose = old_verbose

    let old_efm = &efm
    set efm=%f:%\\s%#%l:%m
 
    if exists(":cgetfile")
        execute "silent! cgetfile " . tmpfile
    else
        execute "silent! cfile " . tmpfile
    endif
   let &efm = old_efm

    " Open the quickfix window below the current window
    bot copen

    call delete(tmpfile)    
endfunction

function! CountFileWords()
    
    let tmpfile = tempname()
    "tempname()

    exe "redir! > " . tmpfile
    silent echon expand("%:p")
    redir END

    let cmd_output= system('count.rb '.tmpfile)
  "  exe "redir! > " . 'E:\test.txt'
    "echo "[Search results for pattern: ]\n"
    echomsg "总字数：".cmd_output
 "   redir END

   call delete(tmpfile)    
endfunction

function! s:XwSetRubyConfig()

    noremap <F5> :w<cr>:call RunRuby()<CR><c-w>w:cc<CR>
    vnoremap <F5> <C-C>:w<cr>:call RunRuby()<CR><c-w>w:cc<CR>
    inoremap <F5> <C-[>:w<cr>:call RunRuby()<CR><c-w>w:cc<CR>

    "map <C-F10> : w !ruby<CR>
    
    noremap <F10> : w !ruby<CR>
    vnoremap <F10> : w !ruby<CR>
    inoremap <F10> <C-[>V : w !ruby<CR>

    set makeprg=ruby\ -c\ %
    noremap <C-F5> :w<cr>:make<cr>:bot copen<cr><c-w>w
    vnoremap <C-F5> <C-C>:w<cr>:make<cr> :bot copen<cr> <c-w>w  
    inoremap <C-F5> <C-[>:w<cr>:make<cr>:bot copen<cr> <c-w>w 

    set omnifunc=rubycomplete#Complete
    let g:rubycomplete_buffer_loading = 1
    let g:rubycomplete_rails = 1
    let g:rubycomplete_classes_in_global = 1
    "source  ~/vimfiles/ftplugin/ri.vim
    let g:browser = '"firefox.exe"  -new-tab '  

    noremap RB :call OpenRubyDoc(expand('<cword>'))<CR>
    noremap RR :call OpenRailsDoc(expand('<cword>'))<CR>
    noremap <F1> :call OpenRIDoc(expand('<cword>'))<CR>
    vnoremap <F1> <C-C>:call OpenRIDoc(expand('<cword>'))<CR>
    inoremap <F1> <C-O>:call OpenRIDoc(expand('<cword>'))<CR>
    command! -nargs=1 Ri :call OpenRIDoc('<args>')

endfunction

command! -nargs=0 Count :call CountFileWords()

map <F4> :cn<CR>

"function! CreateTags()
    "let cmd_output = system('tags.bat')
"endfunction
"command! -nargs=0 Ctags :call CreateTags()

noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h

map <C-F8> :TlistToggle<CR>  
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
let Tlist_Enable_Fold_Column = 0
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1 


" 把 F8 映射到 启动NERDTree插件  
let NERDTreeIgnore=['\.vim$', '\~$', '^coverage$', '^tmp$']
map <F8> :NERDTreeToggle<CR>  
"let NERDTreeMouseMode=3

noremap <ESC> :cclose<CR><ESC>
smap <ESC> <LEFT><ESC>

set clipboard+=unnamed




