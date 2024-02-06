local addDefaultHotChipEffect = 0
playerDie = false
local eatingCount = 0

-- wait function
function WaitForKeyPress(keys)
    while true do
        for _, key in ipairs(keys) do
            if IsControlJustPressed(0, key) then
                return key
            end
        end
        Wait(0)
    end
end

-- animation stuff
function playEatHotChip(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, 1.0, duration, 62, 0, false, false, false)
    RemoveAnimDict(animDict)
end

function playEatHotScream(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, 1.0, duration, 59, 0, false, false, false)
    RemoveAnimDict(animDict)
end

function playEatHotChipCrip(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, 1.0, duration, 54, 0, false, false, false)
    RemoveAnimDict(animDict)
end


function playHotAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, 1.0, duration, 1, 0, false, false, false)
    RemoveAnimDict(animDict)
end

function playStartChallengeAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, 1.0, duration, 62, 0, 0, 0, 0)
    RemoveAnimDict(animDict)
end

-- Animation particle stuff
function playPukeParticle(ped, boneIndex)

    RequestNamedPtfxAsset("scr_familyscenem")
    
    while not HasNamedPtfxAssetLoaded("scr_familyscenem") do
        Wait(1)
    end

    UseParticleFxAsset("scr_familyscenem")

    local SaltChipParticle = StartNetworkedParticleFxLoopedOnEntityBone("scr_tracey_puke", ped, 0.0 - 0.03 , 0.0 + 0.04, 0.0 - 0.01, 0.0, 0.0, 0.0, boneIndex, 2.0, false, false, false, false)

    Wait(700)

    StopParticleFxLooped(SaltChipParticle, 0)
    Wait(200)
end

function playFireParticle(ped, boneIndex)

    playerInvisable = trueww

    RequestNamedPtfxAsset("core")
    
    while not HasNamedPtfxAssetLoaded("core") do
        Wait(1)
    end

    UseParticleFxAsset("core")

    local HotChipParticle = StartNetworkedParticleFxLoopedOnEntityBone("exp_sht_flame", ped, 0.0 - 0.025, 0.0 + 0.115, 0.0, -90.0, -15.0, 0.0, boneIndex, 0.2, false, false, false, false)

    Wait(1500)


    CreateThread(function()
        while true do
            Wait(1)
            if playerInvisable then
                SetEntityProofs(PlayerPedId(), false, true, false, false, false, false, false, false)
                SetEntityInvincible(PlayerPedId(), true)
                DisablePlayerFiring(ped, true)
                StopEntityFire(ped)
                StopEntityFire(ChipProp)

            else
                SetEntityProofs(PlayerPedId(), false, true, false, false, false, false, false, false)
                SetEntityInvincible(PlayerPedId(), false)
                DisablePlayerFiring(ped, false)
                StopEntityFire(ped)
                StopEntityFire(ChipProp)
            end
        end
    end)

    StopParticleFxLooped(HotChipParticle, 0)
    Wait(1000)
    playerInvisable = false
end

-- chip effecttypes
function addChipEffect(chipType, effectAddCounter)

    local chipStartCounter = Config.chipTypes[chipType].startEffectCount

    if chipType == 'hot_chip' then
        effectAddCounterResult = chipStartCounter + effectAddCounter

        local ped = PlayerPedId()

        ClearPedTasksImmediately(ped)
        SetPedIsDrunk(ped, true)
        AnimpostfxPlay("MinigameEndTrevor", -1, true)
        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", effectAddCounterResult)

    elseif chipType == 'salt_chip' then
        effectAddCounterResult = chipStartCounter + effectAddCounter

        local ped = PlayerPedId()

        ClearPedTasksImmediately(ped)
        SetPedIsDrunk(ped, true)
        AnimpostfxPlay("MinigameEndFranklin", -1, true)
        ShakeGameplayCam("DRUNK_SHAKE", effectAddCounterResult)

    elseif chipType == 'sour_chip' then
        effectAddCounterResult = chipStartCounter + effectAddCounter

        local ped = PlayerPedId()

        ClearPedTasksImmediately(ped)
        SetPedIsDrunk(ped, true)
        AnimpostfxPlay("SwitchShortFranklinIn", -1, true)
        ShakeGameplayCam("DRUNK_SHAKE", effectAddCounterResult)

    elseif chipType == 'dog_poop_chip' then
        effectAddCounterResult = chipStartCounter + effectAddCounter

        local ped = PlayerPedId()

        ClearPedTasksImmediately(ped)
        SetPedIsDrunk(ped, true)
        AnimpostfxPlay("MinigameEndMichael", -1, true)
        ShakeGameplayCam("DRUNK_SHAKE", effectAddCounterResult)
    -- elseif chipType == 'gmd_chip' then
    --     effectAddCounterResult = chipStartCounter + effectAddCounter

    --     local ped = PlayerPedId()

    --     ClearPedTasksImmediately(ped)
    --     SetPedIsDrunk(ped, true)
    --     AnimpostfxPlay("DMT_flight", -1, true)
    --     ShakeGameplayCam("DRUNK_SHAKE", effectAddCounterResult)
    end
