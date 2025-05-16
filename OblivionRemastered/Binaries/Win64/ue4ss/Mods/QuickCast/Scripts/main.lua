local UEHelpers = require("UEHelpers")
local initialQuickMenu = nil

local function log(message)
    print("[QuickCast] " .. message .. "\n")
end

local keyPressed = {}
for i = 1, 8 do
    keyPressed[i] = false
end

local function HandleKeyPress(slot)
    log("Key " .. slot .. " pressed - switching to slot")
    keyPressed[slot] = true
end

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

-- Register hooks for key press and release events
for i = 1, 8 do
    RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick" .. i .. "Input_Pressed", function()
        HandleKeyPress(i)
    end)

    RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick" .. i .. "Input_Released", function()
        HandleKeyRelease(i)
    end)
end
