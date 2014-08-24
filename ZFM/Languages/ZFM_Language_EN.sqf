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
	"A %1 %2 %3 %4. %5"
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
	"Balota",
	"Berezino", 
	"Bor", 
	"Chapaevsk", 
	"Chernaya Polana", 
	"Chernogorsk", 
	"Dolina",
	"Drozhino", 
	"Dubky", 
	"Dubrovka", 
	"Elektrozavodsk", 
	"Gorka", 
	"Grishino", 
	"Guglovo", 
	"Gvozdno", 
	"Kabanino", 
	"Kamenka", 
	"Kamyshovo", 
	"Karmanovka", 
	"Khelm", 
	"Komarovo", 
	"Kozlovka", 
	"Krasnostav", 
	"Lopatino", 
	"Mogilevka", 
	"Msta", 
	"Myshkino", 
	"Nadezhdino", 
	"Nizhnoye", 
	"Novodmitrovsk", 
	"Novoselky", 
	"Novy Sobor", 
	"Olsha", 
	"Orlovets", 
	"Pavlovo", 
	"Pogorevka", 
	"Polana", 
	"Prigorodki", 
	"Pulkovo", 
	"Pusta",
	"Pustoshka", 
	"Rogovo", 
	"Shakhovka", 
	"Smirnovo", 
	"Solnichniy", 
	"Sosnovka", 
	"Staroye", 
	"Stary Sobor", 
	"Svetlojarsk", 
	"Tulga", 
	"Vybor", 
	"Vyshnaya Dubrovka", 
	"Vyshnoye", 
	"Zelenogorsk"
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