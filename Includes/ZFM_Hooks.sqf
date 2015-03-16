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
*	ZFM_HOOKS_UNIT_KILLED_FUNCTIONS
*
*	List of functions to execute when a ZFM-generated unit is killed.
*/

ZFM_HOOKS_MISSION_CREATED_FUNCTIONS=[];			// Mission created
ZFM_HOOKS_MISSION_EXPIRED_FUNCTIONS=[];			// Mission expired
ZFM_HOOKS_UNIT_CREATED_FUNCTIONS=[];			// Unit created
ZFM_HOOKS_UNIT_KILLED_FUNCTIONS=[];				// Unit killed
ZFM_HOOKS_UNIT_HIT_FUNCTIONS=[];				// Unit hit
ZFM_HOOKS_UNIT_FIRED_NEAR_FUNCTIONS=[];			// Unit fired near
ZFM_HOOKS_TRIGGER_CREATED_FUNCTIONS=[];			// Triggers
ZFM_HOOKS_TRIGGER_ACTIVATED_FUNCTIONS=[];		// Trigger activated
ZFM_HOOKS_TRIGGER_DEACTIVATED_FUNCTIONS=[];		// Trigger deactivated
ZFM_HOOKS_VEHICLE_CREATED_FUNCTIONS=[];			// Unit created
ZFM_HOOKS_VEHICLE_DAMAGED_FUNCTIONS=[];			// Dammage
ZFM_HOOKS_VEHICLE_DAMAGE_FUNCTIONS=[];			// HandleDamage
ZFM_HOOKS_VEHICLE_HIT_FUNCTIONS=[];				// Hit
ZFM_HOOKS_VEHICLE_FIRED_NEAR_FUNCTIONS=[];		// Fired Near
ZFM_HOOKS_VEHICLE_LANDED_FUNCTIONS=[];			// Landed
	
/*
*	ZFM_Hooks_Handler
*
*	Generic function called each time a registered event handler fires.
*/
ZFM_Hooks_Handler ={
	private["_hookListName","_params"];
	_hookListName = call compile format["ZFM_HOOKS_%1_FUNCTIONS",(_this select 0)];
	_params = _this select 1;

	format["Hook Handler %1 called with params %2",(_this select 0),(_this select 1)] call ZFM_Common_Debug;

	// Loop through the functions added to be called
	{
		_functionCode = call compile format["%1",_x]; // Loop the functions listed
		
		// Make sure it's code.
		if(typeName _functionCode == "CODE") then
		{
			// Pass the function params from the MPEventHandler to the given function
			_params call _functionCode;
		};
	} forEach _hookListName;	
};


ZFM_Hooks_Add_Hook_Function ={
	private["_hookTypes","_functionCode","_execCode"];
	_hookTypes = _this select 0;
	_functionCode = _this select 1;
	
	// Create code which appends to the array programatically
	_execCode = call compile format["ZFM_HOOKS_%1_FUNCTIONS = ZFM_HOOKS_%1_FUNCTIONS + [%2]",_hookTypes,_functionCode];
};