# Quick Cast Hotkeys for Oblivion Remastered

This is a mod of a mod for Oblivion Remastered by [Nistaux](https://www.nexusmods.com/oblivionremastered/users/21571864) on [Nexus Mods](https://www.nexusmods.com/oblivionremastered/mods/1531).

I've been experiencing an issue where a race condition when pressing a hotkey causes the previous spell to on the first press instead of the intended one, as it hasn't finished switching quickly enough. This is an ongoing attempt to address that, but it's still a work in progress. I've been unable to find a good way to implement an actual time delay, as `ExecuteWithDelay` and async loops both seem to cause crashes, so I've had to try and come up with "clever" alternatives.

To install, you need [UE4SS](https://www.nexusmods.com/oblivionremastered/mods/32), and the mod should go here: `OblivionRemastered\Binaries\Win64\ue4ss\Mods\QuickCast\Scripts\main.lua`
