KeyWaitSend(waitKey, timeoutSec=0.15, intimeKeys="", timeoutKeys=""){
    KeyWait, %waitKey% ,T%timeoutSec%
    isTimeout := ErrorLevel = 1
    If (isTimeout){
        Send, %timeoutKeys%
    }else{
        Send, %intimeKeys%
    }
}

switchBluetooth(){
    Send, #a
    Sleep, 500
    Send, +{tab}
    Sleep, 100
    Send, {space}
    Sleep, 100
    Send, #a
}

pastePassword(){
    SetKeyDelay, 0
    send, %clipboard%
}


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
