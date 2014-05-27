/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
ZFM_MISSION_VARIABLE_MISSION_ID = "6x101011";
ZFM_MISSION_VARIABLE_MISSION_TITLE = "6x101012";
ZFM_MISSION_VARIABLE_MISSION_HUMANITY_TYPE = "6x101013";
ZFM_MISSION_VARIABLE_MISSION_LOOTSHARE_TYPE = "6x101014";
ZFM_MISSION_VARIABLE_MISSION_UNITS = "6x101015";
ZFM_MISSION_VARIABLE_MISSION_UNITS_KILLED = "6x101016";
ZFM_MISSION_VARIABLE_MISSION_OBJECTS = "6x101017";
ZFM_MISSION_VARIABLE_MISSION_PARTICIPANTS = "6x101018";
ZFM_MISSION_VARIABLE_MISSION_PARTICIPANT_KILLS = "6x101019";

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



ZFM_MissionArray_AddMissionArray ={
	private ["_missionArray"];
	
	_missionArray = _this select 0;
	
	if(typeName ZFM_CURRENT_MISSIONS == "ARRAY" && _typeName _missionArray == "ARRAY") then
	{
		ZFM_CURRENT_MISSIONS set[(count ZFM_CURRENT_MISSIONS),_missionArray];
	};
	
};

ZFM_MissionArray_RemoveMissionArray ={
	private ["_missionID"];

	if(typeName ZFM_CURRENT_MISSIONS == "ARRAY") then
	{
		ZFM_CURRENT_MISSIONS set[_missionID,[]];
	};
};

ZFM_MissionArray_GetMissionByID ={
	private["_missionID","_missionsCount","_returnMission"];
	
	_missionID = _this select 0;
	
	_returnMission = false;
	
	if(typeName ZFM_CURRENT_MISSIONS =="ARRAY") then
	{
		_missionsCount = count ZFM_MISSIONS;
		
		if(_missionID <= _missionsCount) then
		{
			_returnMission = true;
		};
	};
	
	_returnMission
};

ZFM_MissionArray_SetMission_Variables ={
	private["_missionID","_missionVariableType","_missionVariable","_missionArray","_currentUnits"];
	
	_missionID = _this select 0;
	_missionVariableType = _this select 1;
	_missionVariable = _this select 2;
	
	_missionArray = [_missionID] call ZFM_MissionArray_GetMissionByID;
	
	if(!_missionArray) exitWith{};
	
	switch(_missionVariableType) do
	{
		case ZFM_MISSION_VARIABLE_MISSION_TITLE: {
			(ZFM_CURRENT_MISSIONS select _missionID) set [1,_missionVariable];
		};
		case ZFM_MISSION_VARIABLE_HUMANITY_TYPE: {
			(ZFM_CURRENT_MISSIONS select _missionID) set [1,_missionVariable];
		};
		case ZFM_MISSION_VARIABLE_LOOTSHARE_TYPE: {
			(ZFM_CURRENT_MISSIONS select _missionID) set [2,_missionVariable];
		};
		case ZFM_MISSION_VARIABLE_MISSION_UNITS: {
			_currentUnits = (ZFM_CURRENT_MISSIONS select _missionID) select 3;
		
			if(!typeName _missionVariable == "ARRAY") then
			{
				_currentUnits = _currentUnits + _missionVariable;				
			}
			else
			{
				_currentUnits = _currentUnits + [_missionVariable];
			}
			
			(ZFM_CURRENT_MISSIONS select _missionID) set [3,_currentUnits];
		};
		case ZFM_MISSION_VARIABLE_HUMANITY_TYPE: {
			(ZFM_CURRENT_MISSIONS select _missionID) set [2,_missionVariable];
		};		
		case ZFM_MISSION_VARIABLE_UNITS_KILLED: {
			(ZFM_CURRENT_MISSIONS select _missionID set [4,(ZFM_CURRENT_MISSIONS select _missionID select 4)+1];
		};
		case ZFM_MISSION_VARIABLE_MISSION_OBJECTS: {
			_currentUnits = (ZFM_CURRENT_MISSIONS select _missionID) select 5;
		
			if(!typeName _missionVariable == "ARRAY") then
			{
				_currentObjects = _currentObjects + _missionVariable;				
			}
			else
			{
				_currentObjects = _currentObjects + [_missionVariable];
			}
			
			(ZFM_CURRENT_MISSIONS select _missionID) set [5,_currentObjects];
		};	
		case ZFM_MISSION_VARIABLE_MISSION_PARTICIPANTS: {
			(ZFM_CURRENT_MISSIONS select _missionID set [6,(ZFM_CURRENT_MISSIONS select _missionID select 6)+ [_missionVariable]];
		};		
		case ZFM_MISSION_VARIABLE_MISSION_PARTICIPANTS_KILLS: {
			_unit = _missionVariable select 0;
			_killer = _missionVariable select 1;
		
			_currentParticipants = (ZFM_CURRENT_MISSIONS select _missionID) select 7;
		
			(ZFM_CURRENT_MISSIONS select _missionID) set [7,_currentParticipants + [_unit,_killer]];
		};					
	};
	

};

ZFM_Init_MissionArray ={
	
	_thisMissionArray = [
		(_this select 0),			//Mission Title
		(_this select 1),			//Mission Humanity type (group share / per kill)
		(_this select 2)			//Mission LootShare type
		[],			// Mission Units
		0,			// Units killed (Shortcut)
		[],			// Mission Objects
		[],			// Mission Participants
		[],			// Participants -> Kills
	]
};