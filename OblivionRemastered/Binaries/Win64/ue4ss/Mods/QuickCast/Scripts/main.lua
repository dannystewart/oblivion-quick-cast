local UEHelpers = require("UEHelpers")
local initialQuickMenu = nil

local function log(message)
    print("[QuickCast] " .. message .. "\n")
end

local pending_cast = nil
local frames_to_wait = 6
local tick_debug_counter = 0

local function CastSpellWithQuickInput(slot)
    log("CastSpellWithQuickInput called for slot " .. tostring(slot))
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

        log("Casting with QuickInput for slot " .. tostring(slot))
        playerController:ToggleSpellCastPressed()
    else
        log("String not found for slot " .. tostring(slot))
    end
end

-- Schedule the cast instead of casting immediately
local function ScheduleCast(slot)
    pending_cast = { slot = slot, frames_left = frames_to_wait, debug_ticks = 0 }
    log("Scheduled cast for slot " .. tostring(slot) .. " after " .. tostring(frames_to_wait) .. " frames.")
end

-- Replace quickslot hooks to schedule the cast
for i = 1, 8 do
    RegisterHook("/Script/Altar.VEnhancedAltarPlayerController:Quick" .. i .. "Input_Released", function ()
        ScheduleCast(i)
    end)
end

-- Per-frame polling using ReceiveTick, registered after ClientRestart
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function(Context, NewPawn)
    log("[QuickCast] ClientRestart detected, registering ReceiveTick hook.")
    RegisterHook("/Game/Dev/PlayerBlueprints/BP_OblivionPlayerCharacter.BP_OblivionPlayerCharacter_C:ReceiveTick", function(context, args)
        tick_debug_counter = tick_debug_counter + 1
        if pending_cast then
            pending_cast.debug_ticks = pending_cast.debug_ticks + 1
            log("Tick #" .. tostring(tick_debug_counter) .. ": pending_cast for slot " .. tostring(pending_cast.slot) .. ", frames_left=" .. tostring(pending_cast.frames_left) .. ", debug_ticks=" .. tostring(pending_cast.debug_ticks))
            pending_cast.frames_left = pending_cast.frames_left - 1
            if pending_cast.frames_left <= 0 then
                log("Deferred cast triggered for slot " .. tostring(pending_cast.slot) .. " after " .. tostring(pending_cast.debug_ticks) .. " ticks.")
                CastSpellWithQuickInput(pending_cast.slot)
                pending_cast = nil
            end
        else
            if tick_debug_counter < 10 then
                log("Tick #" .. tostring(tick_debug_counter) .. ": no pending cast.")
            end
        end
    end)
end)
