/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

 
 
ZFM_Loot_Get_Container_Limits ={
	private["_container","_class","_maxMags","_maxWeapons","_maxBackPacks"];
	_container = _this select 0;
	
	// Get the class of the container
	_class = typeOf _container;
	
	// Gets the properties from the Cfg files for max magazines, weapons & backpacks
	_maxMags = getNumber (configFile >> "CfgVehicles" >> _class >> "transportMaxMagazines");
	_maxWeapons = getNumber (configFile >> "CfgVehicles" >> _class >> "transportMaxWeapons");
	_maxBackPacks = getNumber (configFile >> "CfgVehicles" >> _class >> "transportMaxbackpacks");
	
	// Return array 0 = Max Magazines, 1 = Max Weapons, 2= Max Backpacks
	[_maxMags,_maxWeapons,_maxBackPacks]
};

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
		
		diag_log(format["CURRENT %1, MAX %2",_curr,_max]);
		
		if(_curr == _max) then
		{
			_isFull = true;
		};
		
	};
	
	[_isFull,_curr]
};

 
ZFM_Loot_Add_Loot_To_Container_Sub ={
	private["_class","_container","_amount","_isFull","_max"];
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
	
		_max = getNumber (configFile >> "CfgVehicles" >> (typeOf _container) >> "transportMaxbackpacks");
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
		_curr = _isFull select 1;
		
		if(_amount > _max) then
		{
			_amount = _max - _curr;
		};	
		
		diag_log(format["MAGAZINES ISFULL %1",_isFull]);
	
		// If the container is full, or if spawning on ground is 
		if(!(_isFull select 0)) then
		{
			_container addMagazineCargoGlobal[_class,_amount];
		};
	};
};
 
 ZFM_Loot_Add_Loot_To_Container ={
	private["_toAddLootTo","_lootToAdd","_itemsCount","_rowItem","_x"];
	_toAddLootTo = _this select 0;
	_lootToAdd = _this select 1;
	
	if(typeName _toAddLootTo == "OBJECT" && typeName _lootToAdd == "ARRAY") then
	{
		_itemsCount = count _lootToAdd;
		
		diag_log(format["Add Loot to Container param matched %1 AND ZA %2, ITEMSCOUNT %3",_this,count _lootToAdd,_itemsCount]);
		
		if(_itemsCount >0) then
		{
			for [{_x =0},{_x <= _itemsCount-1},{_x = _x +1} ] do
			{
				// Get the item from the array;
				_rowItem = _lootToAdd select _x;
				
				diag_log(format["Add Loot to Container %1 TYPENAME ROWITEM %2, TOADDLOOT TO %2",_rowItem,typeName _rowItem,_toAddLootTo]);
				
				if(typeName _rowItem == "ARRAY") then
				{
					// classname, amount, container
					[(_rowItem select 0),(_rowItem select 1),_toAddLootTo] call ZFM_Loot_Add_Loot_To_Container_Sub;
				};
			};
		};
	};
	
 };
 
 
 /*
 * 	ZFM_Loot_Create_LootItem
 *
 *	Creates a vehicle, places it, positions it, and puts into it the items specified.
 */
 ZFM_Loot_Create_Loot_Object ={
	private["_toAddLootTo","_location","_lootToAdd","_actualLootObject"];
	
	_toAddLootTo = _this select 0;
	_location = _this select 1;
	_lootToAdd = _this select 2;
	
	diag_log(format["Create_Loot_Object called %1",_this]);
	
	// Check and make sure they're actually the right type. Man I wish SQF had typed and defined parameters.. :(
	if(typeName _toAddLootTo == "STRING" && typeName _lootToAdd == "ARRAY") then
	{
		diag_log(format["Create_Loot_Object correct params%1",_this]);
		
		// Make sure it's a vehicle type to add loot to
		if(isClass(configFile >> "CfgVehicles" >> _toAddLootTo)) then
		{
			diag_log(format["Create_Loot_Object is vehicle %1",_this]);
			
			// Create the vehicle for the loot to be put into
			_actualLootObject = createVehicle[_toAddLootTo,_location,[],0,"NONE"];
			_actualLootObject setPos _location;
			_actualLootObject setDir round(random 360);
			
			// Get rid of the weapons, magazines & backpacks that might be added in by default
			clearWeaponCargoGlobal _actualLootObject;
			clearMagazineCargoGlobal _actualLootObject;
			clearBackpackCargoGlobal _actualLootObject;
			
			// Add the items to the container
			[_actualLootObject,_lootToAdd] call ZFM_Loot_Add_Loot_To_Container;
		};
	
	};
 };
 
 
 