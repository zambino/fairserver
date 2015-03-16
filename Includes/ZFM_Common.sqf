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
*	ZFM_Common_Location_Generate_Random
*
*	Generates a random location that is spawn-friendly.
*/
ZFM_Common_Location_Generate_Random ={
	[[(round random 25000),(round random 25000),0],1000,1000,0,0] call BIS_fnc_findSafePos;
};

ZFM_Common_Location_Generate_Random_Road ={
	private["_pos"];
	
	// Get a random pos
	_pos = call ZFM_Common_Location_Generate_Random;
	
	// Find near roads within 500 meters
	_roads = _pos nearRoads 500;
	
	// Max attempts
	_passes = 5;
	
	while{typeName _roads != "ARRAY" || _passes >0} do
	{
		_pos = call ZFM_Common_Location_Generate_Random;
		_roads = _pos nearRoads 500;
		_passes = _passes -1; // Stop infinite recursion
	};
	
	// Return either the road or the last found position
	if(typeName _roads == "ARRAY") then { _roads select 0 } else { _pos };
	
};

ZFM_Common_Debug ={
	if(!ZFM_CONFIGURE_ENABLE_DEBUG_MESSAGES)exitWith{};

	diag_log(
		format["%1 - DEBUG - %2",format["%1 %2",ZFM_NAME,ZFM_VERSION],(_this)]
	);
};