end

-- ChipTypes functions
function StartHotChip(ped, chipType)
    while eating do
        local pressedKey = WaitForKeyPress({38, 73})
        local chipType = chipType
        local statusState = Config.chipTypes[chipType].removeStatus
        local canPlayerDie = Config.chipTypes[chipType].canPlayerDie

        if pressedKey == 38 then -- E Taste

            showPressedText = true
            effectAddCounter = effectAddCounter + 0.2

            addChipEffect(chipType, effectAddCounter)

            playEatHotChip('mp_player_inteat@burger', 'mp_player_int_eat_burger', -1)
            Wait(5000)

            if statusState then
                local statusType = Config.chipTypes[chipType].removeType
                local statusHigh = Config.chipTypes[chipType].removeStatusHigh
                
                TriggerEvent('esx_status:remove', statusType, statusHigh)
            end

            if canPlayerDie then
                local dieChance = Config.chipTypes[chipType].canDieChance
                local randomValue = math.random(1, 100)
                
                if randomValue <= dieChance then
                    showPressedText = true
                    ESX.ShowNotification(Config.Language[Config.Local]['challenge_failed'])
                    eating = false
                    showPressedText = false
                    startChallenge = false
                    eatingCount = 0
                    SetPedMoveRateOverride(ped, 1.0)
                    SetRunSprintMultiplierForPlayer(ped, 1.0)
                    SetPedIsDrunk(GetPlayerPed(-1), false)
                    ResetPedMovementClipset(GetPlayerPed(-1))
                    startChallengeTimer(chipType, effectAddCounter)
                    SetTimecycleModifierStrength(0.0)
                    AnimpostfxStopAll()
                    DeleteObject(ChipProp)
                    ClearPedTasks(ped)
                    if chipType == 'hot_chip' then
                        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.0)
                    elseif chipType == 'salt_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    elseif chipType == 'sour_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    elseif chipType == 'dog_poop_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    -- elseif chipType == 'gmd_chip' then
                    --     ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    end
                    SetEntityHealth(ped, 0)
                    playerDie = true
                end
            end


            SetPedMovementClipset(PlayerPedId(), "move_characters@michael@fire", 0.5)

            eatingCount = eatingCount + 1

            local maxBiteCount =  Config.chipTypes[chipType].challengeMaxBits
            local finalBites = math.random(2, maxBiteCount)

            if eatingCount == finalBites and not playerDie then
                DeleteObject(ChipProp)
                ClearPedTasks(ped)
                ESX.ShowNotification(Config.Language[Config.Local]['challenge_win'])

                TriggerServerEvent('GMD_ChipChallenge:hasFinished', chipType)

                startChallengeTimer(chipType, effectAddCounter)

                eating = false
                showPressedText = true
                startChallenge = false
                eatingCount = 0
            else

                local randomChance = math.random(1, 2)

                if randomChance <= 2 and not playerDie then
                    local ped = PlayerPedId()
                    local headBone = 12844
                
                    playEatHotChipCrip('anim@mp_fm_event@intro', 'beast_transform', -1)
                
                    Wait(1500)
            
                    StopEntityFire(ped)

                    Wait(100)

                    playFireParticle(ped, GetPedBoneIndex(ped, headBone))
                    ClearPedTasks(ped)

                    Wait(5500)
                
                    ClearPedTasks(ped)
    
                    SetEntityInvincible(ped, false)

                    playStartChallengeAnim('mp_player_inteat@burger', 'mp_player_int_eat_burger_enter', -1)
        
                    showPressedText = false
                else

                    showPressedText = false

                end
            end
        elseif pressedKey == 73 then -- X Taste

            showPressedText = true

            DeleteObject(ChipProp)
            ClearPedTasks(ped)
            ESX.ShowNotification(Config.Language[Config.Local]['challenge_canceled'])

            eating = false
            showPressedText = false
            startChallenge = false

            startChallengeTimer(chipType, effectAddCounter)
        end
    end

