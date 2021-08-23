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
