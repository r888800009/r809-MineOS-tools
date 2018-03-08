local GUI = require("GUI")
local buffer = require("doubleBuffering")
local MineOSInterface = require("MineOSInterface")

------------------------------------------------------------------------------------------------------

local mainContainer, window = MineOSInterface.addWindow(MineOSInterface.filledWindow(1, 1, 88, 26, 0xF0F0F0))

local layout = window:addChild(GUI.layout(1, 1, window.width, window.height, 1, 1))
local label = layout:addChild(GUI.label(1, 1, window.width, 1, 0x0, "")):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.top)
local button = layout:addChild(GUI.roundedButton(1, 1, 32, 3, 0xBBBBBB, 0xFFFFFF, 0x999999, 0xFFFFFF, ""))
local counter = 0
button.onTouch = function()

end
