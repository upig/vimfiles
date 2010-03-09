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
$keyword=""
EndIf
;MsgBox(0,"", $keyword)
;ConsoleWrite($keyword)
;$keyword="Array"
;MsgBox(1,1,"tketk")

$fxTitle="Authlogic"


If NOT WinExists($fxTitle) Then
	ShellExecute("file:///"&@ScriptDir&"/rdoc/index.html")
	Sleep(3000)
EndIf

WinActivate($fxTitle)
WinWaitActive($fxTitle)

;ControlClick($fxTitle, "", $ctrlTitle, "left", 1)

;clear
Send("^a")
Send("{DEL}")

Send($keyword)
Send("{ENTER}")

