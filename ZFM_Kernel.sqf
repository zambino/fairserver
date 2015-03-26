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

/*
*	ZFM_KERNEL_MODULE_HOOKS
*
*	Basic hooks only, lads..
*/
ZFM_KERNEL_MODULE_HOOKS =[
	"ZFM_Mission_Type_%1_Initialize",
	"ZFM_Mission_Type_%1_Start",
	"ZFM_Mission_Type_%1_Status",	// Mission status (started, in progress, idle)
	"ZFM_Mission_Type_%1_End",		// Used for ending the mission
	"ZFM_Mission_Type_%1_Display"	// Used for displaying text
];
ZFM_KERNEL_ENABLED_MODULES =[
	
];

// This is appended to by missions
ZFM_DEFINES_KERNEL_TYPES =[];
ZFM_KERNEL_STACK =[];

/*
	Statuses
	Created - Nothing done at all..
    Initialisation - Things done before the mission is announced to the player.
    Start - Things done while/during announcing the mission to the player
    Idle - Things done while the mission has started but nobody is in the area.
    Active - Things done while the mission is running and players are interacting with it.
    Expired - Things done when the mission has expired.
    Completed - Things done when the mission has completed
    Deactivated - Things done after the mission has completed and everything else has been done. 
*/

ZFM_Kernel_Verify_Modules ={
	private["_hooksFound"];
	_hooksFound = 0;
	_modulesFound = 0;
	_hooksTotal = count ZFM_KERNEL_MODULE_HOOKS;
	_modulesTotal = count ZFM_MODULES;

	{
		// Get the module name..
		_moduleName = _x select 5;

		{
			format["Kernel Init: Module hook: %1 %2 ",format[_x,_moduleName],if(!isNil format[_x,_moduleName]) then {_hooksFound = _hooksFound + 1; "FOUND"} else {"NOT FOUND - please ensure that your module implements ALL required hooks."}] call ZFM_Common_Debug;
		} forEach ZFM_KERNEL_MODULE_HOOKS;

		// Log the outcome
		format["Kernel Init: Found %1 of %2 mandatory hooks for module type: %3",_hooksFound,_hooksTotal,_moduleName] call ZFM_Common_Debug;
		
		// Add it 
		if(_hooksFound == _hooksTotal) then 
		{
			_hooksFound = 0;
			_modulesFound = _modulesFound +1;
			ZFM_KERNEL_ENABLED_MODULES = ZFM_KERNEL_ENABLED_MODULES + [_moduleName];
		}
		else
		{	
			_hooksFound = 0;
		};
	} forEach ZFM_MODULES;

	format["Kernel Init: Loaded %1 of %2 modules.",_modulesFound,_modulesTotal] call ZFM_Common_Debug;

	// Return if modules have been found
	(_modulesFound > 0)
};


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
	_missionVehicles = _this select 3;
	_missionMarkers = _this select 4;
	_missionTriggers = if(count _this == 6) then { _this select 5} else { [] };
	_missionLoot = if(count _this == 7) then { _this select 6} else { [] };

	// Get the start time as tickTime (ms)
	_startTime = diag_tickTime;

	// Get the time this was supposed to start and add the expire time to it. 
	_expireTime = _startTime + (ZFM_CONFIGURE_MISSIONS_ALLTYPES_EXPIRE_TIME*60000);


	// Generate the mission array with all the vitamins required for a growing mission..
	_missionArray = [
		_missionType,
		"CREATED",
		_startTime,
		_expireTime,
		[
			_missionParameters,
			_missionUnits,
			_missionVehicles,
			_missionMarkers,
			_missionTriggers,
			_missionLoot
		]
	];

	// Insert a new mission into the mission array.
	_inserted = _missionArray call ZFM_Kernel_InsertNewMission;

	// Did it work?
	_inserted
};



ZFM_TRACKING_KERNEL_CACHE_NUM_MISSIONS = 0;


/*
*	The next time a complete stack flush will occur.
*/
ZFM_TRACKING_KERNEL_CLEAN_NEXT_FLUSH = 0;

