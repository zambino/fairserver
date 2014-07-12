/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

 ZFM_Loot_Crates =[
	"TKSpecialWeapons_EP1",
	"UNBasicAmmunitionBox_EP1",
	"CZBasicWeapons_EP1",
	"TKVehicleBox_EP1",
	"USVehicleBox_EP1",
	"USBasicAmmunitionBox_EP1",
	"GERBasicWeapons_EP1",
	"GuerillaCacheBox_EP1",
	"TKOrdnanceBox_EP1",
	"USSpecialWeapons_EP1"
 ];
 
 ZFM_LOOT_CONTENT_TYPE_SNIPERS = "Lx101010";
 ZFM_LOOT_CONTENT_TYPE_MACHINEGUNS = "Lx101011";
 ZFM_LOOT_CONTENT_TYPE_RIFLES = "Lx101012";
 ZFM_LOOT_CONTENT_TYPE_PISTOLS = "Lx101013";
 ZFM_LOOT_CONTENT_TYPE_TOOLS = "Lx101014";
 ZFM_LOOT_CONTENT_TYPE_BUILDINGSUPPLIES = "Lx101015";
 ZFM_LOOT_CONTENT_TYPE_BACKPACKS = "Lx101016";
 ZFM_LOOT_CONTENT_TYPE_MEDICAL = "Lx101017";
 
 ZFM_DIFFICULTY_TEXT_TYPES =[
	"DEADEMEAT",
	"EASY",
	"MEDIUM",
	"HARD",
	"WAR_MACHINE"
 ];	
 
 ZFM_LOOT_CONTENT_TEXT_TYPES =[
	"SNIPERS",
	"MACHINEGUNS",
	"RIFLES",
	"PISTOLS",
	"TOOLS",
	"BUILDINGSUPPLIES",
	"MEDICAL"
 ];
 
 ZFM_LOOT_CONTENT_TYPES =[
	ZFM_LOOT_CONTENT_TYPE_SNIPERS,
	ZFM_LOOT_CONTENT_TYPE_MACHINEGUNS,
	ZFM_LOOT_CONTENT_TYPE_RIFLES,
	ZFM_LOOT_CONTENT_TYPE_PISTOLS,
	ZFM_LOOT_CONTENT_TYPE_TOOLS,
	ZFM_LOOT_CONTENT_TYPE_BUILDINGSUPPLIES ,
	ZFM_LOOT_CONTENT_TYPE_BACKPACKS,
	ZFM_LOOT_CONTENT_TYPE_MEDICAL
 ];
 
ZFM_LOOT_SNIPERS_DEADMEAT = [];
ZFM_LOOT_SNIPERS_EASY = [];
ZFM_LOOT_SNIPERS_MEDIUM = [];
ZFM_LOOT_SNIPERS_HARD = [];
ZFM_LOOT_SNIPERS_WAR_MACHINE = [];

ZFM_LOOT_MACHINEGUNS_DEADMEAT = [];
ZFM_LOOT_MACHINEGUNS_EASY = [];
ZFM_LOOT_MACHINEGUNS_MEDIUM = [];
ZFM_LOOT_MACHINEGUNS_HARD = [];
ZFM_LOOT_MACHINEGUNS_WAR_MACHINE = [];

ZFM_LOOT_RIFLES_DEADMEAT = [];
ZFM_LOOT_RIFLES_EASY = [];
ZFM_LOOT_RIFLES_MEDIUM = [];
ZFM_LOOT_RIFLES_HARD = [];
ZFM_LOOT_RIFLES_WAR_MACHINE = [];

ZFM_LOOT_PISTOLS_DEADMEAT = [];
ZFM_LOOT_PISTOLS_EASY = [];
ZFM_LOOT_PISTOLS_MEDIUM = [];
ZFM_LOOT_PISTOLS_HARD = [];
ZFM_LOOT_PISTOLS_WAR_MACHINE = [];

