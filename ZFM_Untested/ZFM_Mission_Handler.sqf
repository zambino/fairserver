/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
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


ZFM_MISSION_START_TYPE_TIMED_RANDOM = "6x102011"; // For alpha, only supported mechanism


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

ZFM_Mission_Get_Missions_ByType ={
	private["_missionType"];
	
	// Two distinct types as we want to make sure it's an array before we count it, to stop errors.
	if(typeName ZFM_CURRENT_MISSION != "ARRAY") exitWith{};
	if(count ZFM_CURRENT_MISSION == 0) exitWith{};
	
	if(count ZFM_CURRENT_MISSION ==1) then
	{
	
	
	}
	else
	{
	
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
	private ["_missionArray","_missionType"];
	
	_missionArray = _this select 0;
	
	if(typeName ZFM_CURRENT_MISSIONS == "ARRAY" && typeName _missionArray == "ARRAY") then
	{
		// Get the mission type
		_missionType = _missionArray select 1;
		_canAdd = [] call ZFM_Mission_Can_Add;
	
		if(_canAdd) then
		{
			// Todo: Count by crash missions
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
	private["_missionID","_missionVariableType","_missionVariable","_missionArray","_currentUnits"];
	
	
	
	_missionID = _this select 0;
	_missionVariableType = _this select 1;
	_missionVariable = _this select 2;
	
	diag_log(format["_missionVariableType %1, _missionVariable %2,_missionVariableType %3",_missionVariableType,_missionVariable,_missionVariableType]);
	
	_missionArray = [_missionID] call ZFM_Mission_GetMissionByID;
	
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
			
			if(!typeName _missionVariable == "ARRAY") then
			{
				_currentUnits = _currentUnits + _missionVariable;				
			}
			else
			{
				_currentUnits = _currentUnits + [_missionVariable];
			};
			
			_missionArray set [5,_currentUnits];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_UNITS_TOTAL: {
			diag_log("Units fired");
			_missionArray set[6,(_missionArray select 6) +1];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_UNITS_KILLED: {
			diag_log("Units killed fired");
			_missionArray set[7,(_missionArray select 7) +1];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_MISSION_OBJECTS: {
			diag_log("Mission objects fired");
			_currentUnits = (ZFM_CURRENT_MISSIONS select _missionID) select 8;
		
			if(!typeName _missionVariable == "ARRAY") then
			{
				_currentObjects = _currentObjects + _missionVariable;				
			}
			else
			{
				_currentObjects = _currentObjects + [_missionVariable];
			};
			
			_missionArray set [8,_currentObjects];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};	
		case ZFM_MISSION_VARIABLE_MISSION_PARTICIPANTS: {
			diag_log("Participants fired");
			_missionArray set[9,(_missionArray select 9)+[_missionVariable]];
			ZFM_CURRENT_MISSIONS set[_missionID,_missionArray];
		};		
		case ZFM_MISSION_VARIABLE_MISSION_PARTICIPANT_KILLS: {
			diag_log("Kills fired");
			_unit = _missionVariable select 0;
			_killer = _missionVariable select 1;
		
			_missionArray set[10,(_missionArray select 10)+[_unit,_killer]];
			ZFM_CURRENT_MISSIONS set[_missionID,_missionArray];
		};					
	};
	

};

/*
*	ZFM_Mission_Handler_Start
*
*	Starts the mission loop and mission handler
*/
ZFM_Mission_Handler_Start ={
	private ["_continueExecution"];

	if(ZFM_MISSIONS_MAXIMUM_CONCURRENT_MISSIONS == 0) exitWith {diag_log(format["%1 %2 - Maximum concurrent missions is set to 0. You do want missions, right?",ZFM_NAME,ZFM_VERSION])};
	if((count ZFM_CURRENT_MISSIONS) || ZFM_MISSIONS_MISSION_HANDLER_STARTED) exitWith {diag_log(format["%1 %2 - Mission handler is already running. Exiting..",ZFM_NAME,ZFM_VERSION])};

	_continueExecution = true;
	
	while(_continueExecution) do
	{
		if(ZFM_MISSIONS_START_MISSIONS_WHILE_SERVER_EMPTY && (count playableUnits) ==0) then
		{
			waitUntil{(count playableUnits) != 0};
		};

		if(ZFM_MISSIONS_DEFAULT_MISSION_START_TYPE == ZFM_MISSION_START_TYPE_TIMED_RANDOM) then
		{
			// sets and gets the ZFM_CAN_CREATE_NEW_MISSION variable
			_canAdd = [] call ZFM_Mission_Can_Add;
			
			// If we can't, then wait!
			if(!_canAdd) then
			{
				waitUntil{ZFM_CAN_CREATE_NEW_MISSION};
			};
			
			// Get the random amount based on max-min
			_minutesRandSeed = (ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MAX-ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MIN);
			
			// Get the rounded amount 
			_minutesToWait = (ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MIN + (round random _minutesRandSeed))*60;
			
			// Sleep for the specified interval in minutes
			sleep (_minutesToWait*60);
			
		};
		
	};
	
	
};

/*
*	ZFM_Init_MissionArray
*	
*	Creates the missionArray for the mission, which contains all information on a given mission.
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


*/
ZFM_Mission_Init ={
	private["_thisMissionArray"];
	
	_thisMissionArray = [
		(_this select 0),			//Mission type
		(_this select 1),			//Mission Title
		(_this select 2),			//Mission Humanity type (group share / per kill)
		(_this select 3),			//Mission LootShare type
		[],			// Mission Units
		0,			// Units total
		0,			// Units killed (Shortcut)
		[],			// Mission Objects
		[],			// Mission Participants
		[]			// Participants -> Kills
	];
	
	_thisMissionArray
};

/*
	ZFM_Mission_Generate_New
	
	Houses the mission generation function (puts ll the ZFM_Mission elements into play.
*/
ZFM_Mission_Generate_New ={

};



private ["_myMission"];

while{true} do
{
	_myMission = [ZFM_MISSION_TYPE_CRASH,"TEST","TEST1","TEST3"] call ZFM_Mission_Init;
	[_myMission] call ZFM_Mission_Add;
	
	/*
		Max missions by type
		Max missions total : tested
		Mission array structure: tested
		Mission array updating internal elements : INCOMPLETE
	
		Intended result? - Test data
	*	1 = Mission type - NOT TESTED
	*	2 = Mission title - NOT TESTED
	*	3 = Humanity type - NOT TESTED
	*	4 = LootShare type - NOT TESTED
	*	5 = Units - NOT TESTED
	*	6 = Units total - NOT TESTED
	*	7 = Units killed = TESTED
	*	8 = Mission objects = NOT TESTED
	*	9 = Mission participants = NOT TESTED
	*	10 = Participants->Kills = NOT TESTED


	*/
	
	// Test 0
	[0,ZFM_MISSION_VARIABLE_MISSION_UNITS_KILLED,"any"] call ZFM_Mission_Set;
	
	
	
	diag_log(format["%1",(count ZFM_CURRENT_MISSIONS)]);
	diag_log(format["MISS: %1",ZFM_CURRENT_MISSIONS]);
	sleep 100;


};


