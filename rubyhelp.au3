#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
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
$keyword="rails"
EndIf
;MsgBox(0,"", $keyword)
;ConsoleWrite($keyword)
;$keyword="Array"
;MsgBox(1,1,"tketk")

$fxTitle="Ruby v"

Opt("WinTitleMatchMode", 2)     ;1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase

$firstFlag = 0;
If NOT WinExists($fxTitle) Then
	ShellExecute("file:///"&@ScriptDir&"/rdoc/index.html")
	$firstFlag =1
	Sleep(1000)
EndIf

WinActivate($fxTitle)
if WinWaitActive($fxTitle, "", 2)== 0 Then
	WinActivate($fxTitle)
	exit
Endif

Send("^{F1}")


ControlClick("", "", "[CLASS:MozillaWindowClass; INSTANCE:2]", "left", 1, 10, 20)


Send("^a")
ClipPut($keyword)
Send("^v")

Sleep(300)
Send("{ENTER}")
Send("^{F1}")
