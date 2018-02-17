local fs = require("filesystem")
local GUI = require("GUI")
local MineOSInterface = require("MineOSInterface")
------------------------------------------------------------------------------------------------------------


local buttonColor = 0xD2D2D2
local aboutInfo = {
    name = "r809 Downloader", 
    github = "r888800009",
    license = "apache license 2.0",
    date = "2018",
    info = { 
        "If you find a bug or want to suggest.",
        "Please you open an issue at github r888800009/r809-MineOS-tools in English."
    }
}

------------------------------------------------------------------------------------------------------------
-- mainWindow
    local mainWindow = {
        mainContainer, 
        window,
        l,functions,
        configFile, downloadFolder
    }
    -------------------------------------
    function mainWindow:new()
        local o = {
            mainContainer = nil, window = nil,
            l = {layout1 = nil,layoutAbout = nil,layoutConfig = nil},
            functions = {},
            configFile = nil, downloadFolder = nil
        }
        setmetatable(o,{__index = self})
        return o
    end
    function mainWindow:layoutConfigInit()
        local l = self.l
        local mainContainer, window =self.mainContainer, self.window
        
    end
    function mainWindow:layoutAboutInit()
        local l = self.l
        local mainContainer, window =self.mainContainer, self.window
        l["layoutAbout"]:setCellPosition(1, 1,  l["layoutAbout"]:addChild(GUI.label(1, 1,20,2, 0x000000,aboutInfo.name))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
        l["layoutAbout"]:setCellPosition(1, 1,  l["layoutAbout"]:addChild(GUI.label(1, 1,20,2, 0x2D2D2D,"by "..aboutInfo.github.." in "..aboutInfo.date))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
        l["layoutAbout"]:setCellPosition(1, 1,  l["layoutAbout"]:addChild(GUI.label(1, 1,20,2, 0x2D2D2D,"License: "..aboutInfo.license))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
        l["layoutAbout"]:setCellPosition(1, 1,  l["layoutAbout"]:addChild(GUI.label(1, 1,20,2, 0x5A5A5A,aboutInfo.info[1]))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
        l["layoutAbout"]:setCellPosition(1, 1,  l["layoutAbout"]:addChild(GUI.label(1, 1,20,2, 0x5A5A5A,aboutInfo.info[2]))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
    end

    function mainWindow:layoutDownloaderInit()
        local l = self.l
        local functions =self.functions
        local mainContainer, window =self.mainContainer, self.window
        l["layout1"]:setCellAlignment(1, 1, GUI.alignment.horizontal.center, GUI.alignment.vertical.top)
        l["layout1"]:setCellAlignment(2, 1, GUI.alignment.horizontal.center, GUI.alignment.vertical.top)
        l["layout1"]:setCellPosition(1, 1, l["layout1"]:addChild(GUI.label(1, 1,20,4, 0x2D2D2D,"Step 1"))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
        l["layout1"]:setCellPosition(1, 1, l["layout1"]:addChild(GUI.roundedButton(1, 1, 20, 3, buttonColor, 0x000000, 0xAAAAAA, 0x000000, "New Config"))).onTouch = functions.newConfig
        l["layout1"]:setCellPosition(1, 1, l["layout1"]:addChild(GUI.roundedButton(1, 1, 20, 3,buttonColor, 0x000000, 0xAAAAAA, 0x000000, "Edit Config"))).onTouch = functions.editConfig
        
        ---------------------------------------
        l["layout1"]:setCellPosition(2, 1, l["layout1"]:addChild(GUI.label(2, 1,20,4, 0x2D2D2D,"Step 2"))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
        self.configFile = l["layout1"]:setCellPosition(2, 1, l["layout1"]:addChild(GUI.filesystemChooser(2, 2, 30, 3, 0xE1E1E1, 0x888888, 0x3C3C3C, 0x888888, "", "Open", "Cancel", "Config File","/" )))
        self.downloadFolder = l["layout1"]:setCellPosition(2, 1, l["layout1"]:addChild(GUI.filesystemChooser(2, 2, 30, 3, 0xE1E1E1, 0x888888, 0x3C3C3C, 0x888888, "", "Open", "Cancel", "Download Folder", "/")))
        l["layout1"]:setCellPosition(2, 1, l["layout1"]:addChild(GUI.roundedButton(2, 1, 20, 3, buttonColor, 0x000000, 0xAAAAAA, 0x000000, "Download"))).onTouch = functions.download

        self.configFile:addExtensionFilter(".json")
        self.downloadFolder.filesystemMode = GUI.filesystemModes.directory 
        self.configFile.onSubmit = function(path)
            GUI.error("File \"" .. path .. "\" was selected")
        end
    end

    function mainWindow:selectLayout(setSelectLayout)
        for k, v in pairs(self.l) do
            v.disabled = true
            v.hidden = true
        end
        setSelectLayout.hidden = false
        setSelectLayout.disabled = false
    end

    function mainWindow:close()
        GUI.error("close")
    end
   
    function mainWindow:init()
        self.functions ={
            newConfig = function()
                GUI.error("new config")
            end,
            editConfig = function()
                GUI.error("edit config")
            end,
            download = function()
                GUI.error("download "..self.downloadFolder.path)
                
            end,
            about = function() 
                self:selectLayout(self.l["layoutAbout"]) 
            end,
            downloader =  function() 
                self:selectLayout(self.l["layout1"])
            end 
        }
        local functions = self.functions
        self.mainContainer, self.window = MineOSInterface.addWindow(MineOSInterface.tabbedWindow(1, 1, 88, 25))
        local mainContainer, window =self.mainContainer, self.window
        local l = self.l
        window.tabBar:addItem("Downloader").onTouch = functions.downloader
        -- window.tabBar:addItem("OPPM").onTouch = function()  end 
        window.tabBar:addItem("About").onTouch = functions.about
        local closeTemp = window.actionButtons.close.onTouch
        window.actionButtons.close.onTouch = function()
            self:close()
            closeTemp()
        end
        -------------layout--------------------
        l["layout1"] = window:addChild(GUI.layout(1  , 4, window.width, window.height-3, 2, 1))
        l["layoutAbout"] = window:addChild(GUI.layout(1, 4, window.width, window.height-3, 1, 1))
        ---------------------------------------
        self:layoutAboutInit()
        self:layoutDownloaderInit()
        self:selectLayout(l["layout1"])
    end
    
    function mainWindow:main()
        self:init()
    end
------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------
local mainWindow1 = mainWindow:new()
mainWindow1:main()

--if 
--    GUI.error("You must install OPPM first.")