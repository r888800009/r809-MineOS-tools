-- make by r888800009
-- MIT License

local MineOSPaths = require("MineOSPaths")
local fs = require("filesystem")
local getFiles = fs.list(MineOSPaths.trash)
local str
while true do
    str = getFiles()
    if str == nil then
        break
    end 
    fs.remove(MineOSPaths.trash..str)
end