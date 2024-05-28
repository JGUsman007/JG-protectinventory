
local ids = {}


exports.ox_inventory:registerHook('swapItems', function(data)
    local state = false
    for i = 1 ,#ids do
    if data.toInventory == ids[i] then
        if Config.allowallitems then goto skipcheck end
        for i = 1, #Config.alloweditems do
            if data.fromSlot.name == Config.alloweditems[i] then
                goto skipcheck
            end
        end
        TriggerClientEvent('Client:Notify', data.fromInventory, 'Inventory', 'This item is not allowed', 'error')
        state = true
    end
end
    if state then return false end
    ::skipcheck::
end)



RegisterNetEvent('Server:Update:Inventoryid', function (inventoryid)
    ids[#ids+1] = inventoryid
    exports.ox_inventory:RegisterStash(inventoryid, 'Protected Inventory', Config.slots, Config.maxweight * 1000)
end)