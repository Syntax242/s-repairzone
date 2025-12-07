local QBCore = exports['qb-core']:GetCoreObject()

local function L(key)
    return Config.Strings[Config.Locale][key] or ("MISSING_"..key)
end

-- repair event
RegisterNetEvent("s-repairzone:serverPlayRepairSound", function(netVeh)
    TriggerClientEvent("s-repairzone:clientPlayRepairSound", -1, netVeh)
end)

RegisterNetEvent("s-repairzone:processPayment", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local price = Config.RepairCost

    if not Player then return end

    if Player.Functions.RemoveMoney("cash", price) then
        TriggerClientEvent("s-repairzone:fixVehicle", src)
        return
    end

    if Player.Functions.RemoveMoney("bank", price) then
        TriggerClientEvent("s-repairzone:fixVehicle", src)
        return
    end
    
    TriggerClientEvent('QBCore:Notify', src, L("insufficient_funds"), "error")
end)
