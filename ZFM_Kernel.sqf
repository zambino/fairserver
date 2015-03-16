/*
Zambino Fair Mission
Copyright (C) 2014,2015 Jordan Ashley Craw

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

// This is appended to by missions
ZFM_DEFINES_KERNEL_TYPES =[];
ZFM_KERNEL_STACK =[];

/*
	Stages
    Initialisation - Things done before the mission is announced to the player.
    Start - Things done while/during announcing the mission to the player
    Idle - Things done while the mission has started but nobody is in the area.
    Active - Things done while the mission is running and players are interacting with it.
    Expired - Things done when the mission has expired.
    Completed - Things done when the mission has completed
    Deactivated - Things done after the mission has completed and everything else has been done. 
*/


/*
*	The friendly name of the module
*	The name of the module
*	The name of the author
*	The author's e-mail
*	The author's website
*	The version of the module
*	The location of the module (folder name)
*	Any additional include files
*/


/*
*	ZFM_Kernel_InitModules
*
*	Initialises modules by adding required stuff.
*/
ZFM_Kernel_InitModules = {
	private["_modules","_moduleName","_modulePath","_moduleInstalled"];

	// Exit if we can't list the modules
	if(isNil "ZFM_MODULES") exitWith { "Fatal error: Can't build module list." call ZFM_Common_Debug; };

	if(typeName ZFM_MODULES == "ARRAY") then
	{
		if(count ZFM_MODULES >0) then
		{
			_numModules = count ZFM_MODULES;
			_modules = [];

			format["Kernel Init: Found %1 modules. Beginning initialization",_numModules];

			{
				// Ignore empty elements or junk.
				if(!isNil "_x" && typeName _x == "ARRAY") then
				{
					// Needs to be a fully-formed array definition.
					if(count _x == 8) then
					{
						// Debug log to say: 
						format["Kernel Init Module: %1 %2 by %3 (%4). [More info: %5]",(_x select 0),(_x select 1),(_x select 2),(_x select 3),(_x select 4)] call ZFM_Common_Debug;
						
						// Name of the module SQF file
						_moduleName = format["ZFM_Mission_Type_%1.sqf",(_x select 5)];
						_modulePath = format["Missions\%1%2\%3",ZFM_CONFIGURE_INSTALL_LOCATION,(_x select 6),_moduleName];

						// Include it..
						call compile preprocessFileLineNumbers _modulePath;

						// On Server, no message on the client will appear -- so if this variable doesn't exist, then.. It's not installed.
						_moduleInstalled = not (isNil format["ZFM_Mission_Type_%1_Installed",(_x select 5)]);
						
						if(!_moduleInstalled) then
						{
							format["Kernel Init Module: Module %1 specifying invalid include path at %2",(_x select 5),_modulePath] call ZFM_Common_Debug;
						}
						else
						{
							format["Kernel Init Module: Module init file with valid path %1",_modulePath] call ZFM_Common_Debug;
							_modules = _modules + [_x];
						};
					}
					else
					{
						format["Warning: Skipping module with invalid declaration: %1",_x] call ZFM_Common_Debug;
					};
				};
			} forEach ZFM_MODULES;

			// Log modules loaded
			format["Kernel Init: Completed loading %1 of %2 modules. %3",(count _modules),_numModules,if((count _modules)!=_numModules) then {"Some modules failed to be loaded. Please review errors above."} else {""}] call ZFM_Common_Debug;

			// Rebuild the module array with actual modules.
			ZFM_MODULES = _modules;

			true

		}
		else
		{
			"Fatal error: No modules have added for operation. ZFM needs modules to function!" call ZFM_Common_Debug;
			false
		};
	}
	else
	{
		"Fatal error: Module seems to have been added incorrectly. Re-add as an array and restart." call ZFM_Common_Debug;
		false
	};
};


/*
*	ZFM_Kernel_ByType
*
*	Gets the number of missions in the stack currently by the mission type listed
*/
ZFM_Kernel_ByType ={
	private["_missionType","_numFound"];
	_missionType = _this select 0;

	_numFound = 0;

	{
		if((_x select 0) == _missionType) then
		{
			_numFound = _numFound +1;
		};
	} forEach ZFM_KERNEL_STACK;

	_numFound
};

