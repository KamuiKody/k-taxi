local QBCore = exports['qb-core']:GetCoreObject()
local fare = 0
local distance = 0
local limiter = 0
local permile = 0
local urban = 0
local rural = 0
local hwy = 0
local drivingdistance = 0
local faredisplay = 0
local customlimit = 0
local display = false
local focus = false

function ResetDisplay()
    faredisplay = 0
    drivingdistance = 0
end


function GetDrivingDistance()
    while display do
        local ped = PlayerPedId()
        origincoords = GetEntityCoords(ped)
        Wait(2000)
        updatecoords = GetEntityCoords(ped)
        distanceupdate = #(updatecoords - origincoords)
        local miles = round((distanceupdate/1600), 2)
        drivingdistance  = drivingdistance + miles
        local faredisplay = drivingdistance * Config.DropOffPrice
        UpdateMeter('show', faredisplay, drivingdistance)
    end
end

function UpdateMeter(action, faredisplay, drivingdistance)
    if display then
    SendNUIMessage({
        action = action,
        fare = round(faredisplay, 0),
        distance = round(drivingdistance, 2),
        limiter = limiter,
        permile = Config.DropOffPrice,
        urban = urbanlimit,
        rural = rurallimit,
        hwy = hwylimit,
        custom = custom
    })
    end
end

function Meter(action, faredisplay, distance, limiter, permile, urbanlimit, rurallimit, hwylimit, customlimit)
    if action == 'hide' then 
        display = false
    end
    fare = faredisplay
    distance = distance
    limiter = 0
    permile = permile
    urban = urbanlimit
    rural = rurallimit
    hwy = hwylimit
    custom = customlimit
    SendNUIMessage({
        action = action,
        fare = faredisplay,
        distance = distance,
        limiter = 0,
        permile = Config.DropOffPrice/10,
        urban = urbanlimit,
        rural = rurallimit,
        hwy = hwylimit,
        custom = customlimit
    })
    GetDrivingDistance()
end

function HideMeter()
    display = false
    Wait(500)
    faredisplay = 0
    drivingdistance = 0
    Meter('hide', 0, 0.00, 0, Config.DropOffPrice, Config.UI['speedlimiter'].urban, Config.UI['speedlimiter'].rural, Config.UI['speedlimiter'].hwy, customlimit)
end
RegisterNetEvent('k-taxi:meterfix', function()
    display = true
    faredisplay = 0
    drivingdistance = 0
    Meter('show', 0, 0.00, 0, Config.DropOffPrice, Config.UI['speedlimiter'].urban, Config.UI['speedlimiter'].rural, Config.UI['speedlimiter'].hwy, customlimit)          
end)

RegisterKeyMapping('adjustmeter', 'Touch Taxi Meter', 'keyboard', Config.UI['settings'].focuskey)
RegisterCommand('adjustmeter', function()
    if display then
        if focus then
            SetNuiFocus(false,false)
            focus = false
        else
            focus = true
            SetNuiFocus(true, true)
        end
    end
end)

RegisterKeyMapping('+openmeter', 'Touch Taxi Meter', 'keyboard', Config.UI['settings'].open)
RegisterCommand('+openmeter', function()
    local PlayerData  = QBCore.Functions.GetPlayerData()
    if PlayerData.job.onduty then
        if PlayerData.job.name == Config.Jobname then
            if not display then
                if CabCheck() then
                    display = true
                    customlimit = customlimit
                    Wait(500)
                    Meter('show', 0, 0.00, 0, Config.DropOffPrice, Config.UI['speedlimiter'].urban, Config.UI['speedlimiter'].rural, Config.UI['speedlimiter'].hwy, customlimit)
                end
            else
                display = false
                Wait(500)
                faredisplay = 0
                drivingdistance = 0
                limiter = 0
                Meter('hide', 0, 0.00, 0, Config.DropOffPrice, Config.UI['speedlimiter'].urban, Config.UI['speedlimiter'].rural, Config.UI['speedlimiter'].hwy, customlimit)
                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),0.0) 
            end
        end
    end
end)

RegisterNetEvent('k-taxi:openmeter', function()
    if CabCheck() then
        display = true
        customlimit = customlimit
        Wait(500)
        Meter('show', 0, 0.00, 0, Config.DropOffPrice, Config.UI['speedlimiter'].urban, Config.UI['speedlimiter'].rural, Config.UI['speedlimiter'].hwy, customlimit)
    end
end)

RegisterNetEvent('k-taxi:closemeter', function()
    display = false
    Wait(500)
    faredisplay = 0
    drivingdistance = 0
    limiter = 0
    Meter('hide', 0, 0.00, 0, Config.DropOffPrice, Config.UI['speedlimiter'].urban, Config.UI['speedlimiter'].rural, Config.UI['speedlimiter'].hwy, customlimit)
    SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),0.0) 
end)

RegisterNUICallback('setlimiter', function(data)
    local limit = data.id
    SetNuiFocus(false,false)
    if limit == 0 then return end
    if not limit then 
        limiter = 0
        governer = false
        SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),0.0) 
    else
        governer = true
        limiter = limit
        SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),limit/2.237)
        while true do 
            Wait(2000)
            if not CabCheck() or not display then
                limiter = 0
                governer = false
                SetVehicleMaxSpeed(GetVehiclePedIsIn(PlayerPedId(),false),0.0)
                break
            end
        end
    end
end)