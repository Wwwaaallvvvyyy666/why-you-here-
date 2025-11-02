print(" [Walvy Community Premium]    Loading Script ......")

local supportedGames = {
    -- PlaceId 121864768012064 (Ganti dengan PlaceId game Anda jika berbeda)
    [121864768012064] = { 
        "https://awkwkwk-chi.vercel.app/payload",
        "https://lite-version.vercel.app/fishit"
    }
}

-- 2. Dapatkan pengenal unik (PlaceId) dari game saat ini.
local currentPlaceId = game.PlaceId

-- 3. Cek apakah PlaceId ini ada di tabel 'supportedGames'.
local versions = supportedGames[currentPlaceId]
local payloadUrl = nil -- Variabel untuk menyimpan URL payload yang akan dimuat

-- 4. Definisikan fungsi untuk output logging.
local function logMessage(prefix, message)
    print("[" .. prefix .. "] " .. message)
end

-- 5. Cek apakah PlaceId didukung DAN pilih URL yang benar.
if versions then
    -- Pengecekan versi menggunakan getenv(), sesuai permintaan:
    -- Liteversion dimuat jika getenv().Liteversion telah diatur ke true.
    if getenv() and getenv().Liteversion then
        -- KONDISI LITE: Variabel global Liteversion ditemukan.
        payloadUrl = versions[2]
        logMessage("  Walvy Community  ", "Liteversion detected. Loading Lite payload...")
    else
        -- KONDISI STANDARD/DEFAULT: Variabel global Liteversion tidak ditemukan.
        payloadUrl = versions[1]
        logMessage("  Walvy Community  ", "Standard version selected (Default). Loading full payload...")
    end
end

-- 6. Lanjutkan proses loading jika payloadUrl sudah ditentukan.
if payloadUrl then
    -- Ambil nama game untuk logging.
    local success, gameInfo = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(currentPlaceId)
    end)
    local gameName = success and gameInfo.Name or "Game"

    -- Log deteksi game dan pesan running script.
    print("Game Successfully Detected: " .. gameName)
    print("Running Script......")
    
    -- Log pesan sukses.
    logMessage("  Walvy Community  ", gameName .. "      ✅  Successfully loaded from: " .. payloadUrl)

    -- 7. Coba download script dari URL yang dipilih dan eksekusi.
    pcall(function()
        loadstring(game:HttpGet(payloadUrl))()
    end)
else
    -- 8. Jika PlaceId tidak didukung (tidak ada di tabel supportedGames).
    warn("⚠️ This Game (ID: " .. currentPlaceId .. ") Not Supported.")
    logMessage("Walvy Community", "This Game Not Supported")
end
