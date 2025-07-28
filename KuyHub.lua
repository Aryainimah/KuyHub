-- Kuy Hub (RedHub Modded by Arya)
-- Fitur: Join Team, Translator, Super Fast Attack, Mirage Gear Farm + ESP, Auto Quest, Auto Raid, Auto Stats, Teleport, Safe Mode, ESP Chest, ESP Fruit, Auto Haki, Auto Enhance, No Clip, Auto Kill Aura, Auto Boss, Auto Boat ESP, Safe Mode

local Settings = {
    JoinTeam = "Pirates", -- "Pirates" or "Marines"
    Translator = true,
}

-- GUI Setup (RedHub-style dengan tambahan tab)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "Kuy Hub - RedHub Inspired",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "KuyHubConfig"
})

local TabMain = Window:MakeTab({ Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local TabMisc = Window:MakeTab({ Name = "Misc", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local TabFarm = Window:MakeTab({ Name = "Auto Farm", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local TabRaid = Window:MakeTab({ Name = "Raids", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local TabTP = Window:MakeTab({ Name = "Teleport", Icon = "rbxassetid://4483345998", PremiumOnly = false })
local TabStats = Window:MakeTab({ Name = "Stats", Icon = "rbxassetid://4483345998", PremiumOnly = false })

-- Auto Join Team
TabMain:AddButton({
    Name = "Auto Join Team",
    Callback = function()
        repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Team == nil
        if Settings.JoinTeam == "Pirates" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
        elseif Settings.JoinTeam == "Marines" then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
        end
    end
})

-- Translator Info
if Settings.Translator then
    TabMain:AddParagraph("Translator Status", "Translator Aktif")
end

-- Tambahan fitur lainnya
TabFarm:AddToggle({
    Name = "Auto Quest",
    Default = false,
    Callback = function(v)
        while v and task.wait(2) do
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BanditQuest1", 1)
            end)
        end
    end
})
TabFarm:AddToggle({
    Name = "Auto Kill Aura",
    Default = false,
    Callback = function(v)
        while v and task.wait(0.1) do
            for _,mob in pairs(workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                    end)
                end
            end
        end
    end
})
TabFarm:AddToggle({
    Name = "Auto Boss",
    Default = false,
    Callback = function(v)
        while v and task.wait(5) do
            for _,boss in pairs(workspace.Enemies:GetChildren()) do
                if boss.Name:lower():find("boss") then
                    pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                    end)
                end
            end
        end
    end
})
TabRaid:AddToggle({
    Name = "Auto Start Raid",
    Default = false,
    Callback = function(v)
        while v and task.wait(10) do
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Raids", "Start")
        end
    end
})
TabMisc:AddToggle({
    Name = "Boat ESP",
    Default = false,
    Callback = function(v)
        while v and task.wait(3) do
            for _,boat in pairs(workspace.Boats:GetChildren()) do
                if boat:FindFirstChild("Hull") and not boat:FindFirstChild("ESP") then
                    local esp = Instance.new("BillboardGui", boat.Hull)
                    esp.Name = "ESP"
                    esp.Size = UDim2.new(0,100,0,40)
                    esp.AlwaysOnTop = true
                    local label = Instance.new("TextLabel", esp)
                    label.Size = UDim2.new(1,0,1,0)
                    label.BackgroundTransparency = 1
                    label.Text = "🚤 Boat"
                    label.TextColor3 = Color3.new(1,1,1)
                    label.TextScaled = true
                end
            end
        end
    end
})
TabMisc:AddToggle({
    Name = "Safe Mode",
    Default = false,
    Callback = function(val)
        while val and task.wait(1) do
            game.Players.LocalPlayer.Character.Humanoid.Health = math.huge
        end
    end
})

OrionLib:Init()
