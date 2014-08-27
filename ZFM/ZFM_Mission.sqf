/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

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
*	ZFM_Handle_JIP
*
*	Handles the Join In Progress - updates mission markers for joining players.
*/
ZFM_Mission_Handle_JIP = {
	private["_missionsCount","_row","_crashVehicle","_markerPos","_difficulty","_crash"];
	

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
				_crash = [44,"INFORMATION","ZFM_Loot::ZFM_Mission_Handle_JIP",[_crashVehicle,_markerPos,_difficulty] call ZFM_Language_Log;

				// Add the marker pos for them.
				[_markerPos,_difficulty,_crash] call ZFM_CreateCrashMarker;
			};
		};
	};
};


/*
	ZFM_Mission_CountDead
	
	Counts the number of dead units from an array
*/
ZFM_Mission_CountDead ={
	private["_unitsArray","_numberUnits","_numberDead","_thisUnit"];
	
	_unitsArray = _this select 0;
	_numberDead = 0;
	
	if(typeName _unitsArray == "ARRAY") then
	{
		if(count _unitsArray >0) then
		{
			_numberUnits = count _unitsArray;
		
			for [{_x =0},{_x <= _numberUnits-1},{_x = _x +1} ] do
			{
				// Get the unit
				_thisUnit = _unitsArray select _x;
				
				if(!(alive _thisUnit)) then
				{
					_numberDead = _numberDead + 1;
				};
			};
			
		};
	};
	_numberDead
};
 
/*
*	ZFM_Handle_MissionUnitKilled
*
*	Handles when an AI unit is killed.
*/
ZFM_Mission_Handle_MissionUnitKilled ={
	private ["_unit","_killer","_missionID","_numberActualDead","_killerWeapon","_remainingUnits","_unitType","_deathText","_missionInstance","_numUnitsTotal","_numUnitsKilled"];
	
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
			
				// A little fun, says "That bandit croaked it.." etc. 
				_deathText = ZFM_DeathPhrases call BIS_fnc_selectRandom;
	
				// Per-unit-killed humanity.
				if(ZFM_HUMANITY_FOR_BANDIT_KILLS) then
				{
					[_killer] call ZFM_Alter_Humanity;
				};
				
				// TODO: Remove after debug
				_missionInstance = [_missionID] call ZFM_Mission_GetMissionByID;
				
				// Used to see total units. This is the total units ZFM determines before they spawn. Not based on the number of alive when mission is available. 
				_numUnitsTotal = _missionInstance select 6;
				
				// Used to prevent any kill-skips. 
				_numUnitsKilled = [(_missionInstance select 5)] call ZFM_Mission_CountDead;

				// Sets the number dead based on the info from the missionArray
				[_missionID,ZFM_MISSION_VARIABLE_MISSION_UNITS_KILLED,_numUnitsKilled] call ZFM_Mission_Set;
				
				// Set who killed what, with what. (person's current weapon is determined by ZFM_Mission_Set!
				[_missionID,ZFM_MISSION_VARIABLE_MISSION_PARTICIPANT_KILLS,[_unit,_killer]] call ZFM_Mission_Set;
				
				if(_numUnitsKilled < _numUnitsTotal) then
				{
					[nil,nil,rTitleText,format["That bandit %1! Killed by %2 [%3 / %4]",_deathText,(name _killer),_numUnitsKilled,_numUnitsTotal],"PLAIN",30] call RE;
				}
				else
				{
					diag_log(format["MISSIONID AS PASSED TO CONCLUDE CONCLUDE CONCLUDE %1",_missionID]);
					
					// Conclude the mission!
					[_missionID] call ZFM_Mission_Conclude_Mission;
					
					// All units are killed..
					[nil,nil,rTitleText,format["All units were killed! [%1 / %2]",_numUnitsKilled,_numUnitsTotal],"PLAIN",30] call RE;
				}
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

/*
*	ZFM_Mission_Can_Add
*
*	Determines whether a new mission can be added to the stack.
*/
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
*	ZFM_Mission_Add
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
*	ZFM_Mission_GetMissionByID
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
*	ZFM_Mission_Set
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
	_missionArray = [ZFM_MISSION_METHOD_RANDOM,_missionID] call ZFM_Mission_GenerateMission; // Return MissionArray
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
		
		if(!ZFM_MISSIONS_START_MISSIONS_WHILE_SERVER_EMPTY && (count playableUnits) ==0) then
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
*	ZFM_GenerateMission
*
*	Generates a mission. This is intended to support manually-defined and random mission types.
*/
ZFM_Mission_GenerateMission ={
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
