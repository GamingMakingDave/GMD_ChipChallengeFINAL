Config = {}

Config.DebugMode = true -- disable in roleplay this activate commands

Config.Local = 'en' -- select you Local de, en 

Config.ReChallenge = 1 -- set here restart timer in minutes

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- !!! --- Here, you can customize your chips individually. WARNING!!! You can add your own additional chips. PLEASE REFER TO THE WIKI FOR THIS: 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Config.chipTypes = {
    ['hot_chip'] = {
        name = 'Hot Chip', -- ingame Notify Chipname
        challengeMaxBits = 4, -- maximal bites from Chip its random 
        startEffectCount = 0.4, -- start effectcount by bite + 0.2

        giveMoney = true, -- give player money by challenge success
        moneyNotify = true, -- enable money Notify
        moneyAmount = 1000, -- money ammount 

        giveItem = true, -- give player item by challenge success
        item = {
            [1] = {'water', 1}, -- itemname, itemcount
            [2] = {'bread', 1}, -- itemname, itemcount
        },
        
        removeStatus = true, -- use esx_status remove Status on bite
        removeType = 'thirst', -- status type here thirst or hunger
        removeStatusHigh = 150000, -- remove status high Remember to consider your maximum status in esx_status/config.lua when using the Config.StatusMax = 1000000

        canPlayerDie = true, -- can player die on Chip
        canDieChance = 25 -- death chance is higher, the riskier the challenge. I recommend setting it to 25
    },
    ['salt_chip'] = {
        name = 'Salt Chip', -- ingame Notify Chipname
        challengeMaxBits = 4, -- maximal bites from Chip its random 
        startEffectCount = 0.2, -- start effectcount by bite + 0.2

        giveMoney = true, -- give player money by challenge success
        moneyNotify = true, -- enable money Notify
        moneyAmount = 1000, -- money ammount 

        giveItem = true, -- give player item by challenge success
        item = {
            [1] = {'water', 1}, -- itemname, itemcount
            [2] = {'bread', 1}, -- itemname, itemcount
        },
        
        removeStatus = true, -- use esx_status remove Status on bite
        removeType = 'thirst', -- status type here thirst or hunger
        removeStatusHigh = 150000, -- remove status high Remember to consider your maximum status in esx_status/config.lua when using the Config.StatusMax = 1000000

        canPlayerDie = true, -- can player die on Chip
        canDieChance = 25 -- death chance is higher, the riskier the challenge. I recommend setting it to 25
    },
    ['sour_chip'] = {
        name = 'Sour Chip', -- ingame Notify Chipname
        challengeMaxBits = 4, -- maximal bites from Chip its random 
        startEffectCount = 0.1, -- start effectcount by bite + 0.2

        giveMoney = true, -- give player money by challenge success
        moneyNotify = true, -- enable money Notify
        moneyAmount = 1000, -- money ammount 

        giveItem = true, -- give player item by challenge success
        item = {
            [1] = {'water', 1}, -- itemname, itemcount
            [2] = {'bread', 1}, -- itemname, itemcount
        },
        
        removeStatus = true, -- use esx_status remove Status on bite
        removeType = 'thirst', -- status type here thirst or hunger
        removeStatusHigh = 150000, -- remove status high Remember to consider your maximum status in esx_status/config.lua when using the Config.StatusMax = 1000000

        canPlayerDie = true, -- can player die on Chip
        canDieChance = 25 -- death chance is higher, the riskier the challenge. I recommend setting it to 25
    },
    ['dog_poop_chip'] = {
        name = 'Dog Poop Chip', -- ingame Notify Chipname
        challengeMaxBits = 4, -- maximal bites from Chip its random 
        startEffectCount = 0.6, -- start effectcount by bite + 0.2

        giveMoney = true, -- give player money by challenge success
        moneyNotify = true, -- enable money Notify
        moneyAmount = 1000, -- money ammount 

        giveItem = true, -- give player item by challenge success
        item = {
            [1] = {'water', 1}, -- itemname, itemcount
            [2] = {'bread', 1}, -- itemname, itemcount
        },
        
        removeStatus = true, -- use esx_status remove Status on bite
        removeType = 'thirst', -- status type here thirst or hunger
        removeStatusHigh = 150000, -- remove status high Remember to consider your maximum status in esx_status/config.lua when using the Config.StatusMax = 1000000

        canPlayerDie = true, -- can player die on Chip
        canDieChance = 25 -- death chance is higher, the riskier the challenge. I recommend setting it to 25
    }
    -- ['gmd_chip'] = {
    --     name = 'GMD Super Exemple Chip', -- ingame Notify Chipname
    --     challengeMaxBits = 4, -- maximal bites from Chip its random 

    --     giveMoney = true, -- give player money by challenge success
    --     moneyNotify = true, -- enable money Notify
    --     moneyAmount = 1000, -- money ammount 

    --     giveItem = true, -- give player item by challenge success
    --     item = {
    --         [1] = {'water', 1}, -- itemname, itemcount
    --         [2] = {'bread', 1}, -- itemname, itemcount
    --     },
        
    --     removeStatus = true, -- use esx_status remove Status on bite
    --     removeType = 'thirst', -- status type here thirst or hunger
    --     removeStatusHigh = 150000, -- remove status high Remember to consider your maximum status in esx_status/config.lua when using the Config.StatusMax = 1000000

    --     canPlayerDie = true, -- can player die on Chip
    --     canDieChance = 25 -- death chance is higher, the riskier the challenge. I recommend setting it to 25
    -- }
}

