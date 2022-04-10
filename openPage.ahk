;~ temberature@gmail.com
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force

;-- DOSCOMMANDHERE XP ctrl+alt+d  ahk_basic
msgbox,%A_ScriptFullPath%
MsgBox % A_OSVersion
;~ return

UrlProtocol(Key, Command, Description = "") {
	RegWrite, REG_SZ, HKEY_CLASSES_ROOT, % Key, % "URL Protocol"
	RegWrite, REG_SZ, HKEY_CLASSES_ROOT, % Key "\shell\open\command",, % Command
	RegWrite, REG_SZ, HKEY_CLASSES_ROOT, % Key,, % Description
}
;~ if !A_IsAdmin
	;~ Run, % "*RunAs " (A_IsCompiled ? "" : A_AhkPath " ") Chr(34) A_ScriptFullPath Chr(34)
;use the RegWrite line at your own risk, I don't know what it changes
;~ ; Example
;~ C:\Users\16052\SDD\AutoHotkey\openPage.exe "%1"
;~ RegWrite, REG_SZ, HKEY_CLASSES_ROOT, hook\shell\open\command, , C:\Users\16052\SDD\AutoHotkey\openage.exe

RegRead, OutputVar, HKEY_CLASSES_ROOT, hook\shell\open\command, 
;~ MsgBox, %OutputVar%
raw = %1%
if (raw = "") {
   if(OutputVar) {
      MsgBox, %1%
      MsgBox, 协议名已成功注册或已存在。
      return
   } else {
      command := A_ScriptFullPath " `"`%1`""
      MsgBox, %command%
      UrlProtocol("hook", command, "My Protocol")
      MsgBox, 注册成功，可以使用URL了。
      return
   }
   return
}



;~ Run, test:Hello World
;~ return
EncodeDecodeURI(str, encode := true, component := false) {
   static Doc, JS
   if !Doc {
      Doc := ComObjCreate("htmlfile")
      Doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
      JS := Doc.parentWindow
      ( Doc.documentMode < 9 && JS.execScript() )
   }
   Return JS[ (encode ? "en" : "de") . "codeURI" . (component ? "Component" : "") ](str)
}
;~ msgbox, %1%
;~ return

url := EncodeDecodeURI(raw, false)
;~ msgbox, % url
;~ return

StringSplit, prearr, url, `:
prearr := StrSplit(url, ":") 
;~ MsgBox, % prearr[3]
if (!prearr[3]) {
   
   ;~ MsgBox, % prearr[2]
   ;~ prearr := StrSplit(url, ":") 
   arr := StrSplit(prearr[2], ":") 
   ;~ StringSplit, arr, prearr2, `:
   predisk := arr[1]
   prefolder := arr[2]
} else {
   ;~ MsgBox, b2
   predisk := prearr[2]
   prefolder := prearr[3]
   ;~ MsgBox, % prearr[3]
}
;~ return
;~ StringSplit, arr, url, `:

;~ MsgBox, % prefolder
StringReplace, disk, predisk, `/, , All
StringReplace, folder, prefolder, `/, `\, All
dest := disk ":" folder
;~ MsgBox, % dest
;~ return
StringSplit, pars, dest, `#
;~ msgbox, %pars1%
;~ Colors := "red,green,blue"
;~ StringSplit, ColorArray, Colors, `,
;~ MsgBox, %ColorArray1%
;~ Loop, %ColorArray0%
;~ {
    ;~ this_color := ColorArray%A_Index%
    ;~ MsgBox, Color number %A_Index% is %this_color%.
;~ }
;~ return

file = %pars1%
page = %pars2%
;~ MsgBox, %file%, %page%
;~ return

SetTitleMatchMode, 2
run C:\Windows\explorer.exe %file%
;~ run C:\Program Files (x86)\ABBYY FineReader 14\FineReader.exe
;~ run C:\Windows\notepad.exe
;~ Winwaitactive Untitled - Notepad
StringSplit, paths, file, `\
;~ MsgBox, %paths0%
;~ A:=["a", "b", 11]
;~ MsgBox % paths0.MaxIndex()
last = % paths0
;~ MsgBox, % (paths.MaxIndex())
book:=paths%last%
;~ title = ‎人类文明史.pdf‎ - ABBYY FineReader 14
		;~ 明亮的泥土  颜料发明史_14409473_OCR.pdf - ABBYY FineReader 14
;~ title := book " - ABBYY FineReader 14"
;~ this not work?
;~ MsgBox, % title
;~ return

Winwaitactive, % book
;~ WinActivate
;~ msgbox, Internet Explorer is active and ready- press OK to continue on with your script
;~ sleep, 1000
Send, ^g
Send, %page%
Send, {Enter}