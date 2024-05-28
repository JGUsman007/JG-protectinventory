local inventoryid

local function openinventory()
    print(inventoryid)
    exports.ox_inventory:openInventory('stash', inventoryid)
end


lib.addKeybind({
    name = 'keybind_protectinventory',
    description = 'pay respects',
    defaultKey = Config.keybind,
    onPressed = openinventory
})


RegisterNetEvent('Client:Notify', function(title, description, type)
    lib.notify({
        title = title,
        description = description,
        type = type
    })
end)







if Config.framework == 'esx' then
    ESX = exports["es_extended"]:getSharedObject()

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(playerData)
        inventoryid = playerData.identifier .. ' protectinventory'
        TriggerServerEvent('Server:Update:Inventoryid', inventoryid)
    end)

    AddEventHandler('onResourceStart', function(resourceName)
        Wait(1000)
        if resourceName ~= GetCurrentResourceName() then return end
        if ESX.IsPlayerLoaded() then
            ESX.PlayerData = ESX.GetPlayerData()
            inventoryid = ESX.PlayerData.identifier .. ' protectinventory'
            TriggerServerEvent('Server:Update:Inventoryid', inventoryid)
        end
    end)
else
    QBCore = exports['qb-core']:GetCoreObject()

    RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
        local citizenid = QBCore.Functions.GetPlayerData().citizenid
        inventoryid = citizenid .. ' protectinventory'
        TriggerServerEvent('Server:Update:Inventoryid', inventoryid)
    end)

    AddEventHandler('onServerResourceStart', function(resourceName)
        if resourceName ~= GetCurrentResourceName() then return end

        if QBCore.Functions.GetPlayerData() then
            local citizenid = QBCore.Functions.GetPlayerData().citizenid
            inventoryid = citizenid .. ' protectinventory'
            TriggerServerEvent('Server:Update:Inventoryid', inventoryid)
        end
    end)
end
