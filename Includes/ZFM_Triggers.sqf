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
*	ZFM_Triggers_Add_EventHandlers
*
*	Calls manual event handlers when a trigger is created
*/
ZFM_Triggers_Add_EventHandlers ={
	private["_trigger"];
	_trigger = _this select 0;

	// Call the handler manually
	["TRIGGER_CREATED",_trigger] call ZFM_Hooks_Handler;
};

/*
*	ZFM_Triggers_Create_Trigger
*
*	Creates a trigger.
*/
ZFM_Triggers_Create_Trigger ={
	private["_createdTrigger","_activeCode","_deactiveCode","_xRad","_yRad","_triggerRect","_triggerBySide",
	"_triggerActiveCode","_triggerType","_triggerDeactivateCode","_triggerTimeoutMin","_triggerTimeoutMid","_triggerTimeoutMax","_triggerTimeoutInterruptable"];
	_location = _this select 0;
	_xRad = if(count _this == 2) then { _this select 1 } else { 100 };
	_yRad = if(count _this == 3) then { _this select 2 } else { 100 };
	_triggerRect = if(count _this ==4) then { _this select 3} else { false };
	_triggerBySide =  if(count _this ==5) then { _this select 4 } else { "ANY" };
	_triggerType = if(count _this == 6) then { _this select 5 } else { "PRESENT" };
	_triggerRepeating = if(count _this == 7) then {_this select 6} else {false};
	_triggerTimeoutMin = if(count _this == 8) then { _this select 7} else { 50 };
	_triggerTimeoutMid = if(count _this == 9) then { _this select 8} else { 50 };
	_triggerTimeoutMid = if(count _this == 10) then { _this select 9} else { 50 };
	_triggerTimeoutInterruptable = if(count _this == 9) then { _this select 9 } else { false };

	// Creates the trigger 
	_createdTrigger = createTrigger["EmptyDetector",_location];

	// Give it a pseudo-unique string to identify it with..
	_triggerName = [20] call ZCR_PseudoUniqueString;

	// Set the default handlers..
	_activateCode = format["[""TRIGGER_ACTIVATED"",[""%1"",thislist]] call ZFM_Hooks_Handler",_triggerName];
	_deactivateCode = format["[""TRIGGER_DEACTIVATED"",[""%1"",thislist]] call ZFM_Hooks_Handler",_triggerName];

	// Set properties
	_createdTrigger setTriggerArea [_xRad,_yRad,(round random 360),_triggerRect];
	_createdTrigger setTriggerActivation [_triggerBySide,_triggerType,false];
	_createdTrigger setTriggerStatements ["this",_activateCode,_deactivateCode];
	//_createdTrigger setTriggerTimeout [_triggerTimeoutMin,_triggerTimeoutMid,_triggerTimeoutMax,_triggerTimeoutInterruptable];
	_createdTrigger setTriggerText _triggerName;

	// Attach triggers
	[_createdTrigger] call ZFM_Triggers_Add_EventHandlers;

	// Triggers
	_createdTrigger
};