/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)

	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

if(!isServer) exitWith { diag_log("ZFM: This shouldn't be run by anything other than a server!") };

/*
*	ZFM Includes
*
*	These are the includes that ZFM requires in order to function. None of these require ExecVM/Exec priviledges.
*	They are only functions, and this file executes a single BootStrap function which in turn calls every other function.
*
*	Global variables have been removed to prevent manipulation of ZFM includes.
*/

// Common includes and constants come first
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Constants.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\Config\ZFM_Common_Config.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Common.sqf";

// Other Configurations
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\Config\ZFM_Units_Config.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\Config\ZFM_Loot_Config.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\Config\ZFM_Layout_Config.sqf";

// Other Functions
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Language.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Units.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Loot.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Layout.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Mission.sqf";

//Dnyamic includes. (Based on enabled mission types)
call ZFM_Common_DoMissionBootStrap;
call ZFM_Language_BootStrap;

/*
*	ZFM Initialize
*
*	Waits for all the other server functions to start before ZFM begins.
*/
["Waiting for initialization..","ZFM_Initialize"] call ZFM_Common_Log;
waitUntil{initialized};

/*
	ZFM_Includes_Mission_Config = "\z\addons\dayz_server\ZFM\Config\ZFM_Mission_Config.sqf";
	call compile preprocessFileLineNumbers ZFM_Includes_Mission_Config;
	ZFM_Includes_Loot_Config = "\z\addons\dayz_server\ZFM\Config\ZFM_Loot_Config.sqf";
	call compile preprocessFileLineNumbers ZFM_Includes_Loot_Config;
	ZFM_Includes_Layout_Config = "\z\addons\dayz_server\ZFM\ZFM_Layout_Config.sqf";
	call compile preprocessFileLineNumbers ZFM_Includes_Layout_Config;
	ZFM_Includes_Mission = "\z\addons\dayz_server\ZFM\ZFM_Mission.sqf";
	call compile preprocessFileLineNumbers ZFM_Includes_Mission;
	ZFM_Includes_Mission_Functions = "\z\addons\dayz_server\ZFM\ZFM_Mission_Functions.sqf";
	call compile preprocessFileLineNumbers ZFM_Includes_Mission_Functions;
	ZFM_Includes_Loot = "\z\addons\dayz_server\ZFM\ZFM_Loot.sqf";
	call compile preprocessFileLineNumbers ZFM_Includes_Loot;
	ZFM_Includes_Layout = "\z\addons\dayz_server\ZFM\ZFM_Layout.sqf";
	call compile preprocessFileLineNumbers ZFM_Includes_Layout;
*/


// Remove
ZFM_Layouts_Array =[
	[
		[ZFM_LAYOUT_OBJECT_LOOT,0,["EASY","TKSpecialWeapons_EP1",["MACHINEGUNS","SNIPERS"]]],
		[ZFM_LAYOUT_OBJECT_LOOT,0,["WAR_MACHINE","TKSpecialWeapons_EP1",["BUILDINGSUPPLIES","TOOLS"]]],
		[ZFM_LAYOUT_OBJECT_LOOT,0,["HARD","TKSpecialWeapons_EP1",["PISTOLS","SNIPERS"]]]
	]
];

[ZFM_Layouts_Array,[0,1],[4600,10160,0],20] call ZFM_Layout_Parse;

/*
*	Main (Minimal) init for ZFM
*/

// Declared universally so that ALL AI are put under its spell, rather than one group.

// DEBUGGING - Uncomment to enable BootStrap
// DEBUGGING - Uncomment to enable BootStrap
// DEBUGGING - Uncomment to enable BootStrap
// DEBUGGING - Uncomment to enable BootStrap
//[] call ZFM_Common_DoBootStrap;

// Run the main mission handler -- this loops and waits for mission events to start/finish
//[] call ZFM_Mission_Handler_Start;

// Handle JIP events for players joining after-the-fact so we can update their mission markers
//onPlayerConnected ZFM_Handle_JIP;