end

function StartSaltChip(ped, chipType)
    while eating do
        local pressedKey = WaitForKeyPress({38, 73})
        local chipType = chipType
        local statusState = Config.chipTypes[chipType].removeStatus
        local canPlayerDie = Config.chipTypes[chipType].canPlayerDie

        if pressedKey == 38 then -- E Taste

            showPressedText = true
            effectAddCounter = effectAddCounter + 0.2

            addChipEffect(chipType, effectAddCounter)

            playEatHotChip('mp_player_inteat@burger', 'mp_player_int_eat_burger', -1)
            Wait(5000)

            if statusState then
                local statusType = Config.chipTypes[chipType].removeType
                local statusHigh = Config.chipTypes[chipType].removeStatusHigh

                TriggerEvent('esx_status:remove', statusType, statusHigh)
            end

           if canPlayerDie then
                local dieChance = Config.chipTypes[chipType].canDieChance
                local randomValue = math.random(1, 100)
                
                if randomValue <= dieChance then
                    print("Spieler ist gestorben!")
                    showPressedText = true
                    ESX.ShowNotification(Config.Language[Config.Local]['challenge_failed'])
                    eating = false
                    showPressedText = false
                    startChallenge = false
                    eatingCount = 0
                    SetPedMoveRateOverride(ped, 1.0)
                    SetRunSprintMultiplierForPlayer(ped, 1.0)
                    SetPedIsDrunk(ped, false)
                    ResetPedMovementClipset(ped)
                    startChallengeTimer(chipType, effectAddCounter)

                    AnimpostfxStopAll()
                    DeleteObject(ChipProp)
                    ClearPedTasks(ped)
                    if chipType == 'hot_chip' then
                        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.0)
                    elseif chipType == 'salt_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    elseif chipType == 'sour_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    elseif chipType == 'dog_poop_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    -- elseif chipType == 'gmd_chip' then
                    --     ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    end
                    SetEntityHealth(ped, 0)
                    playerDie = true
                else
                    print("Spieler hat überlebt!")
                end
            end

            SetPedMovementClipset(PlayerPedId(), "move_m@drunk@slightlydrunk", 0.5)

            eatingCount = eatingCount + 1

            local maxBiteCount =  Config.chipTypes[chipType].challengeMaxBits
            local finalBites = math.random(2, maxBiteCount)

            if eatingCount == finalBites and not playerDie then
                DeleteObject(ChipProp)
                ClearPedTasks(ped)
                ESX.ShowNotification(Config.Language[Config.Local]['challenge_win'])

                TriggerServerEvent('GMD_ChipChallenge:hasFinished', chipType)

                startChallengeTimer(chipType, effectAddCounter)

                eating = false
                showPressedText = true
                startChallenge = false
                eatingCount = 0
            else

                local randomChance = math.random(1, 2)

                if randomChance <= 2 and not playerDie then

                    local ped = PlayerPedId()
                    local headBone = 12844
                
                    playEatHotScream('missheistpaletoscore1leadinout', 'trv_puking_leadout', -1)
                
                    Wait(750)
                
                    local boneIndex = GetPedBoneIndex(ped, headBone)
                
                    playPukeParticle(ped, boneIndex)
                    Wait(600)
                    playPukeParticle(ped, boneIndex)
                    Wait(1200)
                    playPukeParticle(ped, boneIndex)
                
                    Wait(5500)

                    ClearPedTasks(ped)
                    SetEntityInvincible(ped, false)
                    playStartChallengeAnim('mp_player_inteat@burger', 'mp_player_int_eat_burger_enter', -1)
        
                    showPressedText = false
                    
                else

                    showPressedText = false

                end
            end
        elseif pressedKey == 73 then -- X Taste

            showPressedText = true

            DeleteObject(ChipProp)
            ClearPedTasks(ped)
            ESX.ShowNotification(Config.Language[Config.Local]['challenge_canceled'])

            eating = false
            showPressedText = false
            startChallenge = false
            startChallengeTimer(chipType, effectAddCounter)
        end
    end
