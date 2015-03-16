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

// Wait until shit is shitted FUCK NUGGETS
waitUntil{initialized};

// Add the defines
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Configure.sqf";			// Configuration as default or supplied by the user
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Defines.sqf";				// Constants the user should not touch.
call compile preprocessFileLineNumbers "\z\addons\dayz_server\ZFM\ZFM_Tracking.sqf";			// Mission tracking


["CRASH",[],[],[],[]] call ZFM_Tracking_Missions_AddNewMission;

diag_log(format["CURRENT MISSIONS %1",ZFM_TRACKING_CURRENT_MISSIONS]);