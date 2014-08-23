/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

/*
	ZFM_CreateCrashMarker
	
	Creates a marker for a crash
*/
ZFM_CreateCrashMarker ={
	private ["_location","_difficulty","_markerText","_textMarkerName","_markerCreatedName","_markerCreated","_markerColor","_markerSize","_markerType"];
	
	_location = _this select 0;
	_difficulty = _this select 1;
	_markerText =_this select 2;
	
	// Create the marker
	_markerColor = "ColorWhite";
	_markerSize = 150;

	["Crash marker is being created. Location %1, Difficulty %2, MarkerText %3","ZFM_Mission_Type_Crash::ZFM_CreateCrashMarker",[_location,_difficulty,_markerText]] call ZFM_Common_Log;
	
	switch(_difficulty) do
	{
		case "DEADMEAT": {
			_markerColor = "ColorYellow";
			_markerSize = 400;
		};		
		case "EASY": {
			_markerColor = "ColorGreen";
			_markerSize = 410;
		};		
		case "MEDIUM": {
			_markerColor = "ColorOrange";
			_markerSize = 420;
		};		
		case "HARD": {
			_markerColor = "ColorRed";
			_markerSize = 440;
		};		
		case "WAR_MACHINE": {
			_markerColor = "ColorBlack";
			_markerSize = 600;
		};
	};

	_markerCreatedName = format["ZFM%1",(round random 999999)];
		
	_markerCreated = createMarker[_markerCreatedName,_location];
	_markerCreatedName setMarkerShape "ELLIPSE";
	_markerCreatedName setMarkerBrush "Solid";
	_markerCreatedName setMarkerSize [_markerSize,_markerSize];
	_markerCreatedName setMarkerColor _markerColor;
	
	// Bugfix: Add marker text (requires another marker)
	
	_textMarkerName = format["ZFM%1",(round random 999999)];
	
	_textMarkerCreated = createMarker[_textMarkerName,_location];
	_textMarkerName setMarkerColor "ColorBlack";
	_textMarkerName setMarkerType "Warning";
	_textMarkerName setMarkerText format["%1 (%2)",_markerText,_difficulty];
	
	[_markerCreatedName,_textMarkerName,[_markerCreated,_textMarkerCreated]]
};


/*
	ZFM_GetVehicleWreckClass
	
	Gets the analogous wreck class for a vehicle.
*/
ZFM_GetVehicleWreckClass ={
	private ["_vehicleClass"];
	
	_vehicleClass = _this select 0;
	
	_wreckClass = false;
	
	switch(_vehicleClass) do
	{
		// PLANE WRECKS
		case "AV8B": {
			_wreckClass = "AV8BWreck";
		};
		case "AV8B2": {
			_wreckClass = "AV8BWreck";
		};
		case "C130J": {
			_wreckClass = "C130J_wreck_EP1";
		};
		case "C130J_US_EP1": {
			_wreckClass = "C130J_wreck_EP1";
		};
		case "F35B": {
			_wreckClass = "F35bWreck";
		};
		case "MQ9PredatorB_US_EP1": {
			_wreckClass = "MQ9PredatorWreck";
		};		
		case "MV22": {
			_wreckClass = "MV22Wreck";
		};		
		case "Su25_CDF": {
			_wreckClass = "SU25Wreck";
		};
		case "Su25_TK_EP1": {
			_wreckClass = "SU25Wreck";
		};
		case "Su34": {
			_wreckClass = "SU34Wreck";
		};		
			
		// HELICOPTER WRECKS
		case "AH1Z": {
			_wreckClass = "AH1ZWreck";
		};
		case "MH60S": {
			_wreckClass = "MH60Wreck";
		};
		case "Mi17_Civilian": {
			_wreckClass = "Mi17Wreck";
		};
		case "Mi17_TK_EP1": {
			_wreckClass = "Mi17Wreck";
		};
		case "Mi17_medevac_Ins": {
			_wreckClass = "Mi17Wreck";
		};
		case "Mi17_medevac_CDF": {
			_wreckClass = "Mi17Wreck";
		};
		case "Mi17_medevac_RU": {
			_wreckClass = "Mi17Wreck";
		};
		case "Mi17_Ins": {
			_wreckClass = "Mi17Wreck";
		};		
		case "Mi17_CDF": {
			_wreckClass = "Mi17Wreck";
		};		
		case "Mi17_rockets_RU": {
			_wreckClass = "Mi17Wreck";
		};		
		case "Mi17_Civilian": {
			_wreckClass = "Mi17Wreck";
		};		
		case "Mi17_UN_CDF_EP1": {
			_wreckClass = "Mi17Wreck";
		};		
		case "Mi171Sh_rockets_CZ_EP1": {
			_wreckClass = "Mi17Wreck";
		};		
		case "Mi171Sh_CZ_EP1": {
			_wreckClass = "Mi17Wreck";
		};		
		case "Mi17_TK_EP1": {
			_wreckClass = "Mi17Wreck";
		};		
		case "Mi24_V": {
			_wreckClass = "Mi24Wreck";
		};		
		case "Mi24_P": {
			_wreckClass = "Mi24Wreck";
		};	
		case "Mi24_D": {
			_wreckClass = "Mi24Wreck";
		};	
		case "Mi24_D_TK_EP1": {
			_wreckClass = "Mi24Wreck";
		};			
		case "Ka52": {
			_wreckClass = "Ka52Wreck";
		};
		case "Ka52Black": {
			_wreckClass = "Ka52Wreck";
		};
		case "UH1Y": {
			_wreckClass = "UH1YWreck";
		};		
	};
	
	_wreckClass
};


