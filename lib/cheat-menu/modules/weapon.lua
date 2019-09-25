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

local tweapon =
{
    images = {},
    path = tcheatmenu.dir .. "weapons\\",
    quick_spawn = imgui.new.bool(fconfig.get('tweapon.quick_spawn',false)),
    noreload = imgui.new.bool(false),
    fast_reload = imgui.new.bool(false),
    search_text = imgui.new.char[20](fconfig.get('tweapon.search_text',"")),
    models = {},
    ped = imgui.new.bool(fconfig.get('tweapon.ped',false)),
}

for i = 1,46,1 do
    table.insert(tweapon.models,i)
end

module.tweapon = tweapon

function module.GetName(id)
    local flibweapons = nil
    if getMoonloaderVersion() < 27 then
        flibweapons = require 'lib.game.weapons'
    else
        flibweapons = require 'libstd.game.weapons'
    end

    local name = flibweapons.get_name(id)
    if name == nil then 
        return ""
    else
        return name
    end
end

function module.CBaseWeaponInfo(name)

    local weapon = callFunction(0x743D10,1,1,name)
    if name ~= "" and getWeapontypeModel(weapon) ~= 0 then
        return weapon
    else
        return 0
    end
end

function module.GiveWeaponToPlayer(weapon)
    if module.GetName(weapon) ~= "" then
        model = getWeapontypeModel(weapon)
        if isModelAvailable(model) then
            requestModel(model)
            loadAllModelsNow()

            if fped.tped.selected ~=  nil then
                if fanimation.tanimation.ped[0] == true then
                    giveWeaponToChar(fped.tped.selected,weapon,99999)
                else
                    giveWeaponToChar(PLAYER_PED,weapon,99999)
                end
                fcommon.CheatActivated()
            else
                printHelpString("~r~No~w~ ped selected")
            end
            
            markModelAsNoLongerNeeded(model)
        end
    end
end

function module.WeaponMain()
    imgui.Spacing()
    if imgui.Button("Remove current weapon",imgui.ImVec2(fcommon.GetSize(2))) then
        if fped.tped.selected ~=  nil then
            if fanimation.tanimation.ped[0] == true then
                removeWeaponFromChar(fped.tped.selected,getCurrentCharWeapon(fped.tped.selected))
            else
                removeWeaponFromChar(PLAYER_PED,getCurrentCharWeapon(PLAYER_PED))
            end
            fcommon.CheatActivated()
        else
            printHelpString("~r~No~w~ ped selected")
        end
    end
    imgui.SameLine()
    if imgui.Button("Remove all weapons",imgui.ImVec2(fcommon.GetSize(2))) then
        if fped.tped.selected ~=  nil then
            if fanimation.tanimation.ped[0] == true then
                removeAllCharWeapons(fped.tped.selected)
            else
                removeAllCharWeapons(PLAYER_PED)
            end
            fcommon.CheatActivated()
        else
            printHelpString("~r~No~w~ ped selected")
        end
    end
    imgui.Spacing()
    if imgui.BeginTabBar("Weapon") then
        if imgui.BeginTabItem("Checkbox") then
            imgui.Spacing()
            imgui.Columns(2,nil,false)
            fcommon.CheckBox({ name = "Fast reload",var = tweapon.fast_reload,func = function()
                if tweapon.fast_reload[0] then
                    setPlayerFastReload(PLAUER_HANDLE,true)
                    fcommon.CheatActivated()
                else
                    setPlayerFastReload(PLAUER_HANDLE,false)
                    fcommon.CheatDeactivated()
                end
            end})
            imgui.NextColumn()
            fcommon.CheckBox({ name = "No reload + Inf ammo",var = tweapon.noreload,func = function()
                if tweapon.noreload[0] then
                    writeMemory( 7600773,1,144,1)
                    writeMemory( 7600815,1,144,1)
                    writeMemory( 7600816,2,37008,1)
                    writeMemory( 7612591,1,144,1)
                    writeMemory( 7612646,1,144,1)
                    writeMemory( 7612647,2,37008,1)
                    fcommon.CheatActivated()
                else
                    writeMemory( 7600773,1,72,1)
                    writeMemory( 7600815,1,255,1)
                    writeMemory( 7600816,2,3150,1)
                    writeMemory( 7612591,1,72,1)
                    writeMemory( 7612646,1,255,1)
                    writeMemory( 7612647,2,3150,1)
                    fcommon.CheatDeactivated()
                end
            end})
            imgui.Columns(1)
            imgui.EndTabItem()
        end
        if imgui.BeginTabItem("Spawn") then
            imgui.Spacing()
            imgui.Columns(2,nil,false)
            fcommon.CheckBox({ name = "Quick Weapon",var = tweapon.quick_spawn,help_text = "Weapon can be spawned from quick spawner using (Left Ctrl + Q). \n\nControls:\nEnter : Stop reading key press\nDelete : Erase full string\nBackspace : Erase last character"})
            imgui.NextColumn()
            fcommon.CheckBox({name = "Ped",var = tweapon.ped,help_text = "Give weapon to ped.Aim with a gun to select."})
            imgui.Columns(1)
            imgui.Spacing()
            if imgui.BeginTabBar("Spawn") then
                if imgui.BeginTabItem("List") then

                    imgui.Spacing()
                    if imgui.BeginChild("Weapon list Window") then
                        fcommon.ShowEntries("Assault rifles",{30,31},65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true)
                        fcommon.ShowEntries("Handguns",{22,23,24},65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true)
                        fcommon.ShowEntries("Heavy weapons",{35,36,37,38},65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true)
                        fcommon.ShowEntries("Melee",{1,2,3,4,6,7,8,9},65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true)
                        fcommon.ShowEntries("Miscellaneous",{10,11,12,14,15,41,42,43,44,45,46},65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true)
                        fcommon.ShowEntries("Projectiles",{16,17,18,39},65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true)
                        fcommon.ShowEntries("Shotguns",{25,26,27},65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true)
                        fcommon.ShowEntries("Sub machine guns",{28,29,32},65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true)
                        fcommon.ShowEntries("Rifles",{33,34},65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true)
                        imgui.EndChild()
                    end
                    imgui.EndTabItem()
                end
                if imgui.BeginTabItem("Search") then
                    imgui.Spacing()
                    if imgui.InputText("Search",tweapon.search_text,ffi.sizeof(tweapon.search_text)) then end
                    imgui.SameLine()
        
                    imgui.Spacing()
                    imgui.Text("Found entries :(" .. ffi.string(tweapon.search_text) .. ")")
                    imgui.Separator()
                    imgui.Spacing()
                    if imgui.BeginChild("Weapon Entries") then
                        fcommon.ShowEntries(nil,tweapon.models,65,65,tweapon.images,tweapon.path,".png",module.GiveWeaponToPlayer,module.GetName,true,tweapon.search_text)
                        imgui.EndChild()
                    end
                    imgui.EndTabItem()
                end
                imgui.EndTabBar()
            end
            imgui.EndTabItem()
        end
        imgui.EndTabBar()
    end
end
return module