ZFM_LOOT_TOOLS_DEADMEAT = [];
ZFM_LOOT_TOOLS_EASY = [];
ZFM_LOOT_TOOLS_MEDIUM = [];
ZFM_LOOT_TOOLS_HARD = [];
ZFM_LOOT_TOOLS_WAR_MACHINE = [];

ZFM_LOOT_BUILDINGSUPPLIES_DEADMEAT = [];
ZFM_LOOT_BUILDINGSUPPLIES_EASY = [];
ZFM_LOOT_BUILDINGSUPPLIES_MEDIUM = [];
ZFM_LOOT_BUILDINGSUPPLIES_HARD = [];
ZFM_LOOT_BUILDINGSUPPLIES_WAR_MACHINE = [];

ZFM_LOOT_MEDICAL_DEADMEAT = [];
ZFM_LOOT_MEDICAL_EASY = [];
ZFM_LOOT_MEDICAL_MEDIUM = [];
ZFM_LOOT_MEDICAL_HARD = [];
ZFM_LOOT_MEDICAL_WAR_MACHINE = [];
 
 
 /*
 *	ZFM_Loot_Get_Contents
 *
 *	Gets the loot contents based on content type and difficulty. Content type is set as an array.
 */
 ZFM_Loot_Get_Contents ={
	private["_difficulty","_contents","_contentsArray","_contentsRow","_contentsCount","_outputArray"];
	_difficulty = _this select 0;
	_contents = _this select 1;

	_outputArray = [];
 
	if(_difficulty in ZFM_DIFFICULTY_TEXT_TYPES && typeName _contents == "ARRAY") then
	{
		// Validate to see if the contents are actually there..
		if(count _contents >0) then
		{
			_contentsCount = count _contents;
			_contentsArray = [];
			
			for [{_x =0},{_x <= _contentsCount-1},{_x = _x +1} ] do
			{
				_contentsRow = _contents select _x;
				_contentsArray = _contentsArray + call compile format["ZFM_LOOT_%1_%2",_contentsRow,_difficulty];
			};
			
			_contentsArray = _outputArray;
		};
	};
	
	_outputArray
 
 };
 
 
 ZFM_Loot_Get_Container_Limits ={
 	private["_container","_class","_maxMags","_maxWeapons","_maxBackPacks"];
	_container = _this select 0;
	
	// Get the class of the container
	_class = typeOf _container;

	// Gets the properties from the Cfg files for max magazines, weapons & backpacks
	_maxMags = getNumber (configFile >> "CfgVehicles" >> _class >> "transportMaxMagazines");
	_maxWeapons = getNumber (configFile >> "CfgVehicles" >> _class >> "transportMaxWeapons");
	_maxBackPacks = getNumber (configFile >> "CfgVehicles" >> _class >> "transportMaxbackpacks");
	
	
	// Isn't this so much easier than using a weird sub-function?
	_currMags = count (getMagazineCargo _container select 0);
	_currWeapons = count (getWeaponCargo _container select 0);
	_currBacks = count (getBackpackCargo _container select 0);
	
	// Return array 0 = Max Magazines, 1 = Max Weapons, 2= Max Backpacks
	[(_maxMags - _currMags),(_maxWeapons - _currWeapons),(_maxBackPacks - _currBacks)]
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
		
		diag_log(format["CURRENT %1, MAX %2",_curr,_max]);
		
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
		
		diag_log(format["AMOUNT AFTER %1, MAX %2, CURR %3, ISFULL %4",_amount,_max,_curr,_isFull]);
		
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
		
		diag_log(format["AMOUNT AFTER %1, MAX %2, CURR %3, ISFULL %4",_amount,_max,_curr,_isFull]);
		
		
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
		diag_log(format["AMOUNT AFTER %1, MAX %2, CURR %3, ISFULL %4",_amount,_max,_curr,_isFull]);
		
		// If the container is full, or if spawning on ground is 
		if(!(_isFull select 0)) then
		{
			_container addMagazineCargoGlobal[_class,_amount];
		};
	};
};
 
 /*
 *	ZFM_Loot_Add_Loot_To_Container
 *
 *	Adds loot to container. This function calls subfunctions. (See above)
 */
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
 
 
 