/*
	ZFM_CreateCrashVehicle_NoWater
	
	We want to make sure that if there's a crash in water, we re-crash it on land
*/
ZFM_CreateCrashVehicle_NoWater ={
	private ["_vehicleType","_location","_createdVehicle","_crashPos"];
	
	_vehicleType = _this select 0;
	//_location = _this select 1;
	
	_continueLoop = true;
	
	while{_continueLoop} do
	{
		// Generate a random location
		_location = [(round random 12000),(round random 12000),3000];
		
		// Make it fly
		_createdVehicle = createVehicle [_vehicleType,_location,[],0,"FLY"]; 
		
		// Watch it crash, see if it's in water, then if it is, no thanks, try again.
		while{alive _createdVehicle} do
		{
			["Crash vehicle created, waiting for crash to occur.","ZFM_Mission_Type_Crash::ZFM_CreateCrashVehicle_NoWater"] call ZFM_Common_Log;

			diag_log(format["%1 %2 - ZFM_CreateCrashVehicle - Vehicle created, currently waiting for crash..",ZFM_NAME,ZFM_VERSION,(visiblePosition _createdVehicle)]);
			
			// Bugfix -- To absolutely ensure it's going to explode and fall.
			_createdVehicle setDamage 1;
			
			// Wait then exit.
			sleep 10;
		};
		
		_crashPos = getPosATL _createdVehicle;
		
		if(!surfaceIsWater _crashPos) then
		{
			_continueLoop = false;
		};
		
		deleteVehicle _createdVehicle;
	};
	
	visiblePosition _createdVehicle
};

/*
	ZFM_CreateCrashVehicle
	
	Spawns a vehicle that will explode and then optionally, replaces it with a nicer-looking wreck model.
	This is because usually when the vehicle bites the big one, it looks like a raisin. Not much to defend!
*/
ZFM_CreateCrashVehicle ={
	private["_vehicleType","_difficulty","_markerText","_playerLocation","_location","_markerCreatedThis","_crashPos"];
	
	_vehicleType = _this select 0;
	_difficulty = _this select 1;
	_markerText = _this select 2;
	
	// Set it first, hope it isn't in the water.
	diag_log(format["%1 %2 - ZFM_CreateCrashVehicle - Crash location found..",ZFM_NAME,ZFM_VERSION,(visiblePosition _createdVehicle)]);

	// Create a crash, but not over water.
	_crashPos = [_vehicleType] call ZFM_CreateCrashVehicle_NoWater;

	// Find out if there's a crash replacement class for the vehicle created..
	_crashRepClass = [_vehicleType] call ZFM_GetVehicleWreckClass;
	
	// IF the _crashRepClass is a string and not BOOL, then continue
	if(typeName _crashRepClass == "STRING") then
	{
		diag_log(format["%1 %2 - ZFM_CreateCrashVehicle - Vehicle crashed, has a crash model replacement - Replacing with wreck, which looks better...",ZFM_NAME,ZFM_VERSION,(visiblePosition _createdVehicle)]);
		_crashDir = getDir _createdVehicle;
		
		// Give the vehicle a short while to burn, explode or do whatever
		sleep 20;
		
		// Get rid of the wreckage and replace it with nicer looking wreckage
		deleteVehicle _createdVehicle;	
		
		// Manipulate the location so that Z is always 0, so we don't have wrecks sitting on the top of trees.
		_crashPosOne = _crashPos select 0;
		_crashPosTwo = _crashPos select 1;
		_crashPos = [_crashPosOne,_crashPosTwo,0];		
	
		// Create a wreck with the corresponding replacement class
		_createdVehicle = createVehicle [_crashRepClass,_crashPos,[],0,"NONE"]; 
	};
	
	// Create the marker for the vehicle.
	_markerCreatedThis = [_crashPos,_difficulty,_markerText] call ZFM_CreateCrashMarker;
	
	diag_log(format["%1 %2 - ZFM_CreateCrashVehicle - Marker set..",ZFM_NAME,ZFM_VERSION,(visiblePosition _createdVehicle)]);
	
	[_createdVehicle,_markerCreatedThis, _crashPos]
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
	
			// TODO: Replace with Layout Array. Then we're done. Oh gosh.

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


ZFM_Mission_Type_Crash_GenerateMissionTitle = {
	private["_missionType","_crashVehicleType","_difficulty"];

	// The place the vehicle was on the way to.
	_OTWT_G = ZFM_CRASH_MISSION_OTWT_GROUP call BIS_fnc_selectRandom;
	_OTWT_P = ZFM_CRASH_MISSION_OTWT_PLACE call BIS_fnc_selectRandom;

	//The 
};


/*
*	ZFM_GenerateMissionTitle
*
*	Generates a Mission Title.
*	TODO: Replace with even more random version. Boom.
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