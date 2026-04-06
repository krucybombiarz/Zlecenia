local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('hitman:reward', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local reward = math.random(Config.Reward.min, Config.Reward.max)

    xPlayer.addAccountMoney(Config.Reward.account, reward)

    TriggerClientEvent('chat:addMessage', source, {
        args = {"zlecenio dawca", "Otrzymano $" .. reward .. " brudnej gotówki"}
    })
end)