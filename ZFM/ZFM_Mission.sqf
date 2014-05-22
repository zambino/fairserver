/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 private["_aiGroup","_playerz","_playerPos","_playerPoop","_unit"];
 
 // Used for Global chat
ZFM_ChatLogic = "Logic" createVehicleLocal [0,0,0];
 
 // Get the config stuff..
ZFM_Includes_Mission_Config = "\z\addons\dayz_server\ZFM\Config\ZFM_Mission_Config.sqf";
ZFM_Includes_Mission_Functions = "\z\addons\dayz_server\ZFM\ZFM_Mission_Functions.sqf";

// We need to get access to these functions..
call compile preprocessFileLineNumbers ZFM_Includes_Mission_Config;
call compile preprocessFileLineNumbers ZFM_Includes_Mission_Functions;

ZFM_GenerateMission ={
	
	private ["_missionMethod"];
	_missionMethod = _this select 0;

	// Array passed to generator function.
	_missionGenArray = [];
	
	switch(_missionMethod) do
	{
		// As of 23/05/2014 - One of two supported methods. Random means random.
		case ZFM_MISSION_METHOD_RANDOM: {
		
			// Random difficulty..
			_missionDifficulty = ZFM_DIFFICULTIES call BIS_fnc_selectRandom;
			
			switch(_missionDifficulty) do
			{
				case "DEADMEAT": {
					
					_missionGenArray = [
						[], // The units that are going to be spawned..
						[], // The vehicles that will spawn alongside the units
						[], // The support weaponry that will be spawned near them
						2, // The number of loot crates that are going to be spawned..
						[],// The items which will be scattered around the crash site
						[],
					];
					
					
				};
				case "EASY": {
					
				};
				case "MEDIUM": {
					
				};
				case "HARD": {
					
				};
				case "WAR_MACHINE": {
					
				};
			};
		};
	};
	
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

			diag_log(_crashTextOne);
			diag_log(_crashTextTwo);
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
	
	sleep 40;

	// Offset by 5 so they're not crushed by spawning vehicles
	_newPozz = [_crashPos,2] call ZFM_Create_OffsetPosition;
	
	//_unitsArrayz = [_createUnitsArray,"WAR_MACHINE",east,_newPozz] call ZFM_CreateUnitGroup;
	//_groupArrayz = _unitsArrayz select 0; // Get the group
	
	// Do the title thang, right?
	[ZFM_MISSION_TYPE_CRASH,_randomVehicle,"WAR_MACHINE"] call ZFM_GenerateMissionTitle;

	
	diag_log("CREATED VEHICLE!");
	
	sleep 100;
	
};
