let $PATH='C:/Program Files/Mozilla Firefox/;C:/Documents and Settings/magic/vimfiles/;C:/GnuWin32/bin/;'.$PATH
source ~/vimfiles/vimrc

:set dir=@TEMPPATH@

function! XWMenu(keyword)
    call system('ruby "@XWPATH@/xwmenu.rb" '.a:keyword)
endfunction      

function! RunGrep(keyword)
    let cmd_output = system('ruby "@XWPATH@/grep.rb" '.a:keyword)
    call ShowQuickFix(cmd_output)
endfunction