/*
*	ZFM_Kernel_CanAddNewMission
*
*	Tells us if we can add a new mission to the stack or not.
*/
ZFM_Kernel_CanAddNewMission ={
	((count ZFM_KERNEL_STACK) < ZFM_CONFIGURE_MISSIONS_ALLTYPES_MAX_CONCURRENT_MISSIONS)
};


/*
	Mission Array

	0 = Type of mission
	1 = Datetime started
	2 = Datetime to expire
	3 = Mission parameters as an array
	4 = Units as an array
	5 = Objects as an array
	6 = Markers as an array
	7 = To be added
*/

/*
*	ZFM_Kernel_GetUnitsKilled
*
*	Checks how many units are killed and how many are there in total.
*/
ZFM_Kernel_GetUnitsKilled ={
	private["_missionID","_missionUnits","_unitsKilledCount"];
	_missionID = _this select 0;

	// Handle the mission ID checking.
	_missionExists = [_missionID] call ZFM_Kernel_MissionExists;
	if(not _missionExists) exitWith{[0,0]};

	// Get the units array
	_missionUnits = ZFM_KERNEL_STACK select _missionID select 4;

	// Start counting.
	_unitsTotalCount = count _missionUnits;
	_unitsKilledCount = 0;

	// Loop the units
	{
		if(!(alive _x)) then
		{
			_unitsKilledCount = _unitsKilledCount +1;
		};
	} forEach _missionUnits;

	// 0 = killed, 1 = total
	[_unitsKilledCount,_unitsTotalCount]
};

/*
*	ZFM_Kernel_AllUnitsKilled
*
*	Checks if all units in a mission are killed.
*/
ZFM_Kernel_AllUnitsKilled = {	
	private["_missionID","_unitsKilled"];
	_missionID = _this select 0;

	// Get the units killed.
	_unitsKilled = [_missionID] call ZFM_Kernel_GetUnitsKilled;

	// Return whether the total is equal to the current killed
	((_unitsKilled select 0) == (_unitsKilled select 1))

};	


/*
*	ZFM_Kernel_HasExpired
*
*	Checks if a mission has expired.
*/
ZFM_Kernel_HasExpired = {
	private["_missionID"];
	_missionID = _this select 0;

	// Does the mission exist?
	_missionExists = [_missionID] call ZFM_Kernel_MissionExists;

	// Exit right away, technically if it's not there, it has expired. It has ceased to be.
	if(not _missionExists) exitWith{true};

	// Okay, so it exists, so has it expired, then?
	// Get the current time.
	_currentTime = diag_tickTime;

	if(_currentTime > (ZFM_KERNEL_STACK select _missionID select 2)) then
	{
		if(true) exitWith{true};
	}
	else
	{
		if(true) exitWith{false};
	};

};

/*
*	ZFM_Kernel_MissionExists
*
*	Checks if a given mission exists.
*/
ZFM_Kernel_MissionExists ={
	(format["%1",(ZFM_KERNEL_STACK select (_this select 0))] != "")
};

/*
*	ZFM_Kernel_PrepareNewMission
*
*	Prepares a new mission array to be added.
*/
ZFM_Kernel_AddNewMission ={
	private["_missionType","_missionExpireTimeMins","_missionParameters","_missionUnits","_missionObjects","_missionMarkers","_missionArray"];
	_missionType = _this select 0;
	_missionParameters = _this select 1;
	_missionUnits = _this select 2;
	_missionObjects = _this select 3;
	_missionMarkers = _this select 4;

	// Get the start time as tickTime (ms)
	_startTime = diag_tickTime;

	// Get the time this was supposed to start and add the expire time to it. 
	//_expireTime = _startTime + (ZFM_CONFIGURE_MISSIONS_ALLTYPES_EXPIRE_TIME*60000);
	_expireTime = _startTime + 5;

	// Generate the mission array with all the vitamins required for a growing mission..
	_missionArray = [
		_missionType,
		"CREATED",
		_startTime,
		_expireTime,
		_missionParameters,
		_missionUnits,
		_missionObjects,
		_missionMarkers
	];

	// Insert a new mission into the mission array.
	_inserted = _missionArray call ZFM_Kernel_InsertNewMission;

	// Did it work?
	_inserted
};


