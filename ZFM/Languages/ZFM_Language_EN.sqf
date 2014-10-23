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
	"Creating Join-In-Progress marker - VehicleType [%1],Position [%2],Difficulty[%3].", //0

	// BootStrap process
	"BootStrapping - DayZ type - Include path is %1.", //1
	"BootStrapping - Enabled Missions - Include path is %1.", //2
	"BootStrapping - Units - Creating centers and enabling AI.", //3
	"BootStrapping - Initialisation - Waiting for init to occur.", //4

	// Debug
	"Debug parameters are %1.", //3
	"Debug null-value check for %1",//2
	"DZMS or EMS is installed. Get rid, rebuild PBO, feel good.", //3
	"AI scripts are not fully tested for ZFM Alpha. Use at your peril, landlubber. Y'arr.", //4

	// Units
	"Units - Creating Unit Group from Mission ID %1", //5
	"Units - Creating Individual Unit %1 of %2 [Type: %3]", //6
	"Units - Equipping Unit with Primary [%1], Magazines [%2], Backpack [%3],Unit [%4] and Magazine [%5]", //7

	// Layouts
	"Layout - Row [%1], Row Array [%2], Row Array Count [%3] - Parsing..",
	"Layout - Row [%1], X-Axis Center Position [%2]",
	"Layout - Row [%1], CenterPos exceeded limited, defaulted",
	"Layout - Row [%1], Column [%2] - Parsing.. ",
	"Layout - Row [%1], Column [%2] - X-Axis Center Position Reached",
	"Layout - Row [%1], Column [%2] - Negative Offset from X-Axis Center",
	"Layout - Row [%1], Column [%2] - Positive Offset from X-Axis Center",
	"Layout - Row [%1], Column [%2] - Y-Axis Center Position Reached",
	"Layout - Row [%1], Column [%2] - Negative Offset from Y-Axis Center",
	"Layout - Row [%1], Column [%2] - Positive Offset from Y-Axis Center",
	"Layout - Row [%1], Column [%2] - Output Location. OutputLoc [%3], ClassName [%4], Orientation [%5], Params [%6]",

	// Loot
	"Loot - Created Loot Object [%1] at [%2] with [%3] loot items.",

	// Missions
	"That bandit %1! Was killed by %2 [%3 / %4].", // 9
	"All units were killed! [%1 / %2]", // 10
	"Mission Debug [Purpose %1] %2", //11
	"Mission GetMissionByID Debug %1 and %2", //12
	"Mission %1 - MissionArray type %2", //13
	"Mission %1 - All units have been killed, concluding mission.", //14
	"Mission %1 - Conclude called with MissionArray %2.", //15
	"Mission %1 - Mission objects removed are %2.", //16
	"Mission %1 - Mission markers object %2 removed.", //17
	"Mission %1 - Mission added.", //18
	"Mission %1 - Mission removed.", //19
	"Mission Handler - Initialized", //20
	"Mission Handler - Startup Check Completed - Maximum concurrent missions not reached.", //21
	"Mission Handler - Main loop started", //22
	"Mission Handler - Current playable units %1", // 23
	"Mission Handler - Start Type %1, Random type %2", //24
	"Mission Handler - Can Add New Mission? %1", //25
	"Mission Handler - Waiting %1 seconds for next loop.", //26
	"Mission Generation - Executed by method %1", //27
	"Mission Generation - Loot Mode [%1], Type [%2], Variables [%3], Units [%4]", //28
	
	// Crash missions
	"Crashed %1", //29
	"%1 [Difficulty: %2]", //30
	"MissionType CRASH - Crash Mission Executing.", //31
	"MissionType CRASH - Crash location found.", //32
	"MissionType CRASH - Vehicle crashed has replacement model. Replacing model with non-burning model.", //33
	"MissionType CRASH - Crash marker has been created at %1", //34
	"MissionType CRASH - Manual locations set, but manual locations are empty. Skipping..",
	"MissionType CRASH - Excluding Mission with Co-ordinates [%1], creating new set of co-ordinates",
	// Crash dynamic stuff
	"A %1 %2 %3 %4. %5" //35
];

