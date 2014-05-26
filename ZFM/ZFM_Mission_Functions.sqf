/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 

 
 
 /*
 *	ZFM_InitUnitSpawn
 *
 *	Test function for creating AI.
 */
 ZFM_InitUnitSpawn = {
	private ["_groupHQ","_skin","_spawnAt","_person","_unit"];
	
	diag_log(format["Params %1",_this]);
	
	// Get the Group HQ
	_groupHQ = _this select 0;
	_skin = _this select 1;
	_spawnAt = _this select 2;
	
	// Create a unit!
	
	diag_log(format["Skin %1,SpawnAt %2, GroupHQ %3",_skin,_spawnAt,_groupHQ]);
	
	_unit = _groupHQ createUnit [_skin,_spawnAt,[], 10, "PRIVATE"];

	// Join the group
	[_unit] joinSilent _groupHQ;
	
	// Get rid of everything they're carrying.
	removeAllWeapons _unit;

	_unit
};
 
/*
*	ZFM_CreateAIGroup
*
*	Create a group for a group of AI.
*/
ZFM_CreateAIGroup = {

	private ["_sideType","_createdGroup"];
	_sideType = _this select 0;

	// Create a group with the specific side type.
	_createdGroup = createGroup _sideType;
	
	//Return the group
	_createdGroup
};

/*
*	ZFM_AI_Get_View_Distance
*
*	Determines the unit#'s
*/
ZFM_AI_Get_View_Distance = {
	private ["_difficulty","_viewRange"];
	
	_difficulty = _this select 0;
	
	_viewRange = 50;
	
	switch(_difficulty) do
	{
		case "DEADMEAT": {
			_viewRange = 30;
		};
		case "EASY": {
			_viewRange = 60;
		};
		case "MEDIUM": {
			_viewRange = 100;
		};
		case "HARD": {
			_viewRange = 200;
		};
		case "WAR_MACHINE": {
			_viewRange = 400;
		};
	};
	
	_viewRange
	
};

/*
*	ZFM_AI_Find_Nearby_Cover
*
*	Used for any type. Will find nearby trees to hide in.
*/
ZFM_AI_Find_Nearby_Cover = {
	private["_unit","_issuingUnit","_difficulty","_unitPosition","_viewRange","_nearbyTrees","_nearestTree","_nearestTreeFound","_objectName"];
	
	_unit = _this select 0;
	_issuingUnit = _this select 1;
	_difficulty = _this select 2;
	
	// Find out where the unit is.
	_unitPosition = getPos _unit;
		
	// Array for nearest tree..
	_nearestTree = [];

	// How many trees are there? So far none, but when we search.. ? 
	_nearbyTrees = 0;
	
	// Get the viewRange for the units.
	_viewRange = [_difficulty] call ZFM_AI_Get_View_Distance;
	
	diag_log(format["View range: %1",_viewRange]);
	
	_nearestTreeFound = false;
	{
		if("" == typeOf _x) then
		{
			if(alive _x ) then 
			{
				_objectName = _x call DZE_getModelName;
				
				diag_log(format["objectName: %1",_objectName]);
				
				if(_objectName in DZE_trees) then
				{
					if(!_nearestTreeFound) then
					{
						// Add to an array.
						_nearestTree set [(count _nearestTree),_x];
						_nearestTreeFound = true;
						diag_log("Found nearby tree..");
					};
					_nearbyTrees = _nearbyTrees + 1;
				};
			};
		};
	} forEach nearestObjects [getPos _unit,[],_viewRange];

	if(_nearbyTrees > 3) then
	{
		// Tell the group
		if(_difficulty == "HARD" || _difficulty == "WAR_MACHINE") then
		{	
			_unit groupChat "ZFS_ETC_FOUND -  Roger that. Found nearby tree cover.";
			_unit sideChat "Roger that. Found nearby tree cover.";
		};
		
		// Go to the tree!
		_unit doMove (getPos _nearestTree); 
		diag_log("Moving to..");
	}
	else
	{
		// Tell the group
		if(_difficulty == "HARD" || _difficulty == "WAR_MACHINE") then
		{	
			_unit groupChat "ZFS_ETC_NOTFOUND - Negative! Cannot find tree cover."; 
			_unit sideChat "Negative! Cannot find tree cover."; 
		};
	};
};

