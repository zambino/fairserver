/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
diag_log(format["%1 %2 - ZFM_Mission.sqf - File loaded",ZFM_NAME,ZFM_VERSION]);

ZFM_MISSION_VARIABLE_MISSION_TYPE = "6x101011";
ZFM_MISSION_VARIABLE_MISSION_TITLE = "6x101012";
ZFM_MISSION_VARIABLE_MISSION_HUMANITY_TYPE = "6x101013";
ZFM_MISSION_VARIABLE_MISSION_LOOTSHARE_TYPE = "6x101014";
ZFM_MISSION_VARIABLE_MISSION_UNITS = "6x101015";
ZFM_MISSION_VARIABLE_MISSION_UNITS_TOTAL = "6x101016";
ZFM_MISSION_VARIABLE_MISSION_UNITS_KILLED = "6x101017";
ZFM_MISSION_VARIABLE_MISSION_OBJECTS = "6x101018";
ZFM_MISSION_VARIABLE_MISSION_PARTICIPANTS = "6x101019";
ZFM_MISSION_VARIABLE_MISSION_PARTICIPANT_KILLS = "6x101020";
ZFM_MISSION_VARIABLE_MISSION_MARKERS = "6x101021";

ZFM_MISSION_START_TYPE_TIMED_RANDOM = "7x101010";

// Mission statuses
ZFM_MISSION_STATUS_IN_PROGRESS = "6x201010";
ZFM_MISSION_STATUS_COMPLETED = "6x201011";
ZFM_MISSION_STATUS_TIMED_OUT = "6x201012";

/*
	ZFM_CURRENT_MISSIONS
	
	The main array that contains currently-active missions. Once a mission ends, it's thrown into:
	ZFM_COMPLETED_MISSIONS
	
*/
ZFM_CURRENT_MISSIONS =[];

/*
	ZFM_COMPLETED_MISSIONS
	
	The array which contains completed missions. I would recommend that if you have a lot of missions
	make sure that you restart your server often, and toggle the amount of missions based on the 
	restart frequency
	
*/
ZFM_COMPLETED_MISSIONS=[];

/*
*	Cached last version of the playableUnits
*/
ZFM_CONNECTED_PLAYERS =[];

/*
	ZFM_CAN_CREATE_NEW_MISSION
	
	Used to tell the main loop to stop if there are the max number of missions running
*/
ZFM_CAN_CREATE_NEW_MISSION = true;

/*
	ZFM_MISSIONS_MISSION_HANDLER_STARTED
	
	Used to check if the mission handler has started. 
*/
ZFM_MISSIONS_MISSION_HANDLER_STARTED = false;

/*
	TODO: Move to global config file..
*/
ZFM_MISSIONS_START_MISSIONS_WHILE_SERVER_EMPTY = false;
ZFM_MISSIONS_MAXIMUM_CONCURRENT_MISSIONS = 3;
ZFM_MISSIONS_MAXIMUM_CONCURRENT_MISSIONS_CRASH = 3;
ZFM_MISSIONS_DEFAULT_MISSION_START_TYPE = ZFM_MISSION_START_TYPE_TIMED_RANDOM;
ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MIN = 15; // Minutes
ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MAX = 45; // Minutes (Means randomly, missions will fire between 15 and 45 minutes)

// Set to NL.
ZFM_DEFAULT_LANGUAGE = "EN";


/*
*	ZFM_Handle_JIP
*
*	Handles the Join In Progress - updates mission markers for joining players.
*/
ZFM_Handle_JIP = {

	if(count ZFM_CURRENT_MISSIONS != 0) then
	{
		// Find out how many missions there are
		_missionsCount = count ZFM_CURRENT_MISSIONS;

		for [{_x =0},{_x <= _missionsCount},{_x = _x +1} ] do
		{
			// Get the row..
			_row = ZFM_CURRENT_MISSIONS select _x;
		
			// Check it's not an empty mission row..
			if(count _row >0) then 
			{
				_crashVehicle = _row select 12;
				_markerPos = _row select 13;
				_difficulty = _row select 14;
				
				diag_log(format["JIP MARKERS %1 AND %2 AND %3",_crashVehicle,_markerPos,_difficulty]);
				
				// Add the marker pos for them.
				[_markerPos,_difficulty,format["Crashed %1",_crashVehicle]] call ZFM_CreateCrashMarker;
			};
		};
	};
};

