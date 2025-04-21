/*
LAST EPOCH HOTKEYS
an AutoHotkey script
created by Dank Rafft
*/


;___ >>> KEY DEFINITIONS AND SETTINGS (modify these) <<< ________________________________

; - HOW TO -
; a list of key codes can be found in AHK's documentation:
; https://www.autohotkey.com/docs/v2/KeyList.htm

; leave the quotation marks "" for key definitions empty if you want to disable a hotkey

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
; skill 4
keySkillToggle4 := ""
; skill 5
keySkillToggle5 := ""

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
; skill 4
keySkillRepeat4 := ""
delaySkillRepeat4 := 0
; skill 5
keySkillRepeat5 := ""
delaySkillRepeat5 := 0


;___ >>> GENERAL SCRIPT SETUP (don't alter) <<< _________________________________________

#SingleInstance Force
#HotIf WinActive("ahk_exe Last Epoch.exe")
HotIfWinActive "ahk_exe Last Epoch.exe"

#SuspendExempt
F5::Reload				; reload script hotkey
F6::Suspend				; suspend hotkeys hotkey, toggle
#SuspendExempt False


;___ >>> HOTKEY CODE (don't alter) <<< __________________________________________________

numSkills := 5

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
			loop numSkills {
				SendInput "{" keySkillToggle%A_Index% " down}"
			}
		} else {
			loop numSkills {
				SendInput "{" keySkillToggle%A_Index% " up}"
			}
		}
	}
}

if (keySkillRepeat !== "") {
	Hotkey keySkillRepeat, SkillRepeater
	timerArray := []
	SkillRepeater(ThisHotkey) {
		Loop numSkills {
			KeyPressed(A_Index)
		}
		if (KeyWait(keySkillRepeat)) {
			Loop numSkills {
				KeyReleased(A_Index)
			}
		}
	}
	KeyPressed(num) {
		if (delaySkillRepeat%num% == 0) {
			SendInput "{" keySkillRepeat%num% " down}"
		} else {
			SendInput "{" keySkillRepeat%num% "}"
			timerArray.InsertAt(num-1, SkillTimer(num))
			timerArray[num-1].Start(delaySkillRepeat%num%)
		}
	}
	KeyReleased(num) {
		if (delaySkillRepeat%num% == 0) {
			SendInput "{" keySkillRepeat%num% " up}"
		} else {
			timerArray[num-1].Stop()
		}
	}
	class SkillTimer {
		__New(num) {
			this.timer := ObjBindMethod(this, "ActivateSkill", num)
		}
		Start(delay) {
			SetTimer this.timer, delay
		}
		Stop() {
			SetTimer this.timer, 0
		}
		ActivateSkill(num) {
			SendInput "{" keySkillRepeat%num% "}"
		}
	}
}