/*
	ZFM_DoBootStrap
	
	Starts up all the checks necessary to ensure that AI and Missions can be loaded.
*/
ZFM_DoBootStrap = {

    private["_checkAI","_outputMessage","_checkAI"];
    
	// Check to see if any AI is already set. 
	_checkAI = [] call ZFM_CheckExistingAI;
	
	// Consistency with error or information logging.
	_outputMessage = ZFM_Name + ZFM_Version;
	
	if(!_checkAI) exitWith { diag_log(_outputMessage + "CheckExistingAI - No other AI is installed. Proceeding with initialization steps for ZFM") };	

	diag_log(_outputMessage + "DoBootStrap - Adding Centers for AI to congregate around..");
	
	// Create the Centers for AI
	ZFM_GROUP_EAST = createCenter east;
	ZFM_GROUP_WEST = createCenter west;
	ZFM_GROUP_CIVILIAN = createCenter civilian;
	ZFM_GROUP_RESISTANCE = createCenter resistance; // Vive Le Resistance!
	
	// unfriendly AI bandits
	// TODO: SET TO 0 once debugging is completed :-)
	EAST setFriend [WEST, 1];
	EAST setFriend [RESISTANCE, 1];

	// Players
	WEST setFriend [EAST, 1];
	WEST setFriend [RESISTANCE, 1];

	// friendly AI
	RESISTANCE setFriend [EAST, 1];
	RESISTANCE setFriend [WEST, 1];
};

/*
*	ZFM_CheckExistingAI
* 
*	Check to see if existing AI systems are installed. 
*/
ZFM_CheckExistingAI = {
    private["_doExit","_outputMessage"];
    
    
	_doExit = false;
	_outputMessage = ZFM_Name + ZFM_Version;
	
	/*
	* 	 Check For WickedAI.
	*/
	if(!isNil(WAIconfigloaded)) then
	{
		diag_log(_outputMessage + "CheckExistingAI - WickedAI discovered. This will interfere with ZFM, and must be disabled before ZFM can run. Exiting.");
		_doExit = true;
	};
	
	/*
	*	Check for SARGE AI
	*/
	if(!isNil(SAR_version)) then
	{
		diag_log(_outputMessage + "CheckExistingAI - SARGE AI discovered. This will interfere with ZFM, and must be disabled before ZFM can run. Exiting.");
		_doExit = true;
	};
	
	/*
	*	Check for DZ AI
	*/
	if(!isNil(DZAI_isActive)) then
	{
		diag_log(_outputMessage + "CheckExistingAI - DZ AI discovered. This will interfere with ZFM, and must be disabled before ZFM can run. Exiting.");
		_doExit = true;	
	};

	_doExit
};

/*
*	ZFM_EquipAIFromArray
*
*	Provide an array in the ZFM format, and equip the unit with the weapons proscribed.
*/
ZFM_EquipAIFromArray ={
	private ["_ai","_equipArray","_primaryWeap","_numMagazines","_unitBackPk","_unitBackPack","_primaryWeapon","_magazineToAdd","_x"];
	
	_ai = _this select 0;
	_equipArray = _this select 1;
	
	// Select things from the AI array.
	_skin = _equipArray select 0;
	_primaryWeap = _equipArray select 1;
	
	// What number of magazines will they spawn with? 
	_numMagazines = _equipArray select 2;
	
	_numMagazines = _numMagazines +5; // Make sure they have at least 5 magazines to start with.
	
	// What backpack?
	_unitBackPk = _equipArray select 3;
	
	// Random pick from the equipment Array
	_primaryWeapon = _primaryWeap call BIS_fnc_selectRandom;
	
	// Random pick from the backpack array
	_unitBackPack = _unitBackPk call BIS_fnc_selectRandom;
	
	// Get the magazine for the weapon out of the config file. DZMS is fun, but why always give them the first one? 
	_magazineToAdd = getArray(configFile >> "CfgWeapons" >> _primaryWeapon >> "magazines") select 0;	
		
	diag_log(format["Skin %1, PrimaryWeap %2, NumMagazines %3,Primary Weapon %4,Backpack %5 ,AI %6, magazine %7",_skin,_primaryWeap,_numMagazines,_primaryWeapon,_unitBackPack,_ai,_magazineToAdd]);
		
	// This is messy; I should join the magazines array and the med supplies array and loop through them all, but fuck it. 
	for [{_x =1},{_x <= _numMagazines},{_x = _x +1} ] do
	{
		_ai addMagazine _magazineToAdd;
	};
	
	_ai addWeapon _primaryWeapon;
	_ai addBackpack _unitBackPack;
};

