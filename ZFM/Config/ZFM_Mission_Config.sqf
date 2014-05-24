/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 
 ZFM_MINIMUM_AI_PER_MISSION = 8;
 ZFM_MINIMUM_LOOT_CONTAINERS_PER_MISSION = 2;
  
 ZFM_MAXIMUM_MISSIONS = 1;
 ZFM_MAXIMUM_CRASH_MISSIONS = 1;
  
 ZFM_GROUP_EAST = objNull;
 ZFM_GROUP_WEST = objNull;
 ZFM_GROUP_CIVILIAN = objNull;
 ZFM_GROUP_RESISTANCE = objNull;
 
 // Global ZFM constants
 ZFM_AI_TYPE_SNIPER = "1x101010";
 ZFM_AI_TYPE_RIFLEMAN = "1x101011";
 ZFM_AI_TYPE_HEAVY = "1x101012";
 ZFM_AI_TYPE_COMMANDER = "1x101013";
 ZFM_AI_TYPE_MEDIC = "1x101014";
 ZFM_AI_TYPE_PILOT = "1x101015";
 ZFM_MISSION_METHOD_RANDOM = "3x101011";
 ZFM_MISSION_TYPE_CRASH = "2x101011";
 ZFM_MISSION_TYPE_CRASH_GOTO = "2x101012";
 ZFM_MISSION_TYPE_CRASH_AMBUSH = "2x101013";
 
 
 ZFM_AI_TYPES = [
	ZFM_AI_TYPE_SNIPER,
	ZFM_AI_TYPE_RIFLEMAN,
	ZFM_AI_TYPE_HEAVY,
	ZFM_AI_TYPE_COMMANDER
	// Not adding Medic or Pilot yet, for later version
 ];
 
 // Used for generation of AI missions (i.e. select at random from this list for difficulty)
 ZFM_DIFFICULTIES =[
	"DEADMEAT",
	"EASY",
	"MEDIUM",
	"HARD",
	"WAR_MACHINE"
 ];
 
 ZFM_MISSION_TYPES =[
	ZFM_MISSION_TYPE_CRASH
 ];
 
ZFM_CrashVehicles_Planes =[
	"AV8B","AV8B2","C130J","C130J_US_EP1","F35B","MQ9PredatorB_US_EP1","MV22",
	"Su25_CDF","Su25_TK_EP1","Su34"
];
ZFM_CrashVehicles_Helicopters =[
	"AH1Z","MH60S","Mi17_Civilian","Mi17_TK_EP1","Mi17_medevac_Ins","Mi17_medevac_CDF","Mi17_medevac_RU",
	"Mi17_Ins","Mi17_CDF","Mi17_rockets_RU","Mi17_Civilian","Mi17_UN_CDF_EP1","Mi171Sh_rockets_CZ_EP1",
	"Mi17_TK_EP1","Mi24_V","Mi24_P","Mi24_D","Mi24_D_TK_EP1","Ka52","Ka52Black","UH1Y"
];
 
//All crash vehicles
ZFM_CrashVehicles = ZFM_CrashVehicles_Planes + ZFM_CrashVehicles_Helicopters;
 