end

function StartSourChip(ped, chipType)
    while eating do
        local pressedKey = WaitForKeyPress({38, 73})
        local chipType = chipType
        local statusState = Config.chipTypes[chipType].removeStatus
        local canPlayerDie = Config.chipTypes[chipType].canPlayerDie

        if pressedKey == 38 then -- E Taste

            showPressedText = true
            effectAddCounter = effectAddCounter + 0.2

            addChipEffect(chipType, effectAddCounter)

            playEatHotChip('mp_player_inteat@burger', 'mp_player_int_eat_burger', -1)
            Wait(5000)

            if statusState then
                local statusType = Config.chipTypes[chipType].removeType
                local statusHigh = Config.chipTypes[chipType].removeStatusHigh

                TriggerEvent('esx_status:remove', statusType, statusHigh)
            end

            if canPlayerDie then
                local dieChance = Config.chipTypes[chipType].canDieChance
                local randomValue = math.random(1, 100)
                
                if randomValue <= dieChance then
                    showPressedText = true
                    ESX.ShowNotification(Config.Language[Config.Local]['challenge_failed'])
                    eating = false
                    showPressedText = false
                    startChallenge = false
                    eatingCount = 0
                    SetPedMoveRateOverride(ped, 1.0)
                    SetRunSprintMultiplierForPlayer(ped, 1.0)
                    SetPedIsDrunk(GetPlayerPed(-1), false)
                    ResetPedMovementClipset(GetPlayerPed(-1))
                    startChallengeTimer(chipType, effectAddCounter)
                    SetTimecycleModifierStrength(0.0)
                    AnimpostfxStopAll()
                    DeleteObject(ChipProp)
                    ClearPedTasks(ped)
                    if chipType == 'hot_chip' then
                        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.0)
                    elseif chipType == 'salt_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    elseif chipType == 'sour_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    elseif chipType == 'dog_poop_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    -- elseif chipType == 'gmd_chip' then
                    --     ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    end
                    SetEntityHealth(ped, 0)
                    playerDie = true
                end
            end

            SetPedMovementClipset(PlayerPedId(), "move_m@drunk@slightlydrunk", 0.5)

            eatingCount = eatingCount + 1

            local maxBiteCount =  Config.chipTypes[chipType].challengeMaxBits
            local finalBites = math.random(2, maxBiteCount)

            if eatingCount == finalBites and not playerDie then
                DeleteObject(ChipProp)
                ClearPedTasks(ped)
                ESX.ShowNotification(Config.Language[Config.Local]['challenge_win'])

                TriggerServerEvent('GMD_ChipChallenge:hasFinished', chipType)

                startChallengeTimer(chipType, effectAddCounter)

                eating = false
                showPressedText = true
                startChallenge = false
                eatingCount = 0
            else

                local randomChance = math.random(1, 2)

                if randomChance <= 2 and not playerDie then

                    local ped = PlayerPedId()
                    local headBone = 12844
                
                    playEatHotScream('missheistpaletoscore1leadinout', 'trv_puking_leadout', -1)
                
                    Wait(750)
                
                    local boneIndex = GetPedBoneIndex(ped, headBone)
                
                    playPukeParticle(ped, boneIndex)
                    Wait(600)
                    playPukeParticle(ped, boneIndex)
                    Wait(1200)
                    playPukeParticle(ped, boneIndex)
                
                    Wait(5500)

                    ClearPedTasks(ped)
                    SetEntityInvincible(ped, false)
                    playStartChallengeAnim('mp_player_inteat@burger', 'mp_player_int_eat_burger_enter', -1)
        
                    showPressedText = false
                    
                else

                    showPressedText = false

                end
            end
        elseif pressedKey == 73 then -- X Taste

            showPressedText = true

            DeleteObject(ChipProp)
            ClearPedTasks(ped)
            ESX.ShowNotification(Config.Language[Config.Local]['challenge_canceled'])

            eating = false
            showPressedText = false
            startChallenge = false
            startChallengeTimer(chipType, effectAddCounter)
        end
    end
