local fs = require("filesystem")
local GUI = require("GUI")
local MineOSInterface = require("MineOSInterface")
local MineOSPaths = require("MineOSPaths")
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
        ------------------------------
        o.mainContainer, o.window = MineOSInterface.addWindow(MineOSInterface.tabbedWindow(1, 1, 88, 25))
        ------------------------------
        setmetatable(o,{__index = self})
        return o
    end
    
    ---------------------------------------------------------------------------------------------------
    function mainWindow:setBackLayout(getBackLayout)
        self.backLayout = getBackLayout or self.l["layout1"]
    end
    function mainWindow:layoutConfigInit()
        local l = self.l
        local mainContainer, window =self.mainContainer, self.window
        --------------------title-----------
        l["layoutConfig"]:setCellPosition(1, 1, l["layoutConfig"]:addChild(GUI.label(2, 1,20,4, 0x2D2D2D,"Config File"))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
        ----------------------new Mode---------------------------------------
        self.configFileNew = l["layoutConfig"]:setCellPosition(1, 1, l["layoutConfig"]:addChild(GUI.filesystemChooser(2, 2, 30, 3, 0xE1E1E1, 0x888888, 0x3C3C3C, 0x888888, MineOSPaths.desktop, "Open", "Cancel", "Config File Folder","/" ))) 
        self.configFileNew.filesystemMode = GUI.filesystemModes.directory 
        self.configFileNameNew =l["layoutConfig"]:setCellPosition(1, 1, l["layoutConfig"]:addChild(GUI.input(2, 2, 30, 3, 0xE1E1E1, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "example.json", "example.json"))) 
        ----------------------edit Mode----------------------------------------
        self.configFileEdit = l["layoutConfig"]:setCellPosition(1, 1, l["layoutConfig"]:addChild(GUI.filesystemChooser(2, 2, 30, 3, 0xE1E1E1, 0x888888, 0x3C3C3C, 0x888888, "/example.json", "Open", "Cancel", "Config File","/" ))) 
        ----------------------all----------------------------------------------
        

        local addFile = l["layoutConfig"]:setCellPosition(1, 1, l["layoutConfig"]:addChild(GUI.layout(1  , 1, 40, 3, 1, 1)))
        addFile:setCellDirection(1,1,GUI.directions.horizontal)
        self.configFileRemove = addFile:setCellPosition(1, 1, addFile:addChild(GUI.roundedButton(1, 1, 10, 3, buttonColor, 0x000000, 0xAAAAAA, 0x000000, "Remove")))
        self.configFileAddFile = addFile:setCellPosition(1, 1, addFile:addChild(GUI.roundedButton(1, 1, 14, 3, buttonColor, 0x000000, 0xAAAAAA, 0x000000, "Add File")))
        self.configFileAddFolder = addFile:setCellPosition(1, 1, addFile:addChild(GUI.roundedButton(1, 1, 14, 3, buttonColor, 0x000000, 0xAAAAAA, 0x000000, "Add Folder")))



        local SaveAndCancel =l["layoutConfig"]:setCellPosition(1, 1, l["layoutConfig"]:addChild(GUI.layout(1  , 1, 40, 3, 1, 1)))
        SaveAndCancel:setCellDirection(1,1,GUI.directions.horizontal)
        self.configFileCancel = SaveAndCancel:setCellPosition(1, 1, SaveAndCancel:addChild(GUI.roundedButton(1, 1, 18, 3, 0xCC0000, 0x000000, 0xAA0000, 0x000000, "Cancel")))
        self.configFileSave = SaveAndCancel:setCellPosition(1, 1, SaveAndCancel:addChild(GUI.roundedButton(1, 1, 18, 3, buttonColor, 0x000000, 0xAAAAAA, 0x000000, "Save Config")))


        local tree = l["layoutConfig"]:setCellPosition(2, 1, l["layoutConfig"]:addChild(GUI.tree(1, 1, 40, 20, 0xE1E1E1, 0x3C3C3C, 0x3C3C3C, 0xAAAAAA, 0x3C3C3C, 0xFFFFFF, 0xBBBBBB, 0xAAAAAA, 0xC3C3C3, 0x444444, GUI.filesystemModes.both, GUI.filesystemModes.both)))
     
        tree:addItem("./ (download Folder)", "./", 1, true)
        tree:addItem("test2", "test1", 2, true)
        tree:addItem("test3", "test2", 3,false)
        tree:addItem("test2", "test3", 2, true)
        tree:addItem("test3", "test4", 3,false)
        -- tree.selectedItem =
        self:setBackLayout(self.l["layout1"])
        ---------------------------events-------------------------------------
        local configFunctions={
            cancel = function() 
                self:selectLayout(self.backLayout) 
                
            end,
            save = function()
                GUI.error("save"..self.configFileNameNew.text.." "..self.configFileNew.path)
                
                GUI.error(tree.items)
            end,
            remove = function()
                local removeItem = tree.selectedItem
                if removeItem then 
                    GUI.error("remove"..removeItem)
                end

            end,
            addFile = function()
                GUI.error("file")
            end, 

            addFolder = function()
                GUI.error("folder")
            end
        }
        -----------------------------------------------------------------------
        self.configFileCancel.onTouch = configFunctions.cancel
        self.configFileSave.onTouch = configFunctions.save
        self.configFileRemove.onTouch = configFunctions.remove
        self.configFileAddFile.onTouch = configFunctions.addFile
        self.configFileAddFolder.onTouch = configFunctions.addFolder
        
    end

    function mainWindow:layoutAboutInit()
        local l = self.l
        local mainContainer, window =self.mainContainer, self.window
        -------------------------------------------------------------   
        
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
        -------------------------------------------------------------

        l["layout1"]:setCellAlignment(1, 1, GUI.alignment.horizontal.center, GUI.alignment.vertical.top)
        l["layout1"]:setCellAlignment(2, 1, GUI.alignment.horizontal.center, GUI.alignment.vertical.top)
        l["layout1"]:setCellPosition(1, 1, l["layout1"]:addChild(GUI.label(1, 1,20,4, 0x2D2D2D,"Step 1"))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
        l["layout1"]:setCellPosition(1, 1, l["layout1"]:addChild(GUI.roundedButton(1, 1, 20, 3, buttonColor, 0x000000, 0xAAAAAA, 0x000000, "New Config"))).onTouch = functions.newConfig
        l["layout1"]:setCellPosition(1, 1, l["layout1"]:addChild(GUI.roundedButton(1, 1, 20, 3,buttonColor, 0x000000, 0xAAAAAA, 0x000000, "Edit Config"))).onTouch = functions.editConfig
        
        ---------------------------------------
        l["layout1"]:setCellPosition(2, 1, l["layout1"]:addChild(GUI.label(2, 1,20,4, 0x2D2D2D,"Step 2"))):setAlignment(GUI.alignment.horizontal.center, GUI.alignment.vertical.center)
        self.configFile = l["layout1"]:setCellPosition(2, 1, l["layout1"]:addChild(GUI.filesystemChooser(2, 2, 30, 3, 0xE1E1E1, 0x888888, 0x3C3C3C, 0x888888, "config.json", "Open", "Cancel", "Config .json File","/" )))
        self.downloadFolder = l["layout1"]:setCellPosition(2, 1, l["layout1"]:addChild(GUI.filesystemChooser(2, 2, 30, 3, 0xE1E1E1, 0x888888, 0x3C3C3C, 0x888888, "/downloads", "Open", "Cancel", "Download Folder", "/")))
        l["layout1"]:setCellPosition(2, 1, l["layout1"]:addChild(GUI.roundedButton(2, 1, 20, 3, buttonColor, 0x000000, 0xAAAAAA, 0x000000, "Download"))).onTouch = functions.download
        ---------------------------------------

        self.configFile:addExtensionFilter(".json")
        self.downloadFolder.filesystemMode = GUI.filesystemModes.directory 
        self.configFile.onSubmit = function(path)
            GUI.error("File \"" .. path .. "\" was selected")
        end
    end
    ---------------------------------------------------------------------------------------------------
    
    function mainWindow:configWindow(editMode)
        
        if editMode then
            
            -----------hide--------
            self.configFileNew.disabled = true
            self.configFileNew.hidden = true
            self.configFileNameNew.disabled = true
            self.configFileNameNew.hidden = true
            ---------------------show
            self.configFileEdit.disabled = false
            self.configFileEdit.hidden  = false
        else
            
            -----------hide--------
            self.configFileEdit.disabled = true
            self.configFileEdit.hidden  = true
            ---------------------show
            self.configFileNew.disabled = false
            self.configFileNew.hidden = false
            self.configFileNameNew.disabled = false
            self.configFileNameNew.hidden = false 
        end
        
        self:selectLayout(self.l["layoutConfig"]) 
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
       -- GUI.error("close")
    end
   
    function mainWindow:init()
        -------------------------------------------
        self.functions ={
            newConfig = function()
                self:configWindow(false)
            end,
            editConfig = function()
                self:configWindow(true)
            end,
            download = function()
                GUI.error("download "..self.downloadFolder.path.." json:"..self.configFile.path)
                
            end,
            about = function() 
                self:selectLayout(self.l["layoutAbout"]) 
            end,
            downloader =  function() 
                self:selectLayout(self.l["layout1"])
            end 
        }
        -------------------------------------------
        local functions = self.functions
        local mainContainer, window =self.mainContainer, self.window
        local l = self.l
        -------------------------------------------
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
        l["layoutConfig"] = window:addChild(GUI.layout(1, 4, window.width, window.height-3, 2, 1)) 
        ---------------------------------------
        self:layoutAboutInit()
        self:layoutDownloaderInit()
        self:layoutConfigInit()
        --------------------------------------
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