ZFM_ERROR_STRINGS =[
	// Fatal errors (ex language ones)
	"Fatal error! No mission types are defined or enabled! Please rectify this by ensuring ZFM_MISSION_TYPES_ENABLED or ZFM_MISSION_TYPES_SUPPORTED has the correct contents",
	"Fatal error! No DayZ types are defined or enabled! Please rectify this by ensuring ZFM_DAYZ_TYPES_SUPPORTED is correct.",

	// Units
	"Unknown unit type provided. Exiting unit creation.",
	"Wrong format for EquipArray for unit. You need to restore ZFM defaults or fix what you broke.",	

	// Missions
	"Maximum concurrent missions is set to 0. You do want missions, right?",
	"Only one instance of the mission handler can run at the same time. Exiting main loop.",
	"Nobody is on the server and ZFM_MISSIONS_START_WHILE_SERVER_EMPTY is set to FALSE. Waiting for player to join."
];

// Module-specific language strings 

ZFM_CRASH_MISSION_OTWT_GROUP =[
	"A %1 on a humanitarian mission to %2",
	"A lost %1 a long distance away from %2",
	"A %1 speeding on its way to %2",
	"A %1 making its way to %2",
	"A %1 on a desperate mission to %2",
	"A %1 damaged by ground fire from %2",
	"A damaged %1 trying to reach %2",
	"A %1 attempting to reach %2",
	"A %1 hauling ass towards %2",
	"A stolen %1 on the way to %2",
	"A %1 on the way to %2",
	"A %1 en route to %2"
];

ZFM_CRASH_MISSION_OTWT_PLACE =[
	"a crack den",
	"a zombie fuck club",
	"a penis party",
	"grab some ass",
	"kill some hookers",
	"smoke some crack"
];

ZFM_CRASH_MISSION_OTWT_ACTION =[
	"has crashed",
	"was destroyed",
	"was decimated",
	"was annihilated",
	"and looks to have crashed",
	"and looks to be in serious trouble",
	"and looks like it's fucked",
	"and looks like they're not going to make it",
	"and looks like it's crashed",
	"and looks like it's been sabotaged",
	"and looks like its pilot crash landed",
	"has been downed",
	"hit a tree and crashed",
	"suffered a malfunction and crashed",
	"and was sabotaged and crashed",
	"and was damaged and crashed",
	"and was hit and crashed",
	"and lost fuel and crashed",
	"crashed in an apparent suicide",
	"crashed in an apparent suicide pact",
	"crashed after losing radio contact",
	"went silent and is presumed crashed",
	"went off the radar and is presumed destroyed",
	"lost radio contact and is presumed crashed"
];

ZFM_CRASH_MISSION_OTWT_CONSEQUENCE =[
	"It would appear that",
	"Looks like",
	"Unfortunately,",
	"Regrettably,",
	"Fuck, looks like",
	"Oh shit,",
	"Hot dawg,",
	"Holy smokes,"
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
	"Peacemakers",
	"Lawbringers",
	"Justice-givers",
	"Peacekeepers",
	"Rectifiers",
	"Just citizens",
	"Lovable peacekeepers",
	"Wonderful people",
	"Fantastic folks",
	"Lovable folks"
];
ZFM_CRASH_MISSION_OTWT_BG_NAMES_BANDIT =[
	"Assholes",
	"Mudererers",
	"Assassins",
	"Criminals",
	"Ex-convicts",
	"Escaped criminals",
	"Rabid bankers",
	"Vicious farmers",
	"Angry bus drivers",
	"Frustrated dudes",
	"Angry wankers",
	"Grizzly truckers",
	"Zombie fuckers",
	"Comic book nerds",
	"Politicians",
	"Porn stars",
	"Sex pests",
	"Mormon priests",
	"Book burners",
	"Scientologists",
	"Sexual deviants",
	"Goat lovers",
	"Momma's boys",
	"Flag burners",
	"Cheese eaters",
	"Fudge farmers",
	"Garlic eaters",
	"Pests",
	"Drug dealers",
	"Meth cookers",
	"Heisenberg",
	"Stabbers",
	"Slave traders",
	"Pimps",
	"Megapimps",
	"Megawhores",
	"Megatwats",
	"Pricks",
	"Jerks",
	"Jerk-offs",
	"Jack-offs",
	"Cum guzzlers",
	"Gang members"
];

ZFM_CRASH_MISSION_CRASH_EXPS =[
	"Crashed",
	"Downed",
	"Buggered",
	"Schruted",
	"Fucked",
	"Destroyed",
	"Bum-fucked",
	"Annihilated",
	"Molested",
	"Burned",
	"Incinerated",
	"Intercepted"
];