# LastEpochHotkeys
An AutoHotkey script for Last Epoch with several utility macros for common tasks. Prevents tendinitis and carpal tunnel syndrome ... probably.

---

## FEATURES

This is an AutoHotkey script providing hotkey functionality for some common tasks in Last Epoch. Tired of pressing multiple buttons in quick succession? Having a physical handicap? Then this is for you.
Currently the script provides the following macros.

- Item Transfer/Selling Repeater: Tired of having to Shift-Click on every item you want to transfer between your inventory and stash (and vice versa) or when selling the conent of your inventory? Then use this, just hold a button and hover over to items to automate it.
- Skill Toggle: Press a button and make your skills repeat indefinitely until you toggle it off again. No more "Numlock trick" or physically holding down a button required.
- Skill Repeat: While the previous Skill Toggle, as the name suggests, toggles skill use, this Skill Repeat is more nuanced. The skills repeat for as long as you hold down the defined key. And you can also set a delay between activations in case you don't want a skill to activate right when it is off cooldown.

If you feel like this list is missing an important feature, feel free to suggest it via the Posts section. Maybe you're lucky and I decide to implement it.


## INSTALL

1. First you need to install [AutoHotkey﻿ (AHK) v2.0](https://www.autohotkey.com/). Without it, this script won't run. It also won't run with AHK v1.1.
2. Once installed, download the archive from the Files section.
3. Extract the 7zip archive. It contains the file LastEpochHotkeys.ahk.
4. If your install of AHK works you should be able to execute that script. BUT before you do that I recommend that you configure the script as explained below.


## SETUP AND USE

If you just downloaded the script I recommend that you configure it first before running it. Otherwise it might not work for you. For that purpose you need a text editor app. Simply open the LastEpochHotkeys.ahk with it. Editors that provide syntax highlighting for AHK scripts, and thus improve readability, are listed in this article:
https://www.autohotkey.com/docs/v2/misc/Editors.htm

The screenshot above shows the content of the file as seen within Visual Studio Code but for the following guide your choice of an editor doesn't matter.

1. At the very top of the script you can find some basic tips on how to configure it.
2. Follow the link to [List of Keys](https://www.autohotkey.com/docs/v2/KeyList.htm) so that you learn what key codes you have to use in order to assign a key on your keyboard or mouse.
3. You should modify the section starting from line 25. Make sure you read all the included notes (comments). There you can put in the key codes for the keys you want to define, set delays, etc.
4. Once you're done with your setup, save the file and close it.
5. Then you can run it. On the right side of your task bar this icon ﻿ should appear, signaling that the script is running.
6. You can use the macros in game now.

When in game you can also restart the script and pause hotkey execution by a press of a button. The defaults are as follows:

- F5 will restart the script. This can be useful if something breaks, isn't working as expected or you modified the settings while the script was running and you want to update them.
- F6 will suspend hotkey execution. Already running processes will continue to run. This can be useful if you have to use a hotkey for another functionality in game.
