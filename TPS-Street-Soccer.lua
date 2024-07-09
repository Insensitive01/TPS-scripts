local Fluent = loadstring(gameHttpGet(httpsgithub.comdawid-scriptsFluentreleaseslatestdownloadmain.lua))()
local SaveManager = loadstring(gameHttpGet(httpsraw.githubusercontent.comdawid-scriptsFluentmasterAddonsSaveManager.lua))()
local InterfaceManager = loadstring(gameHttpGet(httpsraw.githubusercontent.comdawid-scriptsFluentmasterAddonsInterfaceManager.lua))()

local Window = FluentCreateWindow({
    Title = Fluent  .. Fluent.Version,
    SubTitle = by dawid,
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = Dark,
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons httpslucide.devicons for the tabs, icons are optional
local Tabs = {
    Main = WindowAddTab({ Title = Main, Icon =  }),
    Settings = WindowAddTab({ Title = Settings, Icon = settings })
}

local Options = Fluent.Options

do
    FluentNotify({
        Title = Notification,
        Content = This is a notification,
        SubContent = SubContent, -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })



    Tabs.MainAddParagraph({
        Title = Paragraph,
        Content = This is a paragraph.nSecond line!
    })



    Tabs.MainAddButton({
        Title = Button,
        Description = Very important button,
        Callback = function()
            WindowDialog({
                Title = Title,
                Content = This is a dialog,
                Buttons = {
                    {
                        Title = Confirm,
                        Callback = function()
                            print(Confirmed the dialog.)
                        end
                    },
                    {
                        Title = Cancel,
                        Callback = function()
                            print(Cancelled the dialog.)
                        end
                    }
                }
            })
        end
    })



    local Toggle = Tabs.MainAddToggle(MyToggle, {Title = Toggle, Default = false })

    ToggleOnChanged(function()
        print(Toggle changed, Options.MyToggle.Value)
    end)

    Options.MyToggleSetValue(false)


    
    local Slider = Tabs.MainAddSlider(Slider, {
        Title = Slider,
        Description = This is a slider,
        Default = 2,
        Min = 0,
        Max = 5,
        Rounding = 1,
        Callback = function(Value)
            print(Slider was changed, Value)
        end
    })

    SliderOnChanged(function(Value)
        print(Slider changed, Value)
    end)

    SliderSetValue(3)



    local Dropdown = Tabs.MainAddDropdown(Dropdown, {
        Title = Dropdown,
        Values = {one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen},
        Multi = false,
        Default = 1,
    })

    DropdownSetValue(four)

    DropdownOnChanged(function(Value)
        print(Dropdown changed, Value)
    end)


    
    local MultiDropdown = Tabs.MainAddDropdown(MultiDropdown, {
        Title = Dropdown,
        Description = You can select multiple values.,
        Values = {one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen},
        Multi = true,
        Default = {seven, twelve},
    })

    MultiDropdownSetValue({
        three = true,
        five = true,
        seven = false
    })

    MultiDropdownOnChanged(function(Value)
        local Values = {}
        for Value, State in next, Value do
            table.insert(Values, Value)
        end
        print(Mutlidropdown changed, table.concat(Values, , ))
    end)



    local Colorpicker = Tabs.MainAddColorpicker(Colorpicker, {
        Title = Colorpicker,
        Default = Color3.fromRGB(96, 205, 255)
    })

    ColorpickerOnChanged(function()
        print(Colorpicker changed, Colorpicker.Value)
    end)
    
    ColorpickerSetValueRGB(Color3.fromRGB(0, 255, 140))



    local TColorpicker = Tabs.MainAddColorpicker(TransparencyColorpicker, {
        Title = Colorpicker,
        Description = but you can change the transparency.,
        Transparency = 0,
        Default = Color3.fromRGB(96, 205, 255)
    })

    TColorpickerOnChanged(function()
        print(
            TColorpicker changed, TColorpicker.Value,
            Transparency, TColorpicker.Transparency
        )
    end)



    local Keybind = Tabs.MainAddKeybind(Keybind, {
        Title = KeyBind,
        Mode = Toggle, -- Always, Toggle, Hold
        Default = LeftControl, -- String as the name of the keybind (MB1, MB2 for mouse buttons)

        -- Occurs when the keybind is clicked, Value is `true``false`
        Callback = function(Value)
            print(Keybind clicked!, Value)
        end,

        -- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
        ChangedCallback = function(New)
            print(Keybind changed!, New)
        end
    })

    -- OnClick is only fired when you press the keybind and the mode is Toggle
    -- Otherwise, you will have to use KeybindGetState()
    KeybindOnClick(function()
        print(Keybind clicked, KeybindGetState())
    end)

    KeybindOnChanged(function()
        print(Keybind changed, Keybind.Value)
    end)

    task.spawn(function()
        while true do
            wait(1)

            -- example for checking if a keybind is being pressed
            local state = KeybindGetState()
            if state then
                print(Keybind is being held down)
            end

            if Fluent.Unloaded then break end
        end
    end)

    KeybindSetValue(MB2, Toggle) -- Sets keybind to MB2, mode to Hold


    local Input = Tabs.MainAddInput(Input, {
        Title = Input,
        Default = Default,
        Placeholder = Placeholder,
        Numeric = false, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            print(Input changed, Value)
        end
    })

    InputOnChanged(function()
        print(Input updated, Input.Value)
    end)
end


-- Addons
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManagerSetLibrary(Fluent)
InterfaceManagerSetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we)
SaveManagerIgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManagerSetIgnoreIndexes({})

-- use case for doing it this way
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManagerSetFolder(FluentScriptHub)
SaveManagerSetFolder(FluentScriptHubspecific-game)

InterfaceManagerBuildInterfaceSection(Tabs.Settings)
SaveManagerBuildConfigSection(Tabs.Settings)


WindowSelectTab(1)

FluentNotify({
    Title = Fluent,
    Content = The script has been loaded.,
    Duration = 8
})

-- You can use the SaveManagerLoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManagerLoadAutoloadConfig()