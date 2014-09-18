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
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Language.sqf";

// Other Configurations
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\Config\ZFM_Units_Config.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\Config\ZFM_Loot_Config.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\Config\ZFM_Layout_Config.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\Config\ZFM_Mission_Type_Crash_Config.sqf";

// Other Functions
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Units.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Loot.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Layout.sqf";
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Mission.sqf";

//Dnyamic includes. (Based on enabled mission types)
call ZFM_Language_DoBootStrap;								// Bootsraps language (EN,NL,DE,FR)
call ZFM_Common_DoMissionBootStrap;							// Bootstraps supported missions (crash,etc)
call ZFM_Common_DoDayZBootStrap;							// Bootstraps Epoch/Overpoch etc.
call ZFM_Units_DoBootStrap;									// Bootstraps units / centers

[4,"INFORMATION","ZFM_Initialize.sqf::execVM"] call ZFM_Language_Log;
waitUntil{initialized};


_tehLayout = [[4600,10160,0],"WAR_MACHINE",false] call ZFM_Mission_Type_Crash_Create_Layout;
//[_tehLayout,[2,2],[4600,10160,0],10] call ZFM_Layout_Parse;


//[[4600,10160,0],"EASY"] call ZFM_Mission_Type_Crash_Create_Layout;
//[] call ZFM_Mission_Type_Crash_Create_Crash;

/*
*	ZFM Initialize
*
*	Waits for all the other server functions to start before ZFM begins.
*/
/*

_outyPutY = ["Mi17","HERO","EASY"] call ZFM_Mission_Type_Crash_GenerateMissionTitle;
[5,"INFORMATION","ZFM_Initialize.sqf::outPutY",[_outyPutY]] call ZFM_Language_Log;

_outPutCrah = [[1201,1200,0]] call ZFM_Mission_Type_Crash_CheckCrashExclusion;
[5,"INFORMATION","ZFM_Initialize.sqf::outPutCrah",[_outPutCrah]] call ZFM_Language_Log;

// Remove
ZFM_Layouts_Array =[
	[
		[ZFM_LAYOUT_OBJECT_LOOT,0,["EASY","TKSpecialWeapons_EP1",["MACHINEGUNS","SNIPERS"]]],
		[ZFM_LAYOUT_OBJECT_LOOT,0,["WAR_MACHINE","TKSpecialWeapons_EP1",["BUILDINGSUPPLIES","TOOLS"]]],
		[ZFM_LAYOUT_OBJECT_LOOT,0,["HARD","TKSpecialWeapons_EP1",["PISTOLS","SNIPERS"]]]
	],
	[0,0,0],
	[0,[ZFM_LAYOUT_OBJECT_UNIT_GROUP,0,[["COMMANDER","SNIPER","HEAVY","HEAVY"],"WAR_MACHINE",ZFM_GROUP_EAST,1]],0]
];

[ZFM_Layouts_Array,[0,1],[4600,10160,0],20] call ZFM_Layout_Parse;*/


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
//onPlayerConnected ZFM_Mission_Handle_JIP;

