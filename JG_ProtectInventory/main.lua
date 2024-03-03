

exports.ox_inventory:registerHook('swapItems', function(data)
    local state = false
    if data.toInventory == GlobalState.inventoryid then
        if Config.allowallitems then goto skipcheck end
        for i = 1, #Config.alloweditems do
            if data.fromSlot.name == Config.alloweditems[i] then
                goto skipcheck
            end
        end
        TriggerClientEvent('Client:Notify', data.fromInventory, 'Inventory', 'This item is not allowed', 'error')
        state = true
    end

    if state then return false end
    ::skipcheck::
end)



if Config.framework == 'esx ' then
    ESX = exports["es_extended"]:getSharedObject()
    RegisterNetEvent('esx:playerLoaded', function(player, xPlayer, isNew)
        local id = xPlayer.getIdentifier() .. ' protectinventory'
        exports.ox_inventory:RegisterStash(id, 'Protected Inventory', Config.slots, Config.maxweight * 1000)
        TriggerClientEvent('Client:Update:Inventoryid',source,id)
    end)
else
    QBCore = exports['qb-core']:GetCoreObject()
    AddEventHandler('onServerResourceStart', function(resourceName)
        while (not QBCore.Functions.GetPlayerData()) do
            local id = QBCore.Functions.GetPlayerData().citizenid .. ' protectinventory'
            exports.ox_inventory:RegisterStash(id, 'Protected Inventory', Config.slots, Config.maxweight * 1000)
            TriggerClientEvent('Client:Update:Inventoryid',source,id)
        end
    end)

end
