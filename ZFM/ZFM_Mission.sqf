/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 private["_aiGroup","_playerz","_playerPos","_playerPoop","_unit"];
 
 
 // Get the config stuff..
ZFM_Includes_Mission_Config = "\z\addons\dayz_server\ZFM\Config\ZFM_Mission_Config.sqf";
ZFM_Includes_Mission_Functions = "\z\addons\dayz_server\ZFM\ZFM_Mission_Functions.sqf";

// We need to get access to these functions..
call compile preprocessFileLineNumbers ZFM_Includes_Mission_Config;
call compile preprocessFileLineNumbers ZFM_Includes_Mission_Functions;
 
 ZFM_GROUP_EAST = objNull;
 ZFM_GROUP_WEST = objNull;
 ZFM_GROUP_CIVILIAN = objNull;
 ZFM_GROUP_RESISTANCE = objNull;
 
 ZFM_AI_TYPE_SNIPER = "1x101010";
 ZFM_AI_TYPE_RIFLEMAN = "1x101011";
 ZFM_AI_TYPE_HEAVY = "1x101012";
 ZFM_AI_TYPE_COMMANDER = "1x101013";
 ZFM_AI_TYPE_MEDIC = "1x101014";
 ZFM_AI_TYPE_PILOT = "1x101015";
 
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
 
 // Used for basic mission types. If someone were to help maintain or expand this, more can be added here. 
 ZFM_MISSION_TYPE_CRASH = "2x101011";
 ZFM_MISSION_TYPE_CRASH_GOTO = "2x101012";
 ZFM_MISSION_TYPE_CRASH_AMBUSH = "2x101013";
 
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
 
ZFM_GenerateMissionTitle ={
	private["_missionType","_vehicleName","_difficulty","_onTheWayTo","_onTheWayToPlace","_deathType","_securedBy","_crashTextOne","_crashTextTwo"];
	
	_missionType = _this select 0;
	_vehicleName = _this select 1;
	_difficulty = _this select 2;
	
	if(typeName _missionType != "STRING") exitWith {};
	
	switch(_missionType) then
	{
		case ZFM_MISSION_TYPE_CRASH: {
		
			// ... to
			_onTheWayTo = ZFM_OnTheWayTo call BIS_fnc_selectRandom;
		
			// ... place
			_onTheWayToPlace = ZFM_OnTheWayToPlace call BIS_fnc_selectRandom;
			
			// .. how it died
			_deathType = ZFM_OnTheWayToDeath call BIS_fnc_selectRandom;
			
			// Secured by [name]
			_securedBy = ZFM_BanditGroup_Names call BIS_fnc_selectRandom;
		
			// One for each line on the screen
			_crashTextOne = format["A %1 %2 %3 %4",_vehicleName,_onTheWayTo,_onTheWayToPlace,_deathType];
			_crashTextTwo = format["Secured by %1 [Difficulty %2]",_securedBy,_difficulty];
	
			// Far more lovely than anything we've seen before, no?
			titleText[_crashTextOne,"PLAIN",10];
			cutText[_crashTextTwo,"PLAIN DOWN",10];
		};
	};

};
 
 
 
// Call AI bootstrap
[] call ZFM_DoBootStrap;

while{true} do
{
	_vehiclezType = "C130J_US_EP1";
	_playerz = playableUnits;
	_playerPos = _playerz select 0;
	_playerPoop = getPos _playerPos;	
	
	_randomVehicle = ZFM_CrashVehicles_Helicopters call BIS_fnc_selectRandom;
	
	_thisVehicle = [_randomVehicle,"WAR_MACHINE","DIS BE A TEST"] call ZFM_CreateCrashVehicle;
	_crashPos = _thisVehicle select 2;
	
	_createUnitsArray = [
		ZFM_AI_TYPE_RIFLEMAN,
		ZFM_AI_TYPE_RIFLEMAN,
		ZFM_AI_TYPE_RIFLEMAN,
		ZFM_AI_TYPE_RIFLEMAN,
		ZFM_AI_TYPE_RIFLEMAN,
		ZFM_AI_TYPE_RIFLEMAN,
		ZFM_AI_TYPE_RIFLEMAN,
		ZFM_AI_TYPE_RIFLEMAN
	];
	
	wait 40;

	// Offset by 5 so they're not crushed by spawning vehicles
	_newPozz = [_crashPos,2] call ZFM_Create_OffsetPosition;
	
	_unitsArrayz = [_createUnitsArray,"WAR_MACHINE",east,_newPozz] call ZFM_CreateUnitGroup;
	_groupArrayz = _unitsArrayz select 0; // Get the group
	
	// Do the title thang, right?
	[ZFM_MISSION_TYPE_CRASH,_randomVehicle,"WAR_MACHINE"] call ZFM_GenerateMissionTitle;

	
	diag_log("CREATED VEHICLE!");
	
	sleep 100;
	
};
