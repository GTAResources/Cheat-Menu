-- Cheat Menu -  Cheat menu for Grand Theft Auto SanAndreas
-- Copyright (C) 2019 Grinch_

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

local tvisuals =
{
    zone_names = imgui.new.bool(true),
    car_names  = imgui.new.bool(true),
}

module.tvisuals = tvisuals

function module.VisualMain()
    if imgui.BeginTabBar("Visual") then
        imgui.Spacing()
        if imgui.BeginTabItem('Checkbox') then
            imgui.Spacing()

            imgui.Columns(2,nil,false)
            fcommon.CheckBox({ address = 0x589123,name = 'Body armour border'})
            fcommon.CheckBox({ address = 0x589125,name = 'Body armour percentage'})
            fcommon.CheckBox({ address = 0x589207,name = 'Breath meter border'})
            fcommon.CheckBox({ address = 0x589209,name = 'Breath meter percentage'})
            if imgui.Checkbox('Display zone names',tvisuals.zone_names) then
                displayZoneNames(tvisuals.zone_names[0])
                if tvisuals.zone_names[0] then fcommon.CheatActivated() else fcommon.CheatDeactivated() end
            end

            if imgui.Checkbox('Display car names',tvisuals.car_names) then
                displayCarNames(tvisuals.car_names[0])
                if tvisuals.car_names[0] then fcommon.CheatActivated() else fcommon.CheatDeactivated() end
            end
            fcommon.CheckBox({ address = 0xA444A0,name = 'Enable hud'})

            imgui.NextColumn()
           
            fcommon.CheckBox({ address = 0xBA676C,name = 'Enable radar',value = 0,value2 = 2})
            fcommon.CheckBox({ address = 0xA444A4,name = 'Gray radar'})
            fcommon.CheckBox({ address = 0x589355,name = 'Health bar percentage'})
            fcommon.CheckBox({ address = 0x58DD1B,name = 'Hide wanted level',value = 0x90})
            fcommon.CheckBox({ address = 0x58F58D,name = 'Money font border'})
            imgui.Columns(1)
            imgui.EndTabItem()
        end

        if imgui.BeginTabItem('Menu') then
            if imgui.BeginChild("") then
                imgui.Spacing()
                fcommon.UpdateAddress({ name = 'Active wanted star posY',address = 0x858CCC,size = 4,is_float = true,min=-500,default = 12,max = 500})
                fcommon.UpdateAddress({ name = 'Debt color',address = 0x58F4D4 ,size = 1,max = 9})
                fcommon.UpdateAddress({ name = 'Money color',address = 0x58F492 ,size = 1,max = 9})
                fcommon.UpdateAddress({ name = 'Radar X position',address = 0x858A10,size = 4,min=-999,default = 40,max = 999,is_float = true,help_text = "Changes radar vertical position"})
                fcommon.UpdateAddress({ name = 'Radar Y position',address = 0x866B70,size = 4,min=-999,default = 104,max = 999,is_float = true,help_text = "Changes radar horizantal position"})
                fcommon.UpdateAddress({ name = 'Wanted star border',address = 0x58DD41,size = 1,min = 0,default = 1,max = 3})
                fcommon.UpdateAddress({ name = 'Wanted star color',address = 0x58DDC9,size = 1,max = 9})
                imgui.EndChild()
            end
            imgui.EndTabItem()
        end
        imgui.EndTabBar()
    end
end

return module