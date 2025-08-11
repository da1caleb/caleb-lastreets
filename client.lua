-- client.lua — LA Street Names with Discord Rich Presence

-- Load streets table from streets.lua
-- 'streets' is loaded before this by fxmanifest

local function GetRandomStreet()
if not streets or #streets == 0 then
return "Unknown Street"
end
local idx = math.random(1, #streets)
return streets[idx]
end

-- Register /street command
RegisterCommand('street', function()
local name = GetRandomStreet()
print(('Random street: %s'):format(name))
TriggerEvent('chat:addMessage', {
color = { 255, 200, 0 },
multiline = true,
args = { 'StreetFinder', name }
})
-- Also update Discord RP immediately when command is used
UpdateRichPresence(name)
end, false)

-- Export for other resources
exports('GetRandomStreet', function()
return GetRandomStreet()
end)

-- Discord Rich Presence Setup
local function UpdateRichPresence(streetName)
if not streetName then
streetName = GetRandomStreet()
end
SetDiscordAppId(123456789012345678) -- Replace with your Discord App ID
SetRichPresence("Currently at: " .. streetName)
SetDiscordRichPresenceAsset('large_icon') -- Replace with your asset key
SetDiscordRichPresenceAssetText("Los Angeles RP")
end

-- Update Rich Presence every 60 seconds
Citizen.CreateThread(function()
while true do
UpdateRichPresence()
Citizen.Wait(60000)
end
end)