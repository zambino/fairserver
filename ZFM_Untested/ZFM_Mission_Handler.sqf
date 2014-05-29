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
*	ZFM_MissionArray_AddMissionArray
*
*	Adds a pre-generated mission array to ZFM_CURRENT_MISSIONS.
*/
ZFM_Mission_Add ={
	private ["_missionArray"];
	
	_missionArray = _this select 0;
	
	if(typeName ZFM_CURRENT_MISSIONS == "ARRAY" && typeName _missionArray == "ARRAY") then
	{
		ZFM_CURRENT_MISSIONS set[(count ZFM_CURRENT_MISSIONS),[(count ZFM_CURRENT_MISSIONS)] + _missionArray];
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
	
	diag_log(format["MISSION ARRAY %1",_missionArray]);
	if(!typeName _missionArray == "ARRAY") exitWith{};
	
	switch(_missionVariableType) do
	{
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
		case ZFM_MISSION_VARIABLE_HUMANITY_TYPE: {
			diag_log("Humanity type fired");
			_missionArray set[3,_missionVariable];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_LOOTSHARE_TYPE: {
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
		case ZFM_MISSION_VARIABLE_UNITS_TOTAL: {
			diag_log("Units fired");
			_missionArray set[6,(_missionArray select 6) +1];
			ZFM_CURRENT_MISSIONS set [_missionID,_missionArray];
		};
		case ZFM_MISSION_VARIABLE_UNITS_KILLED: {
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
		case ZFM_MISSION_VARIABLE_MISSION_PARTICIPANTS_KILLS: {
			diag_log("Kills fired");
			_unit = _missionVariable select 0;
			_killer = _missionVariable select 1;
		
			_missionArray set[10,(_missionArray select 10)+[_unit,_killer]];
			ZFM_CURRENT_MISSIONS set[_missionID,_missionArray];
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

private ["_myMission"];

while{true} do
{
	_myMission = [ZFM_MISSION_TYPE_CRASH,"TEST","TEST1","TEST3"] call ZFM_Mission_Init;
	[_myMission] call ZFM_Mission_Add;
	
	// Test 0
	[0,ZFM_MISSION_VARIABLE_MISSION_UNITS_KILLED,"any"] call ZFM_Mission_Set;
	
	
	
	diag_log(format["%1",(count ZFM_CURRENT_MISSIONS)]);
	diag_log(format["MISS: %1",ZFM_CURRENT_MISSIONS]);
	sleep 100;


};

