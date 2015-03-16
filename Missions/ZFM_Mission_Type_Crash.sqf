/*
*	ZFM_Mission_Type_Crash
*
*	Created by: 	Jordan Ashley Craw (ZamboniBambino)
*	Date:		February 2015
*	Desc:		Main crash mission.
*
*	Features:
*	It will blow yo' mind. Yo.
*
*/

// Used as a workaround for file_exist not existing.
ZFM_Mission_Type_Crash_Installed = TRUE;


// Global variables..
ZFM_MISSION_TYPE_CRASH_MISSION_STATUS = "NOT_STARTED";

/*
*	Implements _IntroText from ZFM_Missions
*/
ZFM_Mission_Type_Crash_IntroText ={
	
};


// Crash mission generates its units each time, so we leave these empty, to be filled.
ZFM_Mission_Type_Crash_Units =[];
ZFM_Mission_Type_Crash_Vehicles =[];
ZFM_Mission_Type_Crash_Layout=[];
ZFM_Mission_Type_Crash_Trigger=[];

/*
*	Land vehicles which can crash or be abandoned.
*/
ZFM_MiSSION_TYPE_CRASH_CRASH_VEHICLES_LAND =[
	"HMMWV_M2",
	"HMMWV_M2_USArmy",
	"HMMWV_Mk19",
	"HMMWV_Mk19_USArmy",
	"Offroad_DSHKM_Gue",
	"Offroad_DSHKM_TERROR",
	"Pickup_PK_GUE",
	"Pickup_PK_TERROR",
	"EOffroad_DSHKM_TERROR",
	"EPickup_PK_TERROR",
	"HMMWV",
	"UAZ_MG_CDF",
	"UAZ_CDF",
	"Ural_CDF",
	"UralOpen_CDF",
	"UralRefuel_CDF",
	"UAZ_RU",
	"UAZ_MG_INS",
	"UAZ_INS",
	"Ural_INS",
	"UralOpen_INS",
	"UralRefuel_INS",
	"UralCivil",
	"UralCivil2",
	"HMMWV_DES_EP1",
	"HMMWV_MK19_DES_EP1",
	"ATV_US_EP1",
	"ATV_CZ_EP1",
	"BTR40_MG_TK_GUE_EP1",
	"BTR40_TK_GUE_EP1",
	"BTR40_MG_TK_INS_EP1",
	"BTR40_TK_INS_EP1",
	"SUV_PMC",
	"ArmoredSUV_PMC",
	"HMMWV_DZ",
	"SUV_DZ",
	"HMMWV_Armored_DZ",
	"HMMWV_M2_DZ"
];