/*
	ZFM_SetAISkills
	
	Sets AI skills based on config arrays. 
*/
ZFM_SetAISkills ={
	private ["_unit","_difficulty","_skillsArray","_numSkills","_thisRow","_skill","_currSkill","_x"];
	
	_unit  = _this select 0;
	_difficulty = _this select 1;
	
	_skillsArray = [];
	
	// Get the array of skills.
	switch(_difficulty) do 
	{
		case "DEADMEAT": {
			_skillsArray = ZFS_Skills_AI_DEADMEAT;
		};
		case "EASY": {
			_skillsArray = ZFS_Skills_AI_EASY;
		};
		case "MEDIUM": {
			_skillsArray = ZFS_Skills_AI_MEDIUM;
		};
		case "HARD": {
			_skillsArray = ZFS_Skills_AI_HARD;
		};
		case "WAR_MACHINE": {
			_skillsArray = ZFS_Skills_AI_WAR_MACHINE;
		};
	};
	
	_numSkills = count _skillsArray;
	
	// Now we have the skills array, loop through it and set the setSkill array
	for [{_x =0},{_x <= _numSkills-1},{_x = _x +1} ] do
	{
		// Get the whole row..
		_thisRow = _skillsArray select _x;
		
		// Get the items..
		_skill = _thisRow select 0;
		_maxBound = _thisRow select 1;
		
		_currSkill = random _maxBound;
		
		_unit setSkill [_skill,_currSkill];
		
		diag_log(format["Unit skill %1 set to %2",_skill,_currSkill]);
	};
};

/*
	ZFM_Disable_Default_AI
	
	Disables default AI for debugging purposes.
*/
ZFM_Disable_Default_AI ={
	private ["_unit"];
	
	_unit = _this select 0;
	
	_unit disableAI "TARGET";
	_unit disableAI "AUTOTARGET";
	_unit disableAI "FSM";
};

