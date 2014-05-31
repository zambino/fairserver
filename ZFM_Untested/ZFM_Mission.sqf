/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 private["_aiGroup","_playerz","_playerPos","_playerPoop","_unit"];
 
diag_log("MISSION FILE INIT");
 

/*
*	ZFM_Includes_Mission_Config
*	
*	Contains the configuration for units and the general runtime configuration of ZFM missions.
*/ 
ZFM_Includes_Mission_Config = "\z\addons\dayz_server\ZFM\Config\ZFM_Mission_Config.sqf";
call compile preprocessFileLineNumbers ZFM_Includes_Mission_Config;


/*
*	ZFM_Includes_Mission_Functions
*	
*	Contains functions for generating and supporting missions
*/
ZFM_Includes_Mission_Functions = "\z\addons\dayz_server\ZFM\ZFM_Mission_Functions.sqf";
call compile preprocessFileLineNumbers ZFM_Includes_Mission_Functions;

/*
*	ZFM_Includes_Mission_Functions
*	
*	Contains functions for handling currently running missions
*/
ZFM_Includes_Mission_Handler = "\z\addons\dayz_server\ZFM\ZFM_Mission_Handler.sqf";
call compile preprocessFileLineNumbers ZFM_Includes_Mission_Handler;
/*
*	ZFM_Includes_Mission_Functions
*	
*	Contains functions for handling loot
*/
ZFM_Includes_Loot_Functions = "\z\addons\dayz_server\ZFM\ZFM_LootHandler.sqf";
call compile preprocessFileLineNumbers ZFM_Includes_Loot_Functions;

diag_log("COMPILES CALLED INIT");



ZFM_Handle_MissionUnitKilled ={
	private ["_unit","_killer","_missionID","_remainingUnits","_unitType","_deathText"];
	
	_unit = _this select 0;
	_killer = _this select 1;
	
	_outputText = "";
	
	if(typeName _unit == "OBJECT") then
	{
		_missionID = _unit getVariable["ZFM_MISSION_ID",[]];
		
		if(typeName _missionID != "ARRAY") then
		{
			_unitType = _unit getVariable["ZFM_UnitType",[]];
			
			if(typeName _unitType != "ARRAY") then
			{

				_deathText = ZFM_DeathPhrases call BIS_fnc_selectRandom;
	
				// Per-unit-killed humanity.
				if(ZFM_HUMANITY_FOR_BANDIT_KILLS) then
				{
					[_killer] call ZFM_Alter_Humanity;
				};
				
				[nil,nil,rTitleText,format["That bandit %1! Killed by %2",_deathText,(name _killer)],"PLAIN",30] call RE;
			};
		
			
		};
	};
};

