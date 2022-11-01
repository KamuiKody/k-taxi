local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('k-taxi:Notify', function(txt,type,length)
    QBCore.Functions.Notify(txt,type,length)
end)