end

function StartDogPoopChip(ped, chipType)
    while eating do
        local pressedKey = WaitForKeyPress({38, 73})
        local chipType = chipType
        local statusState = Config.chipTypes[chipType].removeStatus
        local canPlayerDie = Config.chipTypes[chipType].canPlayerDie

        if pressedKey == 38 then -- E Taste

            showPressedText = true
            effectAddCounter = effectAddCounter + 0.2

            addChipEffect(chipType, effectAddCounter)

            playEatHotChip('mp_player_inteat@burger', 'mp_player_int_eat_burger', -1)
            Wait(5000)

            if statusState then
                local statusType = Config.chipTypes[chipType].removeType
                local statusHigh = Config.chipTypes[chipType].removeStatusHigh

                TriggerEvent('esx_status:remove', statusType, statusHigh)
            end

            if canPlayerDie then
                local dieChance = Config.chipTypes[chipType].canDieChance
                local randomValue = math.random(1, 100)
                
                if randomValue <= dieChance then
                    showPressedText = true
                    ESX.ShowNotification(Config.Language[Config.Local]['challenge_failed'])
                    eating = false
                    showPressedText = false
                    startChallenge = false
                    eatingCount = 0
                    SetPedMoveRateOverride(ped, 1.0)
                    SetRunSprintMultiplierForPlayer(ped, 1.0)
                    SetPedIsDrunk(GetPlayerPed(-1), false)
                    ResetPedMovementClipset(GetPlayerPed(-1))
                    startChallengeTimer(chipType, effectAddCounter)
                    SetTimecycleModifierStrength(0.0)
                    AnimpostfxStopAll()
                    DeleteObject(ChipProp)
                    ClearPedTasks(ped)
                    if chipType == 'hot_chip' then
                        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.0)
                    elseif chipType == 'salt_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    elseif chipType == 'sour_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    elseif chipType == 'dog_poop_chip' then
                        ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    -- elseif chipType == 'gmd_chip' then
                    --     ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                    end
                    SetEntityHealth(ped, 0)
                    playerDie = true
                end
            end

            
            SetPedMovementClipset(PlayerPedId(), "move_m@drunk@slightlydrunk", 0.5)

            eatingCount = eatingCount + 1

            local maxBiteCount =  Config.chipTypes[chipType].challengeMaxBits
            local finalBites = math.random(2, maxBiteCount)

            if eatingCount == finalBites and not playerDie then
                DeleteObject(ChipProp)
                ClearPedTasks(ped)
                ESX.ShowNotification(Config.Language[Config.Local]['challenge_win'])

                TriggerServerEvent('GMD_ChipChallenge:hasFinished', chipType)

                startChallengeTimer(chipType, effectAddCounter)

                eating = false
                showPressedText = true
                startChallenge = false
                eatingCount = 0
            else

                local randomChance = math.random(1, 2)

                if randomChance <= 2 and not playerDie then

                    local ped = PlayerPedId()
                    local headBone = 12844
                
                    playEatHotScream('missheistpaletoscore1leadinout', 'trv_puking_leadout', -1)
                
                    Wait(750)
                
                    local boneIndex = GetPedBoneIndex(ped, headBone)
                
                    playPukeParticle(ped, boneIndex)
                    Wait(600)
                    playPukeParticle(ped, boneIndex)
                    Wait(1200)
                    playPukeParticle(ped, boneIndex)
                
                    Wait(5500)

                    ClearPedTasks(ped)
                    SetEntityInvincible(ped, false)
                    playStartChallengeAnim('mp_player_inteat@burger', 'mp_player_int_eat_burger_enter', -1)
        
                    showPressedText = false
                    
                else

                    showPressedText = false

                end
            end
        elseif pressedKey == 73 then -- X Taste

            showPressedText = true

            DeleteObject(ChipProp)
            ClearPedTasks(ped)
            ESX.ShowNotification(Config.Language[Config.Local]['challenge_canceled'])

            eating = false
            showPressedText = false
            startChallenge = false
            startChallengeTimer(chipType, effectAddCounter)
        end
    end
