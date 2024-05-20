local resourceName = 'snow_location'
local currentVersion = GetResourceMetadata(resourceName, 'version', 0)

-- Check if current version is outdated
local CheckVersion = function()
    if not currentVersion then
        print("^1["..resourceName.."] Unable to determine current resource version for '" ..resourceName.. "' ^0")
        return
    end
    SetTimeout(1000, function()
        PerformHttpRequest('https://api.github.com/repos/frsnow/' .. resourceName .. '/releases/latest', function(status, response)
            if status ~= 200 then return end
            response = json.decode(response)
            local latestVersion = response.tag_name
            if not latestVersion or latestVersion == currentVersion then return end
            if latestVersion ~= currentVersion then
                print('^1[WARNING]^7 You are not running the latest version, please update! (latest: ^5' .. latestVersion .. '^7, your version: ^3' .. currentVersion .. '^7)')
            else
                print('^1['..resourceName..'] ^2You are running the latest version of ' ..resourceName.. '^0')
            end
        end, 'GET')
    end)
end
CheckVersion()