/*
*	Air vehicles which can crash or run aground, whatever. 
*/
ZFM_MiSSION_TYPE_CRASH_CRASH_VEHICLES_AIR =[
	"Mi17_Ins",
	"Mi17_CDF",
	"Mi17_Civilian",
	"Mi17_DZ",
	"UH1H_DZ",
	"AH6X_DZ",
	"MH6J_DZ",
	"UH1Y",
	"UH1Y_DZ",
	"UH60M_EP1",
	"UH60M_DZ",
	"UH1H_TK_GUE_EP1",
	"UH1H_TK_GUE_DZ",
	"MV22",
	"MV22_DZ",
	"CH_47F_BAF",
	"CH_47F_DZ",
	"BAF_Merlin_HC3_D",
	"BAF_Merlin_DZ",
	"AN2_DZ",
	"MH6J_EP1",
	"An2_1_TK_CIV_EP1",
	"An2_2_TK_CIV_EP1",
	"An2_TK_EP1",
	"CH_47F_EP1",
	"UH1H_TK_EP1"
];

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_HERO_DEADMEAT ={
	"clueless vigilantes",
	"misguided youths",
	"good-hearted simpletons",
	"kind-hearted idiots",
	"kind-hearted everymen",
	"pleasant morons",
	"kindly dumbfucks",
	"blissful simpletons",
	"peaceful dipshits",
	"lovely fools"
};

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_HERO_EASY ={
	"haphazard vigilantes",
	"regular kind-hearted Joes",
	"level-headed workmen",
	"first-day recruits",
	"corporals",
	"privates",
};

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_HERO_MEDIUM ={
	"low-ranking ex-military",
	"low-ranking cadets",
	"inexperienced privates",
	"bog-standard vigilantes",
	"reasonable individuals",
	"frustrated kindly-folks",
	"angry good people",
	"lovely low-rank soldiers",
	"well-meaning military cadets"
};

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_HERO_HARD ={
	 "experienced servicemen",
	 "dedicated servicemen",
	 "dedicated minutemen",
	 "overwatch command",
	 "former UN peacekeepers",
	 "former UN servicemen",
	 "seasoned servicemen",
	 "seasoned soldiers",
	 "ranked soldiers",
	 "conscientious soldiers",
	 "peacekeepers",
	 "defense forces",
	 "former secret service"
};

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_HERO_WAR_MACHINE ={
	 "veteran special forces",
	 "veteran covert operations",
	 "seasoned veterans",
	 "expertly-trained unit",
	 "crack team",
	 "former Navy SEALs",
	 "former SAS commanders",
	 "former KSK commandos",
	 "former COS forces",
	 "former special forces",
	 "former KSO commandos",
	 "commandos",
	 "specOps commandos",
	 "war machine defenders",
	 "war machine protectors",
	 "war machine overwatch",
	 "war machine guardians",
	 "war machine heroes",
	 "war machine troops",
	 "war machine saviours",
	 "war machine minutemen",
	 "war machine commandos",
	 "war machine special forces",
	 "special forces",
	"The Protectors",
	"The Saviours",
	"The Reformers",
	"The Peacebringers",
	"The Peacekeepers"
};

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_BANDIT_DEADMEAT ={
	"brainless thugs",
	"angry mobs",
	"clueless yobs",
	"thugs",
	"clueless vigilantes",
	"misguided youths",
	"narrow-minded gangs",
	"block-headed gangs",
	"petty criminals",
	"low-level gangsters",
	"low-level enforcers",
	"street-corner thugs",
	"low-level gangster",
	"gangster",
	"run-and-gun artists",
	"con artists",
	"various scumbags",
	"scumbags",
	"naer-do-wells",
	"scofflaws",
	"hapless hustlers"
};

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_BANDIT_EASY ={
	"hapless criminals",
	"small-time hoods",
	"smash-and-grab artists",
	"escaped conviccts",
	"bog-standard musclemen",
	"trespassers",
	"delinquents",
	"juvenile delinquents",
	"shady shysters",
	"manipulative malefactors",
	"deplorable thugs",
	"senseless criminals",
	"immoral folks"
};

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_BANDIT_MEDIUM ={
	"corrupt cops",
	"corrupt SWAT washouts",
	"professional hoodlums",
	"mid-level racketeer",
	"felonious hams",
	"mobsters",
	"malefactors",
	"yardbirds",
	"bent blackmailers",
	"nefarious scofflaws"
};

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_BANDIT_HARD ={
	"evildoers",
	"iniquitious ex-SWAT",
	"outrageous monsters",
	"wildcats murderers",
	"murderous malefactors",
	"transgressors",
	"desperados",
	"villains",
	"senseless murderers",
	"wanton murderers",
	"corrupt ex-cops",
	"corrupt SWAT",
	"egregious evildoers",
	"musclebound monsters",
	"aggressive foreign actors",
	"disgraced former special forces"
};

ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_BANDIT_WAR_MACHINE ={
	"disillusioned special forces",
	"enraged special forces",
	"amoral special forces",
	"special force assassins",
	"kill squadrons",
	"hunt-and-destroy units",
	"seek-and-destroy units",
	"murder-for-hire units",
	"war machine tyrants",
	"war machine monsters",
	"war machine assassins",
	"war machine killers",
	"war machine killers for hire",
	"war machine murderers",
	"war machine invaders",
	"war machine psychopaths",
	"The Soulless",
	"The Heartless",
	"The Butchers",
	"The Monsters"
};

ZFM_MiSSION_TYPE_CRASH_ACTIONS_LAND_NAMES =[
	"collided with a tree",
	"smashed into a tree",
	"careened into a a tree",
	"ran through a tree",
	"was smashed by a tree",
	"sustained damage from an ambush",
	"sustained damage from incoming fire",
	"sustained damage from friendly fire",
	"was caught in cross-fire",
	"hit ex-soviet military ordnance",
	"ran over an old mine",
	"ran over a mine",
	"exploded",
	"set on fire",
	"was shot to crap",
	"was hit by debris",
	"was crushed by falling debris",
	"was run off the road",
	"broke down",
	"was destroyed"
];