/*
	ZFM_ExecuteCrashMission
	
	Executes a "crash mission"
*/
ZFM_ExecuteCrashMission ={
	private ["_missionGenArray","_difficulty","_accoutrements","_title","_x","_missionID","_lootContents","_thisLootCrate","_lootItemPos","_isProbabilityBased","_crashVehicle","_unitsToSpawn","_vehiclesToSpawn","_unitSupportWeaponry","_numberLootCrates","_lootCrateMode","_scatterItems","_actCrashVehicle","_crashPos","_offsetGroupPosition","_actCrashGroup"];
	_missionGenArray = _this select 0;
	
	_lootContents = ZFS_FixedLoot_Types call BIS_fnc_selectRandom;
	
	_canCreateMission = [ZFM_MISSION_TYPE_CRASH] call ZFM_CanAddNewMission;
	diag_log(format["CANCREATEMISSION %1",_canCreateMission]);
	
	
	if(!_canCreateMission) exitWith { diag_log(format["%1 %2 - ZFM_ExecuteCrashMission - Too many missions running, exiting..",ZFM_NAME,ZFM_VERSION])};

	if(typeName _missionGenArray == "ARRAY") then
	{
		_difficulty = _missionGenArray select 0;
		_title = _missionGenArray select 1;
		_crashVehicle = _missionGenArray select 2 select 0;
		_unitsToSpawn = _missionGenArray select 3;
		_vehiclesToSpawn = _missionGenArray select 4; // Not yet being supported
		_unitSupportWeaponry = _missionGenArray select 5; // Not yet being supported
		_numberLootCrates = _missionGenArray select 6;
		_lootCrateMode = _missionGenArray select 7;
		_scatterItems = _missionGenArray select 8;
	
		// Add to the mission array.. [TODO]
	
		diag_log(format["MISSIONGENARRAY %1",_missionGenArray]);
		diag_log(format["NUMBERLOOTCRATES %1",_numberLootCrates]);
	
		// Now we've got the crash vehicle
		_actCrashVehicle = [_crashVehicle,_difficulty,format["Crashed %1",_crashVehicle]] call ZFM_CreateCrashVehicle;
		
		// Get the crashPos
		_crashPos = _actCrashVehicle select 2;
		_lootItemPos = [_crashPos,(round random 3),(round random 3)] call ZFM_Create_OffsetPosition;
		// Spawn the loot items
		
		_isProbabilityBased = false;
		
		if(_lootCrateMode != ZFS_Loot_Type_Fixed) then
		{
			_isProbabilityBased = true;
		};
		
		diag_log(format["%1",_missionGenArray]);
		
		// Loop the number of loot crates
		for [{_x =0},{_x <= _numberLootCrates},{_x = _x +1} ] do
		{
			if(_isProbabilityBased) then
			{
				_lootContents = ZFS_LootTable_Types call BIS_fnc_selectRandom;
			};
			
			diag_log(format["PROBABILITYBASED %1",_isProbabilityBased]);

			// Randomise the distance from the crash to make it a little bit more believable. Not too far, though.. :)
			// LootCrates spawning within re-generated wrecks #1  - FIX (further offset)
			_lootItemPos = [_crashPos,(round random 3)+6,(round random 3)] call ZFM_Create_OffsetPosition;
			
			diag_log(format["THISLOOTCRATE %1, %2,%3,%4",_lootItemPos,_difficulty,_lootContents,_isProbabilityBased]);
			
			// Generate nice little stuff around the place to make it look like they at least made an effort.
			_accoutrements = [_crashPos,_difficulty] call ZFM_CreateCrash_Accoutrements;
			
			// Create the crate, of course..
			_thisLootCrate = [_lootItemPos,_difficulty,_lootContents,_isProbabilityBased] call ZFM_Create_LootCrate;
			
			// Add it to the current loot crate.
			ZFM_CURRENT_LOOT_CRATES set [(count ZFM_CURRENT_LOOT_CRATES+1),_thisLootCrate];
		};
	
		// TODO: Spawn vehicles before, so they don't crush the AI or what have you.. ;-)
		// Offset the position as at times, the AI can end up slightly dead from wreckage
		_offsetGroupPosition = [_crashPos,5,5] call ZFM_Create_OffsetPosition;
		
		// Create a group of units based on the missionGenArray
		_actCrashGroup = [_unitsToSpawn,_difficulty,east,_offsetGroupPosition,_missionID] call ZFM_CreateUnitGroup;
		
		diag_log(format["ACT CRASH GROUP %1",_actCrashGroup]);
		
		// DEBUGGING
		diag_log(format["MISSION ARRAY %1",ZFM_MISSIONS]);
		
		// Use remote execution to do the mission information
		[nil,nil,rTitleText,format["%1 [Difficulty: %2]",_title,_difficulty],"PLAIN",30] call RE;
		
		// 0 = units created. 1 = accoutrements created, 2 = crash marker
		[(_actCrashGroup select 1),_accoutrements,(_actCrashVehicle select 1)]
		
	};
	
};

ZFM_GenerateRandomUnits ={

	private ["_difficulty","_maxBound","_generatedUnits","_x","_initRandSeed","_newType"];
	_difficulty = _this select 0;

	_generatedUnits = [];
	
	switch(_difficulty) do 
	{
		case "DEADMEAT": {
			_maxBound = 20;
		};
		case "EASY": {
			_maxBound = 22;
		};
		case "MEDIUM": {
			_maxBound = 28;
		};
		case "HARD": {
			_maxBound = 30;
		};
		case "WAR_MACHINE": {
			_maxBound = 34;
		};
	};
	
	// TODO: Units like commander / gunner / etc in squads will be delayed until a later stage
	_initRandSeed = (round random _maxBound);
	
	// We don't want just ONE unit, do we? 
	if(_initRandSeed < ZFM_MINIMUM_AI_PER_MISSION) then 
	{
		_initRandSeed = ZFM_MINIMUM_AI_PER_MISSION; 
	};
	
	for [{_x =0},{_x <= _initRandSeed-1},{_x = _x +1} ] do
	{
		_newType = ZFM_AI_TYPES call BIS_fnc_selectRandom;
		_generatedUnits = _generatedUnits + [_newType];
	};
	
	_generatedUnits
	
	
};

