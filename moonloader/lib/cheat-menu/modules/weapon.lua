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

module.tweapon =
{
    auto_aim            = imgui.new.bool(fconfig.Get('tweapon.auto_aim',false)),
    ammo_count          = imgui.new.int(fconfig.Get('tweapon.ammo_count',99999)),
    fast_reload         = imgui.new.bool(fconfig.Get('tweapon.fast_reload',false)),
    filter              = imgui.ImGuiTextFilter(),
    max_accuracy        = imgui.new.bool(fconfig.Get('tweapon.max_accuracy',false)),
    max_ammo_clip       = imgui.new.bool(fconfig.Get('tweapon.max_ammo_clip',false)),
    max_move_speed      = imgui.new.bool(fconfig.Get('tweapon.max_move_speed',false)),
    huge_damage         = imgui.new.bool(fconfig.Get('tweapon.huge_damage',false)),
    images              = {},
    long_target_range   = imgui.new.bool(fconfig.Get('tweapon.long_target_range',false)),
    long_weapon_range   = imgui.new.bool(fconfig.Get('tweapon.long_weapon_range',false)),
    names               = fcommon.LoadJson("weapon"),
    no_reload           = imgui.new.bool(fconfig.Get('tweapon.no_reload',false)),
    path                = tcheatmenu.dir .. "weapons",
    ped                 = imgui.new.bool(fconfig.Get('tweapon.ped',false)),
    gang                =
    {
        weapon_array = {},
        used_weapons = fconfig.Get('tweapon.gang_weapons',fconst.DEFAULT_GANG_WEAPONS),
        
        weapons_names =
        {
            "Unarmed",
            "Brass knuckles",
            "Golf club",
            "Night stick",
            "Knife",
            "Baseball bat",
            "Shovel",
            "Poolcue",
            "Katana",
            "Chainsaw",
            "Purple dildo",
            "White dildo",
            "White vibrator",
            "Silver vibrator",
            "Flowers",
            "Cane",
            "Grenade",
            "Teargas",
            "Molotov",
            "No weapon",
            "No weapon",
            "No weapon",
            "Colt45",
            "Silenced",
            "Desert eagle",
            "Shotgun",
            "Sawn off shotgun",
            "Combat shotgun",
            "Uzi",
            "Mp5",
            "Ak47",
            "M4",
            "Tec9",
            "Rifle",
            "Sniper rifle",
            "Rocket launcher",
            "Heat seeker",
            "Flame thrower",
            "Minigun",
            "Satchel charge",
            "Detonator",
            "Spraycan",
            "Fire extinguisher",
            "Camera",
            "Night vision",
            "Thermal vision", 
            "Parachute",          
        },
        weapon1 = imgui.new.int(0),
        weapon2 = imgui.new.int(0),
        weapon3 = imgui.new.int(0),
    },
    weapon_drops = {},
}


module.tweapon.gang.weapon_array = imgui.new['const char*'][#module.tweapon.gang.weapons_names](module.tweapon.gang.weapons_names)
module.tweapon.gang.weapon1[0] = module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][1]
module.tweapon.gang.weapon2[0] = module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][2]
module.tweapon.gang.weapon3[0] = module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][3]

-- Returns weapon name
function module.GetModelName(id)

    if module.tweapon.names[id] ~= nil then
        return module.tweapon.names[id]
    else
        return ""
    end
    
end

-- Used in quick spawner (fcommon)
function module.CBaseWeaponInfo(name)
    local weapon = callFunction(0x743D10,1,1,name)
    if name ~= "" and getWeapontypeModel(weapon) ~= 0 then
        return weapon
    else
        return 0
    end
end

-- Gives weapon to player or ped
function module.GiveWeapon(weapon)
    weapon = tonumber(weapon)
    model = getWeapontypeModel(weapon)
    if isModelAvailable(model) then
        requestModel(model)
        loadAllModelsNow()

        if module.tweapon.ped[0] == true then
            if doesCharExist(fped.tped.selected) then
                giveWeaponToChar(fped.tped.selected,weapon,module.tweapon.ammo_count[0])
                fcommon.CheatActivated()
            else
                printHelpString("~r~No~w~ ped selected")
            end
        else
            giveWeaponToChar(PLAYER_PED,weapon,module.tweapon.ammo_count[0])
            fcommon.CheatActivated()
        end          
        markModelAsNoLongerNeeded(model)
    end
end

function module.RemoveAllWeaponDrops()
    for _, pickup in ipairs(module.tweapon.weapon_drops) do
        if doesPickupExist(pickup) then
            removePickup(pickup)
        end
    end
end

