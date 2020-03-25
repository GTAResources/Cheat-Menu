-- Cheat Menu -  Cheat menu for Grand Theft Auto SanAndreas
-- Copyright (C) 2019-2020 Grinch_

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

local module = {}

module.tvisual =
{
    car_names           = imgui.new.bool(true),
    money =
    {
        negative_memory = allocateMemory(4),
        negative        = imgui.new.char[20](fconfig.Get('tvisual.negative',memory.tostring(readMemory(0x58F50A,4,false)))),
        positive_memory = allocateMemory(4),
        positive        = imgui.new.char[20](fconfig.Get('tvisual.positive',memory.tostring(readMemory(0x58F4C8,4,false)))),
    },
    zone_names          = imgui.new.bool(true),
}

-- Main function
function module.VisualMain()
    fcommon.Tabs("Visual",{"Checkboxes","Menus"},{
        function()
            imgui.Columns(2,nil,false)
            fcommon.CheckBoxValue('Armour border',0x589123)
            fcommon.CheckBoxValue('Armour percentage',0x589125)
            fcommon.CheckBoxValue('Breath border',0x589207)
            fcommon.CheckBoxValue('Breath percentage',0x589209)
            fcommon.CheckBoxFunc('Display car names',module.tvisual.car_names,
            function()    
                displayCarNames(module.tvisual.car_names[0]) 
                fconfig.Set(fconfig.tconfig.misc_data,"Display Car Names",module.tvisual.car_names[0])
                if module.tvisual.car_names[0] then 
                    fcommon.CheatActivated() 
                else 
                    fcommon.CheatDeactivated() 
                end
            end)
            fcommon.CheckBoxFunc('Display zone names',module.tvisual.zone_names,
            function()     
                displayZoneNames(module.tvisual.zone_names[0])
                fconfig.Set(fconfig.tconfig.misc_data,"Display Zone Names",module.tvisual.zone_names[0])
                if module.tvisual.zone_names[0] then 
                    fcommon.CheatActivated() 
                else 
                    fcommon.CheatDeactivated() 
                end
            end)

            imgui.NextColumn()

            fcommon.CheckBoxValue('Enable hud',0xBA6769)
            fcommon.CheckBoxValue('Enable radar',0xBA676C,nil,0,2)
            fcommon.CheckBoxValue('Gray radar',0xA444A4)
            fcommon.CheckBoxValue('Health border',0x589353)
            fcommon.CheckBoxValue('Health percentage',0x589355)
            fcommon.CheckBoxValue('Hide wanted level',0x58DD1B,nil,0x90)
            imgui.Columns(1)
        end,
        function()
            fcommon.RadioButtonFunc("Debt color",{"Red (Default)","Green","Purple","Light purple","White","Black","Yellow","Pink","Gray","Dark red"},{0,1,2,3,4,5,6,7,8,9},0x58F4D4)
            fcommon.RadioButtonFunc("Money color",{"Red","Green (Default)","Purple","Light purple","White","Black","Yellow","Pink","Gray","Dark red"},{0,1,2,3,4,5,6,7,8,9},0x58F492)
            fcommon.RadioButtonFunc("Money font outline",{"No outline","Thin outline","Default outline"},{0,1,2},0x58F58D)
            fcommon.RadioButtonFunc("Money font style",{"Style 1","Style 2","Default style"},{1,2,3},0x58F57F)
            fcommon.DropDownMenu("Money text format",function()
                if imgui.InputText("Positive",module.tvisual.money.positive,ffi.sizeof(module.tvisual.money.positive)) then 
                    ffi.copy(ffi.cast("char*", module.tvisual.money.positive_memory), ffi.string(module.tvisual.money.positive))
                    writeMemory(0x58F4C8,4,module.tvisual.money.positive_memory,false)

                end
                if imgui.InputText("Negative",module.tvisual.money.negative,ffi.sizeof(module.tvisual.money.negative)) then

                    ffi.copy(ffi.cast("char*", module.tvisual.money.negative_memory), ffi.string(module.tvisual.money.negative))
                    writeMemory(0x58F50A,4,module.tvisual.money.negative_memory,false)

                end      
                if imgui.Button("Reset to default",imgui.ImVec2(fcommon.GetSize(1))) then

                    ffi.copy(ffi.cast("char(*)", module.tvisual.money.negative_memory), "-$%07d")
                    imgui.StrCopy(module.tvisual.money.negative,"-$%07d",ffi.sizeof(module.tvisual.money.negative))
                    writeMemory(0x58F50A,4,module.tvisual.money.negative_memory,false)

                    ffi.copy(ffi.cast("char(*)", module.tvisual.money.positive_memory), "$%08d")
                    imgui.StrCopy(module.tvisual.money.positive,"$%08d",ffi.sizeof(module.tvisual.money.positive))
                    writeMemory(0x58F4C8,4,module.tvisual.money.positive_memory,false)
            
                end                    
            end)

            --fcommon.UpdateAddress({ name = 'Radio station text color',address = 0xBAB24C ,size = 4,min=-999,default = 40,max = 999})
            fcommon.UpdateAddress({ name = 'Radar Height',address = 0x866B74,size = 4,min=0,default = 76,max = 999,is_float = true})
            fcommon.UpdateAddress({ name = 'Radar Width',address = 0x866B78,size = 4,min=0,default = 94,max = 999,is_float = true})
            fcommon.UpdateAddress({ name = 'Radar X position',address = 0x858A10,size = 4,min=-999,default = 40,max = 999,is_float = true,help_text = "Changes radar vertical position"})
            fcommon.UpdateAddress({ name = 'Radar Y position',address = 0x866B70,size = 4,min=-999,default = 104,max = 999,is_float = true,help_text = "Changes radar horizantal position"})
            fcommon.UpdateAddress({ name = 'Radar zoom',address = 0xA444A3,size = 1,min=0,default = 0,max = 170})
            fcommon.RadioButtonFunc("Wanted star border",{"No border","Default","Bold border"},{0,1,2},0x58DD41)
            fcommon.RadioButtonFunc("Wanted star color",{"Red","Green","Purple","Light purple","White","Black","Yellow (Default)","Pink","Gray","Dark red"},{0,1,2,3,4,5,6,7,8,9},0x58DDC9)
            fcommon.UpdateAddress({ name = 'Wanted star Y position',address = 0x858CCC,size = 4,is_float = true,min=-500,default = 12,max = 500})
            callFunction(0x71D730,1,1,200.0)
        end
    })
end

return module