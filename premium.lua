print("[Walvy Community Premium] Loading Script......")

local gameScripts = {
    [121864768012064] = "https://raw.githubusercontent.com/Wwwaaallvvvyyy666/Fishit/main/connection%20to.lua", -- Fish It
}

local currentGameId = game.PlaceId
local scriptUrl = gameScripts[currentGameId]

local function buatNotifikasi(title, message)
    print("[" .. title .. "] " .. message)
end

if scriptUrl then
    local success, gameInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(currentGameId)
    end)
    local gameName = success and gameInfo.Name or "Game"

    print("Game Successfully Detected: " .. gameName)
    print("Running Script......")

    buatNotifikasi("Walvy Community", gameName .. " ✅ Successfully loaded")

    pcall(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
else
    warn("⚠️ This Game (ID: " .. currentGameId .. ") Not Supported.")
    buatNotifikasi("Walvy Community", "This Game Not Supported")
end
