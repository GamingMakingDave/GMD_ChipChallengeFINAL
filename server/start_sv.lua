ESX = exports['es_extended']:getSharedObject()

local lastSelectedChip = nil
local againTimer = false
local timer = nil

RegisterServerEvent('GMD_ChipChallenge:valueSend')
AddEventHandler('GMD_ChipChallenge:valueSend', function(canEatAgain, time)
    againTimer = canEatAgain
    timer = time
end)

ESX.RegisterUsableItem('surprise_chip', function(source)
    if not againTimer then
        local chipTypes = Config.chipTypes
        local chipNames = {}

        for chipName, _ in pairs(chipTypes) do
            table.insert(chipNames, chipName)
        end

        if lastSelectedChip then
            for i, chipName in ipairs(chipNames) do
                if chipName == lastSelectedChip then
                    table.remove(chipNames, i)
                    break
                end
            end
        end

        if #chipNames == 0 then
            for chipName, _ in pairs(chipTypes) do
                table.insert(chipNames, chipName)
            end
        end

        local randomIndex = math.random(#chipNames)
        local randomChipType = chipNames[randomIndex]

        local shouldWin = math.random() > 0.5
        print(shouldWin)

        local chipConfig = chipTypes[randomChipType]

        lastSelectedChip = randomChipType

        TriggerClientEvent('GMD_ChipChallenge:challengeStart', source, randomChipType, shouldWin, chipConfig)
    else
        TriggerClientEvent('esx:showNotification', source, (Config.Language[Config.Local]['challende_re_text']:format(timer)))
    end
end)

RegisterServerEvent('GMD_ChipChallenge:hasFinished')
AddEventHandler('GMD_ChipChallenge:hasFinished', function(chipType)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('surprise_chip', 1)

    if Config.chipTypes[chipType] then
        local chipWin = Config.chipTypes[chipType]
        local chipAmmount = Config.chipTypes[chipType].moneyAmount

        if chipWin.giveMoney then
            xPlayer.addMoney(chipAmmount)
            if chipWin.moneyNotify then
                TriggerClientEvent('esx:showNotification', source, (Config.Language[Config.Local]['challenge_money_text']:format(chipAmmount)))
            end
        end

        if chipWin.giveItem then
            for k, v in ipairs(Config.chipTypes[chipType].item) do
                xPlayer.addInventoryItem(v[1], v[2])
            end
        end
    end
end)
