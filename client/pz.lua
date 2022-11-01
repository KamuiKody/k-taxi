local QBCore = exports['qb-core']:GetCoreObject()
local inBoss = false
local inDuty = false
local inStash = false
local inGarage = false
local listen = false

local function Listen4Control()
    CreateThread(function()
        listen = true
        while listen do
            if IsControlJustPressed(0, 38) then 
                if inBoss then
                    exports["qb-core"]:KeyPressed()
                    TriggerEvent("qb-bossmenu:client:OpenMenu")
                elseif inDuty then
                    exports["qb-core"]:KeyPressed()
                    TriggerEvent("k-taxi:setDuty")
                elseif inStash then
                    exports["qb-core"]:KeyPressed()
                    TriggerEvent("k-taxi:Storage")
                elseif inGarage then
                    TriggerEvent('k-taxi:garagemenu')
                    exports["qb-core"]:KeyPressed()
                end
                listen = false
                exports["qb-core"]:HideText()
                break
            end
            Wait(1)
        end
    end)
end

CreateThread(function()
    if not Config.Target then
        -- Boss Menu
        bossZones = BoxZone:Create(
            Config.Locations["boss"].location, 1.5, 1.5, {
            name="box_zone",
            debugPoly = false,
            minZ = Config.Locations["boss"].location.z - 1,
            maxZ = Config.Locations["boss"].location.z + 1,
        })
        bossZones:onPlayerInOut(function(isPointInside, _, _)
            if isPointInside then
                inBoss = true
                exports['qb-core']:DrawText(Config.Locations["boss"].label, 'left')
                Listen4Control()
            else
                exports['qb-core']:HideText()
                inBoss = false
            end
        end)
        -- Duty Menu
        dutyZones = BoxZone:Create(
            Config.Locations["duty"].location, 1.5, 1.5, {
            name="box_zone",
            debugPoly = false,
            minZ = Config.Locations["duty"].location.z - 1,
            maxZ = Config.Locations["duty"].location.z + 1,
        })
        dutyZones:onPlayerInOut(function(isPointInside, _, _)
            if isPointInside then
                inDuty = true
                exports['qb-core']:DrawText(Config.Locations["duty"].label, 'left')
                Listen4Control()
            else
                exports['qb-core']:HideText()
                inDuty = false
            end
        end)
        -- Stash Menu
        stashZones = BoxZone:Create(
            Config.Locations["stash"].location, 1.5, 1.5, {
            name="box_zone",
            debugPoly = false,
            minZ = Config.Locations["stash"].location.z - 1,
            maxZ = Config.Locations["stash"].location.z + 1,
        })
        stashZones:onPlayerInOut(function(isPointInside, _, _)
            if isPointInside then
                inStash = true
                exports['qb-core']:DrawText(Config.Locations["stash"].label, 'left')
                Listen4Control()
            else
                exports['qb-core']:HideText()
                inStash = false
            end
        end)
        -- Garage Menu
        garageZones = BoxZone:Create(
            Config.Locations["garage"].location, 1.5, 1.5, {
            name="box_zone",
            debugPoly = false,
            minZ = Config.Locations["garage"].location.z - 1,
            maxZ = Config.Locations["garage"].location.z + 1,
        })
        garageZones:onPlayerInOut(function(isPointInside, _, _)
            if isPointInside then
                inGarage = true
                exports['qb-core']:DrawText(Config.Locations["garage"].label, 'left')
                Listen4Control()
            else
                exports['qb-core']:HideText()
                inGarage = false
            end
        end)
    else
        exports[Config.Target]:AddBoxZone("taxiduty", Config.Locations['duty'].location, 1.5, 1.5, {
            name="taxiduty",
            heading=327,
            --debugPoly=true
                }, {
            options = {
                {
                    event = "k-taxi:setDuty",
                    icon = "fas fa-sign-in-alt",
                    label = Config.Locations['duty'].label,
                    job = Config.Jobname
                },
            },
            distance = 2.5
        })
        exports[Config.Target]:AddBoxZone("taxiboss", Config.Locations['boss'].location, 1.5, 1.5, {
            name="taxiboss",
            heading=327,
            --debugPoly=true
                }, {
            options = {
                {
                    event = "qb-bossmenu:client:OpenMenu",
                    icon = "fas fa-sign-in-alt",
                    label = Config.Locations['boss'].label,
                    job = Config.Jobname
                },
            },
            distance = 2.5
        })
        exports[Config.Target]:AddBoxZone("Cab-Co Storage", Config.Locations['stash'].location, 1.5, 1.5, {
            name="Cab-Co Storage",
            heading=330,
            --debugPoly=true
                }, {
            options = {
                {  
                event = "k-taxi:Storage",
                icon = "far fa-clipboard",
                label = Config.Locations['stash'].label,
                job = Config.Jobname
                },
            },
            distance = 2.5
        })
        exports[Config.Target]:AddBoxZone("Cab-Co Garage", Config.Locations['garage'].location, 1.5, 1.5, {
            name="Cab-Co Garage",
            heading=330,
            --debugPoly=true
                }, {
            options = {
                {  
                event = "k-taxi:garagemenu",
                icon = "far fa-clipboard",
                label = Config.Locations['garage'].label,
                job = Config.Jobname
                }
            },
            distance = 2.5
        })   
    end 
end)