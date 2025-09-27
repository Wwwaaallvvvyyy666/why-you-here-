print("[Walvy Community] Loading Script......")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local Lighting = game:GetService("Lighting")

local gameScripts = {
    [121864768012064] = "https://pandadevelopment.net/virtual/file/416dabb62a0b6878"
}

local currentGameId = game.PlaceId
local scriptUrl = gameScripts[currentGameId]

local function buatNotifikasi(title, message)
    print("[" .. title .. "] " .. message)
end

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Name = "WalvyLoadingBlur"
blur.Parent = Lighting
TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 24}):Play()

local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "WalvyLoadingGui"
LoadingGui.ResetOnSpawn = false
LoadingGui.Parent = CoreGui

local Background = Instance.new("Frame")
Background.Size = UDim2.new(0, 400, 0, 120)
Background.Position = UDim2.new(0.5, -200, 0, 50)
Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Background.BackgroundTransparency = 0.7
Background.BorderSizePixel = 0
Background.Parent = LoadingGui

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "[Walvy Community] Loading Script..."
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 20
TitleLabel.Parent = Background

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 50)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Starting..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 16
StatusLabel.Parent = Background

local ProgressBarBackground = Instance.new("Frame")
ProgressBarBackground.Size = UDim2.new(0.9, 0, 0, 20)
ProgressBarBackground.Position = UDim2.new(0.05, 0, 0, 80)
ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressBarBackground.BackgroundTransparency = 0.8
ProgressBarBackground.BorderSizePixel = 0
ProgressBarBackground.Parent = Background

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ProgressBar.BackgroundTransparency = 0.2
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ProgressBarBackground

local function updateProgress(percent, statusText)
    StatusLabel.Text = statusText or StatusLabel.Text
    ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    TweenService:Create(ProgressBar, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(percent, 0, 1, 0)}):Play()
end

updateProgress(0, "Initializing...")
task.wait(0.5)

if scriptUrl then
    updateProgress(0.2, "Detecting Game...")
    local success, gameInfo = pcall(function()
        return MarketplaceService:GetProductInfo(currentGameId)
    end)
    local gameName = success and gameInfo.Name or "Unknown Game"
    task.wait(0.5)

    updateProgress(0.5, "Preparing Script...")
    task.wait(0.5)

    print("Game Successfully Detected: " .. gameName)
    print("Running Script......")
    updateProgress(0.7, "Loading Script from Server...")
    task.wait(0.5)

    local loadSuccess, err = pcall(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
    if loadSuccess then
        updateProgress(1, "Script Loaded Successfully!")
        buatNotifikasi("Walvy Community", gameName .. " Successfully loaded")
    else
        updateProgress(1, "Failed to Load Script!")
        warn("[Walvy Community] Error: " .. tostring(err))
        buatNotifikasi("Walvy Community", "Failed to load script: " .. tostring(err))
    end
else
    warn("⚠️ This Game (ID: " .. currentGameId .. ") Not Supported.")
    updateProgress(1, "Game Not Supported!")
    buatNotifikasi("Walvy Community", "This Game Not Supported")
end

task.wait(1)
LoadingGui:Destroy()
TweenService:Create(blur, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 0}):Play()
task.wait(0.5)
blur:Destroy()
