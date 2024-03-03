local inventoryid 

RegisterNetEvent('Client:Update:Inventoryid', function(id)
    inventoryid = id
end)

local function openinventory()
    exports.ox_inventory:openInventory('stash', GlobalState.inventoryid)
end


lib.addKeybind({
    name = 'keybind_protectinventory',
    description = 'pay respects',
    defaultKey = Config.keybind,
    onPressed = openinventory
})


RegisterNetEvent('Client:Notify', function (title,description,type)
    lib.notify({
        title = title,
        description = description,
        type = type
    })    
end)