/*
*	ZFM_CreateUnit
*
*	Create a ZFM_typed unit.
*/
ZFM_CreateUnit ={
	private ["_aiGroup","_difficulty","_skin","_unit","_spawnAt","_equipArray"];

	_aiGroup = _this select 0;
	_difficulty = _this select 1;
	_spawnAt = _this select 2;
	_unitType = _this select 3;
	
	if not (_unitType in ZFM_AI_TYPES) exitWith { diag_log("ZFM_CreateUnit: Unit with unsupported type provided. Function exited.")};
	
	_equipArray = [];
	
	switch(_difficulty) do
	{
		case "DEADMEAT": {
			switch(_unitType) do
			{
				case ZFM_AI_TYPE_SNIPER: {
					_equipArray = ZFS_Equipment_Sniper_EASY;
				};
				
				case ZFM_AI_TYPE_RIFLEMAN: {
					_equipArray = ZFS_Equipment_Rifleman_EASY;
				};
				case ZFM_AI_TYPE_COMMANDER: {
					_equipArray = ZFS_Equipment_Commander;
				};
				case ZFM_AI_TYPE_HEAVY: {
					_equipArray = ZFS_Equipment_Heavy_EASY;
				};
			};
		};
		case "EASY": {
			switch(_unitType) do
			{
				case ZFM_AI_TYPE_SNIPER: {
					_equipArray = ZFS_Equipment_Sniper_EASY;
				};
				
				case ZFM_AI_TYPE_RIFLEMAN: {
					_equipArray = ZFS_Equipment_Rifleman_EASY;
				};
				case ZFM_AI_TYPE_COMMANDER: {
					_equipArray = ZFS_Equipment_Commander;
				};
				case ZFM_AI_TYPE_HEAVY: {
					_equipArray = ZFS_Equipment_Heavy_EASY;
				};
			};
		};
		case "MEDIUM": {
			switch(_unitType) do
			{
				case ZFM_AI_TYPE_SNIPER: {
					_equipArray = ZFS_Equipment_Sniper_MEDIUM;
				};
				
				case ZFM_AI_TYPE_RIFLEMAN: {
					_equipArray = ZFS_Equipment_Rifleman_MEDIUM;
				};
				case ZFM_AI_TYPE_COMMANDER: {
					_equipArray = ZFS_Equipment_Commander;
				};
				case ZFM_AI_TYPE_HEAVY: {
					_equipArray = ZFS_Equipment_Heavy_MEDIUM;
				};
			};
		};
		case "HARD": {
			switch(_unitType) do
			{
				case ZFM_AI_TYPE_SNIPER: {
					_equipArray = ZFS_Equipment_Sniper_HARD;
				};
				
				case ZFM_AI_TYPE_RIFLEMAN: {
					_equipArray = ZFS_Equipment_Rifleman_HARD;
				};
				case ZFM_AI_TYPE_COMMANDER: {
					_equipArray = ZFS_Equipment_Commander;
				};
				case ZFM_AI_TYPE_HEAVY: {
					_equipArray = ZFS_Equipment_Heavy_HARD;
				};
			};
		};
		case "WAR_MACHINE": {
			switch(_unitType) do
			{
				case ZFM_AI_TYPE_SNIPER: {
					_equipArray = ZFS_Equipment_Sniper_WAR_MACHINE;
				};
				
				case ZFM_AI_TYPE_RIFLEMAN: {
					_equipArray = ZFS_Equipment_Rifleman_WAR_MACHINE;
				};
				case ZFM_AI_TYPE_COMMANDER: {
					_equipArray = ZFS_Equipment_Commander;
				};
				case ZFM_AI_TYPE_HEAVY: {
					_equipArray = ZFS_Equipment_Heavy_WAR_MACHINE;
				};
			};
		};
	};
	
	// Get the skin out of the ZFM unit type
	_skin = _equipArray select 0;

	// Spawn the unit..
	_unit = [_aiGroup,_skin,_spawnAt] call ZFM_InitUnitSpawn;
	
	// "I was never given a name.."
	[_unit] call ZFM_GiveUnitName;
	
	// Ad the relevant equipment from the EquipArray
	[_unit,_equipArray] call ZFM_EquipAIFromArray;
	
	// Set the skills for the unit..
	[_unit,_difficulty] call ZFM_SetAISkills;
	
	// Add variables to unit for ZFM
	_unit setVariable ["ZFM_Unit",true]; // For mission checking
	_unit setVariable ["ZFM_UnitType",_unitType];
	_unit setVariable ["ZFM_UnitDifficulty",_difficulty];
	
	// Turn all the switches on, baby.
	_unit enableAI "TARGET";
	_unit enableAI "AUTOTARGET";
	_unit enableAI "MOVE";
	_unit enableAI "ANIM";
	_unit enableAI "FSM";
	_unit setCombatMode "RED";
	_unit setBehaviour "COMBAT";
	
	_unit
};

