local QBCore = exports['qb-core']:GetCoreObject()

local inZone = false
local currentZone = nil
local repairingVehicle = false
local combo = nil

local function L(key)
    return Config.Strings[Config.Locale][key] or ("MISSING_"..key)
end

local function PlayLocalMP3(file, volume)
    SendNUIMessage({
        action = "playSound",
        file = "sounds/"..file,
        volume = volume or 0.8
    })
end

-- sound and range control / if you want the change repair sound "sound/repair.mp3" it must be .mp3
RegisterNetEvent("s-repairzone:clientPlayRepairSound", function(netVeh)
    local veh = NetToVeh(netVeh)
    if veh ~= 0 then
        local ped = PlayerPedId()
        local myCoords = GetEntityCoords(ped)
        local vehCoords = GetEntityCoords(veh)

        if #(myCoords - vehCoords) <= Config.SoundDistance then
            PlayLocalMP3("repair.mp3", 1.0)
        end
    end
end)

CreateThread(function()
    local zones = {}
    for _, zone in pairs(Config.RepairZones) do
        local poly = PolyZone:Create(zone.vertices, {
            name = zone.name,
            minZ = zone.minZ,
            maxZ = zone.maxZ,
            debugPoly = Config.ZoneDebug
        })
        table.insert(zones, poly)

        if zone.blip and zone.blip.enabled then
            local centerX, centerY = 0, 0
            for _, v in ipairs(zone.vertices) do
                centerX = centerX + v.x
                centerY = centerY + v.y
            end

            local bx = centerX / #zone.vertices
            local by = centerY / #zone.vertices
            local blip = AddBlipForCoord(bx, by, (zone.minZ + zone.maxZ) / 2)
            SetBlipSprite(blip, zone.blip.sprite or 402)
            SetBlipColour(blip, zone.blip.color or 2)
            SetBlipScale(blip, zone.blip.scale or 0.8)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(zone.blip.label or "Repair Zone")
            EndTextCommandSetBlipName(blip)
        end
    end

    combo = ComboZone:Create(zones, {
        name = "repair_polys",
        debugPoly = Config.ZoneDebug
    })

    combo:onPlayerInOut(function(isInside, zoneData)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        if isInside and veh ~= 0 then
            inZone = true
            currentZone = zoneData.name
            lib.showTextUI(L("repair_prompt"))
        else
            inZone = false
            currentZone = nil
            lib.hideTextUI()
        end
    end)
end)

CreateThread(function()
    while true do
        Wait(0)
        if inZone and IsPedInAnyVehicle(PlayerPedId(), false) then
            if IsControlJustPressed(0, 38) then
                TriggerEvent("s-repairzone:repairVehicle")
            end
        end
    end
end)

RegisterNetEvent("s-repairzone:repairVehicle", function()
    lib.hideTextUI()

    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)

    if veh == 0 then
        QBCore.Functions.Notify(L("not_in_vehicle"), "error")
        return
    end

    repairingVehicle = true
    FreezeEntityPosition(veh, true)
    SetVehicleEngineOn(veh, false, true, true)
    SetVehicleDoorsLocked(veh, 4)
    SetPedCanBeDraggedOut(ped, false)

    QBCore.Functions.Progressbar("repair_car", L("repairing"), Config.Repairtime, false, true, {
        disableMovement = true,
        disableVehicleMovement = true,
        disableCombat = true,
        disableMouse = false
    }, {}, {}, {}, function()

        repairingVehicle = false
        FreezeEntityPosition(veh, false)
        SetVehicleDoorsLocked(veh, 1)

        -- server broadcast
        TriggerServerEvent("s-repairzone:serverPlayRepairSound", VehToNet(veh))
        TriggerServerEvent("s-repairzone:processPayment")

    end, function()
        repairingVehicle = false
        FreezeEntityPosition(veh, false)
        SetVehicleDoorsLocked(veh, 1)
        QBCore.Functions.Notify(L("cancelled"), "error")
    end)
end)

CreateThread(function()
    while true do
        Wait(0)
        if repairingVehicle then
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
            if veh == 0 then
                local lastVeh = GetPlayersLastVehicle()
                if lastVeh ~= 0 then
                    TaskWarpPedIntoVehicle(ped, lastVeh, -1)
                end
            end
        end
    end
end)

RegisterNetEvent("s-repairzone:fixVehicle", function()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if veh ~= 0 then
        SetVehicleFixed(veh)
        SetVehicleDirtLevel(veh, 0.0)
        QBCore.Functions.Notify(L("repaired"), "success")
    end
end)
