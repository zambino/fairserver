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
*	ZFM_MISSION_FUNCTIONS
*
*	Functions that a mission must implement to be called.
*/
ZFM_MISSION_FUNCTIONS =[
	"ZFM_Mission_Type_%1_IntroText",
	"ZFM_Mission_Type_%1_Layout",
	"ZFM_Mission_Type_%1_Units",
	"ZFM_Mission_Type_%1_Vehicles",
	"ZFM_Mission_Type_%1_Location",
	"ZFM_Mission_Type_%1_Settings",
	"ZFM_Mission_Type_%1_Markers",
	"ZFM_Mission_Type_%1_Triggers",
	"ZFM_Mission_Type_%1_Stats",
	"ZFM_Mission_Type_%1_Start",
	"ZFM_Mission_Type_%1_Running",
	"ZFM_Mission_Type_%1_End"
];

/*
*	ZFM_MISSION_NAMES
*
*	Names to corresponding mission filenames
*/
ZFM_MISSION_NAMES =[
	"Crash"
];

/*
*	ZFM_Mission_BootStrap_Missions
*	
*	Loops all available missions, includes them for use.
*/
ZFM_Mission_BootStrap_Missions ={
	{
		call compile preprocessFileLineNumbers format["%1/ZFM_Mission_Type_%2.sqf",ZFM_DEFINES_INSTALL_LOCATION_MISSIONS,_x];
	} forEach ZFM_MISSION_NAMES;
};

/*
*	ZFM_Mission_Validate_Missions
*
*	Validates whether a mission created has all of the requisite functions.
*/
ZFM_Mission_Validate_Mission ={
	private["_name"];
	_name = _this select 0;	

	{
		if(format["%1",_x] == "") exitWith{false}; // Not defines
	} forEach ZFM_MISSION_FUNCTIONS;

	// True if it runs that gauntlet above..
	if(true) exitWith{ true };
};

/*
*	ZFM_Mission_Create_Layout
*
*	Creates a layout for the 
*/
ZFM_Mission_Create_Mission_Layout =[
	private["_layoutArray"];
	_layoutArray = _this select 0;
	
	// Parse the layout.. TODO: Import layout code.
	_layoutArray call ZFM_Layout_Parse;
];


ZFM_Mission_Create_Mission_Vehicles ={
	private["_missionVehicleArray"];
	_missionVehicleArray = _this select 0;

	if(typeName _missionVehicleArray == "ARRAY") then
	{
		{
			// Array needs to match the parameters of ZFM_Defines_Vehicles_Create_Vehicle
			if(typeName _x =="ARRAY" && (count _x) == 5) then
			{
				_return = _x call ZFM_Defines_Vehicles_Create_Vehicle;
				_output = _output + [_return];
			};
		} forEach _missionVehicleArray;

	};

};


/*
*	ZFM_Mission_Create_Mission_Units
*
*	Create mission units -- wrapper for unit functions.
*/
ZFM_Mission_Create_Mission_Units = {
	private["_missionGroupArray"];
	_missionGroupArray = _this select 0;
	
	if(typeName _missionGroupArray == "ARRAY") then
	{
		_output = [];
	
		{
			/*
				Array format for mission units:
				[
					[groupType,location,side,difficulty],
					...
				]
			*/
		
			if(typeName _x == "ARRAY" && (count _x) == 4) then
			{
				_return = _x call ZFM_Defines_Unit_Create_Unit_Group;
				_output = _output + [_return];
			};
			
			/*
				Output:
				[
					[group,[units]],
					[group,[units]]
				]
			*/
			

		} forEach _missionGroupArray;
	};

};
/*
*	ZFM_Mission_Create_Mission_IntroText
*
*	Implementable method handler. Displays mission text.
*/
ZFM_Mission_Create_Mission_IntroText ={
	private["_introText"];
	_introText = _this select 0;
	
	// Need to be able to call RE.
	if(isNil "BIS_MPF_InitDone") exitWith{};
	
	// Call titletext via RE to show the title.
	[nil,nil,"per",_rTitleText,_introText,"PLAIN DOWN",10] call RE;
	
};



/*
*	ZFM_Mission_Create_Mission
*
*	Missions are modular. So the _missionType points to methods the mission implements and then ZFM_Mission tracks.
*/
ZFM_Mission_Create_Mission ={
	private["_missionType","_valid"];
	_missionType = _this select 0;

	// Validate it is a valid mission 
	_valid = [_missionType] call ZFM_Mission_Validate_Mission;	

	// If we're sure..
	if(!_valid) exitWith {false};
	
	// Run the start call -- will return parameters from the mission (#3 in missionArray) and initialise everything. (i.e. The mission can generate things, generate units, etc)
	
	_startCall = call compile format["ZFM_Mission_Type_%1_Start",_missionType];
	
	// Wait for it to finish (this allows the crash mission to let the vehicle get destroyed..
	waitUntil{
		(call compile format["ZFM_Mission_Type_%1_Status",_missionType]) == "STARTED"
	};
	
	// Call to get the mission units that need to be created..
	_missionUnits_ = call compile format["ZFM_Mission_Type_%1_Units",_missionType];
	
	// Create them..
	_missionUnits = _missionUnits_ call ZFM_Mission_Create_Mission_Units;

	// Get the vehicles..
	_missionVehicles_ = call compile format["ZFM_Mission_Type_%1_Vehicles",_missionType];

	// Create the vehicles..
	_missionVehicles = _missionVehicles_ call ZFM_Mission_Create_Mission_Vehicles;
	
	// Layout is an array which creates a square-plot layout of objects.
	_missionLayout = call compile format["ZFM_Mission_Type_%1_Layout",_missionType];
	
	// The layout call will return objects..(Calls our lovely layout code)
	_missionObjects = _missionLayout call ZFM_Mission_Create_Mission_Layout;
	
	// List of triggers and code to run..
	_missionTriggers_ = call compile format["ZFM_Mission_Type_%1_Triggers",_missionType];
	
	// Create the triggers with code..
	_missionTriggers = _missionTriggers_ call ZFM_Mission_Create_Mission_Triggers;	
	
	// Call the "Finished starting" function. Allows the mission to mess witht he units, vehicles, etc.
	// Needs to pass back all the objects like vehicles, triggers, markers,etc.
	_finishStartCall = [_startCall,_missionUnits,_missionVehicles,_missionLayout,_missionObjects] call compile format["ZFM_Mission_Type_%1_Running",_missionType];
	
	// The markers to be created..
	_missionMarkers_ = call compile format["ZFM_Mission_Type_%1_Markers",_missionType];
	
	// Create the markers..
	_missionMarkers = _missionMarkers_ call ZFM_Mission_Create_Mission_Markers;	
	
	// Get the introText
	_missionIntroText = call compile format["ZFM_Mission_Type_%1_IntroText",_missionType];
	
	// Display the introtext..
	_missionIntroText call ZFM_Mission_Create_Mission_IntroText;
	
	// Create the missionArray
	_missionArray = [
		_missionType,
		_missionParameters,
		_missionObjects,
		_missionMarkers
	];

	// Create a hook for missions being created.
	["MISSION_CREATED",_missionArray] call ZFM_Hooks_Handler;

};