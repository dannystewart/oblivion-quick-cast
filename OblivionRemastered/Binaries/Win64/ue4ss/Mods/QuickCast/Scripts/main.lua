local UEHelpers = require("UEHelpers")
local initialQuickMenu = nil

local function log(message)
    print("[CastOnShortcut] " .. message .. "\n")
end

local function CastSpellWithQuickInput(slot)
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

    ExecuteInGameThread(function()
        -- Nested ExecuteInGameThread calls to ensure we're at least 2 frames after the weapon switch
        ExecuteInGameThread(function()
            local freshQuickMenu = FindFirstOf("VQuickKeysMenuViewModel")
            if not freshQuickMenu then
                log("QuickMenuModel is null/nil in delayed execution")
                return
            end

            local slotIconFullName = freshQuickMenu.Icons[slot]:GetFullName()
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
        end)
    end)
end

RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick1Input_Released", function ()
    CastSpellWithQuickInput(1)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick2Input_Released", function ()
    CastSpellWithQuickInput(2)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick3Input_Released", function ()
    CastSpellWithQuickInput(3)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick4Input_Released", function ()
    CastSpellWithQuickInput(4)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick5Input_Released", function ()
    CastSpellWithQuickInput(5)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick6Input_Released", function ()
    CastSpellWithQuickInput(6)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick7Input_Released", function ()
    CastSpellWithQuickInput(7)
end)
RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick8Input_Released", function ()
    CastSpellWithQuickInput(8)
end)
