-- client.lua
-- Small client script that exposes a /street command which prints a random street name.

-- streets.lua is loaded before this file by fxmanifest.

local function GetRandomStreet()
    if not streets or #streets == 0 then
        return "Unknown Street"
    end
    local idx = math.random(1, #streets)
    return streets[idx]
end

-- Register command to show a random street in chat
RegisterCommand('street', function()
    local name = GetRandomStreet()
    -- Print to client console
    print(('Random street: %s'):format(name))
    -- Add to in-game chat (works if chat resource supports 'chat:addMessage')
    TriggerEvent('chat:addMessage', {
        color = { 255, 200, 0 },
        multiline = true,
        args = { 'StreetFinder', name }
    })
end, false)

-- Example: use an exported function for other scripts to call
exports('GetRandomStreet', function()
    return GetRandomStreet()
end)