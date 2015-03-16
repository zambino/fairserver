diag_log("TEST ME ESTO SPESTO");
diag_log(format["CURRENTLOC %1",position player]);

// Player's location = [14424.6,15954.7,0.00143814]

// EAST is psycho like no other mother fucker
east setFriend [west,0];
east setFriend [resistance,0];
east setFriend [civilian,1]; // Ignore zombies

// RESISTANCE is designated as hero AI
resistance setFriend [west,0];
resistance setFriend [east,0];
resistance setFriend [civilian,1]; // Ignore zombies

// WEST is the player
west setFriend [east,0]; // Bandits will fuck up the player..
west setFriend [resistance,0]; // Heroes will fuck up the player..

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
	_vehicleCreated = [[(_movingFrom select 0),(_movingFrom select 1),1000],(round random 360),_vehicleClass,_sideGroup] call BIS_fnc_spawnvehicle;

	// Get the vehicle
	_thisVehicle = _vehicleCreated select 0;
	removeAllWeapons _thisVehicle;
	_thisVehicle flyInHeight 50;
	_thisVehicle setCombatMode "GREEN";

	// Get the group of the vehicle
	_vehicleGroup = group (_vehicleCreated select 0);

	// Get crash type
	switch(_crashType) do
	{
		case "LANDING" : {
			// Create a waypoint to tell the vehicle to move to it.
			_firstWaypoint = _vehicleGroup addWaypoint[_movingTo,0,1];
			_firstWaypoint setWaypointBehaviour "CARELESS";
			_firstWaypoint setWaypointType "HOLD";
			_firstWaypoint setWaypointSpeed "LIMITED";	
		};
		case "CRASHLANDING": {
			// Create a waypoint to tell the vehicle to move to it.
			_firstWaypoint = _vehicleGroup addWaypoint[_movingTo,0,1];
			_firstWaypoint setWaypointBehaviour "CARELESS";
			_firstWaypoint setWaypointType "HOLD";
			_firstWaypoint setWaypointSpeed "LIMITED";	

			_thisVehicle setDamage (round random 0.5);

		};
		default {
			// Create a waypoint to tell the vehicle to move to it.
			_firstWaypoint = _vehicleGroup addWaypoint[_movingTo,0,1];
			_firstWaypoint setWaypointBehaviour "CARELESS";
			_firstWaypoint setWaypointType "MOVE";
			_firstWaypoint setWaypointSpeed "LIMITED";
		};
	};

	// Add
	destroyer = objNull;

	switch(_crashType) do {

		case "LANDING" : {
			waitUntil{
				not alive _thisVehicle ||
				((position _thisVehicle) distance _movingTo) < 200
			};

			// Get it to land.
			_thisVehicle land "LAND";
			
			// It's landed.
			waitUntil{((position _thisVehicle) select 2) <=1};

			{
				deleteVehicle _x;
			} forEach crew _thisVehicle;

			// Make it so it's not just pristine..
			_thisVehicle setFuel 0;
			_thisVehicle setAmmoCargo 0;
			_thisVehicle engineOn false;
			_thisVehicle setHit ["mala vrtule", 0.95];
			_thisVehicle setHit["velka vrtule",0.95];
		};
		case "CRASHLANDING" : {
			waitUntil{
				not alive _thisVehicle ||
				((position _thisVehicle) distance _movingTo) < 200
			};

			// Get it to land.
			_thisVehicle land "LAND";
			
			// It's landed.
			waitUntil{((position _thisVehicle) select 2) <= (round random 40)};

			// Make it so it's not just pristine..
			_thisVehicle setFuel 0;
			_thisVehicle setAmmoCargo 0;
			_thisVehicle engineOn false;
			_thisVehicle setDamage 1;
		};

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
*	ZFM_Loot_Container_Is_Full
*
*	Tells us if a particular vehicle is full for a given type of object (backpacks, weapons, magazines).
*/
ZFM_Loot_Container_Is_Full ={
	private["_container","_type","_max","_curr","_isFull"];
	_container = _this select 0;
	_type = _this select 1;
	
	_isFull = false;
	_max = -1;
	_curr = -2;
	
	if(typeName _container == "OBJECT" && typeName _type == "STRING") then
	{
		switch(_type) do
		{
			case "magazines" : {
				_max = getNumber (configFile >> "CfgVehicles" >> (typeOf _container) >> "transportMaxMagazines");
				_curr = count (getMagazineCargo _container select 0);
			};
			case "weapons" : {
				_max = getNumber (configFile >> "CfgVehicles" >> (typeOf _container) >> "transportMaxWeapons");
				_curr = count (getWeaponCargo _container select 0);
			};
			case "backpacks" : {
				_max = getNumber (configFile >> "CfgVehicles" >> (typeOf _container) >> "transportMaxbackpacks");
				_curr = count (getBackpackCargo _container select 0);
			};
		};
		
		if(_curr == _max) then
		{
			_isFull = true;
		};
		
	};
	
	[_isFull,_curr]
};

/*
*	ZFM_Loot_Add_Loot_To_Container_Sub
*
*	Function used by ZFM_Loot_Add_Loot_To_Container. When a loot array is passed to that
*	function, it just contains class names. These can be anything -- backpack, weapon or magazine. 
*	This function then takes that class, find out which class type it is, then uses the appropriate command
*	to add it to the loot container.
*/
ZFM_Loot_Add_Loot_To_Container_Sub ={
	private["_class","_container","_amount","_isFull","_max","_curr"];
	_class = _this select 0;
	_amount = _this select 1;
	_container = _this select 2;

	if(isClass(configFile >> "CfgVehicles" >> _class)) then
	{
		// Is it full?
		_isFull = [_container,"backpacks"] call ZFM_Loot_Container_Is_Full;
	
		_max = getNumber (configFile >> "CfgVehicles" >> (typeOf _container) >> "transportMaxbackpacks");
		_curr = _isFull select 1;
		
		if(_amount > _max) then
		{
			_amount = _max - _curr;
		};	
		
		// If the container is full, or if spawning on ground is 
		if(!(_isFull select 0)) then
		{
			_container addBackpackCargoGlobal[_class,_amount];
		};
	};
	
	if(isClass(configFile >> "CfgWeapons" >> _class)) then
	{
		// Is it full?
		_isFull = [_container,"weapons"] call ZFM_Loot_Container_Is_Full;
	
		_max = getNumber (configFile >> "CfgVehicles" >> (typeOf _container) >> "transportMaxWeapons");
		_curr = _isFull select 1;
		
		if(_amount > _max) then
		{
			_amount = _max - _curr;
		};	
		// If the container is full, or if spawning on ground is 
		if(!(_isFull select 0)) then
		{
			_container addWeaponCargoGlobal[_class,_amount];
		};
	};	
	if(isClass(configFile >> "CfgMagazines" >> _class)) then
	{
		// Is it full?
		_isFull = [_container,"magazines"] call ZFM_Loot_Container_Is_Full;
		_max = getNumber (configFile >> "CfgVehicles" >> (typeOf _container) >> "transportMaxMagazines");
		_curr = _isFull select 1;
		
		if(_amount > _max) then
		{
			_amount = _max - _curr;
		};	

		// If the container is full, or if spawning on ground is 
		if(!(_isFull select 0)) then
		{
			_container addMagazineCargoGlobal[_class,_amount];
		};
	};
};

/*
*	ZFM_Vehicles_Generate_Item_AirDrop
*
*	Generates an airdrop at a given location. 
*/
ZFM_Vehicles_Generate_Item_AirDrop ={
	private["_airdropLocation","_generatedLoc","_supplyItem","_supplyChute","_contents"];	
	_airdropLocation = _this select 0;
	_airdropItem = _this select 1;
	_height = _this select 2;
	_contents = _this select 3;

	// Put it in the air
	_generatedLoc = [_airdropLocation select 0,_airdropLocation select 1,_height];

	// Item
	_supplyItem = createVehicle[_airdropItem,_generatedLoc,[],0,"NONE"];

	// Thanks to Soolie for providing aid on this -- you should license your contributions, Soolie!
	_supplyChute = createVehicle ["B_parachute_02_F", getPosASL _supplyItem, [], 0, "NONE"];	

	[_contents,_supplyItem] spawn {
		private["_contents","_item","_amount","_supplyItem"];
		_contents = _this select 0;
		_supplyItem = _this select 1;

		{
			_item = _x select 0;
			_amount = _x select 1;
			[_item,_amount,_supplyItem] spawn ZFM_Loot_Add_Loot_To_Container_Sub;
		} forEach _contents;

	};

	// Attach
	_supplyItem attachTo [_supplyChute,[0,0,0]];
	_supplyItem allowDamage false;
	_supplyChute allowDamage false;	
	_supplyChute hideObject false;

	// Need to check if they're landing
	[_supplyItem,_supplyChute] spawn {
		private["_supplyItem","_supplyChute"];
		_supplyItem = _this select 0;
		_supplyChute = _this select 1;

		// Wait until it's near the ground..
		waitUntil {
			((getPosASL _supplyItem) select 2) <= 10
		};

		_supplyChute setDamage 1;
		// Detach it..
		detach _supplyItem;
	};

};
/*
*	ZFM_Vehicles_Generate_FlyByAirDrop
*
*	Generates a flyby air drop. Only works for non-lootcrates. Fucking annoying!
*/
ZFM_Vehicles_Generate_FlyByAirDrop ={
	private["_flybyVehicle","_flyAt","_spawnArray","_flyFrom","_vehicleCreated","_thisVehicle"];
	_flybyVehicle = _this select 0;
	_flyAt = _this select 1;
	_spawnArray = _this select 2;

	// Fly from 1000 away
	_flyFrom = [_flyAt select 0,(_flyAt select 1)-400,400];

	// So it flies over
	_flyFix = [(_flyAt select 0)+500,(_flyAt select 1)+500,_flyAt select 2];

	// Create the crash vehicle
	_vehicleCreated = [_flyFrom,(round random 360),_flybyVehicle,WEST] call BIS_fnc_spawnvehicle;

	// Get the vehicle
	_thisVehicle = _vehicleCreated select 0;
	removeAllWeapons _thisVehicle;

	// Get the group of the vehicle
	_vehicleGroup = group (_vehicleCreated select 0);

	// Create a waypoint to tell the vehicle to move to it.
	_firstWaypoint = _vehicleGroup addWaypoint[_flyFix,0,1];
	_firstWaypoint setWaypointBehaviour "CARELESS";
	_firstWaypoint setWaypointType "MOVE";
	_firstWaypoint setWaypointSpeed "FULL";

	[_thisVehicle,_flyFix,_spawnArray,_firstWaypoint,_vehicleGroup,_flyFrom] spawn {
		private["_thisVehicle","_flyAt","_spawnArray","_addDistance","_vehicleName","_vehicleContents"];
		_thisVehicle = _this select 0;
		_flyFix = _this select 1;
		_spawnArray = _this select 2;
		_firstWaypoint = _this select 3;
		_vehicleGroup = _this select 4;
		_flyFrom =_this select 5;

		_thisVehicle flyInHeight 250;

		waitUntil {
			((position _thisVehicle) distance _flyFix) <= 300
		};

		// Delete in the spawn call.
		deleteWaypoint _firstWaypoint;

		// Create a waypoint to tell the vehicle to move to it.
		_firstWaypoint = _vehicleGroup addWaypoint[_flyFrom,0,1];
		_firstWaypoint setWaypointBehaviour "CARELESS";
		_firstWaypoint setWaypointType "CYCLE";
		_firstWaypoint setWaypointSpeed "FULL";	

		_thisVehicle flyInHeight 380;

		{
			// Exit if it's dead..
			if(not alive _thisVehicle) exitWith{};

			_vehicleName = _x select 0;
			_vehicleContents = _x select 1;

			_poss = position _thisVehicle;

			// Looks more realistic, but can cause the heli to crash mid drop. Oh well :)
			_posShort = [(_poss select 0),(_poss select 1)];

			// Spawn a paradrop for each..
			[_posShort,(_x select 0),(_poss select 2)-30,_vehicleContents] spawn ZFM_Vehicles_Generate_Item_AirDrop;
			sleep 8;
		} forEach _spawnArray;


		// let the air vehicle move a distance away before being deleted.
		sleep 25;

		{
			deleteVehicle _x;
		} forEach crew _thisVehicle;

		// Delete the air vehicle
		deleteVehicle _thisVehicle;
	};

};


ZFM_Vehicles_Generate_Crash_Land ={
	private["_movingFrom","_movingTo","_vehicleClass","_sideGroup","_crashType"];
	_movingFrom = _this select 0;
	_movingTo = _this select 1;
	_vehicleClass = _this select 2;
	_sideGroup = _this select 3;
	_crashType = _this select 4;

	// Create the crash vehicle
	_vehicleCreated = [[(_movingFrom select 0),(_movingFrom select 1),0],(round random 360),_vehicleClass,_sideGroup] call BIS_fnc_spawnvehicle;

	// Get the vehicle
	_thisVehicle = _vehicleCreated select 0;
	removeAllWeapons _thisVehicle;
	_thisVehicle setCombatMode "GREEN";
	_thisVehicle allowDammage false;

	// Get the group of the vehicle
	_vehicleGroup = group (_vehicleCreated select 0);

	_firstWaypoint = _vehicleGroup addWaypoint[_movingTo,0,1];
	_firstWaypoint setWaypointBehaviour "SAFE";
	_firstWaypoint setWaypointType "MOVE";
	_firstWaypoint setWaypointSpeed "FULL";	

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

			waitUntil {
				not alive _thisVehicle ||
				((position destroyer) distance (position _thisVehicle)) <=300
			};

			titleText["Triggered!","PLAIN DOWN",10];

			_startTime = diag_tickTime;
			destroyer setAmmo["GBU12BombLauncher",30];
			while {alive _thisVehicle && ((position destroyer) distance (position _thisVehicle)) <=200} do
			{
				_timeDiff = diag_tickTime -_startTime;
				diag_log(_timeDiff);
				if(_timeDiff >= 40) then { _thisVehicle setDamage 1; };
				_boom = destroyer fireAtTarget [_thisVehicle,"GBU12BombLauncher"];
			};

			titleText["Vehicle destroyed!","PLAIN DOWN",10];
			if(alive destroyer) then
			{
				deleteWaypoint _firstWaypoint;
				deleteWaypoint destroyerWaypoint;

				_currentpos = position destroyer;
				_newpos = [(_currentpos select 0)-800,_currentpos select 1];
				destroyer flyInHeight 2000;
				sleep 30;

				{
				  deleteVehicle _x;
				} forEach crew destroyer;


				deleteVehicle destroyer;
			};

		};

	};



	waitUntil {
		((position _thisVehicle) distance _movingTo) <=10
	};

	_thisVehicle setDamage 1;

};



