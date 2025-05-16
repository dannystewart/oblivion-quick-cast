local UEHelpers = require("UEHelpers")
local initialQuickMenu = nil

local function log(message)
    print("[CastOnShortcut] " .. message .. "\n")
end

-- Track which keys were pressed
local keyPressed = {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = false,
    [5] = false,
    [6] = false,
    [7] = false,
    [8] = false
}

-- Handle the key press event
local function HandleKeyPress(slot)
    log("Key " .. slot .. " pressed - switching to slot")
    keyPressed[slot] = true
    -- Let the native code handle the switching
end

-- Handle the key release event - this is where we'll do the casting
local function HandleKeyRelease(slot)
    -- Only proceed if this key was previously pressed
    if not keyPressed[slot] then
        return
    end

    -- Reset the pressed state
    keyPressed[slot] = false

    log("Key " .. slot .. " released - attempting cast")

    local currentQuickMenu = FindFirstOf("VQuickKeysMenuViewModel")

    if not initialQuickMenu then
        log("Getting initial QuickMenuModel...")
        currentQuickMenu:RegisterSendOpen()
        currentQuickMenu:RegisterSendClose()
        log("Setup QuickMenuModel in memory...")

        currentQuickMenu = FindFirstOf("VQuickKeysMenuViewModel")
        initialQuickMenu = "loaded"

        log("Loaded initial QuickMenuModel!")
    end

    if not currentQuickMenu then
        log("QuickMenuModel is null/nil")
        return
    end

    local slotIconFullName = currentQuickMenu.Icons[slot]:GetFullName()
    if not slotIconFullName then
        log("SlotIconFullName is nil or empty")
        return
    end

    if string.find(slotIconFullName, "icons%/magic%/") then
        log("String matched: " .. slotIconFullName)

        local playerController = UEHelpers.GetPlayerController()
        if not playerController or not playerController:IsValid() then
            log("PlayerController not found or doesn't exist.")
            return
        end

        log("Casting with QuickInput")
        playerController:ToggleSpellCastPressed()
    else
        log("String not found")
    end
end

-- Register hooks for key press events
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick1Input_Pressed", function ()
    HandleKeyPress(1)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick2Input_Pressed", function ()
    HandleKeyPress(2)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick3Input_Pressed", function ()
    HandleKeyPress(3)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick4Input_Pressed", function ()
    HandleKeyPress(4)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick5Input_Pressed", function ()
    HandleKeyPress(5)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick6Input_Pressed", function ()
    HandleKeyPress(6)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick7Input_Pressed", function ()
    HandleKeyPress(7)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick8Input_Pressed", function ()
    HandleKeyPress(8)
end)

-- Register hooks for key release events
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick1Input_Released", function ()
    HandleKeyRelease(1)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick2Input_Released", function ()
    HandleKeyRelease(2)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick3Input_Released", function ()
    HandleKeyRelease(3)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick4Input_Released", function ()
    HandleKeyRelease(4)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick5Input_Released", function ()
    HandleKeyRelease(5)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick6Input_Released", function ()
    HandleKeyRelease(6)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick7Input_Released", function ()
    HandleKeyRelease(7)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick8Input_Released", function ()
    HandleKeyRelease(8)
end)