ZFM_TRACKING_KERNEL_CACHE_NUM_MISSIONS = 0;


ZFM_Kernel_TimeOut = {
	private["_continue"];
	_continue = true;

	//Get the current count of the stack.
	_stackSize = count ZFM_KERNEL_STACK;

	// Log start up
	"Kernel Cleaner: Cleanup loop beginning.." call ZFM_Common_Debug;

	while {_continue} do
	{
		"Kernel Cleaner: Waiting for stack to update." call ZFM_Common_Debug;
		waitUntil {count ZFM_KERNEL_STACK >0};

		"Kernel Cleaner: Stack is active. Beginning mission loop." call ZFM_Common_Debug;

		// Loop each item in the stack.
		for [{_x=0},{_x<=count ZFM_KERNEL_STACK-1},{_x=_x+1}] do
		{
			if(format["%1",(ZFM_KERNEL_STACK select _x)] != "" && typeName (ZFM_KERNEL_STACK select _x) == "ARRAY") then
			{
				// Select the current row.
				_thisRow = ZFM_KERNEL_STACK select _x;

				format["Kernel Cleaner: Found MissionID %1. Timeout set to %2, current time %3",_x,(_thisRow select 3),diag_tickTime] call ZFM_Common_Debug;

				if(diag_tickTime > (_thisRow select 3)) then
				{
					format["Kernel Cleaner: Mission with ID %1 has expired. Calling expire hook..",_x] call ZFM_Common_Debug;

					// Call hook to show mission has expired.
					["MISSION_EXPIRED",_thisRow] call ZFM_Hooks_Handler;

					// Set it as expired.
					ZFM_KERNEL_STACK set[_x,"EXPIRED_MISSION"];

					// Need to create a timeout hook to handle this.
					[] spawn (call compile format["ZFM_Mission_Type_%1_End",_thisRow select 0]);
				};
			};
		};

		// Wait 30 seconds
		sleep 30;
	};
};

ZFM_Kernel_Start ={
	private["_continue","_cachedNumberMissions"];
	_continue = true;

	// Do all of the including of each of the modules supplied.
	[] call ZFM_Kernel_InitModules;

	// Start up the second running process to do cleanup on the array 
	[] call ZFM_Kernel_TimeOut;

	// Loop it.
	while{_continue } do
	{
		_numMissions = count ZFM_KERNEL_STACK;

		if(_numMissions == ZFM_TRACKING_KERNEL_CACHE_NUM_MISSIONS) then
		{
			// Debug log new mission waiting..
			format["Kernel waiting for a new mission to be added. %1 missions in stack.",_numMissions] call ZFM_Common_Debug;
			sleep 20; // Wait for the stack to update.
		}
		else
		{
			// Debug log new item.
			format["Kernel discovered new item in stack. Initialisation of mission starting.."] call ZFM_Common_Debug;			
			ZFM_TRACKING_KERNEL_CACHE_NUM_MISSIONS = _numMissions;

			// Run the mission init function

			sleep 20; // Wait for stack to update.
		};
	};

	
	
};

/*
*	ZFM_Kernel_InsertNewMission
*
*	Adds a new mission to the mission stack.
*/
ZFM_Kernel_InsertNewMission = {
	private["_missionArray","_canAddNewMission"];

	// Create the mission array
	_missionArray = _this;

	// Can we add a new mission?
	_canAddNewMission = call ZFM_Kernel_CanAddNewMission;

	if(_canAddNewMission) then
	{
		ZFM_KERNEL_STACK set[(count ZFM_KERNEL_STACK),_missionArray];
		if(true) exitWith{true};
	}
	else
	{
		if(true) exitWith{false};
	};
};