end

-- timer stuff
function startChallengeTimer(chipType, effectAddCounter)
    local challengeTimeInMinutes = Config.ReChallenge
    local challengeTimeInMilliseconds = challengeTimeInMinutes * 60000
    local currentThird = 3
    local effectCounterDelay = effectAddCounter

    local challengeAgain = true

    CreateThread(function()
        while challengeAgain do
            Wait(1000)

            challengeTimeInMilliseconds = challengeTimeInMilliseconds - 1000

            if challengeTimeInMilliseconds <= 0 then
                challengeAgain = false
                TriggerServerEvent('GMD_ChipChallenge:valueSend', challengeAgain, nil)
                local ped = PlayerPedId()
                SetPedMoveRateOverride(ped, 1.0)
                SetRunSprintMultiplierForPlayer(ped, 1.0)
                SetPedIsDrunk(ped, false)
                ResetPedMovementClipset(ped)
                AnimpostfxStopAll()
                if chipType == 'hot_chip' then
                    ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 0.0)
                elseif chipType == 'salt_chip' then
                    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                elseif chipType == 'sour_chip' then
                    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                elseif chipType == 'dog_poop_chip' then
                    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                -- elseif chipType == 'gmd_chip' then
                --     ShakeGameplayCam("DRUNK_SHAKE", 0.0)
                end

                SetTimecycleModifierStrength(0.0)

                break
            else
                remainingSeconds = math.ceil(challengeTimeInMilliseconds / 1000)
                remainingThirds = math.ceil(remainingSeconds / (challengeTimeInMinutes * 60 / 3))

                TriggerServerEvent('GMD_ChipChallenge:valueSend', challengeAgain, remainingSeconds)

                if remainingThirds < currentThird and not playerDie then
                    currentThird = remainingThirds
            
                    if chipType == 'hot_chip' then
                        effectCounterDelay = effectCounterDelay - 0.2
                        ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", effectCounterDelay)
                    elseif chipType == 'salt_chip' then
                        effectCounterDelay = effectCounterDelay - 0.2
                        ShakeGameplayCam("DRUNK_SHAKE", effectCounterDelay)
                    elseif chipType == 'sour_chip' then
                        effectCounterDelay = effectCounterDelay - 0.2
                        ShakeGameplayCam("DRUNK_SHAKE", effectCounterDelay)
                    elseif chipType == 'dog_poop_chip' then
                        effectCounterDelay = effectCounterDelay - 0.2
                        ShakeGameplayCam("DRUNK_SHAKE", effectCounterDelay)
                    -- elseif chipType == 'gmd_chip' then
                    --     effectCounterDelay = effectCounterDelay - 0.2
                    --     ShakeGameplayCam("DRUNK_SHAKE", effectCounterDelay)
                    end
                end
            end
        end
    end)
end

function CalculateEffectReductions(currentStrength, totalTime)
    if currentStrength <= 0.0 then
        return 0, {}
    end

    local reductions = {}
    local remainingTime = totalTime
    local timePerReduction = 1000

    while currentStrength > 0.0 and remainingTime > 0 do
        local reductionAmount = math.min(currentStrength, 1.0)
        table.insert(reductions, {time = totalTime - remainingTime, strength = reductionAmount})
        currentStrength = currentStrength - reductionAmount
        remainingTime = remainingTime - timePerReduction
    end

    return #reductions, reductions
end