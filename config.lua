
Config = {}


-- in meters (for those americans who dont understand 1 meter = 3.28 feet)
Config.SoundDistance = 20.0 

-- Choose your language
-- [tr = türkçe],  [en = english]
-- [ru = pусский], [es = español]
-- [de = deutsch], [fr = Français]
Config.Locale = "en" 

-- Progressbar time (ms) 10000 = 10 second
Config.Repairtime = 10000

-- Car repair cost bank or cash its same
Config.RepairCost = 1000

-- Polyzone debug
Config.ZoneDebug = false

-- Zones (uses polyzone btw)
Config.RepairZones = {
    {
        name = "garbage_area",
        minZ = 18.0,
        maxZ = 25.0,
        vertices = {
            vector2(-1354.14, -757.19),
            vector2(-1357.54, -751.89),
            vector2(-1363.02, -755.99),
            vector2(-1359.46, -760.79),
        },
        blip = {
            enabled = true,
            label = "Repair Zone",
            sprite = 643,     
            color = 4,
            scale = 0.8
        }
    },

    {
        name = "franklin_house",
        minZ = 29.0,
        maxZ = 32.0,
        vertices = {
            vector2(-23.49, -1430.42),
            vector2(-27.26, -1430.49),
            vector2(-27.42, -1424.37),
            vector2(-23.35, -1424.19),
        },
        blip = {
            enabled = true,
            label = "Repair Zone",
            sprite = 643,     
            color = 4,
            scale = 0.8
        }
    },

    {
        name = "paleto_bay",
        minZ = 29.0,
        maxZ = 34.0,
        vertices = {
            vector2(-62.07, 6446.59),
            vector2(-64.62, 6444.17),
            vector2(-61.08, 6440.66),
            vector2(-58.63, 6443.07),
        },
        blip = {
            enabled = true,
            label = "Repair Zone",
            sprite = 643,     
            color = 4,
            scale = 0.8
        }
    },

    {
        name = "fire_station",
        minZ = 33.0,
        maxZ = 38.0,
        vertices = {
            vector2(1699.89, 3588.22),
            vector2(1693.04, 3584.33),
            vector2(1688.13, 3591.49),
            vector2(1695.62, 3595.73),
        },
        blip = {
            enabled = true,
            label = "Repair Zone",
            sprite = 643,     
            color = 4,
            scale = 0.8
        }
    }
}




Config.Strings = {
    tr = {
        repair_prompt = "[E] Aracı Tamir Et",
        repairing = "Araç Tamir Ediliyor...",
        repaired = "Araç Tamir Edildi",
        insufficient_funds = "Yeterli paran yok!",
        cancelled = "İşlem İptal Edildi",
        not_in_vehicle = "Araçta değilsin!"
    },
    en = {
        repair_prompt = "[E] Repair Vehicle",
        repairing = "Repairing Vehicle...",
        repaired = "Vehicle Repaired",
        insufficient_funds = "You do not have enough money!",
        cancelled = "Repair Cancelled",
        not_in_vehicle = "You are not in a vehicle!"
    },
    es = {
        repair_prompt = "[E] Reparar vehículo",
        repairing = "Reparando vehículo...",
        repaired = "Vehículo reparado",
        insufficient_funds = "¡No tienes suficiente dinero!",
        cancelled = "Reparación cancelada",
        not_in_vehicle = "¡No estás en un vehículo!"
    },
    ru = { 
        repair_prompt = "[E] Починить транспорт",
        repairing = "Идёт починка транспорта...",
        repaired = "Транспорт починен",
        insufficient_funds = "У вас недостаточно денег!",
        cancelled = "Починка отменена",
        not_in_vehicle = "Вы не в транспорте!"
    },
    de = { 
        repair_prompt = "[E] Fahrzeug reparieren",
        repairing = "Fahrzeug wird repariert...",
        repaired = "Fahrzeug repariert",
        insufficient_funds = "Du hast nicht genug Geld!",
        cancelled = "Reparatur abgebrochen",
        not_in_vehicle = "Du bist nicht in einem Fahrzeug!"
    },
    fr = {
        repair_prompt = "[E] Réparer le véhicule",
        repairing = "Réparation du véhicule en cours...",
        repaired = "Véhicule réparé",
        insufficient_funds = "Vous n'avez pas assez d'argent !",
        cancelled = "Réparation annulée",
        not_in_vehicle = "Vous n'êtes pas dans un véhicule !"
    }
}