ZFM_Mission_Conclude_Mission ={
	private["_missionID","_missionArray","_markers","_objects"];
	_missionID = _this select 0;
	
	_missionArray = [_missionID] call ZFM_Mission_GetMissionByID;
	
	diag_log(format["Mission CONCLUDE CALLED %1, MISSIONID %2",_missionArray,_missionID]);
	
	if(typeName _missionArray == "ARRAY") then
	{
		diag_log(format["Mission CONCLUDE MISSIONARRAY %1",_missionArray]);
		
		if(count _missionArray >0) then
		{
			_objects = _missionArray select 8;
			_markers = _missionArray select 10;

			// Remove the mission marker!
			[_markers] call ZFM_Mission_Remove_Mission_Marker;
		};
	};
};

/*

*/

ZFM_Mission_Remove_Mission_Objects = {
	private ["_missionObjects"];
	
	_missionObjects = _this select 0;
	
	diag_log(format["ZFM_MISSION_REMOVE_MISSION_OBJECTS params %1",_this]);
	
	if(typeName _missionObjects == "ARRAY") then
	{
		diag_log(format["ZFM_MISSION_REMOVE_MISSION_OBJECTS COUNT COUNT COUNT %1",count _missionObjects]);
	
		if(count _missionObjects > 0) then
		{
				{
					diag_log(format["OBJECT %1",_x]);
					// Is it an actual object?
					if(typeName _x == "OBJECT") then
					{
						deleteVehicle _x; // Get rid of it.
					};
				} forEach _missionObjects;
		};	
	};
	
};

/*
*	ZFM_Mission_Remove_Mission_Marker
*
*	Removes the mission marker from the mission stack.
*/
ZFM_Mission_Remove_Mission_Marker ={
	private["_missionID","_missionArray","_missionMarkers","_missionMarkerOne","_missionMarkerTwo"];
	
	_missionMarkers = _this select 0;
	
	diag_log(format["ZFM_MISSION_REMOVE_MISSION_MARKER params %1",_this]);

		if(typeName _missionMarkers == "ARRAY") then
		{
			diag_log(format["ZFM_MISSION_REMOVE_MISSION_MARKER MARKERS %1",_missionMarkers]);
		
			_missionMarkerOne = _missionMarkers select 0;
			_missionMarkerTwo = _missionMarkers select 1;
			
			deleteMarker _missionMarkerOne;
			deleteMarker _missionMarkerTwo;
		};	
};

/*
*	ZFM_MissionArray_Free
*
*	Clears objects listed within a missionArray from the server.
*/
ZFM_Mission_Free ={
	private ["_missionID","_mission","_objects","_units","_numObjects","_numUnits","_x"];
	
	_missionID = _this select 0;
	_mission = [_missionID] call ZFM_MissionArray_GetMissionByID;
	
	if(!_mission || !typeName _mission == "ARRAY") exitWith{};
	
	_objects = _mission select 8;
	_units = _mission select 5;
	
	if(count _objects || count _units) then
	{
		{
			if(typeName _x == "OBJECT") then
			{
				deleteVehicle _x
			};
		} forEach _objects;
	};

};

ZFM_Mission_Can_Add = {
	private["_currentMissions"];
	
	_currentMissions = count ZFM_CURRENT_MISSIONS;

	if(_currentMissions < ZFM_MISSIONS_MAXIMUM_CONCURRENT_MISSIONS) then
	{
		ZFM_CAN_CREATE_NEW_MISSION = true;
	}	
	else
	{
		ZFM_CAN_CREATE_NEW_MISSION = false;
	};
	
	ZFM_CAN_CREATE_NEW_MISSION
	
};

/*
*	ZFM_MissionArray_AddMissionArray
*
*	Adds a pre-generated mission array to ZFM_CURRENT_MISSIONS.
*/
ZFM_Mission_Add ={
	private ["_missionArray","_missionType","_thisOffset"];
	
	_missionArray = _this select 0;
	
	diag_log(format["ZFM_MISSION_ADD NULL CHECK %1",_this]);
	
	if(typeName ZFM_CURRENT_MISSIONS == "ARRAY" && typeName _missionArray == "ARRAY") then
	{
		// Get the mission type
		_missionType = _missionArray select 1;
		_canAdd = [] call ZFM_Mission_Can_Add;
		
		diag_log(format["ZFM_MISSION_ADD NULL CHECK - CAN ADD %1, MISSION TYPE",_canAdd,_missionType]);
		
		if(_canAdd) then
		{
			diag_log(format["ZFM_CURRENT_MISSIONS - %1 AND %2",ZFM_CURRENT_MISSIONS,count ZFM_CURRENT_MISSIONS]);
			
		
			// Todo: Count by mission type
			ZFM_CURRENT_MISSIONS set[(count ZFM_CURRENT_MISSIONS),[(count ZFM_CURRENT_MISSIONS)] + _missionArray]
		};
	};
	
};

