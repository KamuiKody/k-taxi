
local QBCore = exports['qb-core']:GetCoreObject()
local delivering = false
local pickedUp = false
local playing = false
local StartLoc = nil
local riders = nil
local over = false
local name = 'John Doe'
local name2 = 'Jane Doe'
local display = false
local drivingdistance = 0
local faredisplay = 0
local customlimit = 0
local gender = false
local fare = 0
local distance = 0
local limiter = 0
local permile = 0
local urban = 0
local rural = 0
local hwy = 0
local focus = false
local available = false
local npccalls = {}

function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end

function GarageMenu()
    local garageMenu = {
        {
            header = "| Cab-Co Garage |",
            isMenuHeader = true
        }
    }
    local VehicleList = Config.Locations['garage']['vehicles'][QBCore.Functions.GetPlayerData().job.grade.level]
    for k, v in pairs(VehicleList) do
        garageMenu[#garageMenu+1] = {
            header = v,
            params = {
                event = "k-taxi:choose",
                args = {
                        vehicle = v
                }
            }
        }
    end
    garageMenu[#garageMenu+1] = {
        header = "⬅ Close Menu",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }
    exports['qb-menu']:openMenu(garageMenu)
end

function CabCheck()
    local ped = PlayerPedId()
    local veh = GetEntityModel(GetVehiclePedIsIn(ped))
    local retval = false
    for i = 1, #Config.Locations['garage']['vehicles'][QBCore.Functions.GetPlayerData().job.grade.level], 1 do
        if veh == GetHashKey(Config.Locations['garage']['vehicles'][QBCore.Functions.GetPlayerData().job.grade.level][i]) then
            retval = true
        end
    end
    return retval
end

