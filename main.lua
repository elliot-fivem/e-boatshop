Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)

        if NetworkIsSessionStarted() then
            ScriptInitialized()

            break
        end
    end
end)


ScriptInitialized = function()

    while not HasModelLoaded(0x76284640) do
        RequestModel(0x76284640)
        Citizen.Wait(1)
    end   
        renter = CreatePed(2, 0x76284640, -724.4918, -1335.172, 1.596292, 39.9396613342285, false, false)
        
    SetBlockingOfNonTemporaryEvents(renter, true)
    SetPedFleeAttributes(renter, 0, false)
    SetPedCombatAttributes(renter, 46, true)
    SetEntityAsMissionEntity(renter, true, true)
    
    local boatBlip = AddBlipForCoord(-724.4918, -1335.172, 1.596292)

    SetBlipSprite(boatBlip, 427)
    SetBlipScale(boatBlip, 1.0)
    SetBlipColour(boatBlip, 17)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("BoatShop")
    EndTextCommandSetBlipName(boatBlip)
end

Citizen.CreateThread(function()

    while true do
        if #(GetEntityCoords(PlayerPedId()) - vector3(-724.4918, -1335.172, 1.596292)) < 10 then
            if IsControlJustReleased(0, 38) then

                SendNUIMessage({
                    Action = "OPEN_NUI"
                })
                SetNuiFocus(true, true)
            end
        end


        Citizen.Wait(0)
    end

end)

boatExist = false

Citizen.CreateThread(function()

     RegisterNUICallback('callbackName', function(eventData, _)
        SetNuiFocus(false, false)

        SendNUIMessage({
            Action = "CLOSE_NUI"
        })

        if eventData.response then
            if boatExist then
                return print("Du har redan hyrt en båt")
            end

            while not HasModelLoaded(0x362CAC6D) do
                RequestModel(0x362CAC6D)
                Citizen.Wait(0)
            end

            boat = CreateVehicle(0x362CAC6D, -726.9, -1328.8, 0.4, 232.2, false, false)
            boatExist = true
            TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
        else
            print("du valde nej i UIn")
        end

    end)
end)