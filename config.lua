ConfigShared = {}
ConfigShared.Debug = true

ConfigShared.Notify = "ox" -- (oxnotif, esx)
ConfigShared.VehicleTimeout =  10 * 60 -- 10 minute = 10 * 60
ConfigShared.SpawnInVehicle = true
ConfigShared.Plate = {
    Active = true,
    PlateText = "SNOW"
}

ConfigShared.Locations = {
    ["location_sud"] = {
        coords = vec3(207.208878, -828.954468, 30.788357),
        ped_heading = 195.070862,
        spawn_coords = vec3(-111.771423, -1372.707642, 29.414673),
        spawn_heading = 280.629913,
        blips = {
            id = 225,
            color = 1,
            scale = 0.8,
            label = "Location Sud",
        },
        vehicles = {
            {
                model = "adder",
                Label = "Adder",
                description = "The Adder is a two-door hypercar featured in Grand Theft Auto V and Grand Theft Auto Online.",
                image = "https://media.discordapp.net/attachments/1232027084763955365/1239518263742828575/164px-Adder.png?ex=664336d7&is=6641e557&hm=237563e1325731970cfdcbca29d48132a670a8f65baa83df63b035d6289e8d63&=&format=webp&quality=lossless",
                price = 1000
            },
            {
                model = "sultan",
                Label = "Sultan",
                description = "The Sultan is a four-door sports sedan featured in Grand Theft Auto III, Grand Theft Auto: San Andreas, Grand Theft Auto IV, Grand Theft Auto V and Grand Theft Auto Online.",
                image = "https://media.discordapp.net/attachments/1232027084763955365/1239518263742828575/164px-Adder.png?ex=664336d7&is=6641e557&hm=237563e1325731970cfdcbca29d48132a670a8f65baa83df63b035d6289e8d63&=&format=webp&quality=lossless",
                price = 10
            }
        }
    },
    -- ["location_nord"] = {
    --     coords = vec3(-113.010986, -1362.923096, 28.380981),
    --     vehicles = {
    --         {
    --             model = "sultan",
    --             Label = "Sultan",
    --             description = "The Sultan is a four-door sports sedan featured in Grand Theft Auto III, Grand Theft Auto: San Andreas, Grand Theft Auto IV, Grand Theft Auto V and Grand Theft Auto Online.",
    --             image = "https://media.discordapp.net/attachments/1232027084763955365/1239518263742828575/164px-Adder.png?ex=664336d7&is=6641e557&hm=237563e1325731970cfdcbca29d48132a670a8f65baa83df63b035d6289e8d63&=&format=webp&quality=lossless",
    --             price = 10
    --         }
    --     }
    -- }
}