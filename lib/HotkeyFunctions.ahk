; Item Transfer/Selling Repeater
if (keyItemTransRepeatActive && keyItemTransRepeat != "") {
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

; Skill Toggle
if (keySkillToggleActive && keySkillToggle != "") {
	Hotkey keySkillToggle, ToggleChannelSkill
	ToggleChannelSkill(ThisHotkey) {
		static active := false
		active := !active
		if (active) {
			KeyPress(enableSkillToggle, delaySkillToggle)
		} else {
			KeyRelease(enableSkillToggle, delaySkillToggle)
		}
	}
}

; Skill Repeater
if (keySkillRepeatActive && keySkillRepeat != "") {
	Hotkey keySkillRepeat, SkillRepeater
	SkillRepeater(ThisHotkey) {
		KeyPress(enableSkillRepeat, delaySkillRepeat)
		if (KeyWait(keySkillRepeat)) {
			KeyRelease(enableSkillRepeat, delaySkillRepeat)
		}
	}
}

; Teleport
if (keyPortalActive && keyPortal != "") {
	Hotkey keyPortal, Portal
	Portal(ThisHotkey) {
		WinGetPos &winX, &winY, &winW, &winH, "A"
		xPortal := winX + winW / 2 - winW * winModX
		yPortal := winY + winH / 2 - winH * winModY
		MouseGetPos &tempX, &tempY
		SendInput keyPortalGame
		Sleep delayPortClick
		Click xPortal, yPortal
		Sleep 150
		Click tempX, tempY, 0
	}
}

; general stuff

timerArray := []
timerArray.Length := numSkills

KeyPress(enabled, delay) {
	Loop numSkills {
		if (enabled[A_Index]) {
			if (delay[A_Index] == 0) {
				SendInput "{" keysSkillBar[A_Index] " down}"
			} else {
				SendInput "{" keysSkillBar[A_Index] "}"
				timerArray.InsertAt(A_Index, SkillTimer(A_Index))
				timerArray[A_Index].Start(delay[A_Index])
			}
		}
	}
}

KeyRelease(enabled, delay) {
	Loop numSkills {
		if (enabled[A_Index]) {
			if (delay[A_Index] == 0) {
				SendInput "{" keysSkillBar[A_Index] " up}"
			} else {
				timerArray[A_Index].Stop()
			}
		}
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
		SendInput "{" keysSkillBar[num] "}"
	}
}