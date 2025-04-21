iniKeyReadWrite(Filename, Section, Key, Default) {
    temp := IniRead(Filename, Section, Key, "error")
    if (temp = "error") {
        IniWrite Default, Filename, Section, Key
        temp := IniRead(Filename, Section, Key)
    }
    return temp
}

iniReset(Filename) {
    FileDelete Filename
    Reload
}

iniCreate(Filename) {
    IniWrite "
    (
    ; A list of key codes can be found in AHK's documentation:
    ; https://www.autohotkey.com/docs/v2/KeyList.htm
    ; In "enabled" fields a 0 means that this function/hotkey
    ; is disabled, while a 1 enables it.
    ; Delays are measured in ms, so a value of 1000 is a second.
    ; A delay of 0 disables the delay and keeps the key pressed
    ; for as long as you hold down the hotkey.
    ; Changes to this file require a restart/reload of the script.
    )", Filename, "HOW TO USE"
}