/*
*	ZFM_Kernel_TimeOut
*
*	Runs through the mission stack and clears timed out missions.
*/
ZFM_Kernel_TimeOut = {
	private["_continue"];
	_continue = true;

	//Get the current count of the stack.
	_stackSize = count ZFM_KERNEL_STACK;

	// Set the next flush in thirty seconds.
	ZFM_TRACKING_KERNEL_CLEAN_NEXT_FLUSH = diag_tickTime + (300000);

	// Log start up
	"Kernel Cleaner: Cleanup loop beginning.." call ZFM_Common_Debug;

	while {_continue} do
	{
		"Kernel Cleaner: Waiting for stack to update." call ZFM_Common_Debug;
		waitUntil {count ZFM_KERNEL_STACK >0};

		"Kernel Cleaner: Stack is active. Beginning mission loop." call ZFM_Common_Debug;

		// Advise on next flush
		format["Kernel Cleaner: Next flush in %1 minutes",round((ZFM_TRACKING_KERNEL_CLEAN_NEXT_FLUSH - diag_tickTime)/60000)] call ZFM_Common_Debug;

		if(diag_tickTime >= ZFM_TRACKING_KERNEL_CLEAN_NEXT_FLUSH) then
		{
			
			_expiredMissions = 0;
			{
				if(typeName _x == "STRING") then
				{
					_expiredMissions = _expiredMissions +1;
				};

			} forEach ZFM_KERNEL_STACK;

			if(_expiredMissions == (count ZFM_KERNEL_STACK-1)) then
			{
				ZFM_KERNEL_STACK = [];
				ZFM_TRACKING_KERNEL_CLEAN_NEXT_FLUSH = diag_tickTime + (300000);
				format["Kernel Cleaner: Stack has been reset with %1 inactive missions cleared",_expiredMissions] call ZFM_Common_Debug;
			};
		};

		// Loop each item in the stack.
		for [{_x=0},{_x<=count ZFM_KERNEL_STACK-1},{_x=_x+1}] do
		{
			if(format["%1",(ZFM_KERNEL_STACK select _x)] != "" && typeName (ZFM_KERNEL_STACK select _x) == "ARRAY") then
			{
				// Select the current row.
				_thisRow = ZFM_KERNEL_STACK select _x;

				// Found a mission
				format["Kernel Cleaner: Found MissionID %1. Timeout set to %2, current time %3",_x,(_thisRow select 3),diag_tickTime] call ZFM_Common_Debug;

				// Has it expired?
				if(diag_tickTime > (_thisRow select 3)) then
				{
					format["Kernel Cleaner: Mission with ID %1 has expired. Calling expire hook..",_x] call ZFM_Common_Debug;

					// Call hook to show mission has expired.
					[_x,"EXPIRED"] call ZFM_Kernel_Set_Stack_Item_Status;

					// Need to create a timeout hook to handle this.
					[] spawn (call compile format["ZFM_Mission_Type_%1_End",_thisRow select 0]);
				};
			};
		};

		// Wait 60 seconds
		sleep 60;
	};
};


