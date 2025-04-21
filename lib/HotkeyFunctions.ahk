; Item Transfer/Selling Repeater
if (keyItemTransRepeatActive) {
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
if (keySkillToggleActive) {
	Hotkey keySkillToggle, ToggleChannelSkill
	ToggleChannelSkill(ThisHotkey) {
		static active := false
		active := !active
		if (active) {
			loop numSkills {
				if (enableSkillToggle[A_Index]) {
					SendInput "{" keysSkillBar[A_Index] " down}"
				}
			}
		} else {
			loop numSkills {
				if (enableSkillToggle[A_Index]) {
					SendInput "{" keysSkillBar[A_Index] " up}"
				}
			}
		}
	}
}

; Skill Repeater
if (keySkillRepeatActive) {
	Hotkey keySkillRepeat, SkillRepeater
	timerArray := []
	timerArray.Length := numSkills
	SkillRepeater(ThisHotkey) {
		Loop numSkills {
            if (enableSkillRepeat[A_Index]) {
                KeyPress(A_Index)
            }
		}
		if (KeyWait(keySkillRepeat)) {
			Loop numSkills {
                if (enableSkillRepeat[A_Index]) {
				    KeyRelease(A_Index)
                }
			}
		}
	}
	KeyPress(num) {
		if (delaySkillRepeat[num] == 0) {
			SendInput "{" keysSkillBar[num] " down}"
		} else {
			SendInput "{" keysSkillBar[num] "}"
			timerArray.InsertAt(num, SkillTimer(num))
			timerArray[num].Start(delaySkillRepeat[num])
		}
	}
	KeyRelease(num) {
		if (delaySkillRepeat[num] == 0) {
			SendInput "{" keysSkillBar[num] " up}"
		} else {
			timerArray[num].Stop()
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
}