/*
	ZFM_CreateUnitGroup
	
	Takes an array input and other requirements to generate groups of AI at once. Returns in an array for convenience.
*/
ZFM_CreateUnitGroup ={
	private["_unitsArray","_difficulty","_side","_thisUnit","_spawnAt","_uArrayReturn","_unitGroup","_unitsArrayCount","_aiType","_thisUnit","_x"];

	_unitsArray = _this select 0;
	_difficulty = _this select 1;
	_side = _this select 2;
	_spawnAt = _this select 3;
	_missionID = _this select 4;
	
	_uArrayReturn = [];
	
	if(typeName _unitsArray =="ARRAY") then
	{
		_unitsArrayCount = count _unitsArray; 
	
		if(_unitsArrayCount > 0) then
		{
			//Create AI group..
			_unitGroup = [_side] call ZFM_CreateAIGroup;
			
			for [{_x =0},{_x <= _unitsArrayCount-1},{_x = _x +1} ] do
			{
				_aiType = _unitsArray select _x;
				
				if(_aiType in ZFM_AI_TYPES) then
				{
					// Stagger them so they aren't just crushed or what have you.
					_staggerSpawnAt = [_crashPos,(round random 10),(round random 10)] call ZFM_Create_OffsetPosition;
				
					diag_log(format["%1 %2 - ZFM_CreateUnitGroup - Unit %3 of %4  (type %5) created..",ZFM_NAME,ZFM_VERSION,_x,(_unitsArrayCount-1),_aiType]);
					_thisUnit = [_unitGroup,_difficulty,_staggerSpawnAt,_aiType] call ZFM_CreateUnit;
				
					// Lets us find out which mission the unit is attached to.
					_thisUnit setVariable ["ZFM_MISSION_ID",_missionID];
					
					_thisUnit addMPEventHandler["MPKilled",{
						[(_this select 0),(_this select 1)] call ZFM_Handle_MissionUnitKilled;
					}];
					
					
					// Add to the array return
					_uArrayReturn = _uArrayReturn + [_thisUnit];
				};
			};
			
			// Stops them from killing eachother when they fire..s
			_unitGroup setFormation "ECH LEFT";
			
		};
	};
	
	// Return the units so we can muck around with them, tell them to get in cars, etc. 
	[_unitGroup,_uArrayReturn]
};

