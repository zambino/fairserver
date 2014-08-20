/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
ZFM_INFORMATION_STRINGS = [

	// Join-In-Progress
	"Creating Join-In-Progress marker - VehicleType [%1],Position [%2],Difficulty[%3].",

	// Debug
	"Debug parameters for _this are %1.",
	"Debug null-value check for %1",
	"DZMS or EMS is installed. Get rid, rebuild PBO, feel good.",
	"AI scripts are not fully tested for ZFM Alpha. Use at your peril, landlubber. Y'arr.",


	// Units
	"Units - Creating Unit Group from Mission ID %1",
	"Units - Creating Individual Unit %1 of %2 [Type: %3]",
	"Units - Equipping Unit with Primary [%1], Magazines [%2], Backpack [%3],Unit [%4] and Magazine [%5]",

	// Missions
	"That bandit %1! Was killed by %2 [%3 / %4].", // User message
	"All units were killed! [%1 / %2]", // User message
	"Mission Debug [Purpose %1] %2",
	"Mission GetMissionByID Debug %1 and %2",
	"Mission %1 - MissionArray type %2",
	"Mission %1 - All units have been killed, concluding mission.",
	"Mission %1 - Conclude called with MissionArray %2.",
	"Mission %1 - Mission objects removed are %2.",
	"Mission %1 - Mission markers object %2 removed.",
	"Mission %1 - Mission added.",
	"Mission %1 - Mission removed.",
	"Mission Handler - Initialized",
	"Mission Handler - Startup Check Completed - Maximum concurrent missions not reached.",
	"Mission Handler - Main loop started",
	"Mission Handler - Current playable units %1",
	"Mission Handler - Start Type %1, Random type %2",
	"Mission Handler - Can Add New Mission? %1",
	"Mission Handler - Waiting %1 seconds for next loop.",
	"Mission Generation - Executed by method %1",
	"Mission Generation - Loot Mode [%1], Type [%2], Variables [%3], Units [%4]",

	// Crash missions
	"Crashed %1",
	"%1 [Difficulty: %2]",
	"MissionType CRASH - Crash Mission Executing.",
	"MissionType CRASH - Crash location found.",
	"MissionType CRASH - Vehicle crashed has replacement model. Replacing model with non-burning model.",
	"MissionType CRASH - Crash marker has been created at %1",

	// Crash dynamic stuff
	"A %1 %2 %3 %4. %5",
];

ZFM_ERROR_STRINGS =[
	// Fatal errors (ex language ones)
	"Fatal error! No mission types are defined or enabled! Please rectify this by ensuring ZFM_MISSION_TYPES_ENABLED or ZFM_MISSION_TYPES_SUPPORTED has the correct contents",

	// Units
	"Unknown unit type provided. Exiting unit creation.",
	"Wrong format for EquipArray for unit. You need to restore ZFM defaults or fix what you broke.",	

	// Missions
	"Maximum concurrent missions is set to 0. You do want missions, right?",
	"Only one instance of the mission handler can run at the same time. Exiting main loop.",
	"Nobody is on the server and ZFM_MISSIONS_START_WHILE_SERVER_EMPTY is set to FALSE. Waiting for player to join.",
];

// Module-specific language strings 

ZFM_CRASH_MISSION_OTWT =[
	
];

ZFM_CRASH_MISSION_OTWT_PLACE =[

];

ZFM_CRASH_MISSION_OTWT_ACTION =[
	
];
ZFM_CRASH_MISSION_OTWT_CONSEQUENCE =[
	"It would appear that",
	"Looks like",
	"Unfortunately,",
	"Regrettably,",
	"Fuck, looks like",
	"Oh shit,",
	"Hot dawg,",
	"Holy smokes,",
];

// Double formatting to replace a wildcard replaced by a wildcard.. ;-)
ZFM_CRASH_MISSION_OTWT_CONSEQUENCE_CONCLUSION =[
	"%1 took control of the area.",
	"%1 are camped in the area.",
	"%1 are patrolling nearby.",
	"%1 are having an orgy in the vicinity.",
	"%1 took up sniper positions nearby.",
	"%1 are hidden nearby",
	"%1 formed defensive positions.",
	"%1 are now in control.",
	"%1 are in command.",
	"%1 are the big chiefs in town."
];


ZFM_CRASH_MISSION_OTWT_BG_NAMES_HERO =[
	"My Hero Group Name",
];
ZFM_CRASH_MISSION_OTWT_BG_NAMES_BANDIT =[
	"My Bandit Group Name"
];