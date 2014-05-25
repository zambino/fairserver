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
 
 // Get the config stuff..
ZFM_Includes_Mission_Config = "\z\addons\dayz_server\ZFM\Config\ZFM_Mission_Config.sqf";
ZFM_Includes_Mission_Functions = "\z\addons\dayz_server\ZFM\ZFM_Mission_Functions.sqf";
ZFM_Includes_Loot_Functions = "\z\addons\dayz_server\ZFM\ZFM_LootHandler.sqf";

// We need to get access to these functions..
call compile preprocessFileLineNumbers ZFM_Includes_Mission_Config;
call compile preprocessFileLineNumbers ZFM_Includes_Mission_Functions;
call compile preprocessFileLineNumbers ZFM_Includes_Loot_Functions;

diag_log("COMPILES CALLED INIT");

/*
	ZFM Mission-In-Progress variables
*/
ZFM_MISSIONS = [];
ZFM_HAS_COMPLETED_MISSION = false;
ZFM_CURRENT_LOOT_CRATES =[];
ZFM_CURRENT_MISSION_STATUS =[];
ZFM_CURRENT_MISSION_UNITS=[];


diag_log("MISSION FILES CALLED INIT");

/*
	ZFM_CanAddNewMission
	
	Check to see if there are too many missions of a certain type
*/
ZFM_CanAddNewMission ={
	private["_missionType","_canAddNewMission","_numExistingMissions","_row"];
	_missionType = _this select 0;

	// Let's assume we're miserable pessimists
	_canAddNewMission = false;
	
	if(typeName ZFM_MISSIONS == "ARRAY") then
	{
		// Find out how many existing missions there are.
		_numExistingMissions = count ZFM_MISSIONS;
		
		// Are we at the maximum?
		if(_numExistingMissions <= ZFM_MAXIMUM_MISSIONS) then
		{
			// Horrible, and I know -- it's hacky, but I can't think how we can more easily store this. Global array? Bah.
			_numCrashMissions = 0;
		
			if(_numExistingMissions > 0) then
			{
				diag_log(format["ZFM_CanAddNewMission - NUMEXISTINGMISSIONS %1",_numExistingMissions]);
			
				// Make sure we've got missions as an array still. 
				for [{_x =0},{_x <= _numberExistingMissions-1},{_x = _x +1} ] do
				{
					_row = ZFM_MISSIONS select _x;
					
					diag_log(format["ZFM_CanAddNewMission - MISSION ROW %1",_numCrashMissions]);
					
					if(typeName _row == "ARRAY") then
					{
						_missionType = _row select 0;
						_missionTitle = _row select 1;
						
						switch(_missionType) do
						{
							case ZFM_MISSION_TYPE_CRASH: {
								_numCrashMissions = _numCrashMissions +1;
							};
						};
					};
				};
			};
			diag_log(format["ZFM_CanAddNewMission - NUMCRASHMISSIONS %1",_numCrashMissions]);
			
			// Loop has gotten us how many different types of missions we have
			switch(_missionType) do
			{
				case ZFM_MISSION_TYPE_CRASH: {
					
					if((_numCrashMissions) <= ZFM_MAXIMUM_CRASH_MISSIONS) then
					{
						diag_log(format["ZFM_CanAddNewMission - MAX CRASH MISSIONS %1",ZFM_MAXIMUM_CRASH_MISSIONS]);
						_canAddNewMission = true;
					};
				};
			};
			_canAddNewMission
		};
	};

	

};

/*
	ZFM_AddNewMissionItem
	
	Adds a Mission Item to the stack of missions.
*/
ZFM_AddNewMissionItem ={
	private ["_missionType","_missionTitle","_params","_missionID"];
	
	_missionType = _this select 0;
	_missionTitle = _this select 1;
	
	if(typeName ZFM_MISSIONS == "ARRAY") then
	{
		// Get the ID.
		_missionID = (count ZFM_MISSIONS)+1;
		_params = [_missionID,_missionType,_missionTitle];
		
		ZFM_MISSIONS set [_missionID,_params];
	};
};

ZFM_RemoveMissionItem ={
	private ["_missionID","_numExistingMissions"];
	
	_missionID = _this select 0;

	if(typeName ZFM_MISSIONS == "ARRAY") then
	{
		_numExistingMissions = count ZFM_MISSIONS;
		if(_numExistingMissions == 0) exitWith{};
		ZFM_MISSIONS set [_missionID,nil];
	};
};

