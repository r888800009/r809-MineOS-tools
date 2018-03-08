-- make by r888800009
-- apache 2.0
local buffer = require("doubleBuffering")
local GUI = require("GUI")
local MineOSInterface = require("MineOSInterface")
local process = require("process")

local mainContainer, window = MineOSInterface.addWindow(MineOSInterface.filledWindow(1, 1, 88, 25, 0x262626))
local panel 
local env
------------------------------
function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else
        copy = orig
    end
    return copy
end

-------------------------
function new()
end

function virtualScreen()
 local T1 = shallowcopy(process.info().env)

    local functions={
        require = function (str)
            local o = require(str)       
            GUI.error(str)
            return o       
        end,
        print = function(str)
            GUI.error(str)
        end
    }
    T1.print = functions.print
    T1.require = functions.require
    --GUI.error(T1.require)
    return T1
end

function init()
    panel = GUI.panel(1, 1+3, window.width, window.height, 0x000000)
    window:addChild(panel)
    env = virtualScreen()
    local sh1 =process.load("sh",env)
    coroutine.resume(sh1)
end
function display()
    window:draw()
    buffer.draw(true)
end

function main() 
    init()
    display()
end


main()