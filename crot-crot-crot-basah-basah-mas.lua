print(" [Walvy Community Premium]    Loading Script ......")

local supportedGames = {
    [121864768012064] = { 
        "https://raw.githubusercontent.com/Wwwaaallvvvyyy666/ngetes/refs/heads/main/666",
        "https://lite-version.vercel.app/fishit"
    }
}

local currentPlaceId = game.PlaceId
local versions = supportedGames[currentPlaceId]
local payloadUrl = nil

local function logMessage(prefix, message)
    print("[" .. prefix .. "] " .. message)
end

if versions then
    if _G and _G.Liteversion then
        payloadUrl = versions[2]
    else
        payloadUrl = versions[1]
    end
end

if payloadUrl then
    local success, gameInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(currentPlaceId)
    end)
    local gameName = success and gameInfo.Name or "Game"

    print("Game Successfully Detected: " .. gameName)
    print("Running Script......")
    
    logMessage("  Walvy Community  ", gameName .. "      ✅  Successfully loaded.")

    pcall(function()
        loadstring(game:HttpGet(payloadUrl))()
    end)
else
    warn("⚠️ This Game (ID: " .. currentPlaceId .. ") Not Supported.")
    logMessage("Walvy Community", "This Game Not Supported")
end