ZFM_GenerateMissionTitle ={
	private["_missionType","_vehicleName","_difficulty","_onTheWayTo","_onTheWayToPlace","_deathType","_securedBy","_crashTextOne","_crashTextTwo"];
	
	_missionType = _this select 0;
	_vehicleName = _this select 1;
	_difficulty = _this select 2;
	
	switch(_missionType) do
	{
		case ZFM_MISSION_TYPE_CRASH: {
		
			diag_log("CRASH MISSION TYPE UYA");
		
			// ... to
			_onTheWayTo = ZFM_OnTheWayTo call BIS_fnc_selectRandom;
		
			// ... place
			_onTheWayToPlace = ZFM_OnTheWayToPlace call BIS_fnc_selectRandom;
			
			// .. how it died
			_deathType = ZFM_OnTheWayToDeath call BIS_fnc_selectRandom;
			
			// Secured by [name]
			_securedBy = ZFM_BanditGroup_Names call BIS_fnc_selectRandom;
		
			// Fixed so that the mission handling logic calls rTITLETEXT
			format["A %1 %2 %3 %4. Looks like %5 have secured the site.",_vehicleName,_onTheWayTo,_onTheWayToPlace,_deathType,_securedBy]
		};
	};

};

ZFM_GenerateMission ={
	private ["_missionMethod","_missionGenArray","_missionUnits","_missionArray","_missionTitle","_missionDifficulty","_lootMode","_missionType","_missionVariables"];
	_missionMethod = _this select 0;

	diag_log("GENERATEMISSION - NOW THE FUNCTION WAS CALLED.");
	
	// Array passed to generator function.
	_missionGenArray = [];
	
	diag_log(format["MISSION METHOD: %1",_missionMethod]);			
			
	switch(_missionMethod) do
	{
		// As of 23/05/2014 - One of two supported methods. Random means random.
		case ZFM_MISSION_METHOD_RANDOM: {
		
			// Random difficulty..
			_missionDifficulty = ZFM_DIFFICULTIES call BIS_fnc_selectRandom;
			
			// Loot type (fixed or what have you.. ? 
			_lootMode = ZFM_LOOT_MODE_TYPES call BIS_fnc_selectRandom;
			
			// As of 23/05 will always be "CRASH"
			_missionType = ZFM_MISSION_TYPES call BIS_fnc_selectRandom;
			
			// Get a random crash vehicle..
			_missionVariables = ZFM_CrashVehicles call BIS_fnc_selectRandom;
			
			// Generate a bunch of units
			_missionUnits = [_missionDifficulty] call ZFM_GenerateRandomUnits;
			
			// Lessee..
			diag_log(format["LOOTMODE: %1, TYPE %2, VARIABLES: %3, UNITS %4",_lootMode,_missionType,_missionVariables,_missionUnits]);
			
			// Create the dynamic mission title
			_missionTitle = [ZFM_MISSION_TYPE_CRASH,_missionVariables,_difficulty] call ZFM_GenerateMissionTitle;
			
			
			// Return value
			_missionGenArray = [
				_missionDifficulty,		// Difficulty
				_missionTitle,			// Title displayed to the user
				[_missionVariables],	// Mission-related variables passed (for crash, just the vehicle that will crash
				_missionUnits, 					// The units that are going to be spawned alongside the wreck 
				[], 					// The vehicles that will spawn alongside the units
				[], 					// The support weaponry that will be spawned near them
				(round random 4)+2, 	// The number of loot crates that are going to be spawned
				_lootMode,				// The mode that the loot crates will be spawned with.
				[]						// The items which will be scattered around the crash site
			];
			
			switch(_missionType) do
			{
				// Only available mission type at present
				case ZFM_MISSION_TYPE_CRASH: {
					diag_log("CRASH MISSION BEING GENERATED");
					_missionArray = [_missionGenArray] call ZFM_ExecuteCrashMission;
					_missionGenArray set[9,_missionArray select 0];
					_missionGenArray set[10,_missionArray select 1];
					_missionGenArray set[11,_missionArray select 2];
					
					diag_log(format["MISSION GEN ARRAY: %1",_missionGenArray]);
					
				};
			};
		};
		
		_missionGenArray
	};
	
};

// Call AI bootstrap
[] call ZFM_DoBootStrap;



/*while{true} do
{
	// TEST: Generate Mission
	[ZFM_MISSION_METHOD_RANDOM] call ZFM_GenerateMission;
	
	// do some logging.
	diag_log(format["ZFM MISSIONS %1, LOOT CRATES %2, STATUS %3, MISSION UNITS %4, COUNT MISSIONS %5",ZFM_MISSIONS,ZFM_CURRENT_LOOT_CRATES,ZFM_CURRENT_MISSION_STATUS,ZFM_CURRENT_MISSION_UNITS,(count ZFM_MISSIONS)]);
	diag_log("CREATED VEHICLE!");
	
	sleep 10000;
	
};
*/