/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 
ZFM_CRASH_MISSION_MAXIMUM_CONCURRENT_MISSIONS = 3;
ZFM_CRASH_MISSION_NUMBER_LOOT_CRATES_DEADMEAT = 1;
ZFM_CRASH_MISSION_NUMBER_LOOT_CRATES_EASY = 1;
ZFM_CRASH_MISSION_NUMBER_LOOT_CRATES_MEDIUM = 2;
ZFM_CRASH_MISSION_NUMBER_LOOT_CRATES_HARD = 3;
ZFM_CRASH_MISSION_NUMBER_LOOT_CRATES_WAR_MACHINE = 4;

ZFM_CRASH_MISSION_NUMBER_UNITS_DEADMEAT = 4;
ZFM_CRASH_MISSION_NUMBER_UNITS_EASY = 8;
ZFM_CRASH_MISSION_NUMBER_UNITS_MEDIUM = 10;
ZFM_CRASH_MISSION_NUMBER_UNITS_HARD = 12;
ZFM_CRASH_MISSION_NUMBER_UNITS_WAR_MACHINE = 14;

ZFM_CRASH_MISSION_NUMBER_OBJECTS_DEADMEAT = 6;
ZFM_CRASH_MISSION_NUMBER_OBJECTS_EASY = 8;
ZFM_CRASH_MISSION_NUMBER_OBJECTS_MEDIUM = 10;
ZFM_CRASH_MISSION_NUMBER_OBJECTS_HARD = 12;
ZFM_CRASH_MISSION_NUMBER_OBJECTS_WAR_MACHINE = 14;

/*
*	ZFM_CRASH_MISSION_USE_HIVE_VEHICLES
*
*	Should we even include hive vehicles when generating layouts?
*/
ZFM_CRASH_MISSION_USE_HIVE_VEHICLES = true;

/*
*	ZFM_CRASH_MISSION_HIVE_VEHICLE_PERCENTAGE_CHANCE
*	
*	What's the % likelihood that some vehicles will spawn with the mission that the player can keep?
*/
ZFM_CRASH_MISSION_HIVE_VEHICLE_PERCENTAGE_CHANCE = 10; 


ZFM_CRASH_MISSION_LAYOUT_OBJECTS_DEADMEAT =[
	"Land_A_tent",
	"ACamp",
	"Hedgehog",
	"Hedgehog",
	"Hedgehog",
	"Land_obstacle_prone"
];
ZFM_CRASH_MISSION_LAYOUT_OBJECTS_EASY =[
	"Land_A_tent",
	"ACamp",
	"Hedgehog",
	"Hedgehog",
	"Hedgehog",
	"Land_obstacle_prone"
];
ZFM_CRASH_MISSION_LAYOUT_OBJECTS_MEDIUM =[
	"Land_CamoNet_EAST",
	"Land_tent_east",
	"CampEast",
	"Camp",
	"Barrack2"
];
ZFM_CRASH_MISSION_LAYOUT_OBJECTS_HARD =[
	"Land_CamoNet_EAST",
	"Land_tent_east",
	"CampEast",
	"Camp",
	"Barrack2"
];
ZFM_CRASH_MISSION_LAYOUT_OBJECTS_WAR_MACHINE =[
	"Land_CamoNet_EAST",
	"Land_tent_east",
	"CampEast",
	"Camp",
	"Barrack2"
];

ZFM_CRASH_MISSION_LAYOUT_DEADMEAT =[
[0,0,0,0,0],
[0,0,0,0,0],
[0,0,1,0,0],	
[0,0,0,0,0],
[0,0,0,0,0]
];
ZFM_CRASH_MISSION_LAYOUT_EASY =[
[0,0,0,0,0],
[0,0,0,0,0],
[0,0,1,0,0],	
[0,0,0,0,0],
[0,0,0,0,0]
];
ZFM_CRASH_MISSION_LAYOUT_MEDIUM =[
[0,0,0,0,0],
[0,0,0,0,0],
[0,0,1,0,0],	
[0,0,0,0,0],
[0,0,0,0,0]
];
ZFM_CRASH_MISSION_LAYOUT_HARD =[
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],	
[0,0,0,1,1,0,0,0],
[0,0,0,1,1,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0]
];
ZFM_CRASH_MISSION_LAYOUT_WAR_MACHINE =[
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],	
[0,0,0,1,1,0,0,0],
[0,0,0,1,1,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0]
];


ZFM_CRASH_MISSION_USE_MANUAL_CRASH_LOCATIONS = false; // Why use cotton when you have silk?

ZFM_CRASH_MISSION_MANUAL_CRASH_LOCATIONS =[

];

ZFM_CRASH_MISSION_EXCLUDED_CRASH_LOCATIONS =[
	// [_xMin,_xMax,_yMin,_yMax]
	[1200,1205,1200,1205],
	[1206,1210,1206,1210]
];
ZFM_CRASH_MISSION_PLANES =[
	"AV8B","AV8B2","C130J","C130J_US_EP1","F35B","MQ9PredatorB_US_EP1","MV22",
	"Su25_CDF","Su25_TK_EP1","Su34"
];
ZFM_CRASH_MISSION_HELICOPTERS =[
	"AH1Z","MH60S","Mi17_Civilian","Mi17_TK_EP1","Mi17_medevac_Ins","Mi17_medevac_CDF","Mi17_medevac_RU",
	"Mi17_Ins","Mi17_CDF","Mi17_rockets_RU","Mi17_Civilian","Mi17_UN_CDF_EP1","Mi171Sh_rockets_CZ_EP1",
	"Mi17_TK_EP1","Mi24_V","Mi24_P","Mi24_D","Mi24_D_TK_EP1","Ka52","Ka52Black","UH1Y"
];
 
//All crash vehicles
ZFM_CRASH_MISSION_VEHICLES = ZFM_CRASH_MISSION_PLANES + ZFM_CRASH_MISSION_HELICOPTERS;
 