/*
*	ZFM_MissionArray_RemoveMissionArray
*
*	Removes a missionArray from  ZFM_CURRENT_MISSIONS.
*/
ZFM_Mission_Remove ={
	private ["_missionID"];

	if(typeName ZFM_CURRENT_MISSIONS == "ARRAY") then
	{
		ZFM_CURRENT_MISSIONS set[_missionID,[]];
	};
};

/*
*	ZFM_Mission_VerifyID
*
*	Verifies an ID can exist. THIS WILL BE REPLACED WITH FUNCTIONS FROM ZCR.
*/
ZFM_Mission_VerifyID={
	private ["_missionID","_isMission"];
	
	_missionID = _this select 0;
	_isMission = false;
	
	if(_missionID <= (count ZFM_CURRENT_MISSIONS)) then
	{
		_isMission = true;
	};
	
	_isMission
	
};

/*
*	ZFM_MissionArray_GetMissionByID	
*
*	Gets a mission array from ZFM_CURRENT_MISSIONS by Mission ID.
*/
ZFM_Mission_GetMissionByID ={
	private["_missionID","_missionsCount","_returnMission"];
	
	_missionID = _this select 0;
	_returnMission = false;
	
	if(typeName ZFM_CURRENT_MISSIONS =="ARRAY") then
	{
		_missionsCount = count ZFM_CURRENT_MISSIONS;
		
		diag_log(format["GETMISSIONBYID COUNT %1, MISSIONID %2",_missionsCount,_missionID]);
		
		if(_missionID <= _missionsCount) then
		{
			_returnMission = ZFM_CURRENT_MISSIONS select _missionID;
		};
	};
	
	diag_log(format["%1",_returnMission]);
	
	
	_returnMission
};