function module.AutoAim()
    while true do
        if module.tweapon.auto_aim[0] then
            while module.tweapon.auto_aim[0] do
                if isCharOnFoot(PLAYER_PED) then
                    local x, y =  getPcMouseMovement()
                    x = math.floor(x/2)
                    y = math.floor(y/2)

                    if (y ~= 0 or x ~= 0) then
                        writeMemory(11988014,1,1,false)
                    else
                        if isKeyDown(2) then
                            writeMemory(11988014,1,0,false)
                        end
                    end
                end
                wait(0)
            end
            writeMemory(11988014,1,1,false)
        end
        wait(0)
    end
end

-- Main function
function module.WeaponMain()
    
    imgui.Spacing()
    if imgui.Button("Remove current weapon",imgui.ImVec2(fcommon.GetSize(2))) then
        
        if module.tweapon.ped[0] == true then
            if fped.tped.selected ~=  nil then
                removeWeaponFromChar(fped.tped.selected,getCurrentCharWeapon(fped.tped.selected))
                printHelpString("Current weapon removed")
            else
                printHelpString("~r~No~w~ ped selected")
            end
        else
            removeWeaponFromChar(PLAYER_PED,getCurrentCharWeapon(PLAYER_PED))
            printHelpString("Current weapon removed")
        end
    end

    imgui.SameLine()
    if imgui.Button("Remove all weapons",imgui.ImVec2(fcommon.GetSize(2))) then         
        if module.tweapon.ped[0] == true then
            if fped.tped.selected ~=  nil then
                removeAllCharWeapons(fped.tped.selected)
                printHelpString("All weapons removed")
            else
                printHelpString("~r~No~w~ ped selected")
            end
        else
            removeAllCharWeapons(PLAYER_PED)
            printHelpString("All weapons removed")
        end
    end
    if imgui.Button("Drop weapon",imgui.ImVec2(fcommon.GetSize(1))) then   
        local ped = PLAYER_PED

        if module.tweapon.ped[0] == true then
            if fped.tped.selected ==  nil then
                ped = nil
                printHelpString("~r~No~w~ ped selected")
            end
        end     

        if ped ~= nil then
            local x,y,z = getOffsetFromCharInWorldCoords(ped,0.0,3.0,0.0)
            local weapon_type = getCurrentCharWeapon(ped)
            if weapon_type == 0 then
                printHelpString("No weapon to drop")
            else
                local weapon_model = getWeapontypeModel(weapon_type)
                local weapon_ammo = getAmmoInCharWeapon(ped,weapon_type)

                local pickup = createPickupWithAmmo(weapon_model,3,weapon_ammo,x,y,z)
                table.insert(module.tweapon.weapon_drops,pickup)
                removeWeaponFromChar(PLAYER_PED,weapon_type)
                printHelpString("Weapon dropped")
            end
        end
    end
    fcommon.Tabs("Weapons",{"Checkboxes","Spawn","Gang weapon editor"},{
        function()
            imgui.Columns(2,nil,false)
            fcommon.CheckBoxVar("Auto aim",module.tweapon.auto_aim,"Enables joypad auto aim feature\n\nControls:\n Q = left\n E = right")
            fcommon.CheckBoxVar("Fast reload",module.tweapon.fast_reload,nil,
            function()
                setPlayerFastReload(PLAYER_HANDLE,module.tweapon.fast_reload[0])
            end)
            fcommon.CheckBoxVar("Huge damage",module.tweapon.huge_damage,"Increase all weapon damage",
            function()
                if not module.tweapon.huge_damage[0] then
                    callFunction(0x5BE670,0,0)
                end
            end)
            fcommon.CheckBoxVar("Long target range",module.tweapon.long_target_range,nil,
            function()
                if not module.tweapon.long_target_range[0] then
                    callFunction(0x5BE670,0,0)
                end
            end)
            fcommon.CheckBoxVar("Long weapon range",module.tweapon.long_weapon_range,nil,
            function()
                if not module.tweapon.long_weapon_range[0] then
                    callFunction(0x5BE670,0,0)
                end
            end)
        
            imgui.NextColumn()
            
            fcommon.CheckBoxVar("Max accuracy",module.tweapon.max_accuracy,nil,
            function()
                if not module.tweapon.max_accuracy[0] then
                    callFunction(0x5BE670,0,0)
                end
            end)
            fcommon.CheckBoxVar("Max ammo clip",module.tweapon.max_ammo_clip,nil,
            function()
                if not module.tweapon.max_ammo_clip[0] then
                    callFunction(0x5BE670,0,0)
                end
            end)
            fcommon.CheckBoxVar("Max move speed",module.tweapon.max_move_speed,nil,
            function()
                if not module.tweapon.max_move_speed[0] then
                    callFunction(0x5BE670,0,0)
                end
            end)
            fcommon.CheckBoxVar("No reload + Inf ammo",module.tweapon.no_reload,nil,
            function()
                if module.tweapon.no_reload[0] then
                    writeMemory( 0x73FA85,1,0x90,1)
                    writeMemory( 0x73FAAF,1,0x90,1)
                    writeMemory( 0x73FAB0,2,0x9090,1)
                    writeMemory( 0x7428AF,1,0x90,1)
                    writeMemory( 0x7428E6,1,0x90,1)
                    writeMemory( 0x7428E7,2,0x9090,1)
                else
                    writeMemory( 0x73FA85,1,72,1)
                    writeMemory( 0x73FAAF,1,255,1)
                    writeMemory( 0x73FAB0,2,3150,1)
                    writeMemory( 0x7428AF,1,72,1)
                    writeMemory( 0x7428E6,1,255,1)
                    writeMemory( 0x7428E7,2,3150,1)
                end
            end)
            imgui.Columns(1)
        end,
        function()
            imgui.Columns(2,nil,false)
            fcommon.CheckBoxVar("Ped",module.tweapon.ped,"Give weapon to ped. Aim with a gun to select")
            imgui.NextColumn()
            imgui.Columns(1)
            imgui.Spacing()
            if imgui.InputInt('Ammo', module.tweapon.ammo_count) then
              module.tweapon.ammo_count[0]  =  (module.tweapon.ammo_count[0] < 0) and 0 or  module.tweapon.ammo_count[0]
              module.tweapon.ammo_count[0]  =  (module.tweapon.ammo_count[0] > 99999) and 99999 or  module.tweapon.ammo_count[0]
            end
            imgui.Spacing()
            fcommon.Tabs("Spawn",{"List","Search"},{
                function()
                    fcommon.DrawImages(fconst.IDENTIFIER.WEAPON,fconst.DRAW_TYPE.LIST,module.tweapon.images,fconst.WEAPON.IMAGE_HEIGHT,fconst.WEAPON.IMAGE_WIDTH,module.GiveWeapon,nil,module.GetModelName,module.tweapon.filter)
                end,
                function()
                    fcommon.DrawImages(fconst.IDENTIFIER.WEAPON,fconst.DRAW_TYPE.SEARCH,module.tweapon.images,fconst.WEAPON.IMAGE_HEIGHT,fconst.WEAPON.IMAGE_WIDTH,module.GiveWeapon,nil,module.GetModelName,module.tweapon.filter)
                end
            })
        end,
        function()
            if imgui.Combo("Gang", fped.tped.gang.index,fped.tped.gang.array,#fped.tped.gang.list) then
                module.tweapon.gang.weapon1[0] = module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][1]
                module.tweapon.gang.weapon2[0] = module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][2]
                module.tweapon.gang.weapon3[0] = module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][3]
            end
            imgui.Dummy(imgui.ImVec2(0,10))

            imgui.Combo("Weapon 1", module.tweapon.gang.weapon1,module.tweapon.gang.weapon_array,#module.tweapon.gang.weapons_names)
            imgui.Combo("Weapon 2", module.tweapon.gang.weapon2,module.tweapon.gang.weapon_array,#module.tweapon.gang.weapons_names)
            imgui.Combo("Weapon 3", module.tweapon.gang.weapon3,module.tweapon.gang.weapon_array,#module.tweapon.gang.weapons_names)


            imgui.Dummy(imgui.ImVec2(0,10))
            if imgui.Button("Apply changes",imgui.ImVec2(fcommon.GetSize(2))) then
                setGangWeapons(fped.tped.gang.index[0],module.tweapon.gang.weapon1[0],module.tweapon.gang.weapon2[0],module.tweapon.gang.weapon3[0])
                module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][1] = module.tweapon.gang.weapon1[0]
                module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][2] = module.tweapon.gang.weapon2[0]
                module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][3] = module.tweapon.gang.weapon3[0]
                fcommon.CheatActivated()
            end
            imgui.SameLine()
            if imgui.Button("Reset to default",imgui.ImVec2(fcommon.GetSize(2))) then

                module.tweapon.gang.used_weapons = fconst.DEFAULT_GANG_WEAPONS

                for x=1,10,1 do
                    setGangWeapons(x,module.tweapon.gang.used_weapons[x][1],module.tweapon.gang.used_weapons[x][2],module.tweapon.gang.used_weapons[x][3])
                end
                module.tweapon.gang.weapon1[0] = module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][1]
                module.tweapon.gang.weapon2[0] = module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][2]
                module.tweapon.gang.weapon3[0] = module.tweapon.gang.used_weapons[fped.tped.gang.index[0]+1][3]
                printHelpString("Gang weapons reset")
            end
        end
    })  
end
return module