ZFM_MISSION_TYPE_CRASH_ACTIONS_AIR_NAMES =[
	"fall from the sky",
	"exploded in a mid-air collision",
	"was shot down by a missile battery",
	"exploded mid-air and crashed"
];

ZFM_MISSION_TYPE_CRASH_ACTIONS_ENROUTE_NAMES =[
	"speeding to",
	"making its way to",
	"en route to",
	"on the way to",
	"making its way to",
	"racing to",
	"zooming to",
	"zipping to"
];

ZFM_MISSION_TYPE_CRASH_ACTIONS_TO_NAMES_HERO =[
	"provide assistance",
	"a medical camp",
	"an orphanage",
	"provide medical assistance",
	"protect survivors"
];

ZFM_MISSION_TYPE_CRASH_ACTIONS_TO_NAMES_BANDIT =[
	"rob a bank",
	"invade a city",
	"destroy a trader",
	"destroy a base",
	"invade a base",
	"steal things"
];

ZFM_MISSION_TYPE_CRASH_ACTIONS_RECOVER_NAMES =[
	"are on the scene",
	"have secured the site",
	"have taken over the area",
	"are looking after the site",
	"are providing overwatch",
	"are protecting the area",
	"are camped out defending",
	"are ready for action",
	"are ready to rock and roll",
	"are ready to kick ass",
	"are ready to kick it"
];

/*
*	ZFM_Mission_Type_Crash_Create_Crash_Title
*
*	Generates a random mission title.
*/
ZFM_Mission_Type_Crash_Create_Crash_Title ={
	private["_difficulty","_from","_to","_at","_output","_toToArray","_toTo","_enroute","_actionArray","_action","_groupArray","_theGroup","_recoverAction"];
	_difficulty = _this select 0;
	_unitTypes = _this select 1;
	_vehicletype = _this select 2;
	_from = _this select 3;
	_to = _this select 4;
	_at = _this select 5;
	
	// to (bandit or hero)
	_toToArray = call compile format["ZFM_MISSION_TYPE_CRASH_ACTIONS_TO_NAMES_%1",_unitTypes];
	_toTo = _toToArray call BIS_fnc_selectRandom;
	
	// En-route to..
	_enroute = ZFM_MISSION_TYPE_CRASH_ACTIONS_ENROUTE_NAMES call BIS_fnc_selectRandom;
	
	// Action (vehicle type specific)
	_actionArray = call compile format["ZFM_MISSION_TYPE_CRASH_ACTIONS_%1_NAMES",_vehicletype];
	_action = _actionArray call BIS_fnc_selectRandom;
	
	// Group
	_groupArray = call compile format["ZFM_MiSSION_TYPE_CRASH_GROUP_NAMES_%1_%2",_difficulty,_unitTypes];
	_theGroup = _actionArray call BIS_fnc_selectRandom;
	
	// Recover action
	_recoverAction = ZFM_MISSION_TYPE_CRASH_ACTIONS_RECOVER_NAMES call BIS_fnc_selectRandom;
	
	// A <vehicle> <enroute> to <to> <action> - <group> <recover_action>. [Difficulty: <difficulty>]
	format[
		"A %1 %2 to %3 %4 %5 %6. [%7 Difficulty: %8]",
		_vehicletype,
		_enroute,
		_toTo,
		_action,
		_theGroup,
		_recoverAction,
		_unitTypes,
		_difficulty
	]
};

