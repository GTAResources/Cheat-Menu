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

module.table = {

    [0]	    = "Initial 1",
    [1]	    = "Initial 2",
    [2]	    = "Intro",
    [3]	    = "They Crawled From Uranus",
    [4]	    = "Dualuty",
    [5]	    = "Go Go Space Monkey",
    [6]	    = "Lets Get Ready To Bumble",
    [7]	    = "Inside Track Betting",
    [8]	    = "Pool",
    [9]	    = "Lowrider (Bet And Dance)",
    [10]	= "Beefy Baron",
    [11]	= "Big Smoke",
    [12]	= "Ryder",
    [13]	= "Tagging Up Turf",
    [14]	= "Cleaning The Hood",
    [15]	= "Drive-Thru",
    [16]	= "Nines And AKs",
    [17]	= "Drive-By",
    [18]	= "Sweets Girl",
    [19]	= "Cesar Vialpando",
    [20]	= "Los Sepulcros",
    [21]	= "Doberman",
    [22]	= "Burning Desire",
    [23]	= "Gray Imports",
    [24]	= "Home Invasion",
    [25]	= "Catalyst",
    [26]	= "Robbing Uncle Sam",
    [27]	= "OG Loc",
    [28]	= "Running Dog",
    [29]	= "Wrong Side of the Tracks",
    [30]	= "Just Business",
    [31]	= "Lifes a Beach",
    [32]	= "Madd Doggs Rhymes",
    [33]	= "Management Issues",
    [34]	= "House Party",
    [35]	= "Race Tournament / 8-track / Dirt Track",
    [36]	= "Lowrider (High Stakes)",
    [37]	= "Reuniting The Families",
    [38]	= "The Green Sabre",
    [39]	= "Badlands",
    [40]	= "First Date",
    [41]	= "Local Liquor Store",
    [42]	= "Small Town Bank",
    [43]	= "Tanker Commander",
    [44]	= "Against All Odds",
    [45]	= "King in Exile",
    [46]	= "Body Harvest",
    [47]	= "Are you going to San Fierro?",
    [48]	= "Wu Zi Mu / Farewell, My Love...",
    [49]	= "Wear Flowers In Your Hair",
    [50]	= "Deconstruction",
    [51]	= "555 WE TIP",
    [52]	= "Snail Trail",
    [53]	= "Mountain Cloud Boys",
    [54]	= "Ran Fa Li",
    [55]	= "Lure",
    [56]	= "Amphibious Assault",
    [57]	= "The Da Nang Thang",
    [58]	= "Photo Opportunity",
    [59]	= "Jizzy",
    [60]	= "Outrider",
    [61]	= "Ice Cold Killa",
    [62]	= "Torenos Last Flight",
    [63]	= "Yay Ka-Boom-Boom",
    [64]	= "Pier 69",
    [65]	= "T-Bone Mendez",
    [66]	= "Mike Toreno",
    [67]	= "Zeroing In",
    [68]	= "Test Drive",
    [69]	= "Customs Fast Track",
    [70]	= "Puncture Wounds",
    [71]	= "Back to School",
    [72]	= "Air Raid",
    [73]	= "Supply Lines",
    [74]	= "New Model Army",
    [75]	= "Monster",
    [76]	= "Highjack",
    [77]	= "Interdiction",
    [78]	= "Verdant Meadows",
    [79]	= "N.O.E.",
    [80]	= "Stowaway",
    [81]	= "Black Project",
    [82]	= "Green Goo",
    [83]	= "Learning to Fly",
    [84]	= "Fender Ketchup",
    [85]	= "Explosive Situation",
    [86]	= "Youve Had Your Chips",
    [87]	= "Fish in a Barrel",
    [88]	= "Don Peyote",
    [89]	= "Intensive Care",
    [90]	= "The Meat Business",
    [91]	= "Freefall",
    [92]	= "Saint Marks Bistro",
    [93]	= "Misappropriation",
    [94]	= "High Noon",
    [95]	= "Madd Dogg",
    [96]	= "Architectural Espionage",
    [97]	= "Key To Her Heart",
    [98]	= "Dam And Blast",
    [99]	= "Cop Wheels",
    [100]	= "Up, Up and Away!",
    [101]	= "Breaking the Bank at Caligulas",
    [102]	= "A Home In The Hills",
    [103]	= "Vertical Bird",
    [104]	= "Home Coming",
    [105]	= "Cut Throat Business",
    [106]	= "Beat Down on B Dup",
    [107]	= "Grove 4 Life",
    [108]	= "Riot",
    [109]	= "Los Desperados",
    [110]	= "End Of The Line (1)",
    [111]	= "End Of The Line (2)",
    [112]	= "End Of The Line (3)",
    [113]	= "Shooting range",
    [114]	= "Los Santos Gym Fight School",
    [115]	= "San Fierro Gym Fight School",
    [116]	= "Las Venturas Gym Fight School",
    [117]	= "Trucking",
    [118]	= "Quarry",
    [119]	= "Boat School",
    [120]	= "Bike School",

    -- Sub-Missions
    [121]	= "Taxi-Driver",
    [122]	= "Paramedic",
    [123]	= "Firefighter",
    [124]	= "Vigilante",
    [125]	= "Burglary",
    [126]	= "Freight Train",
    [127]	= "Pimping",
    [128]	= "Blood Ring",
    [129]	= "Kickstart",
    [130]	= "Beat the Cock!",
    [131]	= "Courier",
    [132]	= "The Chiliad Challenge",
    [133]	= "BMX / NRG-500 STUNT Mission",
    [134]	= "Buy Properties Mission",
}

return module