/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

if(!isServer) exitWith { diag_log("ZFM: This shouldn't be run by anything other than a server!") };

/*
	System utility variables.
*/
ZFSS_Installed = true;
ZFM_Name = "Zambino FairMission System [ZFM] ";
ZFM_Version = "v0.4.5";

diag_log(format["%1 %2 - Waiting for INITIALIZATION..",ZFM_Name,ZFM_Version]);
waitUntil{initialized};

/*
	Globals used to ensure that things can function
*/
ZFM_Includes_Functions_File = "\z\addons\dayz_server\ZFM\ZFM_Functions.sqf";
ZFM_Includes_Loot_File = "\z\addons\dayz_server\ZFM\ZFM_LootHandler.sqf";
ZFM_Includes_AI_File = "\z\addons\dayz_server\ZFM\ZFM_Initialize_AI.sqf";
ZFM_Includes_Admin_file = "\z\addons\dayz_server\ZFM\ZFM_Admin.sqf";

[] execVM ZFM_Includes_Functions_File;
[] execVM ZFM_Includes_Loot_File;
[] execVM ZFM_Includes_AI_File;
[] execVM ZFM_Includes_Admin_File;