/*
*	ZFM_Mission_Type_Crash_Start
*
*	Called by ZFM_Missions.sqf; tells the defined mission that the mission start has been called.
*/
ZFM_Mission_Type_Crash_Start ={
	private["_difficulty","_crashVehicle","_crashLocation","_unitTypes"];

	// Random difficulty to begin with..
	_difficulty = ZFM_DEFINES_DIFFICULTIES call BIS_fnc_selectRandom;

	_crashSuperClass = ["LAND","AIR"] call BIS_fnc_selectRandom;
	
	// Random crash vehicle to begin with
	_crashVehicle = call compile format["ZFM_MiSSION_TYPE_CRASH_CRASH_VEHICLES_%1",_crashSuperClass];
	
	switch(_crashSuperClass) do
	{
		/*
			From ZFM Wiki:
		
			Vehicle is spawned in with the full crew.
			
			Vehicle spawn in-air location is generated using ZFM_Common_Location_Generate_Random.
			Random move to location is generated using a *new function* to generate a random location within N meters.
			
			Vehicle is commanded to move from the spawn in location to the move-to location.
			
			If players destroy the vehicle, then units, loot, and the rest are spawned in next to the crash location, or the nearest open space.
			
			If players do not destroy the vehicle, then air crash effects are generated and then the units, loot, and the rest are spawned in next to the crash location, or the nearest open space. 
		*/
		case "AIR": {
			// Spawn a location that the heli or plane will start at..
			_spawnStartingLocation = call ZFM_Common_Location_Generate_Random;
			
			// Spawn a location that the heli or plane will move to.
			// Note: Crash location is random as players could shoot it down.
			_spawnMoveToLocation = call ZFM_Common_Location_Generate_Random;
			
			// we don't need to create them here, the mission handler does that itself.
			ZFM_Mission_Type_Crash_Vehicles = ZFM_Mission_Type_Crash_Vehicles + [
				_crashVehicle,				// vehicleClass
				_spawnStartingLocation,		// Location
				[],							// Contents
				true,						// With crew?
				true,							// Flying
				{
					private["_vehicle"];
					_vehicle = _this select 0;
					
					// Tell the vehicle to move to the location.
					[_spawnMoveToLocation,"MOVE"] call ZFM_Vehicles_Add_Waypoint;
				} // Init code
			];
			
			// Will be passed back to "Running" function.
			[_crashVehicle,_difficulty,_crashSuperClass]
			
			// In this instance, we can't really create units in advance because the crash is dynamic.
			// This means we have to tell the mission handler to create the crash vehicle, then we wait
			// For it to appear, wait, then call the ZFM_Mission functions manually. Bit of a bypass, but..
			// The handler is cool <3 <3
		};
		
		/*
			From ZFM Wiki:
		
			Vehicle is spawned in with the full crew 
			
			Vehicle crash site location is generated using ZFM_Common_Location_Generate_Random.
			Units are spawned at the crash site location. 
			
			Random move from location is generated using a *new function* to generate a random location within N meters.
			
			Vehicle is commanded to drive to the location specified. 
			
			If the vehicle is destroyed by players on its way, then units are commanded to go to the crash.
			
			If the vehicle makes it to the crash site, then the AI is there lying in wait.
			Land crash effects are generated. 
		*/
		case "LAND": {
			// Spawn a location that the vehicle will start at, preferrably on a road so it doesn't take decades..
			_spawnStartingLocation = call ZFM_Common_Location_Generate_Random_Road;
			
			// Now we generate the crash site; the trap the vehicle will move into.
			_spawnMoveToLocation = call ZFM_Common_Location_Generate_Random;		
			
			// Now we generate the layout of the stuff around the units
			
			// Now we generate vehicles spawned around them
			
			// Now we generate static junk to spawn around
			
			// Now we generate triggers for the coup de grace.. <3
			
			// We don't generate the markers yet.. we wait for the "Running" call to do that.
		};
	};
	
	
	// Generate a random location for the mission.
	_crashLocation = call ZFM_Common_Location_Generate_Random;
	
	// Is it a bandit or a hero mission? (Random Select)
	_unitTypes = ZFM_DEFINES_FACTIONS call BIS_fnc_selectRandom;
	
	
	// TODO: add in pre-defined layouts
	
	// MissionUnits need to be generated based on difficulty..
	
	// Set to say the mission is ready. ("NOT_STARTED","PROCESSING","STARTED","ENDED")
	ZFM_MISSION_TYPE_CRASH_MISSION_STATUS = "STARTED";

};

ZFM_MISSION_TYPE_CRASH_MISSION_STATUS = "NOT_STARTED";

/*
*	ZFM_Mission_Type_Crash_Status
*
*	Simple function that returns the current state of the mission status.
*/
ZFM_Mission_Type_Crash_Status ={
	ZFM_MISSION_TYPE_CRASH_MISSION_STATUS
};
ZFM_Mission_Type_Crash_End ={};