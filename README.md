# Quick Cast Hotkeys for Oblivion Remastered

This is a mod of a mod for Oblivion Remastered by [Nistaux](https://www.nexusmods.com/oblivionremastered/users/21571864) on [Nexus Mods](https://www.nexusmods.com/oblivionremastered/mods/1531). I had an issue which no one else seems to be experiencing based on the mod posts where when I pressed the number hotkeys (1-8), there was often a race condition where it was casting the current spell before switching to the new spell. If I was on 1 and pressed 2, sometimes 1 would cast because it hadn't switched to 2 yet.

I don't know much about Lua, Unreal Engine 5, or UE4SS modding, but I tried my hand at fixing it, and in initial testing, I haven't seen the issue since. I hope maybe this helps someone else too.

To install, you need [UE4SS](https://www.nexusmods.com/oblivionremastered/mods/32), and the mod should go here: `OblivionRemastered\Binaries\Win64\ue4ss\Mods\QuickCast\Scripts\main.lua`
