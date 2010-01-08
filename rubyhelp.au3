#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.12.1
 Author:         xiangwei 31531640@qq.com http://17memo.com

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

if $CmdLine[0]>0 then 
$keyword=$CmdLine[1]
else 
$keyword=""
EndIf
;MsgBox(0,"", $keyword)
;ConsoleWrite($keyword)
;$keyword="Array"
;MsgBox(1,1,"tketk")

$fxTitle="fxri - Instant Ruby Enlightenment"
$ctrlTitle = "[CLASS:FXWindow; INSTANCE:4]"

if WinExists ($fxTitle)<>True then 
	ShellExecute("fxri.rbw")
	MsgBox(1, "Please Wait", "Wait for init for first time", 3)
EndIf

WinActivate($fxTitle)
WinWaitActive($fxTitle)

ControlClick($fxTitle, "", $ctrlTitle, "left", 1)

;clear
Send("^a")
Send("{DEL}")

Send($keyword)

