function SetLocationPoint()
    for key, value in pairs(ConfigShared.Locations) do
        Locations = ConfigShared.Locations[key]
        
        local ped_model = lib.requestModel("a_m_m_business_01", 5000)

        local ped = CreatePed(4, ped_model, Locations.coords.x, Locations.coords.y, Locations.coords.z, 0.0, false, false)
        SetEntityAsMissionEntity(ped, true, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)

        local blip = AddBlipForCoord(Locations.coords.x, Locations.coords.y, Locations.coords.z)
        SetBlipSprite(blip, Locations.blips.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Locations.blips.scale)
        SetBlipColour(blip, Locations.blips.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Locations.blips.label)
        EndTextCommandSetBlipName(blip)

        location_points = lib.points.new({
            coords = Locations.coords,
            distance = 5.0,
        })

        function location_points:onEnter()
            TargetAdd(ped, key)
        end

        function location_points:onExit()
            TargetRemove(ped, key)
        end
    end
end

haveVehicle = false

function OpenLocationMenu(locationId)

    local Options = {}

    Options[#Options+1] = {
        title = Strings.Menu.mainMenu.title,
        icon = "fas fa-car",
        description = Strings.Menu.mainMenu.description,
    }

    Options[#Options+1] = {
        title = Strings.Menu.returnVehicle.title,
        icon = "fas fa-car",
        description = Strings.Menu.returnVehicle.description,
        disabled = not haveVehicle,
        onSelect = function ()
            haveVehicle = false
            DeleteTimeAndVehicle()
        end
    }

    for key, value in pairs(ConfigShared.Locations[locationId].vehicles) do
        local vehicle = ConfigShared.Locations[locationId].vehicles[key]
        Options[#Options+1] = {
            title = vehicle.Label,
            description = vehicle.description,
            image = vehicle.image,
            disabled = haveVehicle,
            metadata = {
                {
                    label = "Price",
                    value = vehicle.price
                }
            },
            serverEvent = "snow_location:eventMoney",
            args = { model = vehicle.model, price = vehicle.price, spawn_coords = ConfigShared.Locations[locationId].spawn_coords, spawn_heading = ConfigShared.Locations[locationId].spawn_heading}
        }
    end

    lib.registerContext({
        id = "location_"..locationId,
        title = "Location - " .. locationId:gsub("^%l", string.upper),
        options = Options
    })

    lib.showContext("location_"..locationId)
end