ZFS_Skills_AI_DEADMEAT = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",0.1],
    ["aimingShake",1],
    ["aimingSpeed",0.1],
    ["endurance",0.1],
    ["spotDistance",0.1],
    ["spotTime",0.1],
    ["courage",0.1],
    ["reloadSpeed",0.1],
    ["commanding",0.1],
    ["general",0.1]
 ];
 
 ZFS_Skills_AI_EASY = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",0.25],
    ["aimingShake",0.8],
    ["aimingSpeed",0.25],
    ["endurance",0.25],
    ["spotDistance",0.25],
    ["spotTime",0.25],
    ["courage",0.25],
    ["reloadSpeed",0.25],
    ["commanding",0.25],
    ["general",0.25]
 ];
 
 ZFS_Skills_AI_MEDIUM = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",0.65],
    ["aimingShake",0.3],
    ["aimingSpeed",0.65],
    ["endurance",0.65],
    ["spotDistance",0.65],
    ["spotTime",0.65],
    ["courage",0.65],
    ["reloadSpeed",0.65],
    ["commanding",0.65],
    ["general",0.65]
 ];
 
 ZFS_Skills_AI_HARD = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",0.85],
    ["aimingShake",0.2],
    ["aimingSpeed",0.85],
    ["endurance",0.85],
    ["spotDistance",0.85],
    ["spotTime",0.85],
    ["courage",0.85],
    ["reloadSpeed",0.85],
    ["commanding",0.85],
    ["general",0.85]
 ];
 
 ZFS_Skills_AI_WAR_MACHINE = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",1],
    ["aimingShake",0.1],
    ["aimingSpeed",1],
    ["endurance",1],
    ["spotDistance",1],
    ["spotTime",1],
    ["courage",1],
    ["reloadSpeed",1],
    ["commanding",1],
    ["general",1]
 ];
 
	/*
		UNIT EQUIP ARRAYS
		
		These are used to determine what equipment units of various difficulties get.
		Most of this data is the same but is left this way so people can change this for their server.
		
		The array MUST be in this form: 
		
		[
			"SKIN_NAME",  // STRING only
			["Weapon1","Weapon2"], //[] ARRAY only
			1, // NUMERICAL only
			["BackPack1","BackPack2"] // ARRAY only, must be backpacks
			["Item1","Item2"] // ARRAY only, MUST be magazines. 
		]
	*/
	
	
  // Snipers
 ZFS_Equipment_Sniper_EASY = [
	"Bandit1_DZ", 												// Skin (STRING)
	["SVD_CAMO"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
 ];
 ZFS_Equipment_Sniper_MEDIUM = [
	"Soldier_Sniper_PMC_DZ", 														// Skin
	["SVD_CAMO","DMR_DZ","m107","SVD_des_EP1"],										// Snipers from FixedLoot. (Random pick)
	3,																				// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],				// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]	
 ];
 
 ZFS_Equipment_Sniper_HARD = [
	"GUE_Soldier_Sniper_DZ", 											// Skin
	["SCAR_H_LNG_Sniper_SD","SVD_CAMO","DMR_DZ"],						// Snipers from FixedLoot. (Random pick)
	5,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];

 ZFS_Equipment_Sniper_WAR_MACHINE = [
	"GUE_Soldier_Sniper_DZ",
	["KSVK_DZE","DMR_DZ","m107"],				// Will always have an awesome sniper rifle..
	5,
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];
 
  // Riflemen
  ZFS_Equipment_Rifleman_EASY = [
	"Bandit1_DZ", 												// Skin
	["AK_47_M","AK_74","AKS_74_kobra","AKS_74_U","G36C","G36K_camo","M4A1","M249_DZ"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
 ];
 ZFS_Equipment_Rifleman_MEDIUM = [
	"GUE_Soldier_MG_DZ", 														// Skin
	["AK_47_M","AK_74","AKS_74_kobra","AKS_74_U","G36C","G36K_camo","M4A1","M249_DZ","G36A_camo","G36C_camo","M240_DZ"],										// Snipers from FixedLoot. (Random pick)
	3,																				// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],				// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]	
 ];
 
 ZFS_Equipment_Rifleman_HARD = [
	"GUE_Soldier_Crew_DZ", 											// Skin
	["AK_47_M","AK_74","AKS_74_kobra","AKS_74_U","G36C","G36K_camo","M4A1","M249_DZ","G36A_camo","G36C_camo","M240_DZ","MG36_camo"],						// Snipers from FixedLoot. (Random pick)
	5,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];

 ZFS_Equipment_Rifleman_WAR_MACHINE = [
	"Ins_Soldier_GL_DZ",
	["FN_FAL","FN_FAL_ANPVS4","G36A_camo","G36C_camo","M240_DZ","MG36_camo","PK"],				// Will always have an awesome sniper rifle..
	5,
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];
 
 // Commander is only used in hard or war machine, same model.
ZFS_Equipment_Commander = [
	"GUE_Commander_DZ",
	["FN_FAL","FN_FAL_ANPVS4","SCAR_H_LNG_Sniper_SD","PK"],				// Will always have an awesome sniper rifle..
	8,
	["DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];
 
 // Heavy machinegunners
 ZFS_Equipment_Heavy_EASY = [
	"Bandit1_DZ", 												// Skin
	["M249_DZ"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
 ];
 ZFS_Equipment_Heavy_MEDIUM = [
	"Bandit2_DZ", 														// Skin
	["Mk_48_DZ","M249_DZ"],										// Snipers from FixedLoot. (Random pick)
	3,																				// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],				// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]	
 ];
 
 ZFS_Equipment_Heavy_HARD = [
	"GUE_Soldier_CO_DZ", 											// Skin
	["MG36_camo","M249_DZ","M240_DZ"],						// Snipers from FixedLoot. (Random pick)
	5,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];

 ZFS_Equipment_Heavy_WAR_MACHINE = [
	"GUE_Soldier_CO_DZ",
	["PK"],				// Will always have an awesome sniper rifle..
	5,
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];
 
 /*
	ZFM Mission Variables
 */
 
 
 /*
	ZFM BanditGroup Names

	Used to add spice to dynamic missions
 */
 ZFM_BanditGroup_Names =[
	"well-trained mercenaries",
	"well-trained ex-army soldiers",
	"special forces",
	"opportunistic thieves",
	"gathered low-lives",
	"armed cult members",
	"Chernarussian separatists",
	"cold-blooded murderers",
	"cold-blooded criminals",
	"ruthless killers",
	"trained killers",
	"rogue policemen",
	"corrupted officials",
	"war criminals",
	"escaped prisoners",
	"rugged survivalists",
	"nearby survivors",
	"nearby saboteurs",
	"ruthless reclusives",
	"deadly mercenaries",
	"malicious psychopaths",
	"angry survivors",
	"cold-blooded killers",
	"for-profit bandits",
	"power-hungry bandits",
	"local bandits",
	"devious survivalists",
	"devious bandits",
	"ruthless bandits",
	"greedy bandits",
	"desperate bandits",
	"angry bandits",
	"merciless bandits",
	"well-trained bandits",
	"opportunistic bandits",
	"a group of thugs",
	"a group of ex-gangsters",
	"a group of murderers",
	"escaped convicts"
 ];
 
 
/* ZFM_BanditGroup_Fun_Names =[
	"666ers",
	"101 Dalmatians",
	"99 Luftballons",
	"28 DayZ Later",
	"The Angels",
	"Uptown Riders",
	"Balota BumFuck Club",
	"Balota Bastards Crew",
	"Balota Burger Boys",
	"Balota Fuck Club",
	"Bambi Rapers",
	"Bambi Molesters",
	"Bambi Predators",
	"Bambi Prick Festival",
	"Bambi Semen Factory",
	"Bespoleznyye Vlagalishcha",
	"Black Rebels",
	"Black Widows",
	"Born Losers",
	"Bethesda Cockworks",
	"Brigands",
	"The Brotherhood",
	"Chernarus Fuck Club",
	"Chernarus Bongo Boys",
	"Chernarus Cheese Choppers",
	"Chernarus Chippy Chappies",
	"Crucifiers",
	"Dark Souls",
	"Death Knights",
	"Dean Hall's Massive Ego",
	"Del Fuegos",
	"Devil's Advocates",
	"Devil's Hand",
	"Devil's Tribe",
	"Dogs of Hell",
	"Gigantskiy muzhestvennost",
	"Grave Diggers",
	"Grand Funk Railroad",
	"Gunthugs",
	"Heaven's Helpers",
	"Hell's Satans",
	"The Horde",
	"Iron Bloods",
	"Iron Chains",
	"Invincible Motherfuckers",
	"Jackals",
	"Jesters",
	"KOS Motherfuckers",
	"Koza Malchiki",
	"Krasivyye Pazukhi",
	"Los Lobos",
	"The Lost",
	"Madcaps",
	"Mayans",
	"Nader's Raiders",
	"Niznhoye Murder Crew",
	"Niznhoye BumFuck Club",
	"No Heads in Electro",
	"No Pants in Electro",
	"No Cunts in Electro",
	"Order of Odin",
	"The One-eyed Snakes",
	"One Percenters",
	"Pacific Coast Highway",
	"Pistoleros",
	"Pythons",
	"Renegades",
	"Satan's Disciples",
	"Satan's Helpers",
	"Satan's Messengers",
	"Satan's Mothers",
	"Satan's Sinners",
	"Skinny Commandos",
	"Smertel'nyy ovets",
	"Sons of Anarchy",
	"Standalone Pricks",
	"Triple Sixers",
	"Vipers",
	"Voyennyye prestupniki",
	"Wizards",
	"Yankee Rebels",
	"Yellow Dragons",
	"Zlo obez'yana"	
];*/

ZFM_OnTheWayTo =[
	"en route to",
	"in transit to",
	"transporting medical personnel to",
	"on a routine trip to",
	"on a rescue mission to",
	"on a support mission to",
	"on an urgent rescue mission to",
	"on a humanitarian mission to",
	"on its way to rescue survivors from",
	"on a desperate mission to",
	"making a delivery to",
	"making an ammo drop to",
	"making a humanitarian drop to",
	"making its way to"
];

ZFM_OnTheWayToPlace =[
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

ZFM_OnTheWayToDeath =[
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
	//"hit Dean Hall's ego and exploded"
];

 /*
	ZFM DeathPhrases
	
	Shown when AI or a player dies. Funny :)
 */
ZFM_DeathPhrases =[
	"is cooking with the Kennedys",
	"went tits up",
	"kissed their miserable life goodbye",
	"bit the big one",
	"kicked the bucket",
	"is six feet under",
	"got fucked up",
	"got fucked BIG TIME",
	"was snuffed out",
	"is worm food",
	"bought a pine condo", 
	"became living-challenged", 
	"sleeps with the fishes",
	"is pushing up daisies",
	"bit the dust",
	"fucked the dog",
	"screwed the pooch",
	"croaked",
	"tripped the light fantastic",
	"cashed in their chips",
	"ceased to be",
	"checked out",
	"took a dirt nap",
	"tried to walk through a wall of bullets",
	"became a bullet collector",
	"left the building",
	"reached the finish line",
	"is a goner",
	"won one for the reaper",
	"got fucked by a train",
	"joined a necrophiliac's singles club",
	"took a dirt nap",
	"is immortality challenged",
	"went into the fertilizer business",
	"was put in the crisper",
	"is pining for the fjords",
	"said YES to death"
]; 