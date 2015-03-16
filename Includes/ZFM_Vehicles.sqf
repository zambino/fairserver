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
*	ZFM_Function_Generate_Airstrike
*
*	Generates an airstrike on a given location. Needs to be static.
*/
ZFM_Vehicles_Generate_AirStrike ={
	private["_location","_vehicleStartAt","_sideGroup","_muzzles","_vehicleStartAt","_vehicleMoveToAfter","_vehicleCreated","_thisVehicle","_vehicleGroup","_firstWaypoint"];
	_location = _this select 0;
	_vehicleClass = "B_Plane_CAS_01_F";
	_sideGroup = _this select 1;
	_object = _this select 2;

	// Random location for the vehicle to start at
	_vehicleStartAt = [(_location select 0),(_location select 1)-1000];
	_vehicleMoveToAfter = [(_location select 0)+900,(_location select 1)+1000];

	// Create the spawn in
	_vehicleCreated = [_vehicleStartAt,0,_vehicleClass,_sideGroup] call BIS_fnc_spawnvehicle;



	// Set it to fly fairly low so the targeting is accurate
	_thisVehicle = _vehicleCreated select 0;
	_thisVehicle flyInHeight 5;
	_thisVehicle selectWeapon "Bomb_04_Plane_CAS_01_F";

player assignAsCargo _thisVehicle;

	//  Set the waypoint to kill / blow up / etc
	_vehicleGroup = group _thisVehicle;

	// Create the first waypoint
	_firstWaypoint = _vehicleGroup addWaypoint[_location,0,1];
	_firstWaypoint waypointAttachVehicle _object;
	_firstWaypoint setWaypointBehaviour "COMBAT";
	_firstWaypoint setWaypointType "SAD";
	_firstWaypoint setWaypointSpeed "LIMITED";
	_firstWaypoint setWaypointCombatMode "RED";

	// Roughly approximates laser targeting..
	waitUntil {
		((position _thisVehicle) distance (position _object)) < 450
	};

	// Get them to blow up the target
	_thisVehicle fire "Bomb_04_Plane_CAS_01_F";

	// Get rid of the first waypoint so the plane doesn't circle..
	deleteWaypoint [_vehicleGroup,1];

	// Re-add the waypoint
	_firstWaypoint = _vehicleGroup addWaypoint[_vehicleMoveToAfter,0,1];
	_firstWaypoint waypointAttachVehicle _object;
	_firstWaypoint setWaypointBehaviour "CARELESS";
	_firstWaypoint setWaypointType "MOVE";
	_firstWaypoint setWaypointSpeed "FULL";

	// Add the second waypoint
	_vehicleGroup move _vehicleMoveToAfter;

	// Wait for the plane to move off (Use waituntil as we don't want to make the vehicle global)
	waitUntil {
		(((position _thisVehicle) distance _vehicleMoveToAfter) < 100)
	};

	// Destroy it if it's not done..
	if(alive _object) then { _thisVehicle setDamage 1; };

	// Delete it
	deleteVehicle _thisVehicle;
};

