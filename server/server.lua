local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("carmenu", "Open Car Menu", {}, false, function(source, args)
    TriggerClientEvent('qb-carmenu:client:openMenu', source)
end)


QBCore.Functions.CreateCallback("qb-carmenu:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    exports['ghmattimysql']:execute('SELECT * FROM player_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(result)
        if result[1] ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)