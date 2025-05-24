# Quick Cast Hotkeys for Oblivion Remastered

This is a mod of a mod for Oblivion Remastered by [Nistaux](https://www.nexusmods.com/oblivionremastered/users/21571864) on [Nexus Mods](https://www.nexusmods.com/oblivionremastered/mods/1531).

I was frequently seeing a race condition where the game hadn't finished switching to the new spell before triggering the cast, so the first press would cast the previous spell. For example, pressing 2 while slot 1 was selected would cast 1 the first time, then subsequent presses would cast 2.

This version introduces a delay between selecting and casting, so instead of immediately triggering when a hotkey is pressed, it schedules the cast to occur after a short delay. It uses `ReceiveTick` to count frames after a hotkey is pressed, allowing 6 more frames (about 1/6th of a second at 60 FPS) before the spell is actually cast. This gives the game enough time to finish the switch before casting.

## Installation

To install, you need [UE4SS](https://www.nexusmods.com/oblivionremastered/mods/32), and the mod should go here: `OblivionRemastered\Binaries\Win64\ue4ss\Mods\QuickCast\Scripts\main.lua`