/*
*	ZFM_Kernel_Verify_Modules
*
*	Verifies any mission items waiting to be executed.
*/
ZFM_Kernel_Examine_Stack = {
	private["_functionCall","_return","_params","_stackItem","_status","_type","_functionCall"];

  	for [{_x=0},{_x<=count ZFM_KERNEL_STACK-1},{_x=_x+1}] do
  	{
  		diag_log(format["STACK IS %1",ZFM_KERNEL_STACK]);
  		_item = (ZFM_KERNEL_STACK select _x);

  		if(typeName _item == "ARRAY") then
  		{
			// Type of mission
			_type = _item select 0;

			// Status of the stack item.
		  	_status = _item select 1;

		  	switch(_status) do
		  	{
		  		/*
				*	HOOKS:
				*
				*	All excluding "status" must return an array with the format:
				*
				*	[
				*		RETURN_VALUE		(bool),
						[
							Parameters,
							Units,
							Vehicles,
							Markers,
							Triggers,
							etc.	
						]
				*	]
		  		*/
		  		case "CREATED":{
		  			_functionCall = call compile format["ZFM_Mission_Type_%1_Initialize",_type];

		  			if(typeName _functionCall == "CODE") then 
		  			{
			  			// Call it as we want to know what the return value is
			  			_returnArray = [_x,_item] call _functionCall;
			  			
			  			// Get the return value first..
			  			_return = _returnArray select 0;
			  			_params = _returnArray select 1;

			  			// Don't reset it if the array isn't set properly. Why bother?
			  			if((count _params) == 6) then 
						{
				  			_stackItem = ZFM_KERNEL_STACK select _x;
				  			_stackItem set[4,_params];
				  			ZFM_KERNEL_STACK set[_x,_stackItem];
						};	

			  			// Returns true to say "All MY INIT IS DONE!"
			  			if(_return) then 
			  			{
			  				// It's initialized..
			  				[_x,"INITIALIZED"] call ZFM_Kernel_Set_Stack_Item_Status;
			  			}
			  			else
			  			{ // Epic fail!
			  				format["Kernel Modules: Mission Type %1 Initialize Function FAILED.",_type] call ZFM_Common_Debug;
			  				[_x,"ERROR"] call ZFM_Kernel_Set_Stack_Item_Status;
			  			};		
		  			};
		  		};		

		  		case "INITIALIZED" :{
		  			_functionCall = call compile format["ZFM_Mission_Type_%1_Start",_type];
			  		
			  		// Call it as we want to know what the return value is
		  			_returnArray = [_x,_item] call _functionCall;
		  			
		  			// Get the return value first..
		  			_return = _returnArray select 0;
		  			_params = _returnArray select 1;

		  			// Don't reset it if the array isn't set properly. Why bother?
		  			if((count _params) == 6) then 
					{
			  			_stackItem = ZFM_KERNEL_STACK select _x;
			  			_stackItem set[4,_params];
			  			ZFM_KERNEL_STACK set[_x,_stackItem];
					};	

		  			if(_return) then
		  			{
		  				[_x,"IDLE"] call ZFM_Kernel_Set_Stack_Item_Status;
		  			}
		  			else
		  			{
		  				format["Kernel Modules: Mission Type %1 Start Function FAILED",_type] call ZFM_Common_Debug;
		  				[_x,"ERROR"] call ZFM_Kernel_Set_Stack_Item_Status;
		  			};
		  		};

				default {

					// If the mission has expired, we do nothing with it. 
					if(_status == "EXPIRED") exitWith {
						format["Kernel Stack: Mission Type %1 with ID %2 has expired. Nothing to action.",_type,_x];
					};

					// Call back to the Status function to find out how the mission is doing..
					_functionCall = call compile format["ZFM_Mission_Type_%1_Status",_type];

		  			_returnArray = [_x,_item] call _functionCall;

		  			// Get the return value first..
		  			_return = _returnArray select 0;
		  			_params = _returnArray select 1;

		  			// Don't reset it if the array isn't set properly. Why bother?
		  			if((count _params) == 6) then 
					{
			  			_stackItem = ZFM_KERNEL_STACK select _x;
			  			_stackItem set[4,_params];
			  			ZFM_KERNEL_STACK set[_x,_stackItem];
					};	

					// 
					if(_return != _status && _return in ["ACTIVE","IDLE","ENDED"]) then
					{
						format["Kernel Stack: Mission Type %1 with ID %2 status changed from %3 to %4",_type,_x,_status,_return] call ZFM_Common_Debug;
						[_x,_return] call ZFM_Kernel_Set_Stack_Item_Status;
					}
					else
					{
						format["Kernel Stack: Mission Type %1 and ID %2 status request from %3 to invalid status %4 ignored.",_type,_x,_status,_return] call ZFM_Common_Debug;
					};

					// Reselect as we updated the
					_type = _item select 0;
				  	_status = _item select 1;

				  	// Updates the 
					format["Kernel Stack: Mission Type %1 and ID %2 has status of %3",_type,_x,_status] call ZFM_Common_Debug;

				};

			};
  		};

  	};
};

ZFM_Kernel_Set_Stack_Item_Status = {
	private["_stackID","_status","_kernelItem"];	
	_stackID = _this select 0;
	_status = _this select 1;

	_kernelItem = (ZFM_KERNEL_STACK select _stackID);
	_kernelItem set [1,_status];

	ZFM_KERNEL_STACK set[_stackID,_kernelItem];
};

/*
*	ZFM_Kernel_Monitor
*	
*	Monitors the stack and adds missions where appropriate.
*/
ZFM_Kernel_Monitor ={

	


	diag_log(format["MOULES %1",ZFM_KERNEL_ENABLED_MODULES]);
};


/*
*	ZFM_Kernel_Start
*
*	Starts the kernel loop.
*/
ZFM_Kernel_Start ={
	private["_continue","_cachedNumberMissions","_modules"];
	_continue = true;

	// Do all of the including of each of the modules supplied. Needs to be
	[] call ZFM_Kernel_InitModules;
	
	// Verify the module has the prerequisite functions to be a module..
	_modules = [] call ZFM_Kernel_Verify_Modules;

	// Exit if modules aren't found
	if(not _modules) exitWith { "Fatal error: Kernel found no modules! Please read logs above and install some!" call ZFM_Common_Debug };

	// Start up the second running process to do cleanup on the array 
	[] spawn ZFM_Kernel_TimeOut;

	// Start up the third running process that monitors 
	[] spawn ZFM_Kernel_Monitor;

	// Loop it.
	while{_continue} do
	{
		// Check for new missions and progressing missions..
		[] call ZFM_Kernel_Examine_Stack;
		sleep 30; // Longer sleeps, better performance; shorter, worse performance better updates
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