/*
*	ZFM_MissionArray_SetMission_Variables
*
*	Adds mission variables to a specific MissionArray. This is used to keep status updates of missions.
*
*	Example:
*	
*	// This will set a mission variable for a mission of missionID _myMissionID
*	[_myMissionID,ZFM_MISSION_VARIABLE_MISSION_TYPE,ZFM_MISSION_TYPE_CRASH] call ZFM_MissionArray_SetMission_Variables;

*/
ZFM_Mission_Set ={
	private["_missionID","_missionVariableType","_missionVariable","_missionArray","_killers","_killerWeapon","_currentUnits"];
	
	_missionID = _this select 0;
	_missionVariableType = _this select 1;
	_missionVariable = _this select 2;
	
	diag_log(format["_missionVariableType %1, _missionVariable %2,_missionVariableType %3",_missionVariableType,_missionVariable,_missionVariableType]);
	
	_missionArray = [_missionID] call ZFM_Mission_GetMissionByID;
	
	diag_log(format["BEGINNING MISSIONARRAY %1, MISSION ID %2",_missionArray,_missionID]);
	
	switch(_missionVariableType) do
	{
		default {
			diag_log("Something wrong with the cases");
		};
	
		case ZFM_MISSION_VARIABLE_MISSION_TYPE: {
			diag_log("Mission type fired");
			_missionArray set[1,_missionVariable];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_TITLE: {
			diag_log("Mission title fired");
			_missionArray set[2,_missionVariable];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_HUMANITY_TYPE: {
			diag_log("Humanity type fired");
			_missionArray set[3,_missionVariable];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_LOOTSHARE_TYPE: {
			diag_log("Loot share type fired");
			_missionArray set[4,_missionVariable];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_UNITS: {
			diag_log("Units fired");
			_currentUnits = _missionArray select 5;
			_missionArray set [5,_currentUnits];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_UNITS_TOTAL: {
			diag_log("Units fired");
			_missionArray set[6,_missionVariable];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_UNITS_KILLED: {
			diag_log("Units killed fired");
			_missionArray set[7,(_missionArray select 7) +1];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_OBJECTS: {
			diag_log("Mission objects fired");
			diag_log(format["CURRENTOBJECTS %1",_missionArray]);
			_currentObjects = _missionArray select 8;
		
			if(typeName _missionVariable != "ARRAY") then
			{
				_currentObjects = _currentObjects + _missionVariable;				
			}
			else
			{
				_currentObjects = _currentObjects + [_missionVariable];
			};
			
			_missionArray set [8,_currentObjects];
			diag_log(format["CURRENTOBJECTS UPDATED %1, %2",_missionArray,_missionID]);
			
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};	
		case ZFM_MISSION_VARIABLE_MISSION_PARTICIPANTS: {
			diag_log("Participants fired");
			_missionArray set[9,(_missionArray select 9)+[_missionVariable]];
			ZFM_CURRENT_MISSIONS set[_missionID,_missionArray];
		};		
		case ZFM_MISSION_VARIABLE_MISSION_PARTICIPANT_KILLS: {
			_unit = _missionVariable select 0;
			_killer = _missionVariable select 1;
			_missionArray set[10,(_missionArray select 10)+[_unit,_killer,currentWeapon _killer]];
			ZFM_CURRENT_MISSIONS set[_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_MARKERS: {
			diag_log("MISSION MARKERS");
			_missionArray set[11,_missionVariable];
			ZFM_CURRENT_MISSIONS set[_missionID,_missionArray];
		};	
		
	};
};

/*
	ZFM_Mission_Generate_New
	
	Houses the mission generation function (puts ll the ZFM_Mission elements into play.
	At the moment, just a wrapper function for ZFM_GenerateMission..
*/
ZFM_Mission_Generate_New ={
	private["_missionArray","_title","_units","_unitsTotal","_newMission"];
	_missionID = _this select 0;

	// Crash mission should pass to generateMission, then 
	_missionArray = [ZFM_MISSION_METHOD_RANDOM,_missionID] call ZFM_GenerateMission; // Return MissionArray
	diag_log(format["MISSION ARRAY FROM GENERATEMISSION %1",_missionArray]);
	[_missionArray] call ZFM_Mission_Add;
	
	diag_log(format["MISSION ARRAY FROM STACK %1",ZFM_CURRENT_MISSIONS]);	
};

/*
*	ZFM_Mission_Handler_Start
*
*	Starts the mission loop and mission handler
*/
ZFM_Mission_Handler_Start ={
	private ["_continueExecution"];

	diag_log("MISSION HANDLER STARTED");
	
	if(ZFM_MISSIONS_MAXIMUM_CONCURRENT_MISSIONS == 0) exitWith {diag_log(format["%1 %2 - Maximum concurrent missions is set to 0. You do want missions, right?",ZFM_NAME,ZFM_VERSION])};
	if((count ZFM_CURRENT_MISSIONS) >0 || ZFM_MISSIONS_MISSION_HANDLER_STARTED) exitWith {diag_log(format["%1 %2 - Mission handler is already running. Exiting..",ZFM_NAME,ZFM_VERSION])};

	diag_log("MISSION HANDLER PASSED CHECK");
	
	_continueExecution = true;
	
	while{_continueExecution} do
	{
		diag_log("MISSION HANDLER LOOP STARTED");
		
		diag_log(format["COUNT PLAYABLE UNITS",(count playableUnits)]);
		
		if(ZFM_MISSIONS_START_MISSIONS_WHILE_SERVER_EMPTY && (count playableUnits) ==0) then
		{
			diag_log(format["%1 %2 - Nobody is on the server and ZFM_MISSIONS_START_WHILE_SERVER_EMPTY is set to TRUE. Waiting until a player joins.",ZFM_NAME,ZFM_VERSION]);
			waitUntil{(count playableUnits) != 0};
		};

		diag_log(format["START TYPE %1,RANDOM %2",ZFM_MISSIONS_DEFAULT_MISSION_START_TYPE,ZFM_MISSION_START_TYPE_TIMED_RANDOM]);
		
		if(ZFM_MISSIONS_DEFAULT_MISSION_START_TYPE == ZFM_MISSION_START_TYPE_TIMED_RANDOM) then
		{
			diag_log("TIMED RANDOM FIRED");
		
			// sets and gets the ZFM_CAN_CREATE_NEW_MISSION variable
			_canAdd = [] call ZFM_Mission_Can_Add;
			
			diag_log(format["CAN ADD %1",_canAdd]);
			
			// If we can't, then wait!
			if(!_canAdd) then
			{
				diag_log(format["WAITING UNTIL %1",_canAdd]);
				waitUntil{ZFM_CAN_CREATE_NEW_MISSION};
			};
			
			diag_log(format["BEFORE ARRAY %1",ZFM_CURRENT_MISSIONS]);
			
			// calls to start a new mission..
			[(count ZFM_CURRENT_MISSIONS)] call ZFM_Mission_Generate_New;
			
			diag_log(format["AFTER ARRAY %1",ZFM_CURRENT_MISSIONS]);
			
			// Get the random amount based on max-min
			_minutesRandSeed = (ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MAX-ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MIN);
			
			// Get the rounded amount 
			_minutesToWait = (ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MIN + (round random _minutesRandSeed))*60;
			
			diag_log(format["WAITING %1 SECONDS",_minutesToWait]);
			
			// Sleep for the specified interval in minutes
			sleep (_minutesToWait);
			
		};
		
	};
};

/*
	ZFM_ExecuteCrashMission
	
	Executes a "crash mission
	TODO: Needs to return a complete mission array for being inserted into the stack
*/
ZFM_ExecuteCrashMission ={
	private ["_missionGenArray","_difficulty","_objects","_accoutrements","_title","_x","_lootCrates","_missionID","_lootContents","_thisLootCrate","_lootItemPos","_isProbabilityBased","_crashVehicle","_unitsToSpawn","_vehiclesToSpawn","_unitSupportWeaponry","_numberLootCrates","_lootCrateMode","_scatterItems","_actCrashVehicle","_crashPos","_offsetGroupPosition","_actCrashGroup"];
	_missionGenArray = _this select 0;
	_missionID = _this select 1;
	
	_lootContents = ZFS_FixedLoot_Types call BIS_fnc_selectRandom;

	diag_log(format["%1 %2 - ZFM_Mission.sqf::ZFM_ExecuteCrashMission - Executing.",ZFM_Name,ZFM_Version]);
	
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
	
	
		if(typeName _numberLootCrates != "SCALAR") then
		{
			_numberLootCrates = 2;
		};
		
		_lootCrates = [];
	
		// Add to the mission array.. [TODO]
	
		diag_log(format["%1 %2 - ZFM_Mission.sqf::ZFM_ExecuteCrashMission - MissionGenArray %3.",ZFM_Name,ZFM_Version,_missionGenArray]);
		diag_log(format["%1 %2 - ZFM_Mission.sqf::ZFM_ExecuteCrashMission - MissionGenArray %3.",ZFM_Name,ZFM_Version,_missionGenArray]);
		diag_log(format["%1 %2 - ZFM_Mission.sqf::ZFM_ExecuteCrashMission - NumberLootCrates %3.",ZFM_Name,ZFM_Version,_numberLootCrates]);

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
		
		// TODO: Replace with matrix-based method
		_accoutrements = [_crashPos,_difficulty] call ZFM_CreateCrash_Accoutrements;
		
		// Loop the number of loot crates
		for [{_x =0},{_x <= _numberLootCrates},{_x = _x +1} ] do
		{
			_lootContents = ZFS_LootTable_Types call BIS_fnc_selectRandom;
			
			diag_log(format["%1 %2 - ZFM_Mission.sqf::ZFM_ExecuteCrashMission - ProbabilityBased %3.",ZFM_Name,ZFM_Version,_isProbabilityBased]);
	
			// Randomise the distance from the crash to make it a little bit more believable. Not too far, though.. :)
			// LootCrates spawning within re-generated wrecks #1  - FIX (further offset)
			_lootItemPos = [_crashPos,(round random 3)+6,(round random 3)] call ZFM_Create_OffsetPosition;
			
			diag_log(format["THISLOOTCRATE %1, %2,%3,%4",_lootItemPos,_difficulty,_lootContents,_isProbabilityBased]);
			
			// Create the crate, of course..
			_thisLootCrate = [_lootItemPos,_difficulty,_lootContents,_isProbabilityBased] call ZFM_Create_LootCrate;
			
			_lootCrates = _lootCrates + [_thisLootCrate];
			
			diag_log(format["THISLOOTCRATEITEM %1",_thisLootCrate]);
			
		};
	
		// TODO: Spawn vehicles before, so they don't crush the AI or what have you.. ;-)
		// Offset the position as at times, the AI can end up slightly dead from wreckage
		_offsetGroupPosition = [_crashPos,5,5] call ZFM_Create_OffsetPosition;
		
		// Create a group of units based on the missionGenArray
		_actCrashGroup = [_unitsToSpawn,_difficulty,east,_offsetGroupPosition,_missionID] call ZFM_CreateUnitGroup;
		
		// Use remote execution to do the mission information
		// TODO: Set timeout time down a bit
		[nil,nil,rTitleText,format["%1 [Difficulty: %2]",_title,_difficulty],"PLAIN",60] call RE;
		
		
		/*
			*	0 = Mission ID 
			*	1 = Mission type
			*	2 = Mission title
			*	3 = Humanity type - (Per unit kill or shared amount)
			*	4 = LootShare type - (Spawn with crash or spawn per person)
			*	5 = Units - An array containing the objects for the units.
			*	6 = Units total - An integer containing the total number of units
			*	7 = Units killed = An integer containing the total number of units killed
			*	8 = Mission objects = An array containing objects for the mission, which are removed after the mission ends to preserve performance.
			*	9 = Mission participants = An array containing just the names of the people participating in the mission
			*	10 = Participants->Kills = An array containing the names of the people who have killed AI, and how many they killed.
			*	11 = Markers = Contains the markers for the mission
			*	12 = CrashVehicle Type
			*	13 = Crash location
			*	14 = Difficulty
			*   15 = Status
		*/
			
		_objects = _lootCrates + _accoutrements;
		
		// Return the missionArray excluding ID, which appended by the handler..
		[ZFM_MISSION_TYPE_CRASH,_title,"NOT_IMPLEMENTED","NOT_IMPLEMENTED",(_actCrashGroup select 1),(count (_actCrashGroup select 1)),0,_objects,[],(_actCrashVehicle select 1),(_actCrashVehicle select 2),_crashVehicle,_crashPos,_difficulty]
	};
	
};

/*
*	ZFM_GenerateRandomUnits
*
*	Generates an array of ZFM-typed random units.
*/
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

/*
*	ZFM_GenerateMissionTitle
*
*	Generates a Mission Title 
*/
ZFM_GenerateMissionTitle ={
	private["_missionType","_vehicleName","_difficulty","_onTheWayTo","_onTheWayToPlace","_deathType","_securedBy","_crashText"];
	
	_missionType = _this select 0;
	_vehicleName = _this select 1;
	_difficulty = _this select 2;
	
	switch(_missionType) do
	{
		case ZFM_MISSION_TYPE_CRASH: {
			
			
			switch(ZFM_DEFAULT_LANGUAGE) do
			{
				case "EN" : {
					// ... to
					_onTheWayTo = ZFM_OnTheWayTo call BIS_fnc_selectRandom;
				
					// ... place
					_onTheWayToPlace = ZFM_OnTheWayToPlace call BIS_fnc_selectRandom;
					
					// .. how it died
					_deathType = ZFM_OnTheWayToDeath call BIS_fnc_selectRandom;
					
					// Secured by [name]
					_securedBy = ZFM_BanditGroup_Names call BIS_fnc_selectRandom;
				
					// Fixed so that the mission handling logic calls rTITLETEXT
					_crashText = format["A %1 %2 %3 %4. Looks like %5 have secured the site.",_vehicleName,_onTheWayTo,_onTheWayToPlace,_deathType,_securedBy];
											
				};
				case "NL" : {
					// ... naar
					_onTheWayTo = ZFM_OnTheWayTo_NL call BIS_fnc_selectRandom;
				
					// ... waar?
					_onTheWayToPlace = ZFM_OnTheWayToPlace call BIS_fnc_selectRandom;
					
					// .. hoe?
					_deathType = ZFM_OnTheWayToDeath_NL call BIS_fnc_selectRandom;
					
					// Secured by [name]
					_securedBy = ZFM_BanditGroup_Names_NL call BIS_fnc_selectRandom;
				
					// Fixed so that the mission handling logic calls rTITLETEXT
					_crashText = format["Een %1 %2 %3 %4. %5 hebben der site aangegrepen.",_vehicleName,_onTheWayTo,_onTheWayToPlace,_deathType,_securedBy];
				};
				
			};
			
		};
	};

	_crashText
	
	
};

/*
*	ZFM_GenerateMission
*
*	Generates a mission. This is intended to support manually-defined and random mission types.
*/
ZFM_GenerateMission ={
	private ["_missionMethod","_missionGenArray","_missionUnits","_missionArray","_missionTitle","_missionDifficulty","_lootMode","_missionType","_missionVariables"];
	_missionMethod = _this select 0;
	_missionID = _this select 1;
	
	diag_log(format["%1 %2 - ZFM_Mission.sqf::ZFM_GenerateMission - Executed. Mission method %1",ZFM_Name,ZFM_Version,_missionMethod]);

	// Array passed to generator function.
	_missionGenArray = [];
			
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
					_missionGenArray = [_missionGenArray,_missionID] call ZFM_ExecuteCrashMission;
				};
			};
		};
	};
	
	_missionGenArray
};