local function NPCCall()
    StartLoc = table.unpack(Config.PedLoc[math.random(1, #Config.PedLoc)])
    riders = math.random(1,2)
    rideCall = true
    local x, y, z, w = table.unpack(StartLoc)
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
    if math.random(1,2) == 1 then
        gender = 'male'
    else
        gender = 'female'
    end
    if riders == 1 then
        name = Config.Peds['names'][gender][math.random(1,#Config.Peds['names'][gender])]
        TriggerEvent('k-taxi:Notify', 'You have to pick up '.. name ..' at '.. street ..'. ', 'success', 5000)
        Wait(5000)
        npccalls[#npccalls+1] = {
            location = StartLoc,
            riders = riders,
            gender = gender,
            name = name,
            name2 = false
        }
        rideCall = false
    else
        name = Config.Peds['names'][gender][math.random(1,#Config.Peds['names'][gender])]
        name2 = Config.Peds['names'][gender][math.random(1,#Config.Peds['names'][gender])]
        TriggerEvent('k-taxi:Notify', 'You have to pick up '.. name ..' and '.. name2 ..' at '.. street ..'.', 'success', 5000)
        Wait(5000)
        npccalls[#npccalls+1] = {
            location = StartLoc,
            riders = riders,
            gender = gender,
            name = name,
            name2 = name2
        }
        rideCall = false
    end    
end
exports("NPCCall", NPCCall)

local function DropoffLocation(EndLoc, pickupprice, riders, plate)
    if DeliveryBlip ~= nil then
        RemoveBlip(DeliveryBlip)
    end
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    local currentplate = QBCore.Functions.GetPlate(veh)
    Wait(500)
    if plate ~= currentplate then TriggerEvent('k-taxi:Notify', Config.Notifications['nocab'],'error',5000) return end
    local x, y, z, w = table.unpack(EndLoc)
    local street = GetStreetNameAtCoord(x,y,z)
    DeliveryBlip = AddBlipForCoord(EndLoc.x, EndLoc.y, EndLoc.z)
    SetBlipColour(DeliveryBlip, Config.NPCBlipColor)
    SetBlipRoute(DeliveryBlip, true)
    SetBlipRouteColour(DeliveryBlip, Config.NPCRouteColor)
    Wait(500)
    dropoffprice = round(((GetGpsBlipRouteLength()/1776) * Config.DropOffPrice), 0)
    if riders == 1 then
        TriggerEvent('k-taxi:Notify', 'You have to drop off '.. name ..' at '.. GetStreetNameFromHashKey(street) ..'.', 'success', 5000)
    else
        TriggerEvent('k-taxi:Notify', 'You have to drop off '.. name ..' and '.. name2 ..' at '.. GetStreetNameFromHashKey(street) ..'.', 'success', 5000)
    end
    if display then
        UpdateMeter('show', 0, 0)
    else 
        TriggerEvent('k-taxi:meterfix')
    end
    local runaway = false
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = #(pos - vector3(EndLoc.x, EndLoc.y, EndLoc.z))
        if dist < 10 and GetEntitySpeed(ped) < 0.2 then
            local veh = GetVehiclePedIsIn(ped, 0)
            TaskLeaveVehicle(Npc, veh, 1)
            SetEntityAsMissionEntity(Npc, false, true)
            SetEntityAsNoLongerNeeded(Npc)
            TaskGoStraightToCoord(Npc, EndLoc.x, EndLoc.y, EndLoc.z, 1.0, -1, 0.0, 0.0)
            PlayPedAmbientSpeechNative(Npc, "GENERIC_THANKS", "Speech_Params_Standard")
            if riders == 2 then
                Wait(0)
                TaskLeaveVehicle(Npc2, veh, 1)
                SetEntityAsMissionEntity(Npc2, false, true)
                SetEntityAsNoLongerNeeded(Npc2)
                TaskGoStraightToCoord(Npc2, EndLoc.x, EndLoc.y, EndLoc.z, 1.0, -1, 0.0, 0.0)
                PlayPedAmbientSpeechNative(Npc2, "GENERIC_BYE", "Speech_Params_Standard")
            end
            local newveh = GetVehiclePedIsIn(ped)
            local newestplate = QBCore.Functions.GetPlate(newveh)            
            if plate ~= newestplate then 
                RemoveBlip(DeliveryBlip)
                over = true 
                NpcTaken = false
                TriggerEvent('k-taxi:Notify', Config.Notifications['nocab'],'error',5000) 
                return 
            end       
            TriggerServerEvent('k-taxi:paymebicf', pickupprice, dropoffprice)
            if DeliveryBlip ~= nil then
                RemoveBlip(DeliveryBlip)
            end  
            Wait(0)            
            ResetDisplay()
            Meter('hide', 0, 0.00, 0, Config.DropOffPrice, Config.UI['speedlimiter'].urban, Config.UI['speedlimiter'].rural, Config.UI['speedlimiter'].hwy, customlimit)
            Wait(60000)
            DeletePed(Npc)
            gender = false
            over = true
            NpcTaken = false
            break
        end
        if GetVehicleBodyHealth(veh) < Config.VehicleHealth then
            RemoveBlip(DeliveryBlip)
            if GetEntitySpeed(veh) < 1 then
                TaskReactAndFleePed(Npc, PlayerPedId())
                if riders == 2 then
                    TaskReactAndFleePed(Npc2, PlayerPedId())
                end
                gender = false
                gender = false
                over = true
                NpcTaken = false
                break
            end
        end
        if GetEntitySpeed(veh) > (Config.VehicleSpeed/2.237) then 
            runaway = true
        end
        if runaway then
            RemoveBlip(DeliveryBlip)
            if GetEntitySpeed(veh) < 1 then
                TaskReactAndFleePed(Npc, PlayerPedId())
                if riders == 2 then
                    TaskReactAndFleePed(Npc2, PlayerPedId())
                end
                gender = false
                gender = false
                over = true
                NpcTaken = false
                break
            end
        end
        Wait(0)
    end
end

RegisterNetEvent('k-taxi:CallForCab', function(offer,fname,lname,coords)
    local x, y, z = table.unpack(coords)
    local street, cross = GetStreetNameAtCoord(x,y,z)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.job.onduty then
        if PlayerData.job.name == Config.Jobname then
            if CabCheck() then
                TriggerEvent('k-taxi:Notify', 'You have a call from '.. fname ..' '.. lname ..' at '.. GetStreetNameFromHashKey(street) ..' and '..GetStreetNameFromHashKey(cross)..' for $'..offer..'. [E] to accept', 'success', 15000)
                local civride = true
                while civride do
                    Wait(0)
                    if IsControlPressed(0, 38) then
                        QBCore.Functions.TriggerCallback('k-taxi:ispickedup', function(cb)
                            if not cb then
                                local x,y,z = table.unpack(coords)
                                local CivBlip = AddBlipForCoord(x, y, z)
                                SetBlipColour(CivBlip, Config.NPCBlipColor)
                                SetBlipRoute(CivBlip, true)
                                SetBlipRouteColour(CivBlip, Config.NPCRouteColor)
                                civride = true
                                while CivBlip ~= nil do
                                    Wait(100)
                                    if #(GetEntityCoords(PlayerPedId()) - coords) < 25 then
                                        RemoveBlip(CivBlip)
                                        civride = false
                                        break
                                    end
                                end
                            else
                                civride = false
                            end
                        end)
                    end
                end
            end
        end
    end
end)


CreateThread(function()
    while true do 
        if civride then
            Wait(15000)            
            civride = false
        end
        if over then
            Wait(Config.Cooldown)
            delivering = false            
        end
        if not civride and not over then
            Wait(2000)
        end
    end
end)

CreateThread(function()
    if Config.RandomCalls then
        while true do
            if not delivering then
                if available then
                    local PlayerData = QBCore.Functions.GetPlayerData()
                    if PlayerData.job.onduty then
                        if PlayerData.job.name == Config.Jobname then
                            if CabCheck() then
                                NPCCall()
                            end
                        end
                    end
                end
                local low = Config.Calltime['low']
                local high = Config.Calltime['high']
                random = math.random(low, high)
                Wait(random * 60000)
            else
                Wait(3000)
            end
        end
    end
end)

RegisterNetEvent('k-taxi:toggleavailable', function()
    if available then
        available = false
        TriggerEvent('k-taxi:Notify', Config.Notifications['notavailable'], 'error', 5000)
    else 
        available = true
        TriggerEvent('k-taxi:Notify', Config.Notifications['available'], 'success', 5000)
    end
end)

CreateThread(function()
    TaxiBlip = AddBlipForCoord(Config.Locations['blip'].location)
    SetBlipSprite (TaxiBlip, Config.Locations['blip'].sprite)
    SetBlipDisplay(TaxiBlip, 4)
    SetBlipScale  (TaxiBlip, Config.Locations['blip'].scale)
    SetBlipAsShortRange(TaxiBlip, true)
    SetBlipColour(TaxiBlip, Config.Locations['blip'].color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations['blip'].label)
    EndTextCommandSetBlipName(TaxiBlip)
end)

RegisterNetEvent('k-taxi:garagemenu', function()
    local garageMenu = {
        {
            header = "| Cab-Co Garage |",
            isMenuHeader = true
        },
        {
            header = "Enter Garage",
            params = {
                event = 'k-taxi:garage'
            }
        },
        {
            header = "Park Car",
            params = {
                event = 'k-taxi:park'
            }
        },
    }    
    exports['qb-menu']:openMenu(garageMenu)
end)



RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == Config.Jobname then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent("k-taxi:setDuty", function()    
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job.name == Config.Jobname then
        TriggerServerEvent("QBCore:ToggleDuty")
    end
end)

RegisterNetEvent("k-taxi:Storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "taxidrawer")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "taxidrawer", {
        maxweight = Config.Locations['stash'].weight,
        slots = Config.Locations['stash'].size
    })
end)
local CarOut = {}

RegisterNetEvent("k-taxi:choose", function(data)
    local Player = QBCore.Functions.GetPlayerData()
    local citizenid = Player.citizenid
    local carout = false
    for i = 1,#CarOut,1 do
        if CarOut[i] == citizenid then
            TriggerEvent('k-taxi:Notify', Config.Notifications['carout'], 'error', 5000)
            carout = true
            break
        end
    end
    Wait(0)
    if not carout then
        for i = 1,#Config.Locations['garage'].spawn,1 do
            coords = Config.Locations['garage'].spawn[i]
            local x, y, z = table.unpack(coords)
            spot = GetClosestVehicle(x, y, z, 3.0, 0, 70)
            if spot ~= 0 then
            else
                QBCore.Functions.TriggerCallback('QBCore:Server:SpawnVehicle', function(netId)
                    local veh = NetToVeh(netId)
                    local plate = Config.Platetxt ..tostring(math.random(1,9))
                    SetVehicleNumberPlateText(veh, plate)
                    exports[Config.Fuel]:SetFuel(veh, 100.0)
                    TriggerEvent("vehiclekeys:client:SetOwner", plate)
                    table.insert(CarOut, citizenid)            
                end, data.vehicle, coords, true)
            break end
        end
    end
end)

RegisterNetEvent("k-taxi:park", function()
    local citizenid = QBCore.Functions.GetPlayerData().citizenid
    local nopark = 0
    for i = 1,#Config.Locations['garage'].spawn,1 do
        coords = Config.Locations['garage'].spawn[i]
        local x, y, z = table.unpack(coords)
        local spot = GetClosestVehicle(x, y, z, 3.0, 0, 70)
        if spot == 0 then
            nopark = nopark + 1
        else 
            local veh = GetVehiclePedIsIn(PlayerPedId(), true)
            local model = GetEntityModel(veh)
            local retval = false
            for i = 1, #Config.Locations['garage']['vehicles'][QBCore.Functions.GetPlayerData().job.grade.level], 1 do
               -- print(model,GetHashKey(Config.Locations['garage']['vehicles'][QBCore.Functions.GetPlayerData().job.grade.level][i]))
                if model == GetHashKey(Config.Locations['garage']['vehicles'][QBCore.Functions.GetPlayerData().job.grade.level][i]) then
                    retval = true
                end
            end         
            if spot == veh then
                if retval then
                    DeleteVehicle(veh)
                    for i = 1,#CarOut,1 do
                        if CarOut[i] == citizenid then
                            table.remove(CarOut, i)
                        end
                    end
                    TriggerEvent('k-taxi:Notify', Config.Notifications['park'], 'success', 5000)
                else
                    TriggerEvent('k-taxi:Notify', Config.Notifications['nopark'], 'error', 5000)
                end
            else
               TriggerEvent('k-taxi:Notify', Config.Notifications['nopark'], 'error', 5000)
            end
            retval = false
            break 
        end
    end
    if nopark == #Config.Locations['garage'].spawn then
        TriggerEvent('k-taxi:Notify', Config.Notifications['nopark'], 'error', 5000)
    end
end)

RegisterNetEvent('k-taxi:garage', function()
    GarageMenu()
end)

RegisterNetEvent('k-taxi:mission', function()
    StartLoc = table.unpack(Config.PedLoc[math.random(1, #Config.PedLoc)])
    riders = math.random(1,2)
    if delivering then
        TriggerEvent('k-taxi:Notify', Config.Notify['cooldown'], 'success', 5000)
    else
        TriggerEvent('k-taxi:npcmission', StartLoc, riders)
        local street, crossroad = GetStreetNameAtCoord(StartLoc)
        if riders == 1 then
            name = names[math.random(1,#names)]
            TriggerEvent('k-taxi:Notify', 'You have to pick up '.. name ..' at '.. street ..' and '.. crossroad .. '. [E] to accept.', 'success', 15000)
        else
            name = names[math.random(1,#names)]
            name2 = names[math.random(1,#names)]
            TriggerEvent('k-taxi:Notify', 'You have to pick up '.. name ..' and '.. name2 ..' at '.. street ..' and '.. crossroad .. '. [E] to accept.', 'success', 15000)
        end
    end
end)

RegisterNetEvent('k-taxi:civ_calls', function()
    if CabCheck() then
        QBCore.Functions.TriggerCallback('k-taxi:cb:getcivcalls', function(calls)
            local civcallmenu = {
                {
                    header = '| Civilian Calls |',
                    isMenuHeader = true
                }
            }
            for k,v in pairs(calls) do
                if v then
                    local x, y, z, w = table.unpack(v.location)
                    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
                    civcallmenu[#civcallmenu+1] = {
                        header = v.name,
                        txt = street,
                        params = {
                            event = 'k-taxi:selectciv',
                            args = {
                                cid = k,
                                coords = v.location,
                                name = v.name
                            }
                        }
                    }
                end
            end
            exports['qb-menu']:openMenu(civcallmenu)
        end)
    end
end)

RegisterNetEvent('k-taxi:selectciv', function(data)
    QBCore.Functions.TriggerCallback('k-taxi:pickupciv', function(cb)
        if not cb then
            local x,y,z = table.unpack(data.coords)
            local CivBlip = AddBlipForCoord(x, y, z)
            SetBlipColour(CivBlip, Config.NPCBlipColor)
            SetBlipRoute(CivBlip, true)
            SetBlipRouteColour(CivBlip, Config.NPCRouteColor)
            civride = true
            while CivBlip ~= nil do
                Wait(100)
                if #(GetEntityCoords(PlayerPedId()) - coords) < 25 then
                    RemoveBlip(CivBlip)
                    break
                end
            end
        end
    end, data.cid)
end)

RegisterNetEvent('k-taxi:npc_calls', function()
    if CabCheck() then
        local npccallmenu = {
            {
                header = '| Local Calls |',
                isMenuHeader = true
            }
        }
        local num = 0
        for k,v in pairs(npccalls) do
            num = num + 1
            local x, y, z, w = table.unpack(v.location)
            local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
            if v.riders == 1 then
                npccallmenu[#npccallmenu+1] = {
                    header = v.name..' at '..street,
                    params = {
                        event = 'k-taxi:selectnpc',
                        args = {
                            num = k,
                            StartLoc = v.location,
                            riders = v.riders,
                            gender = v.gender,
                            name = v.name
                        }
                    }
                }
            else
                npccallmenu[#npccallmenu+1] = {
                    header = v.name..' and '..v.name2..' at '..street,
                    params = {
                        event = 'k-taxi:selectnpc',
                        args = {
                            num = k,
                            StartLoc = v.location,
                            riders = v.riders,
                            gender = v.gender,
                            name = v.name,
                            name2 = v.name2
                        }
                    }
                }
            end
        end
        exports['qb-menu']:openMenu(npccallmenu)
    end
end)

RegisterNetEvent('k-taxi:selectnpc', function(data)
    gender = data.gender
    name = data.name
    name2 = data.name2
   -- print(table.unpack(npccalls))
    table.remove(npccalls, data.num)
    TriggerEvent('k-taxi:npcmission', data.StartLoc, data.riders)
end)

RegisterNetEvent('k-taxi:npcmission', function(StartLoc, riders)
    if CabCheck() then
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        local plate = QBCore.Functions.GetPlate(veh)
        if not delivering then
            if StartLoc == nil then
                StartLoc = table.unpack(Config.PedLoc[math.random(1, #Config.PedLoc)])
            end
            EndLoc = table.unpack(Config.PedLoc[math.random(1, #Config.PedLoc)])
            if riders == nil then
                riders = math.random(1,2)
            end
            if StartLoc == EndLoc then
                EndLoc = table.unpack(Config.PedLoc[math.random(1, #Config.PedLoc)])
                if StartLoc == EndLoc then
                    EndLoc = table.unpack(Config.PedLoc[math.random(1, #Config.PedLoc)])
                end
            end
            local NPCModel = Config.Peds['model'][gender][math.random(1, #Config.Peds['model'][gender])]
            local model = GetHashKey(NPCModel)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end            
            Npc = CreatePed(3, model, StartLoc.x, StartLoc.y, StartLoc.z - 0.98, StartLoc.w, false, true)
            PlaceObjectOnGroundProperly(Npc)
            FreezeEntityPosition(Npc, true)
            TaskSetBlockingOfNonTemporaryEvents(Npc,true)
            if riders == 2 then
                local NPCModel2 = Config.Peds['model'][gender][math.random(1, #Config.Peds['model'][gender])]
                Npc2 = CreatePed(3, model, StartLoc.x, StartLoc.y - 2.2, StartLoc.z - 0.98, StartLoc.w, false, true)
                PlaceObjectOnGroundProperly(Npc2)
                FreezeEntityPosition(Npc2, true)
            end
            if NpcBlip ~= nil then
                RemoveBlip(NpcBlip)
            end
            NpcBlip = AddBlipForCoord(StartLoc.x, StartLoc.y, StartLoc.z)
            SetBlipColour(NpcBlip, Config.NPCBlipColor)
            SetBlipRoute(NpcBlip, true)
            SetBlipRouteColour(NpcBlip, Config.NPCRouteColor)
            Wait(5000)
            pickupprice =  round(((GetGpsBlipRouteLength()/1615) * Config.PickupPrice), 0)
            if not Config.RideShare then
                if riders == 2 then
                    TriggerEvent('k-taxi:Notify', 'They have offered you $'..pickupprice..' each to pick them up.', 'success', 15000)
                    pickupprice = pickupprice * 2  
                else
                    TriggerEvent('k-taxi:Notify', 'They have offered you $'..pickupprice..' to pick them up.', 'success', 15000)                      
                end
            else
                TriggerEvent('k-taxi:Notify', 'They have offered you $'..pickupprice..' to pick them up.', 'success', 15000)
            end
            delivering = true
            Wait(0)
            while not pickedUp do
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local dist = #(pos - vector3(StartLoc.x, StartLoc.y, StartLoc.z))
                if dist < 20 then
                    if not playing then
                        playing = true
                        FreezeEntityPosition(Npc, false)
                        TaskPlayAnim(Npc, 'friends@frj@ig_1', 'wave_a', 500, 500, -1, 1, 0, false, false, false)
                    end
                    if dist < 15 and GetEntitySpeed(ped) < 8 then
                        local veh = GetVehiclePedIsIn(ped, 0)
                        local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(veh)
                        for i=maxSeats - 1, 0, -1 do
                            if IsVehicleSeatFree(veh, i) then
                                freeSeat = i
                                break
                            end
                        end
                        Wait(5000)
                        customlimit = customlimit
                        ClearPedTasksImmediately(Npc)
                        TaskEnterVehicle(Npc, veh, -1, freeSeat, 1.0, 0)
                        Wait(500)
                        PlayPedAmbientSpeechNative(Npc, "GENERIC_HI", "Speech_Params_Standard")
                        if riders == 2 then
                            Wait(2000)
                            if IsVehicleSeatFree(veh, freeSeat - 1) then
                                freeSeat = freeSeat - 1
                            else
                                freeSeat = freeSeat - 2
                            end
                            ClearPedTasksImmediately(Npc2)
                            FreezeEntityPosition(Npc2, false)
                            TaskEnterVehicle(Npc2, veh, -1, freeSeat, 1.0, 0)
                            Wait(500)
                            PlayPedAmbientSpeechNative(Npc2, "GENERIC_HI", "Speech_Params_Standard")
                        end
                        if NpcBlip ~= nil then
                            RemoveBlip(NpcBlip)
                        end 
                        ResetDisplay()
                        playing = false
                        NpcTaken = true
                        DropoffLocation(EndLoc, pickupprice, riders, plate)
                    end
                end
                Wait(0)
            end
        end
    end
end)
