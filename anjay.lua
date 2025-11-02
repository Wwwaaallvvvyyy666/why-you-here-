-- Ini adalah script loader utama (Universal Loader) yang akan diletakkan di:
-- https://raw.githubusercontent.com/.../crot-crot-crot-basah-basah-mas.lua

print(" [Walvy Community Premium]    Loading Script ......")

-- 1. Definisikan tabel game yang didukung. 
local supportedGames = {
    -- PlaceId 121864768012064
    [121864768012064] = { 
        "https://awkwkwk-chi.vercel.app/payload",           -- [1] Versi Standard / Full (Default)
        "https://lite-version.vercel.app/fishit"            -- [2] Versi Lite
    }
}

-- 2. Dapatkan PlaceId dari game saat ini.
local currentPlaceId = game.PlaceId
local versions = supportedGames[currentPlaceId]
local payloadUrl = nil

-- 3. Definisikan fungsi untuk output logging.
local function logMessage(prefix, message)
    print("[" .. prefix .. "] " .. message)
end

-- 4. Logika Pemilihan Versi
if versions then
    -- Pengecekan menggunakan _G, yang universal dan tidak menyebabkan error.
    if _G and _G.Liteversion then
        -- KONDISI LITE: _G.Liteversion = true Dideklarasikan.
        payloadUrl = versions[2]
        logMessage("  Walvy Community  ", "Liteversion detected. Loading Lite payload: " .. payloadUrl)
    else
        -- KONDISI STANDARD/DEFAULT: _G.Liteversion tidak dideklarasikan.
        payloadUrl = versions[1]
        logMessage("  Walvy Community  ", "Standard version selected (Default). Loading full payload: " .. payloadUrl)
    end
end

-- 5. Lanjutkan proses loading jika payloadUrl ditemukan.
if payloadUrl then
    local success, gameInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(currentPlaceId)
    end)
    local gameName = success and gameInfo.Name or "Game"

    print("Game Successfully Detected: " .. gameName)
    print("Running Script......")
    
    logMessage("  Walvy Community  ", gameName .. "      ✅  Successfully loaded.")

    -- 6. Eksekusi payload yang dipilih.
    pcall(function()
        loadstring(game:HttpGet(payloadUrl))()
    end)
else
    -- 7. Jika PlaceId tidak didukung.
    warn("⚠️ This Game (ID: " .. currentPlaceId .. ") Not Supported.")
    logMessage("Walvy Community", "This Game Not Supported")
end
