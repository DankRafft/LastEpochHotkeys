/*
LAST EPOCH HOTKEYS
an AutoHotkey script
created by Dank Rafft

; -< HOW TO USE >-

Upon the scripts first start an INI file is created in the script root folder.
Only modify the values in there and leave the script files as is, unless you know
exactly what you're doing.

A list of key codes can be found in AHK's documentation:
https://www.autohotkey.com/docs/v2/KeyList.htm
*/

; script setup

#Requires AutoHotkey >=2.0
#SingleInstance Force
#Include <IniFunctions>
#HotIf WinActive("Last Epoch ahk_class UnityWndClass")
HotIfWinActive "Last Epoch ahk_class UnityWndClass"

scriptVersion := 1.2
TraySetIcon A_ScriptDir "\lib\tray.ico"
A_IconTip := "Last Epoch Hotkeys v" scriptVersion

iniPath := A_ScriptDir "\LastEpochHotkeys.ini"
if !FileExist(iniPath) {
	iniCreate(iniPath)
}

; script control keys

F5::Reload					; reload script hotkey
#SuspendExempt
F6::Suspend					; suspend hotkeys hotkey, toggle
#SuspendExempt False
; reset INI file to its default values, also restarts script
F8::iniReset(iniPath)

; hotkey variables and INI setup

numSkills := 5

keysSkillBar := []
keysSkillBar.Length := numSkills
keysSkillBar.InsertAt(1, iniKeyReadWrite(iniPath, "SkillBarKeys", "keySlot1", "q"))
keysSkillBar.InsertAt(2, iniKeyReadWrite(iniPath, "SkillBarKeys", "keySlot2", "w"))
keysSkillBar.InsertAt(3, iniKeyReadWrite(iniPath, "SkillBarKeys", "keySlot3", "e"))
keysSkillBar.InsertAt(4, iniKeyReadWrite(iniPath, "SkillBarKeys", "keySlot4", "r"))
keysSkillBar.InsertAt(5, iniKeyReadWrite(iniPath, "SkillBarKeys", "keySlot5", "RButton"))

keyItemTransRepeat := iniKeyReadWrite(iniPath, "ItemTransRepeat", "key", "MButton")
keyItemTransRepeatStripped := StripHotkeyModifiers(keyItemTransRepeat)
keyItemTransRepeatActive := iniKeyReadWrite(iniPath, "ItemTransRepeat", "enabled", 1)

keySkillToggle := iniKeyReadWrite(iniPath, "SkillToggle", "key", "XButton1")
keySkillToggleActive := iniKeyReadWrite(iniPath, "SkillToggle", "enabled", 0)
keySkillToggleNative := iniKeyReadWrite(iniPath, "SkillToggle", "native", 0)
enableSkillToggle := []
delaySkillToggle := []
enableSkillToggle.Length := numSkills
delaySkillToggle.Length := numSkills
loop numSkills {
	enableSkillToggle.InsertAt(A_Index, iniKeyReadWrite(iniPath, "SkillToggle", "enableSlot" A_Index, 0))
}
loop numSkills {
	delaySkillToggle.InsertAt(A_Index, iniKeyReadWrite(iniPath, "SkillToggle", "delaySlot" A_Index, 0))
}

keySkillRepeat := iniKeyReadWrite(iniPath, "SkillRepeat", "key", "XButton2")
keySkillRepeatStripped := StripHotkeyModifiers(keySkillRepeat)
keySkillRepeatActive := iniKeyReadWrite(iniPath, "SkillRepeat", "enabled", 0)
keySkillRepeatNative := iniKeyReadWrite(iniPath, "SkillRepeat", "native", 1)
enableSkillRepeat := []
delaySkillRepeat := []
enableSkillRepeat.Length := numSkills
delaySkillRepeat.Length := numSkills
loop numSkills {
	enableSkillRepeat.InsertAt(A_Index, iniKeyReadWrite(iniPath, "SkillRepeat", "enableSlot" A_Index, 0))
}
loop numSkills {
	delaySkillRepeat.InsertAt(A_Index, iniKeyReadWrite(iniPath, "SkillRepeat", "delaySlot" A_Index, 1000))
}

keyPortal := iniKeyReadWrite(iniPath, "Portal", "key", "+t")
keyPortalActive := iniKeyReadWrite(iniPath, "Portal", "enabled", 0)
keyPortalGame := iniKeyReadWrite(iniPath, "Portal", "keyGame", "t")
delayPortClick := iniKeyReadWrite(iniPath, "Portal", "delayClick", 1500)
winModX := iniKeyReadWrite(iniPath, "Portal", "winModX", 0.003)
winModY := iniKeyReadWrite(iniPath, "Portal", "winModY", 0.09)

#Include <HotkeyFunctions>