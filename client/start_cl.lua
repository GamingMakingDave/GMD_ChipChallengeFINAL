ESX = exports['es_extended']:getSharedObject()

-- local values
showStartChallengeText = false
local showChipType = false

-- global values
startChallenge = false
eating = false
showPressedText = false
playerInvisable = false

RegisterNetEvent('GMD_ChipChallenge:challengeStart')
AddEventHandler('GMD_ChipChallenge:challengeStart', function(chipType, Test)

    local ped = PlayerPedId()
    local ChipmodelHash = GetHashKey('bzzz_prop_food_one_nacho_a')
    local bone = 60309

    showStartChallengeText = false
    startChallenge = false
    effectAddCounter = 0
    playerDie = false
    print(chipType)


    CreateThread(function()
        while true do
            Wait(1)
            if not showStartChallengeText then
                ESX.ShowHelpNotification(Config.Language[Config.Local]['start_challenge_text'])
            else
                break
            end
        end
    end)

    RequestModel(ChipmodelHash)

    while not HasModelLoaded(ChipmodelHash) do
        Wait(500)
    end

    ChipProp = CreateObject(ChipmodelHash, 0, 0, 0, 1, 1, 0)

    AttachEntityToEntity(ChipProp, ped, GetPedBoneIndex(ped, bone), -0.02, 0.0, 0.0, 30.0, 24.0, 44.0, true, true, false, true, 1, true)

    Wait(100)
    
    FreezeEntityPosition(ChipProp, true)

    playStartChallengeAnim('mp_player_inteat@burger', 'mp_player_int_eat_burger_enter', -1)

    startChallenge = true

    while startChallenge do
        local pressedKey = WaitForKeyPress({38, 73})

        if pressedKey == 38 then -- E Taste

            showStartChallengeText = true
            showPressedText = true
            showChipType = true
            effectAddCounter = 0.2

            AttachEntityToEntity(ChipProp, ped, GetPedBoneIndex(ped, bone), -0.02, 0.0, 0.0, 30.0, 24.0, 44.0, true, true, false, true, 1, true)

            Wait(100)

            FreezeEntityPosition(ChipProp, true)

            playEatHotChip('mp_player_inteat@burger', 'mp_player_int_eat_burger', -1)

            Wait(5000)
            print(chipType)

            addChipEffect(chipType, effectAddCounter)

            showPressedText = false

            if showChipType then
                local chipType = Config.chipTypes[chipType].name
                ESX.ShowNotification((Config.Language[Config.Local]['chiptype_notify']:format(chipType)), -1)
                playStartChallengeAnim('mp_player_inteat@burger', 'mp_player_int_eat_burger_enter', -1)
                Wait(2000)
                showChipType = false
            end 

            CreateThread(function()
                while true do
                    Wait(1)
                    if not showPressedText and showStartChallengeText and startChallenge then
                        ESX.ShowHelpNotification(Config.Language[Config.Local]['next_step_text'])
                    end
                end
            end)

            eating = true

            if chipType == 'hot_chip' then
                StartHotChip(ped, chipType)
            end
            if chipType == 'salt_chip' then
                StartSaltChip(ped, chipType)
            end
            if chipType == 'sour_chip' then
                StartSourChip(ped, chipType)
            end
            if chipType == 'dog_poop_chip' then
                StartDogPoopChip(ped, chipType)
            end
            -- if chipType == 'gmd_chip' then
            --     StartGMDChip(ped, chipType)
            -- end
            -- add here you own Chips
 
        elseif pressedKey == 73 then -- X Taste

            startChallenge = false
            showStartChallengeText = true
            showPressedText = false


            DeleteObject(ChipProp)
            ClearPedTasks(ped)
        end
    end
end)