/*
*	ZFM_Vehicles_Generate_Crash_Air
*
*	Generate an air crash.
*/
ZFM_Vehicles_Generate_Crash_Air ={
	private["_movingFrom","_movingTo","_thisVehicle","_vehicleGroup","_firstWaypoint","_destroyerWaypoint"];
	_movingFrom = _this select 0;
	_movingTo = _this select 1;
	_vehicleClass = _this select 2;
	_sideGroup = _this select 3;
	_crashType = _this select 4;

	// Create the crash vehicle
	_vehicleCreated = [_movingFrom,(round random 360),_vehicleClass,_sideGroup] call BIS_fnc_spawnvehicle;

	// Get the vehicle
	_thisVehicle = _vehicleCreated select 0;
	removeAllWeapons _thisVehicle;
	_thisVehicle flyInHeight 50;

	// Get the group of the vehicle
	_vehicleGroup = group (_vehicleCreated select 0);

	// Create a waypoint to tell the vehicle to move to it.
	_firstWaypoint = _vehicleGroup addWaypoint[_movingTo,0,1];
	_firstWaypoint setWaypointBehaviour "CARELESS";
	_firstWaypoint setWaypointType "MOVE";
	_firstWaypoint setWaypointSpeed "LIMITED";

	// Add
	destroyer = objNull;

	switch(_crashType) do
	{
		case "AIRFIGHT": {
			// Create the pos for the destroying vehicle..
			_destroyerStart = [(_movingFrom select 0)-800,(_movingFrom select 1)-800];

			// Tell it to destroy the crash vehicle..
			_destroyerCreated = [_destroyerStart,getDir _thisVehicle,"I_Plane_Fighter_03_CAS_F",RESISTANCE] call BIS_fnc_spawnvehicle;

			// Get the destroying vehicle
			destroyer = _destroyerCreated select 0;
			destroyer flyInHeight 50;
			// Get the group of the destroying vehicle
			destroyGroup = group destroyer;

			// Create the waypoint to destroy it..
			destroyerWaypoint = destroyGroup addWaypoint[_thisVehicle,0];
			destroyerWaypoint waypointAttachVehicle _thisVehicle;
			destroyerWaypoint setWaypointBehaviour "CARELESS";
			destroyerWaypoint setWaypointType "MOVE";
			destroyerWaypoint setWaypointSpeed "FULL";

		};	
	};

	switch(_crashType) do {
		case "AIRFIGHT": {
			waitUntil {
				not alive _thisVehicle ||
				((position destroyer) distance (position _thisVehicle)) <=300
			};

			titleText["Triggered!","PLAIN DOWN",10];

			_startTime = diag_tickTime;

			while {alive _thisVehicle} do
			{
				_timeDiff = diag_tickTime -_startTime;
				diag_log(_timeDiff);
				if(_timeDiff >= 40) then { _thisVehicle setDamage 1; };
				destroyer setAmmo["missiles_ASRAAM",10];
				_boom = destroyer fireAtTarget [_thisVehicle,"missiles_ASRAAM"];
			};

			titleText["Vehicle destroyed!","PLAIN DOWN",10];

		// Destroy it so it looks like the plane did it..
			//_thisVehicle setDamage 1;

			// Tell the plane to fuck off
			if(alive destroyer) then
			{
				deleteWaypoint _firstWaypoint;
				deleteWaypoint destroyerWaypoint;

				_currentpos = position destroyer;
				_newpos = [(_currentpos select 0)-800,_currentpos select 1];
				destroyer flyInHeight 2000;
				sleep 30;
				deleteVehicle destroyer;

			};

		};

		case "NORMAL" : {
			// Wait until it's near the movingTo
			waitUntil{
				not alive _thisVehicle ||
				((position _thisVehicle) distance _movingTo) < 300
			};

			// Destroy it
			_thisVehicle setDamage 1;	
		};
	};
};

/*
*	ZFM_Vehicles_Add_EventHandlers
*
*	Adding eventhandlers for vehicles created.
*/
ZFM_Defines_Vehicles_Add_EventHandlers ={
	private["_vehicle"];
	_vehicle = _this select 0;
	// Manually register hook
	["VEHICLE_CREATED",[_thisVehicle]] call ZFM_Hooks_Handler;

	// RV handled events
	_vehicle addEventHandler["Dammaged", {
		["VEHICLE_DAMAGED",_this] call ZFM_Hooks_Handler;
	}];
	_vehicle addEventHandler["HandleDamage",{
		["VEHICLE_DAMAGE",_this] call ZFM_Hooks_Handler;
	}];
	_vehicle addEventHandler["Hit",{
		["VEHICLE_HIT",_this] call ZFM_Hooks_Handler;
	}];
	_vehicle addEventHandler["FiredNear",{
		["VEHICLE_FIRED_NEAR",_this] call ZFM_Hooks_Handler;
	}];
	_vehicle addEventHandler["LandedStopped",{
		["VEHICLE_LANDED",_this] call ZFM_Hooks_Handler;
	}];
	
};

/*
*	ZFM_Vehicles_Create_Vehicle
*
*	Primitive function for creating a handled vehicle.
*/
ZFM_Vehicles_Create_Vehicle ={
	private["_vehicleClass","_location","_contents"];
	_vehicleClass = _this select 0;
	_location = _this select 1;
	_contents = _this select 2;
	_withCrew = _this select 3;
	_flying = _this select 4;
	_side = _this select 5;	

	// Spawning with a crew? 
	if(_withCrew) then
	{
		_thisVehicle =[_location,(round random 360),_vehicleClass,_side] call bis_fnc_spawnVehicle;
		[(_thisVehicle select 0)] call ZFM_Defines_Vehicles_Add_EventHandlers;
		if(true) exitWith {_thisVehicle};
	}
	else
	{
		_thisVehicle = createVehicle[_vehicleClass,_location,[],0,"CAN_COLLIDE"];
		[_thisVehicle] call ZFM_Defines_Vehicles_Add_EventHandlers;
		if(true) exitWith {_thisVehicle};
	};
};


