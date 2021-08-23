#SingleInstance, force
#NoTrayIcon
#Include, Util.ahk

; ~XButton2 & LButton::
; ~XButton2 & RButton::
~XButton2 & MButton::!F4
~XButton2 & WheelUp::AltTab
~XButton2 & WheelDown::ShiftAltTab
~XButton2 & WheelLeft::Left
~XButton2 & WheelRight::Right
~XButton2 & XButton1::!p

; ~XButton1 & LButton::
~XButton1 & RButton::KeyWaitSend("RButton",, "^+t", "^t")
~XButton1 & MButton::^w
~XButton1 & WheelUp::^Tab
~XButton1 & WheelDown::^+Tab
~XButton1 & WheelLeft::Send, {RButton}t
; ~XButton1 & WheelRight::
~XButton1 & XButton2::F5
