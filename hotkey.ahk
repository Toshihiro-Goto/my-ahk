; AutoHotkey Wiki https://ahkwiki.net/Top

; ===modifier================================
; +	Shift
; ^	Control
; !	Alt
; #	Windowsロゴキー
; <, > 左右の修飾キーを使用（NT系専用）
;   例: <!a:: 左Alt+A

; ===Template of XMBC settings==============
; LButton::
; RButton::
; MButton::
; XButton1:: ;戻るボタン
; XButton2:: ;進むボタン
; WheelUp::
; WheelDown::
; WheelLeft::
; WheelRight::

; ==========================================
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance, force
#UseHook, On
#Include, D:\backup\AutoHotKey\v1\Util.ahk
; ==========================================
; グローバル変数初期化はキーマッピングより上でないと機能しない。
mode := 0
RunCombinationKey(){
    Run, "C:\Program Files\AutoHotkey\AutoHotkey1.exe" "D:\backup\AutoHotKey\v1\CombinationKey.ahk",,, pid
    Return pid
}
CombinationKeyPid := RunCombinationKey()

OnExit, ExitSub
return
ExitSub:
    MsgBox, 4,, AHKを停止しますか？
    IfMsgBox, No
    {
        Return
    }
    global pid
    Process, Close, %pid%
    isFailed := ErrorLevel = 0
    If (isFailed){
        MsgBox, 失敗しました。
        Return
    }
ExitApp
; ==========================================
#b::switchBluetooth()

#+q::ExitApp
#+r::
    MsgBox, 4,, AHKをリロードしますか？
    IfMsgBox, No
    {
        Return
    }
    IfMsgBox, Yes
    {
        Reload
        Return
    }
Return

; ==========================================
; LButton::
; RButton::
; MButton::
; XButton1::
; XButton2::
; WheelUp::
; WheelDown::
WheelLeft::^c
WheelRight::^v

; ==========================================
XButton1::
    ; XButton2 > XButton1 の同時押しだが、
    ; XButton2 & XButton1 と記述すると、
    ; XButton1 & XButton2 を上に加えて書いた場合に想定通りに動かない。
    If (GetKeyState("XButton2", "P")){
        Send, !p
        Return
    }
    ; ホールドで無効
    KeyWait, XButton1, T0.15
    isTimeout := ErrorLevel = 1
    If (!isTimeout){
        Send, {XButton1}
    }
Return

~XButton1 & RButton::
    KeyWait, RButton , T0.15
    isTimeout := ErrorLevel = 1
    If (isTimeout){
        ; hold: open new tab
        Send, ^t
    }else{
        ; hold: open closed tab
        Send, ^+t
    }
Return
~XButton1 & MButton::^w
~XButton1 & WheelUp::^Tab
~XButton1 & WheelDown::^+Tab
~XButton1 & WheelLeft::Send, {RButton}t
; ~XButton1 & WheelRight::

; ==========================================
XButton2::
    If (GetKeyState("XButton1", "P")){
        Send, {F5}
        Return
    }
    KeyWait, XButton2 ,T0.15
    isTimeout := ErrorLevel = 1
    If (!isTimeout){
        Send, {XButton2}
    }
Return
; ~XButton2 & LButton::
~XButton2 & RButton::ChangeMode()
~XButton2 & MButton::!F4

; 同じファイルでは機能しないので別ファイルで実行する
; ~XButton2 & WheelUp::AltTab
; ~XButton2 & WheelDown::ShiftAltTab

~XButton2 & WheelLeft::Left
~XButton2 & WheelRight::Right

; ==========================================
q::FuncInMode("q","MouseMoveTopForPiccoma")
w::SendInMode("w", "^w")
e::SendInMode("e", "{MButton}")
r::SendInMode("r", "{LButton}")
a::SendInMode("a", "{Left}")
s::SendInMode("s", "{Right}")
d::SendInMode("d", "{WheelUp}")
f::SendInMode("f", "{WheelDown}")
g::FuncInMode("g", "ClickFullGood")

ChangeMode(){
    global mode
    mode := mode = 0
    SetTimer, ShowMode, 16
    SetTimer, EndShowMode, 400
Return
ShowMode:
    ToolTip, %mode%
Return
EndShowMode:
    SetTimer, EndShowMode, Off
    SetTimer, ShowMode, Off
    ToolTip
Return
}

SendInMode(a, b){
    global mode
    if( mode = 0 ){
        Send, %a%
    }else{
        Send, %b%
    }
}

FuncInMode(a, f){
    global mode
    if( mode = 0 ){
        Send, %a%
    }else{
        %f%()
    }
}

MouseMoveTopForPiccoma(){
    MouseMove, 1358, 115
}

ClickFullGood(){
    Loop, 10 {
        Send, {LButton}
    }
}
