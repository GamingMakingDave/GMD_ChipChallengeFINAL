ESX = exports['es_extended']:getSharedObject()

if Config.DebugMode then
    RegisterCommand('clearchip', function(source, args)
        DeleteObject(ChipProp)
    end, false)

    RegisterCommand('teststate', function(source, args)
        TriggerEvent('esx_status:remove', 'thirst', 30000)
    end, false)

    RegisterCommand('testwalk', function(source, args)
        SetPedMovementClipset(PlayerPedId(), "move_characters@michael@fire", 0.5)
    end, false)


    RegisterCommand('clearped', function(source, args)
        local ped = PlayerPedId()

            SetPedMoveRateOverride(ped, 1.0)
            SetRunSprintMultiplierForPlayer(ped, 1.0)
            SetPedIsDrunk(GetPlayerPed(-1), false)
            SetPedMotionBlur(ped, false)
            ResetPedMovementClipset(GetPlayerPed(-1))
            AnimpostfxStopAll()
            ShakeGameplayCam("DRUNK_SHAKE", 0.0)
            SetTimecycleModifierStrength(0.0)
    end, false)
end