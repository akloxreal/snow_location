ESX = exports["es_extended"]:getSharedObject()

AddEventHandler("esx:playerLoaded")
RegisterNetEvent("esx:playerLoaded", function (playerData)
    ESX.PlayerData = playerData
    SetLocationPoint()
end)

AddEventHandler("onResourceStart", function (name)
    if name == GetCurrentResourceName() then
        SetLocationPoint()
        DeleteTimeAndVehicle()
    end
end)