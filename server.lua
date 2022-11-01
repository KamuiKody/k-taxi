local QBCore = exports['qb-core']:GetCoreObject()
local slot = 0
local callavailable = false
local civcalls = {}


function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end

if Config.Command ~= false then
    QBCore.Commands.Add(Config.Command, Config.ComandDescription, { {name = 'Offer', help = 'Pickup offer before fare amount'} }, false, function(source, args)
       local PlayerData = QBCore.Functions.GetPlayer(source).PlayerData
       local firstname = PlayerData.charinfo.firstname
       local lastname = PlayerData.charinfo.lastname
       civcalls[PlayerData.citizenid] = {
            name = firstname.." "..lastname,
            location = GetEntityCoords(GetPlayerPed(source))
       }
       callavailable = true
       --print(args[1])
       TriggerClientEvent('k-taxi:CallForCab', -1, args[1], firstname, lastname, GetEntityCoords(GetPlayerPed(source)))
    end, 'user')

    QBCore.Functions.CreateCallback('k-taxi:ispickedup', function(source, cb)
        cb(callavailable)
        Wait(0)
        callavailable = false            
    end)

    QBCore.Functions.CreateCallback('k-taxi:cb:getcivcalls', function(source, cb)
        cb(civcalls)
    end)

    QBCore.Functions.CreateCallback('k-taxi:pickupciv', function(source, cb, citizenid)
        if civcalls[citizenid] ~= nil then
            civcalls[citizenid] = nil
            cb(true)
        else
            cb(false)
        end
    end)
end

RegisterNetEvent('k-taxi:paymebicf', function(pickupprice, dropoffprice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local total = pickupprice + dropoffprice
    local payment = round((total * 0.75), 0)
    if Config.Tip['active'] then
        local randomAmount = math.random(1, 5)
        local r1, r2 = math.random(1, 5), math.random(1, 5)
        if randomAmount == r1 or randomAmount == r2 then 
            payment = payment + math.random(Config.Tip['low'], Config.Tip['high']) 
        end
    end
    Player.Functions.AddMoney('cash', payment)
    local boss = round((payment/3), 0)
    TriggerEvent("qb-bossmenu:server:addAccountMoney", Config.Jobname, boss)
    if Config.ItemChance['active'] then
        local chance = math.random(1, 100)
        if chance < Config.ItemChance['percentage'] then
            items = Config.ItemChance['items']
            item = items[math.random(1,#items)]
            Player.Functions.AddItem(item, 1, false)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
        end        
    end
end)