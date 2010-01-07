source ~/vimfiles/vimrc

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
inoremap <C-S>		<C-O>:update<CR>

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
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c


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
" 设置文件编码  
set fenc=utf-8  
" 设置文件编码检测类型及支持格式  
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936  
color blackboard
let g:browser = '"C:/Program Files/Mozilla Firefox/firefox.exe"  -new-tab '  
" Open the Ruby ApiDock page for the word under cursor, in a new Firefox tab
function! OpenRubyDoc(keyword)
  let url = 'http://apidock.com/ruby/'.a:keyword
  call system(g:browser.url)
endfunction           
noremap RB :call OpenRubyDoc(expand('<cword>'))<CR>

" Open the Rails ApiDock page for the word under cursos, in a new Firefox tab
function! OpenRailsDoc(keyword)
  let url = 'http://apidock.com/rails/'.a:keyword
  call system(g:browser.url)
endfunction
noremap RR :call OpenRailsDoc(expand('<cword>'))<CR>



let g:fuzzy_ceiling=20000
let g:fuzzy_matching_limit=25
let g:fuzzy_ignore = "gems/*, log/*"
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

nnoremap <silent> <F3> :Rgrep<CR> 
let Grep_Default_Filelist = '*.rb *.yml *.erb *.html *.css *.txt *.js' 
let Grep_Skip_Dirs = '.svn' 

let Grep_Path = 'C:\GnuWin32\bin\grep.exe ' 
let Fgrep_Path = 'C:\GnuWin32\bin\fgrep.exe ' 
let Egrep_Path = 'C:\GnuWin32\bin\egrep.exe ' 
let Agrep_Path = 'C:\GnuWin32\bin\agrep.exe ' 
let Grep_Find_Path = 'C:\GnuWin32\bin\find.exe ' 
let Grep_Xargs_Path = 'C:\GnuWin32\bin\xargs.exe ' 

map <F4> :cn<CR>

map <C-F8> :TlistToggle<CR>  
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
let Tlist_Enable_Fold_Column = 0
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1 



" 把 F8 映射到 启动NERDTree插件  
map <F8> :NERDTreeToggle<CR>  
"let NERDTreeMouseMode=3