Config.Language = {
    ['de'] = {
        ['start_challenge_text'] = 'Du hast den Chip ausgepackt willst du wirklich die ~o~~bold~Surprise Chip Challenge... ~h~~w~machen? ~r~~h~~n~~italic~Sei dir den Nebenwirkungen bewusst!~italic~~h~~w~~n~Möchtest du die Challenge fortsetzen? ~n~Drücke ~INPUT_PICKUP~ für Ja oder ~INPUT_VEH_DUCK~ für Nein.~n~',
        ['chiptype_notify'] = 'Du hast %s erwischt nun wird es lustig',
        ['next_step_text'] = 'Drücke ~INPUT_PICKUP~ um weiter zu machen oder ~INPUT_VEH_DUCK~ um die Challange abzubrechen.',
        ['challenge_failed'] = 'Du hast die Challenge nicht gemeistert und bist daran bewusstlos geworden!',
        ['challenge_canceled'] = 'Du hast die Challenge abbgebrochen? WEICHEI!!!',
        ['challenge_win'] = 'Du hast die Challenge gemeister Glückwunsch',
        ['challende_re_text'] = 'Du musst noch %s Sekunden lang warten bis du ein neuen Chip öffnen kannst!',
        ['challenge_money_text'] = 'Du hast %s $ für die Challenge erhalten.'
    },
    ['en'] = {
        ['start_challenge_text'] = 'Youve unpacked the chip, do you really want to take the ~o~~bold~Surprise Chip Challenge... ~h~~w~now? ~r~~h~~n~~italic~Be aware of the side effects!~italic~~h~~w~~n~Do you want to proceed with the challenge? ~n~Press ~INPUT_PICKUP~ for Yes or ~INPUT_VEH_DUCK~ for No.~n~',
        ['chiptype_notify'] = 'You got %s, now it gets interesting',
        ['next_step_text'] = 'Press ~INPUT_PICKUP~ to continue or ~INPUT_VEH_DUCK~ to cancel the challenge.',
        ['challenge_failed'] = 'You failed the challenge and passed out!',
        ['challenge_canceled'] = 'You canceled the challenge? CHICKEN!!!',
        ['challenge_win'] = 'Congratulations! Youve mastered the challenge',
        ['challende_re_text'] = 'You have to wait %s more seconds before you can open a new chip!',
        ['challenge_money_text'] = 'You received %s for completing the challenge.'
    }
}