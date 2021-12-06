local menu = MenuV:CreateMenu(false, 'Car Menu', 'topleft', 155, 0, 0, 'size-125', 'none', 'menuv', 'test')
local SavedCar

RegisterNetEvent('qb-carmenu:client:openMenu')
AddEventHandler('qb-carmenu:client:openMenu', function()
    MenuV:OpenMenu(menu)
end)






--Toggle Engine
local engine_button = menu:AddButton({
    label = 'Toggle Engine',
    value = nil,
    description = 'Toggle Engine'
})
engine_button:On('select', function(item)
    TriggerEvent('vehiclekeys:client:ToggleEngine')
end)






--Limit speed
local limiter_button = menu:AddSlider({
    label = 'Limiter',
    value = '0',
    values = {{
        label = 'Disabled',
        value = '0',
        description = 'Disabled'
    }, {
        label = '60',
        value = '60',
        description = '60Km/h'
    }, {
        label = '90',
        value = '90',
        description = '90Km/h'
    }, {
        label = '140',
        value = '140',
        description = '140Km/h'
    }}
})
limiter_button:On('select', function(item, value)
    local plyPed = PlayerPedId()
    if IsPedSittingInAnyVehicle(plyPed) then
        local plyVeh = GetVehiclePedIsIn(plyPed, false)
        local maxSpeed = GetVehicleHandlingFloat(plyVeh,"CHandlingData","fInitialDriveMaxFlatVel")
        if value == '0' then
            SetEntityMaxSpeed(plyVeh, maxSpeed)
            QBCore.Functions.Notify("Speed limiter disabled")
        else
            SetEntityMaxSpeed(plyVeh, value / 3.6)
            QBCore.Functions.Notify("Speed limited to " .. value .. "Km/h")
        end
    end
end)







--Toggle Doors
local door_button = menu:AddSlider({
    label = 'Toggle door',
    value = 'Hood',
    values = {{
        label = 'Driver',
        value = 'Driver',
        description = 'Driver'
    }, {
        label = 'Passenger',
        value = 'Passenger',
        description = 'Passenger'
    }, {
        label = 'Hood',         --Capot
        value = 'Hood',
        description = 'Hood'
    }, {
        label = 'Trunk',        --Coffre
        value = 'Trunk',
        description = 'Trunk'
    }, {
        label = 'RearLeft',        
        value = 'RearLeft',
        description = 'RearLeft'
    }, {
        label = 'RearRight',        
        value = 'RearRight',
        description = 'RearRight'
    }}
})
door_button:On('select', function(item, value)
    local plyPed = PlayerPedId()
    local plyVeh = nil
    if IsPedSittingInAnyVehicle(plyPed) then
        plyVeh = GetVehiclePedIsIn(plyPed, false)
    else
        plyVeh = SavedCar
    end
    if plyVeh ~= nil then
        local Door = 0

        if value == 'Driver' then
            Door = 0
        elseif value == 'Passenger' then
            Door = 1
        elseif value == 'Hood' then
            Door = 4
        elseif value == 'Trunk' then
            Door = 5
        elseif value == 'RearLeft' then
            Door = 2
        elseif value == 'RearRight' then
            Door = 3
        end	

        if GetVehicleDoorAngleRatio(plyVeh, Door) ~= 0 then
            SetVehicleDoorShut(plyVeh, Door, false, false)
        else
            SetVehicleDoorOpen(plyVeh, Door, false, false)
        end
    end
end)




--Shuffle seats
local shuffle_button = menu:AddButton({
    label = 'Shuffle seats',
    value = nil,
    description = 'Shuffle seats'
})
shuffle_button:On('select', function(item)
    TriggerEvent('SeatShuffle')
end)





--Toggle Lock
local lock_button = menu:AddButton({
    label = 'Toggle lock',
    value = nil,
    description = 'Toggle lock'
})
lock_button:On('select', function(item)
    TriggerEvent('vehiclekeys:client:ToggleLock')
end)





--Toggle headlights
local headlight_button = menu:AddSlider({
    label = 'Headlights',
    value = '0',
    values = {{
        label = '0',
        value = '0',
        description = '0'
    }, {
        label = '1',
        value = '1',
        description = '1'
    }, {
        label = '2',         
        value = '2',
        description = '2'
    }}
})
headlight_button:On('select', function(item, value)
    local plyPed = PlayerPedId()
    local plyVeh = nil
    if IsPedSittingInAnyVehicle(plyPed) then
        plyVeh = GetVehiclePedIsIn(plyPed, false)
    else
        plyVeh = SavedCar
    end
    if plyVeh ~= nil then
        if value == '1' then
            SetVehicleLights(plyVeh, 1)
        elseif value == '2' then
            SetVehicleLights(plyVeh, 2)
        else
            SetVehicleLights(plyVeh, 0)
        end
    end
end)




--Save car
local save_button = menu:AddSlider({
    label = 'Save car',
    value = 'Save',
    values = {{
        label = 'Save',
        value = 'Save',
        description = 'Save car'
    }, {
        label = 'Reset',
        value = 'Reset',
        description = 'Reset car'
    }}
})
save_button:On('select', function(item, value)
    local plyPed = PlayerPedId()
    if value == 'Reset' then
        SavedCar = nil
        QBCore.Functions.Notify("Vehicle reset")
    else
        if IsPedSittingInAnyVehicle(plyPed) then
            local plyVeh = GetVehiclePedIsIn(plyPed, false)
            local plate = GetVehicleNumberPlateText(plyVeh)
            QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
                if result == false then
                    QBCore.Functions.Notify("You don't have the key", "error", 3500)
                else
                    SavedCar = plyVeh
                    QBCore.Functions.Notify("Vehicle saved")
                end
            end, plate)
        end
    end
end)





--Zip Code
local zip_button = menu:AddButton({
    label = 'Zip code',
    value = nil,
    description = 'Zip code'
})
zip_button:On('select', function(item)
    TriggerEvent('nearest-postal:client:GoPostal')
end)
