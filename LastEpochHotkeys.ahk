/*
LAST EPOCH HOTKEYS
an AutoHotkey script
created by Dank Rafft

- HOW TO -
a list of key codes can be found in AHK's documentation:
https://www.autohotkey.com/docs/v2/KeyList.htm
leave the quotation marks "" for key definitions empty if you want to disable a hotkey
*/


;___ >>> GENERAL SCRIPT SETUP (don't alter) <<< _________________________________________

#SingleInstance Force
#HotIf WinActive("ahk_exe Last Epoch.exe")
HotIfWinActive "ahk_exe Last Epoch.exe"

F5::Reload				; reload script hotkey
#SuspendExempt
F6::Suspend				; suspend hotkeys hotkey, toggle
#SuspendExempt False


;___ >>> KEY DEFINITIONS AND SETTINGS (modify this) <<< _________________________________

; --- ITEM TRANSFER/SELL REPEATER ---

; key to repeat item transfer/selling while held
keyItemTransRepeat := "MButton"

; --- SKILL TOGGLE ---

; key to toggle skill states
keySkillToggle := "XButton1"
; skill 1 key assigned in game on your skill bar
keySkillToggle1 := "RButton"
; skill 2
keySkillToggle2 := "f"
; skill 3
keySkillToggle3 := ""

; --- SKILL REPEATER ---

; key to repeat skills while held
keySkillRepeat := ""
; skill 1 key assigned in game on your skill bar
; skill 1 delay between activations, in ms
keySkillRepeat1 := ""
delaySkillRepeat1 := 0
; skill 2
keySkillRepeat2 := ""
delaySkillRepeat2 := 0
; skill 3
keySkillRepeat3 := ""
delaySkillRepeat3 := 0


;___ >>> HOTKEY CODE (don't alter) <<< __________________________________________________

if (keyItemTransRepeat !== "") {
	Hotkey keyItemTransRepeat, ItemTransferRepeat
	ItemTransferRepeat(ThisHotkey) {
		Delayed() {
			SendInput "{RButton}"
		}
		SendInput "{LShift down}"
		SetTimer Delayed, 100
		if (KeyWait(keyItemTransRepeat)) {
			SendInput "{LShift up}"
			SetTimer Delayed, 0
		}
	}
}

if (keySkillToggle !== "") {
	Hotkey keySkillToggle, ToggleChannelSkill
	ToggleChannelSkill(ThisHotkey) {
		static active := false
		active := !active
		if (active) {
			SendInput "{" keySkillToggle1 " down}"
			SendInput "{" keySkillToggle2 " down}"
			SendInput "{" keySkillToggle3 " down}"
		}
		Else {
			SendInput "{" keySkillToggle1 " up}"
			SendInput "{" keySkillToggle2 " up}"
			SendInput "{" keySkillToggle3 " up}"
		}
	}
}

if (keySkillRepeat !== "") {
	Hotkey keySkillRepeat, SkillRepeater
	SkillRepeater(ThisHotkey) {
		if (delaySkillRepeat1 == 0) {
			SendInput "{" keySkillRepeat1 " down}"
		}
		else {
			SendInput "{" keySkillRepeat1 "}"
			SetTimer Delayed1, delaySkillRepeat1
		}
		if (delaySkillRepeat2 == 0) {
			SendInput "{" keySkillRepeat2 " down}"
		}
		else {
			SendInput "{" keySkillRepeat2 "}"
			SetTimer Delayed2, delaySkillRepeat2
		}
		if (delaySkillRepeat3 == 0) {
			SendInput "{" keySkillRepeat3 " down}"
		}
		else {
			SendInput "{" keySkillRepeat3 "}"
			SetTimer Delayed3, delaySkillRepeat3
		}
		if (KeyWait(keySkillRepeat)) {
			if (delaySkillRepeat1 == 0) {
				SendInput "{" keySkillRepeat1 " up}"
			}
			else {
				SetTimer Delayed1, 0
			}
			if (delaySkillRepeat2 == 0) {
				SendInput "{" keySkillRepeat2 " up}"
			}
			else {
				SetTimer Delayed2, 0
			}
			if (delaySkillRepeat3 == 0) {
				SendInput "{" keySkillRepeat3 " up}"
			}
			else {
				SetTimer Delayed3, 0
			}
		}
	}
	Delayed1() {
		SendInput "{" keySkillRepeat1 "}"
	}
	Delayed2() {
		SendInput "{" keySkillRepeat2 "}"
	}
	Delayed3() {
		SendInput "{" keySkillRepeat3 "}"
	}
}