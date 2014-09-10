/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

/*
*	ZFM_Mission_Type_Crash_GetVehicleWreckClass
*	
*	Gets the analogous wreck class for a vehicle.
*/
ZFM_Mission_Type_Crash_GetVehicleWreckClass ={
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
*	ZFM_Mission_Type_Crash_Create_Marker
*
*	Creates a marker for a crash.
*/
ZFM_Mission_Type_Crash_Create_Marker ={
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
	

	_textMarkerName = format["ZFM%1",(round random 999999)];
	_textMarkerCreated = createMarker[_textMarkerName,_location];
	_textMarkerName setMarkerColor "ColorBlack";
	_textMarkerName setMarkerType "Warning";
	_textMarkerName setMarkerText format["%1 (%2)",_markerText,_difficulty];
	
	[_markerCreatedName,_textMarkerName,[_markerCreated,_textMarkerCreated]]	

};

ZFM_Mission_Type_Crash_GetFriendlyVehicleName ={
private ["_vehicleClass"];
	
	_vehicleClass = _this select 0;
	_wreckClass = false;
	
	switch(_vehicleClass) do
	{
		// PLANE WRECKS
		case "AV8B": {
			_wreckClass = "Harrier II Jet Plane";
		};
		case "AV8B2": {
			_wreckClass = "Harrier II Jet Plane";
		};
		case "C130J": {
			_wreckClass = "Super-Hercules Cargo Plane";
		};
		case "C130J_US_EP1": {
			_wreckClass = "Super-Hercules Cargo Plane";
		};
		case "F35B": {
			_wreckClass = "F-35 Fighter Jet";
		};
		case "MQ9PredatorB_US_EP1": {
			_wreckClass = "Excessive Civilian Casualties (AKA Predator Drone)";
		};		
		case "MV22": {
			_wreckClass = "Osprey tilt-rotor plane";
		};		
		case "Su25_CDF": {
			_wreckClass = "SU-25 Fighter Jet";
		};
		case "Su25_TK_EP1": {
			_wreckClass = "SU-25 Fighter Jet";
		};
		case "Su34": {
			_wreckClass = "SU-34 Fighter Jet";
		};		
			
		// HELICOPTER WRECKS
		case "AH1Z": {
			_wreckClass = "Bell Viper Helicopter";
		};
		case "MH60S": {
			_wreckClass = "Seahawk Helicopter";
		};
		case "Mi17_Civilian": {
			_wreckClass = "Mi17 Helicopter";
		};
		case "Mi17_TK_EP1": {
			_wreckClass = "Mi17 Helicopter";
		};
		case "Mi17_medevac_Ins": {
			_wreckClass = "Mi17 Medi-Heli";
		};
		case "Mi17_medevac_CDF": {
			_wreckClass = "Mi17 Medi-Heli";
		};
		case "Mi17_medevac_RU": {
			_wreckClass = "Mi17 Medi-Heli";
		};
		case "Mi17_Ins": {
			_wreckClass = "Mi17 Helicopter";
		};		
		case "Mi17_CDF": {
			_wreckClass = "Mi17 Helicopter";
		};		
		case "Mi17_rockets_RU": {
			_wreckClass = "Mi17 Sexcopter";
		};		
		case "Mi17_Civilian": {
			_wreckClass = "Mi17 Porncopter";
		};		
		case "Mi17_UN_CDF_EP1": {
			_wreckClass = "Mi17 Bonecopter";
		};		
		case "Mi171Sh_rockets_CZ_EP1": {
			_wreckClass = "Mi17 Spunkcopter";
		};		
		case "Mi171Sh_CZ_EP1": {
			_wreckClass = "Mi17 Gobcopter";
		};		
		case "Mi17_TK_EP1": {
			_wreckClass = "Mi17 Zobcopter";
		};		
		case "Mi24_V": {
			_wreckClass = "Hind-D"; // What's a Russian gunship doing out here? SNAAAAAAAAAAAAAAAAAAAAAKE!!!!
		};		
		case "Mi24_P": {
			_wreckClass = "Hind-G";
		};	
		case "Mi24_D": {
			_wreckClass = "Hind-Z";
		};	
		case "Mi24_D_TK_EP1": {
			_wreckClass = "Hind-D-O-G-G";
		};			
		case "Ka52": {
			_wreckClass = "Kamov Alligator Helicopter";
		};
		case "Ka52Black": {
			_wreckClass = "Kamov Alligator Helicopter";
		};
		case "UH1Y": {
			_wreckClass = "Huey";
		};		
	};
	
	_wreckClass
};


/*
*	ZFM_Mission_Type_Crash_Create
*
*	Main function for creating and executing the crash mission. Either dynamic or user-created.
*/
ZFM_Mission_Type_Crash_Create ={

	// Oh we're close.
	// Create the crash, create the layout, create the marker, clear away trees then we're done. Return as mission array row.

};

ZFM_Mission_Type_Crash_GenerateObjectList_Item ={
	private["_difficulty","_objects","_outputList","_thisItem"];
	_difficulty = _this select 0;
	_numberItems = _this select 1;

	_outputList =[];

	// Get the relevant object thing.
	_objects = call compile format["ZFM_CRASH_MISSION_LAYOUT_OBJECTS_%1",_difficulty];

	for [{_x =1},{_x <= _numberItems},{_x = _x +1} ] do
	{
		_thisItem = _objects call BIS_fnc_selectRandom;
		_outputList = _outputList + [_thisItem];
	};

	_outputList
};

/*
*	ZFM_Mission_Type_Crash_GenerateRandomUnitGroup_Item
*
*	Generates a unit group item for use in a layout array.
*/
ZFM_Mission_Type_Crash_GenerateRandomUnitGroup_Item ={
	private["_difficulty","_unitList","_outputArray"];
	_difficulty = _this select 0;

	// Get the array of text types 
	_unitList = [_difficulty] call ZFM_Units_GenerateRandomUnits;

	// Return the array that will be shown in the layout!
	[ZFM_LAYOUT_OBJECT_UNIT_GROUP,0,[_unitList,_difficulty,ZFM_GROUP_EAST,1]]
};

/*
*	ZFM_Mission_Type_Crash_GenerateRandomLootCrate_Item_Multi
*
*	Generates multiple loot crate array items.
*/
ZFM_Mission_Type_Crash_GenerateRandomLootCrate_Item_Multi ={
	private["_difficulty","_numCrates","_thisItem","_outputArray"];
	_difficulty = _this select 0;
	_numCrates = _this select 1;

	_outputArray = [];

	for [{_x =1},{_x <= _numCrates},{_x = _x +1} ] do
	{
		_thisItem = [_difficulty] call ZFM_Mission_Type_Crash_GenerateRandomLootCrate_Item;
		_outputArray = _outputArray + _thisItem;
	};

	_outputArray
};

/*
*	ZFM_Mission_Type_Crash_GenerateRandomLootCrate_Item
*
*	Generates an array for use in a layout array.
*/
ZFM_Mission_Type_Crash_GenerateRandomLootCrate_Item ={
	private["_difficulty","_outputArray","_itemTypes","_lootClass","_thisItem"];
	_difficulty = _this select 0;
	_outputArray = [];
	_numberItemTypes = round random ((count ZFM_LOOT_CONTENT_TEXT_TYPES)-1);

	// Get a random Loot crate class..
	_lootClass = ZFM_Loot_Crates call BIS_fnc_selectRandom;

	// Pre-prepared for the text types.
	_itemTypes = [];

	// Adds the text types to the array. (i.e. Pistols, Machineguns, etc. )
	for [{_x =1},{_x <= _numberCrates},{_x = _x +1} ] do
	{
		_thisItem = ZFM_LOOT_CONTENT_TEXT_TYPES call BIS_fnc_selectRandom;
		_itemTypes = _itemTypes + [_thisItem];
	};

	// Return the array that will be shown in the layout.
	[ZFM_LAYOUT_OBJECT_LOOT,0,[_difficulty,_lootClass,_itemTypes]]

};

/*
*	ZFM_Mission_Type_Crash_Create_Layout
*
*	Creates a layout for the crash using the layout compositor.
*/
ZFM_Mission_Type_Crash_Create_Layout ={
	private["_crashLocation","_difficulty","_nearBuildings","_numUnits","_thisRow","_numLootCrates","_objectsPerRow","_generatedUnits","_generatedCrates","_generatedObjects","_generatedAll","_generatedCount","_continue"];

	_crashLocation  = _this select 0;
	_difficulty = _this select 1;
	_nearBuildings = _this select 2;

	// How many units are there? 
	_numUnits = call compile format["ZFM_CRASH_MISSION_NUMBER_UNITS_%1",_difficulty];

	// How many loot crates do we have?
	_numLootCrates = call compile format["ZFM_CRASH_MISSION_NUMBER_LOOT_CRATES_%1",_difficulty];

	// Get the layout
	_layoutTemplate = call compile format["ZFM_CRASH_MISSION_LAYOUT_%1",_difficulty];

	// Here are the units..
	_generatedUnits = [_difficulty] call ZFM_Mission_Type_Crash_GenerateRandomUnitGroup_Item;

	// Now we generate the loot crates
	_generatedCrates = [_difficulty,_numLootCrates] call ZFM_Mission_Type_Crash_GenerateRandomLootCrate_Item_Multi;

	if(_nearBuildings) then {

		// How many objects to be added?
		_numObjects =  call compile format["ZFM_CRASH_MISSION_NUMBER_OBJECTS_%1",_difficulty];

		// Now we have the objects we've generated.
		_generatedObjects = [_difficulty,_numObjects] call ZFM_Mission_Type_Crash_GenerateObjectList_Item;
	};

	// Place them all into a super-array of items which we will then start to assign to the layout.
	_generatedAll = _generatedUnits + _generatedCrates + _generatedObjects;

	_generatedCount = count _generatedAll;

	// Get the height of the layout array
	_layoutHeight = (count _layoutTemplate)-1;

	// Get the width.
	_layoutWidth = count (_layoutTemplate select 0);

	// Okay, I hate having to use a new loop, but I think the randomness is justified to make people look
	// At the mission and think "Hm, not seen this one before!" and that's important for me.
	for [{_x =0},{_x <= _generatedCount-1},{_x = _x +1} ] do
	{
		// Get the item for this row.
		_thisRow = _generatedAll select _x;
	
		_randomRow = round random _layoutHeight;
		_randomCol = round random _layoutWidth;

		// Okay, now we generate a random row and position
		_selectedRow = _layoutTemplate select _randomRow;
		_selectedItem = _selectedRow select _randomCol;

		// Make sure it's a replaceable element.
		if(typeName _selectedItem == "SCALAR" && _seletedItem == 0) then {
			// Set the item in the row to the item in the array.
			_selectedRow set[_randomCol,_thisRow];

			// JJ: Rewrite this so that each row is cached rather than repacked count(x) times
			_layoutTemplate set[_x,_selectedRow]; // Repacked back into the array..
		}
		else
		{
			_continue = true;

			while{_continue} do
			{
				_randomRow = round random _layoutHeight;
				_randomCol = round random _layoutWidth;

				// Okay, now we generate a random row and position
				_selectedRow = _layoutTemplate select _randomRow;
				_selectedItem = _selectedRow select _randomCol;


				if(typeName _selectedItem == "SCALAR" && _selectedItem ==0) then
				{
					_selectedRow set[_randomCol,_thisRow];
					_layoutTemplate set[_x,_selectedRow]; 
					_continue = false; // Exit, we missed the center.
				};
			};
		};
	};

	_layoutTemplate
};


/*
*	ZFM_Mission_Type_Crash_Create_Crash
*
*	Creates the crash for the crash mission.
*/
ZFM_Mission_Type_Crash_Create_Crash={
	private["_vehicleClass","_difficulty","_location","_markerPre","_markerPrez","_marker","_returnArray"];

	_returnArray =[];

	switch(count _this) do
	{
		// Random vehicle, random difficulty, random location
		case 0: {
			
			// Randomise the difficulty and the vehicle type..
			_vehicleClass = ZFM_CRASH_MISSION_VEHICLES call BIS_fnc_selectRandom;
			_difficulty = ZFM_DIFFICULTY_TEXT_TYPES call BIS_fnc_selectRandom;

			//Generate the crash vehicle using object function
			_location = [_vehicleClass] call ZFM_Mission_Type_Crash_Create_CrashVehicle_Object;

			// Get the pre-text for the marker.
			_markerPre = ZFM_CRASH_MISSION_CRASH_EXPS call BIS_fnc_selectRandom;
			_markerPrez = [_vehicleClass] call ZFM_Mission_Type_Crash_GetFriendlyVehicleName;

			// Generate a marker for the crash
			_marker = [_location select 1,_difficulty,(_markerPre + " " + _markerPrez)] call ZFM_Mission_Type_Crash_Create_Marker;	

			_returnArray =[_vehicleClass,_difficulty,_location,_marker];

		};

		// Vehicle specified
		case 1: {
			if(typeName (_this select 0) == "STRING") then
			{
				// Use the explicitly-defined vehicle.
				_vehicleClass = _this select 0;

				// Random difficulty
				_difficulty = ZFM_DIFFICULTY_TEXT_TYPES call BIS_fnc_selectRandom;

				//Generate the crash vehicle using object function
				_location = [_vehicleClass] call ZFM_Mission_Type_Crash_Create_CrashVehicle_Object;

				// Get the pre-text for the marker.
				_markerPre = ZFM_CRASH_MISSION_CRASH_EXPS call BIS_fnc_selectRandom;
				_markerPrez = [_vehicleClass] call ZFM_Mission_Type_Crash_GetFriendlyVehicleName;

				// Generate a marker for the crash
				_marker = [_location select 1,_difficulty,(_markerPre + " " + _markerPrez)] call ZFM_Mission_Type_Crash_Create_Marker;	

				// Return it
				_returnArray =[_vehicleClass,_difficulty,_location,_marker];			
			};
		};

		case 2: {
			if(typeName (_this select 0) == "STRING" && typeName (_this select 1) == "STRING") then
			{
				// Use the explicitly-defined vehicle.
				_vehicleClass = _this select 0;

				// Random difficulty
				_difficulty = _this select 1;

				//Generate the crash vehicle using object function
				_location = [_vehicleClass] call ZFM_Mission_Type_Crash_Create_CrashVehicle_Object;

				// Get the pre-text for the marker.
				_markerPre = ZFM_CRASH_MISSION_CRASH_EXPS call BIS_fnc_selectRandom;
				_markerPrez = [_vehicleClass] call ZFM_Mission_Type_Crash_GetFriendlyVehicleName;

				// Generate a marker for the crash
				_marker = [_location select 1,_difficulty,(_markerPre + " " + _markerPrez)] call ZFM_Mission_Type_Crash_Create_Marker;	

				// Return it
				_returnArray =[_vehicleClass,_difficulty,_location,_marker];				
			};
		};

		case 3: {
			if(typeName (_this select 0) == "STRING" && typeName (_this select 1) == "STRING" && typeName (_this select 2) =="ARRAY") then
			{
				// Use the explicitly-defined vehicle.
				_vehicleClass = _this select 0;

				// Random difficulty
				_difficulty = _this select 1;

				//Generate the crash vehicle using object function
				_location = _this select 2;

				// Get the pre-text for the marker.
				_markerPre = ZFM_CRASH_MISSION_CRASH_EXPS call BIS_fnc_selectRandom;
				_markerPrez = [_vehicleClass] call ZFM_Mission_Type_Crash_GetFriendlyVehicleName;

				// Generate a marker for the crash
				_marker = [_location select 1,_difficulty,(_markerPre + " " + _markerPrez)] call ZFM_Mission_Type_Crash_Create_Marker;	

				// Return it
				_returnArray =[_vehicleClass,_difficulty,_location,_marker];								
			};
		};
	};

	_returnArray
};


/*
*	ZFM_Mission_Type_Crash_Create_CrashVehicle_Object
*
*	Creates the crash vehicle object, which then dutifully crashes. 
*/
ZFM_Mission_Type_Crash_Create_CrashVehicle_Object ={
	private["_vehicleClass","_location","_createdVehicle","_wreckClass","_outputPos"];
	_vehicleClass = _this select 0;

	_outputPos =[];

	switch(count _this) do
	{
		// Just the crash vehicle, no position
		case 1:{
			if(typeName (_this select 0) =="STRING") then
			{
				_vehicleClass = _this select 0;

				// Generate an appropriate location..
				_location = [] call ZFM_Mission_Type_Crash_GenerateCrashLocation;
				_location set[2,10000]; // Keep it in the air.

				// Get the wreck that's going to replace it. 
				_wreckClass = [_vehicleClass] call ZFM_Mission_Type_Crash_GetVehicleWreckClass;

				// Okay, so we place the vehicle in the air.
				_createdVehicle = createVehicle [_vehicleClass,_location,[],0,"FLY"]; 
				_createdVehicle setVariable["ObjectID",-1];
				_createdVehicle setVariable["ObjectUID",-1];
										
				while{alive _createdVehicle} do
				{
					// Bugfix -- To absolutely ensure it's going to explode and fall.
					_createdVehicle setDamage 1;
					
					// Wait then exit.
					sleep 10;
				};

				// Get the position of the crash while it's burning..
				_outputPos = getPos _createdVehicle;

				// Get rid of the vehicle that's currently burning, or what have you.
				deleteVehicle _createdVehicle;

				// Get on the floor!
				_outputPos set[2,0];

				// Create the vehicle wreck
				_createdVehicle = createVehicle[_wreckClass,_outputPos,[],0,"NONE"];

				// Get the exact position
				_outputPos = getPos _createdVehicle;

				// Clear trees from the nearby area..
				[_outputPos,5] call ZFM_Common_ClearTrees;

				_outputPos = [_createdVehicle,_outputPos];
			};
		};

		// Crash vehicle AND location
		case 2: {
			if(typeName (_this select 0) == "STRING" && typeName (_this select 1) =="ARRAY") then
			{
				_vehicleClass = _this select 0;
				_location = _this select 1;
				_location set[2,10000]; // Keep it in the air.

				// Get the wreck that's going to replace it. 
				_wreckClass = [_vehicleClass] call ZFM_Mission_Type_Crash_GetVehicleWreckClass;

				// Okay, so we place the vehicle in the air.
				_createdVehicle = createVehicle [_vehicleClass,_location,[],0,"FLY"]; 
				_createdVehicle setVariable["ObjectID",-1];
				_createdVehicle setVariable["ObjectUID",-1];

				while{alive _createdVehicle} do
				{
					// Bugfix -- To absolutely ensure it's going to explode and fall.
					_createdVehicle setDamage 1;
					
					// Wait then exit.
					sleep 10;
				};

				// Get the position of the crash while it's burning..
				_outputPos = getPos _createdVehicle;

				// Get rid of the vehicle that's currently burning, or what have you.
				deleteVehicle _createdVehicle;

				// Get on the floor!
				_outputPos set[2,0];

				// Create the vehicle wreck
				_createdVehicle = createVehicle[_wreckClass,_outputPos,[],0,"NONE"];
				_outputPos = getPos _createdVehicle;

				// Clear trees from the nearby area..
				[_outputPos,5] call ZFM_Common_ClearTrees;

				_outputPos = [_createdVehicle,_outputPos];
			};
		};
	};

	_outputPos
};

/*
*	ZFM_Mission_Type_Crash_CheckCrashExclusion
*
**	Checks to see if the location given is excluded by ZFM_CRASH_MISSION_EXCLUDED_CRASH_LOCATIONS
*
*		Example:
*		Max X = 1203, Min X = 1200
*		Max Y = 1203, Min Y = 1200
*
*		This means, that the following co-ordinates will be prevented, and any in-between.
*		[1201,1201]	[1201,1202]	[1201,1203]
*		[1202,1201]	[1202,1202]	[1202,1203]
*		[1203,1201]	[1203,1202]	[1203,1203]
*
*		For 1200-1205, say:
*		[1201,1201]	[1201,1202]	[1201,1203]	[1201,1204]	[1201,1205]
*		[1202,1201]	[1202,1202]	[1202,1203]	[1202,1204]	[1202,1205]
*		[1203,1201]	[1203,1202]	[1203,1203]	[1203,1204]	[1203,1205]
*		[1204,1201]	[1204,1202]	[1204,1203]	[1204,1204]	[1204,1205]
*		[1205,1201]	[1205,1202]	[1205,1203]	[1205,1204]	[1205,1205]
*
*/
ZFM_Mission_Type_Crash_CheckCrashExclusion ={
	private["_location","_xPos","_yPos","_zPos","_row","_xMin","_xMax","_yMin","_yMax"];
	_location = _this select 0;

	_retVal = false; // More likely to be un-excluded, than excluded.

	if(typeName _location == "ARRAY") then
	{
		if(typeName ZFM_CRASH_MISSION_EXCLUDED_CRASH_LOCATIONS == "ARRAY" && count ZFM_CRASH_MISSION_EXCLUDED_CRASH_LOCATIONS >0) then
		{

			_crashCounts = count ZFM_CRASH_MISSION_EXCLUDED_CRASH_LOCATIONS;

			for [{_x =0},{_x <= _crashCounts-1},{_x = _x +1} ] do
			{
				_row = ZFM_CRASH_MISSION_EXCLUDED_CRASH_LOCATIONS select _x;

				if(typeName _row == "ARRAY" && count _row == 4) then
				{
					_xMin = _row select 0;
					_xMax = _row select 1;
					_yMin = _row select 2;
					_yMax = _row select 3;

					_xPos = _location select 0;
					_yPos = _location select 1;
					_zPos = _location select 2;

					if((_xPos <= _xMax) && (_xPos >= _xMin)) then
					{
						if((_yPos <= _yMax) && (_yPos >= _yMin)) then
						{
							[51,"INFORMATION","ZFM_Mission_Type_Crash::ZFM_Mission_Type_Crash_CheckCrashExclusion",[_location]] call ZFM_Language_Log;
							_x = _crashCounts-1; // Exit right away..
							_retVal = false; // Just in case.
						};
					};

				};
			};

		};
	};


	_retVal

};


/*
*	ZFM_Mission_Type_Crash_CHeckCrashLocation
*
*	Checks the location isn't excluded, and isn't in water. 
*/
ZFM_Mission_Type_Crash_CheckCrashLocation = {
	private["_locInput","_retVal","_isExcluded","_location"];
	_locInput = _this select 0;

	_retVal = false; // Not in water.
	_location = [_locInput,40,200,10,0,2000,0] call BIS_fnc_findSafePos; // Excludes water.
	_isExcluded = [_location] call ZFM_Mission_Type_Crash_CheckCrashExclusion;

	if(_isExcluded) then
	{
		_retVal = true;
		_retVal
	};
	_retVal
};


/*
*	ZFM_Mission_Type_Crash_GenerateCrashLocation
*
*	Generates a location for a crash site for a vehicle. If there's a manual location generated, then use that.
*/
ZFM_Mission_Type_Crash_GenerateCrashLocation = {
	
	private["_location","_continueLoop"];
	// Are we using manual crash locations?
	if(ZFM_CRASH_MISSION_USE_MANUAL_CRASH_LOCATIONS) then
	{
		// Manual missions with an actual array..
		if(typeName ZFM_CRASH_MISSION_MANUAL_CRASH_LOCATIONS == "ARRAY" && (count ZFM_CRASH_MISSION_MANUAL_CRASH_LOCATIONS) >0) then
		{
			// Select one at random from the list.
			_location = ZFM_CRASH_MISSION_MANUAL_CRASH_LOCATIONS call BIS_fnc_selectRandom;
			_location
		}
		else
		{	
			[51,"INFORMATION","ZFM_Mission::ZFM_Mission_Type_Crash_GenerateCrashLocation"] call ZFM_Language_Log;
		};
	}
	else
	{
		_continueLoop = true;
		while{_continueLoop} do
		{
			// Generate a random location
			_location = [(round random 12000),(round random 12000),0];
			_continueLoop = [_location] call ZFM_Mission_Type_Crash_CheckCrashLocation;
		};

		_location
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
	private["_missionType","_crashVehicleType","_difficulty","_OTWT_G","_OTWT_P","_OTWT_OUTPUT","_OTWT_C","_OTWT_CC","_OTWT_GW"];

	_vehicleName = _this select 0;
	_heroOrBandit = _this select 1;
	_difficulty = _this select 2;

	// The place the vehicle was on the way to.
	_OTWT_G = ZFM_CRASH_MISSION_OTWT_GROUP call BIS_fnc_selectRandom;
	_OTWT_P = ZFM_CRASH_MISSION_OTWT_PLACE call BIS_fnc_selectRandom;
	_OTWT_A = ZFM_CRASH_MISSION_OTWT_ACTION call BIS_fnc_selectRandom;
	_OTWT_OUTPUT = format[_OTWT_G,_vehicleName, _OTWT_P] + " " + _OTWT_A + ". ";
	_OTWT_C = ZFM_CRASH_MISSION_OTWT_CONSEQUENCE call BIS_fnc_selectRandom;
	_OTWT_CC = ZFM_CRASH_MISSION_OTWT_CONSEQUENCE_CONCLUSION call BIS_fnc_selectRandom;
	_OTWT_G = call compile format["ZFM_CRASH_MISSION_OTWT_BG_NAMES_%1",_heroOrBandit];
	_OTWT_GW = _OTWT_G call BIS_fnc_selectRandom;
	_OTWT_OUTPUT = _OTWT_OUTPUT + format[_OTWT_CC,_OTWT_GW] + "." + format["[Difficulty: %1]",_difficulty];

	_OTWT_OUTPUT
};