/*
	ZFM_CreateCrashMarker
	
	Creates a marker for a crash
*/
ZFM_CreateCrashMarker ={
	private ["_location","_difficulty","_markerText","_markerCreated","_markerColor","_markerSize","_markerType"];
	
	_location = _this select 0;
	_difficulty = _this select 1;
	_markerText =_this select 2;
	
	// Create the marker
	
	_markerColor = "ColorWhite";
	_markerSize = 150;

	diag_log(format["Crash Marker. Location %1, Difficulty %2, MarkerText %3",_location,_difficulty,_markerText]);
	
	
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

	_markerCreated = createMarker[format["%1",(round random 999999)],_location];
	_markerCreated setMarkerShape "ELLIPSE";
	_markerCreated setMarkerBrush "Solid";
	_markerCreated setMarkerSize [_markerSize,_markerSize];
	_markerCreated setMarkerColor _markerColor;
	
	// Bugfix: Add marker text (requires another marker)
	_textMarkerCreated = createMarker[format["%1",(round random 999999)],_location];
	_textMarkerCreated setMarkerColor "ColorBlack";
	_textMarkerCreated setMarkerType "Warning";
	_textMarkerCreated setMarkerText format["%1 (%2)",_markerText,_difficulty];
	
	[_markerCreated,_textMarkerCreated]
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
	ZFM_CreateCrashVehicle_Sub
	
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
		diag_log(format["%1 %2 - ZFM_CreateCrashVehicle_NoWater - Creating crash, hopefully not in water..",ZFM_NAME,ZFM_VERSION]);
					
		// Watch it crash, see if it's in water, then if it is, no thanks, try again.
		while{alive _createdVehicle} do
		{
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
	ZFM_CrashSite_OffsetPosition
	
	Offsets the Position on x axis.
*/
ZFM_Create_OffsetPosition ={

	private["_position","_x","_y","_z","_newX"];
	
	_position = _this select 0;
	_offsetX = _this select 1;
	_offsetY = _this select 2;

	_x = _position select 0;
	_y = _position select 1;
	_z = _position select 2;
	
	_newX = _x -_offsetY;
	_newY = _y - _offsetY;
	
	// Return the position
	[_newX,_newY,_z]
};

/*
	ZFM_CreateCrash_Accoutrements
	
	Create nice little additions around the crash..
*/
ZFM_CreateCrash_Accoutrements ={
	private["_crashLocation","_difficulty","_thisAccObject","_doRandLoc","_createdAccout","_randomFort","_createdAccObjects","_accoutObjects","_accoutObjAmount"];
	
	_crashLocation = _this select 0;
	_difficulty = _this select 1;
	
	_createdAccObjects = [];
	_accoutObjects = [];
	_accoutObjAmount = 2;
	
	switch(_difficulty) do
	{
		case "EASY" : {
			_accoutObjects = ZFM_Accoutrements_Minor;
			_accoutObjAmount = 6;
		};
		case "MEDIUM" : {
			_accoutObjects = ZFM_Accoutrements_Medium;
			_accoutObjAmount = 5;
		};
		case "HARD" : {
			_accoutObjects = ZFM_Accoutrements_Ridiculous;
			_accoutObjAmount = 3;
		};
		case "WAR_MACHINE" : {
			_accoutObjects = ZFM_Accoutrements_Ridiculous;
			_accoutObjAmount = 3;
		};
	};
	
	if(_difficulty != "DEADMEAT") then
	{
		for [{_x =1},{_x <= _accoutObjAmount},{_x = _x +1} ] do
		{
			_doRandLoc = [_crashLocation,(round random 25),(round random 25)] call ZFM_Create_OffsetPosition;
			
			diag_log(format["ACCOUT OBJECTS %1, RANDLOC %2",_accoutObjects,_doRandLoc]);
			
			// Get the object name from the list set above..
			_thisAccObject = _accoutObjects call BIS_fnc_selectRandom;
			
			diag_log(format["THIS ACCOBJECT %1",_thisAccObject]);
			
			// Create the accoutrements..
			_createdAccout = createVehicle [_thisAccObject,_doRandLoc,[],0,"CAN_COLLIDE"];
			
			// So we can then do cleanup of all accoutrements if necessary
			_createdAccout setVariable["ZFM_Accoutrement",true];
			_createdAccObjects set[_x,_createdAccout];
		};
	};
	_createdAccObjects
};

/*
	ZFM_Alter_Humanity
	
	Add/Remove humanity for a given player.
*/
ZFM_Alter_Humanity ={
	private ["_player","_currentHumanity","_humanityToAdd"];
	
	_player = _this select 0;
	_humanityToAdd = ZFM_HUMANITY_AMOUNT_PER_BANDIT;
	
	if(typeName _player == "OBJECT") then
	{
		_currentHumanity = _player getVariable["humanity",0];
		
		if(ZFM_HUMANITY_AMOUNT_PER_BANDIT >0) then
		{
			if(!ZFM_HUMANITY_AMOUNT_FIXED) then
			{
				_humanityToAdd = round random ZFM_HUMANITY_AMOUNT;
			};
			_player setVariable["humanity",_currentHumanity + _humanityToAdd];
		};
	};
};



/*
ZFM_UnitGroup_GetInVehicle_Goto ={
	private ["_group","_vehicle","_gotoLocation","_x"];
	
	_group = _this select 0; // Side group
	_vehicle = _this select 1;
	_gotoLocation = _this select 2;
	
	if(typeName _unitGroup == "ARRAY") then
	{
		_group setFormation "DIAMOND"; // Just for a laugh
	
		// Firstly tell the group to get into the car..
		_gotoCarWP = _group addWaypoint[position _vehicle, 0];
		_gotoCarWP setWaypointType "GETIN";
		
		// Wait for that..
		sleep 50;
		
		// Now move to the _gotoLocation
		_gotoCarWP setWaypointType "MOVE";
		_gotoCarWP setWaypointPosition [_gotoLocation,0];
	};
};
*/