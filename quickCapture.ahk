#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force
FileEncoding, UTF-8-RAW
FileEncoding, UTF-8
;~ temberature@gmail.com

if (FileExist(".\quickCapture.ini")) {
	IniRead, CaptureFileFolder, .\quickCapture.ini, settings, CaptureFileFolder
	;~ MsgBox, %CaptureFileFolder%
}

If (CaptureFileFolder = "" OR CaptureFileFolder = "ERROR") {
	InputBox, CaptureFileFolder, 请配置捕捉存放文件夹路径, please set folder for capture content https://space.bilibili.com/437767128
	IniWrite, %CaptureFileFolder%, .\quickCapture.ini, settings, CaptureFileFolder
}


!q::
;~ clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
Send ^c
ClipWait  ; Wait for the clipboard to contain text.
;~ MsgBox Control-C copied the following contents to the clipboard:`n`n%clipboard%
FormatTime, FileName, A_Now, yyyy-MM-dd
FormatTime, TimeString, A_Now, HH:mm
;~ MsgBox The specified date and time, when formatted, is %TimeString%.
StringReplace, clipboard, clipboard, `r`n, <br> , All
StringReplace, clipboard, clipboard, `n, <br> , All
;~ MsgBox, % clipboard
FileAppend, `n- %TimeString% %clipboard%`n, %CaptureFileFolder%%FileName%.md
MsgBox, 0, , 保存成功, 2
return

!r::
clipboard := ""  ; Start off empty to allow ClipWait to detect when the text has arrived.
Send ^c
ClipWait  ; Wait for the clipboard to contain text.

winshow, ahk_class WeChatMainWndForPC
WinActivate, ahk_class WeChatMainWndForPC

Sleep 1000
Send ^{a}
Send ^{f}
Sleep 1000
SendInput, %clipboard%
Sleep 2000
Send, {Enter}

Winwaitactive, ahk_class FTSMsgSearchWnd
MouseMove, 670, 196
Sleep 1000
Click
return