/*
	ZFM_ExecuteCrashMission
	
	Executes a "crash mission"
*/
ZFM_ExecuteCrashMission ={
	private ["_missionGenArray","_difficulty","_title","_x","_lootContents","_thisLootCrate","_lootItemPos","_isProbabilityBased","_crashVehicle","_unitsToSpawn","_vehiclesToSpawn","_unitSupportWeaponry","_numberLootCrates","_lootCrateMode","_scatterItems","_actCrashVehicle","_crashPos","_offsetGroupPosition","_actCrashGroup"];
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
	
		diag_log(format["CRASHVEHICLE %1",_crashVehicle]);
	
		// Now we've got the crash vehicle
		_actCrashVehicle = [_crashVehicle,_difficulty,"UNUSED"] call ZFM_CreateCrashVehicle;
		
		// Get the crashPos
		_crashPos = _actCrashVehicle select 2;
		_lootItemPos = [_crashPos,(round random 3)] call ZFM_Create_OffsetPosition;
		// Spawn the loot items
		
		_isProbabilityBased = false;
		
		if(_lootCrateMode != ZFS_Loot_Type_Fixed) then
		{
			_isProbabilityBased = true;
		};
		
		diag_log(format["%1",_missionGenArray]);
		
		// Loop the number of loot crates
		for [{_x =0},{_x <= _numberLootCrates-1},{_x = _x +1} ] do
		{
		
			if(_isProbabilityBased) then
			{
				_lootContents = ZFS_LootTable_Types call BIS_fnc_selectRandom;
			};
			
			diag_log(format["PROBABILITYBASED %1",_isProbabilityBased]);
			

			// Randomise the distance from the crash to make it a little bit more believable. Not too far, though.. :)
			// LootCrates spawning within re-generated wrecks #1  - FIX (further offset)
			_lootItemPos = [_crashPos,(round random 4)+6] call ZFM_Create_OffsetPosition;
			
			diag_log(format["THISLOOTCRATE %1, %2,%3,%4",_lootItemPos,_difficulty,_lootContents,_isProbabilityBased]);
			
			// Create the crate, of course..
			_thisLootCrate = [_lootItemPos,_difficulty,_lootContents,_isProbabilityBased] call ZFM_Create_LootCrate;
			
			// Add it to the current loot crate.
			ZFM_CURRENT_LOOT_CRATES set [(count ZFM_CURRENT_LOOT_CRATES+1),_thisLootCrate];
		};
	
		// TODO: Spawn vehicles before, so they don't crush the AI or what have you.. ;-)
	
		// Offset the position as at times, the AI can end up slightly dead from wreckage
		
		_offsetGroupPosition = [_crashPos,5] call ZFM_Create_OffsetPosition;
		diag_log(format["_offsetGroupPosition %1",_offsetGroupPosition]);
		// Create a group of units based on the missionGenArray
		_actCrashGroup = [_unitsToSpawn,_difficulty,east,_offsetGroupPosition] call ZFM_CreateUnitGroup;
		
		// Add to the stack of missions.
		[ZFM_MISSION_TYPE_CRASH,_title] call ZFM_AddNewMissionItem;
	};
	
};

ZFM_GenerateRandomUnits ={

	private ["_difficulty","_maxBound","_generatedUnits","_x","_initRandSeed","_newType"];
	_difficulty = _this select 0;

	_generatedUnits = [];
	
	switch(_difficulty) do 
	{
		case "DEADMEAT": {
			_maxBound = 8;
		};
		case "EASY": {
			_maxBound = 10;
		};
		case "MEDIUM": {
			_maxBound = 15;
		};
		case "HARD": {
			_maxBound = 18;
		};
		case "WAR_MACHINE": {
			_maxBound = 20;
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
		
			// One for each line on the screen
			[nil,nil,rTitleText,format["A %1 %2 %3 %4. Looks like %5 have secured the site.",_vehicleName,_onTheWayTo,_onTheWayToPlace,_deathType,_securedBy],"PLAIN",30] call RE;
		};
	};

};

ZFM_GenerateMission ={
	private ["_missionMethod","_missionGenArray","_missionUnits","_missionTitle","_missionDifficulty","_lootMode","_missionType","_missionVariables"];
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
			
			// Create the dynamic mission title
			_missionTitle = [_missionType,_missionVariables,_missionDifficulty] call ZFM_GenerateMissionTitle;
			
			// Lessee..
			diag_log(format["LOOTMODE: %1, TYPE %2, VARIABLES: %3, UNITS %4",_lootMode,_missionType,_missionVariables,_missionUnits]);
			
			// Return value
			_missionGenArray = [
				_missionDifficulty,		// Difficulty
				_missionTitle,			// Title displayed to the user
				[_missionVariables],	// Mission-related variables passed (for crash, just the vehicle that will crash
				_missionUnits, 					// The units that are going to be spawned alongside the wreck 
				[], 					// The vehicles that will spawn alongside the units
				[], 					// The support weaponry that will be spawned near them
				(round random 3)+1, 	// The number of loot crates that are going to be spawned
				_lootMode,				// The mode that the loot crates will be spawned with.
				[]						// The items which will be scattered around the crash site
			];
			
			switch(_missionType) do
			{
				// Only available mission type at present
				case ZFM_MISSION_TYPE_CRASH: {
					diag_log("CRASH MISSION BEING GENERATED");
					[_missionGenArray] call ZFM_ExecuteCrashMission;
				};
			};
			
		};
	};
	
};

diag_log("BOOTSTRAP NOT YET CALLED INIT 8");

// Call AI bootstrap
[] call ZFM_DoBootStrap;

diag_log("BOOTSTRAP CALLED INIT");


while{true} do
{
	[ZFM_MISSION_METHOD_RANDOM] call ZFM_GenerateMission;
	diag_log("CREATED VEHICLE!");
	
	sleep 100;
	
};