_thisloc = [14424.6,15954.7,0.00143814];
_fromloc = [13000,15900];

[_fromloc,_thisloc,"O_MRAP_02_F",EAST,"AIRFIGHT"] spawn ZFM_Vehicles_Generate_Crash_Land; 


_airdrops =[
	[
		"B_MBT_01_mlrs_F",
		[
			["arifle_Katiba_ARCO_pointer_snds_F",5]
		]
	],
	[
		"B_MBT_01_mlrs_F",
		[
			["arifle_MXM_RCO_pointer_snds_F",5]
		]
	],
	[
		"B_Truck_01_covered_F",
		[
			["arifle_MXM_RCO_pointer_snds_F",5]
		]
	],
	[
		"O_Heli_Attack_02_F",
		[
			["arifle_MXM_RCO_pointer_snds_F",5]
		]
	]	
];

_dizizi = "O_Heli_Light_02_F" createVehicle _thisloc;

//[_fromloc,_thisloc,"O_Heli_Light_02_F",EAST,"CRASHLANDING"] spawn ZFM_Vehicles_Generate_Crash_Air;
//["I_Heli_Transport_02_F",_thisloc,_airdrops] spawn ZFM_Vehicles_Generate_FlyByAirDrop;
/*
_dizzy = createVehicle["Land_CargoBox_V1_F",_thisloc,[],0,"NONE"];


[_thisloc,"C_SUV_01_F",70] call ZFM_Vehicles_Generate_Item_AirDrop;
[_thisloc,"Land_CargoBox_V1_F",70] call ZFM_Vehicles_Generate_Item_AirDrop;
[_thisloc,"Land_CargoBox_V1_F",70] call ZFM_Vehicles_Generate_Item_AirDrop;
*/

/*

// Start from an offset
_startFromLoc = [_thisloc select 0,(_thisloc select 1)-200,0];

// Fly in very low
_startFromFlyLow = [_thisloc select 0,(_thisloc select 1)-50,0];

// Spawn a heli in with full crew
vehi = [_startFromLoc, 180, "B_Heli_Attack_01_F", WEST] call BIS_fnc_spawnvehicle;

diag_log(format["%1",vehi]);

// Fly to the player's location
_vehiGroup = group (vehi select 0);

_moveStart = _vehicGroup addWaypoint [_startFromFlyLow,0];
_moveHere setWaypointBehaviour "CARELESS";
_moveHere setWaypointType "MOVE";
_moveHere setWaypointCompletionRadius 0.2;
_moveHere setWaypointSpeed "FULL";
(vehi select 0) flyInHeight 30;
_moveHere = _vehiGroup addWaypoint [position player,0];
_moveHere setWaypointBehaviour "CARELESS";
_moveHere setWaypointType "MOVE";
_moveHere setWaypointCompletionRadius 0.2;
_moveHere setWaypointSpeed "FULL";
_moveHere setWaypointStatements["true","(vehi select 0) land 'LAND';"];
*/

diag_log("YAY");