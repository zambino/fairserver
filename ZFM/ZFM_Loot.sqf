/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

 

 /*
 *	ZCR_Item_Is_Weapon
 *	
 *	With a given classname, tells you if it is a weapon or not.
 *	TODO: Move to ZCR.
 */
ZCR_Item_Is_Weapon ={
	private["_class","_isWeapon"];
	_class = _this select 0;
	_isWeapon = false;

	if(isClass(configFile >> "CfgWeapons" >> _class)) then
 	{
 			_isWeapon = true;
 	};

 	_isWeapon
};

 /*
 *	ZCR_Item_Get_Type
 *
 *	Gets the type of the item based on the classname given.
 *	TODO: Move to ZCR
 */
 ZCR_Item_Get_Type ={
 	private["_class"];
 	_class = _this select 0;
 	_type = "none";

 	if(typeName _class == "STRING") then
 	{
 		if(isClass(configFile >> "CfgWeapons" >> _class)) then
 		{
 			_type = "weapon";
 		};
 		if(isClass(configFile >> "CfgVehicles" >> _class)) then
 		{
 			_type = "backpack";
 		};
 		if(isClass(configFile >> "CfgMagazines" >> _class)) then
 		{
 			_type = "magazine";
 		};
	};
	_type
};

/*
*	ZFM)Loot_Contents_Append_Magazines
*
*	Appends magazines to a given lootArray for each weapon supplied.
*/
ZFM_Loot_Contents_Append_Magazines ={
	private["_contents","_countContents","_type","_weapon","_appendArray","_magazine"];
	_contents = _this select 0;
	_appendArray = [];

	if(typeName _contents == "ARRAY") then
	{	
		_countContents = count _contents;
		
		for[{_x=0},{_x <= _countContents-1},{_x = _x +1}] do
		{
			_rowItem = _contents select _x;
			_weapon = 	[_rowItem] call ZCR_Item_Is_Weapon;

			if(_weapon) then
			{
				_magazine = getArray(configFile >> "CfgWeapons" >> _rowItem >> "magazines");

				if(typeName _magazine == "ARRAY") then
				{
					diag_log(format["MAGAZINE %1",_magazine]);
					if(count _magazine >0) then
					{

						_appendArray = _appendArray + [(_magazine select 1)];
					};
				};
			};

			_contents + _appendArray
		};
	};
};


 /*
 *	ZFM_Loot_Get_Contents
 *
 *	Gets the loot contents based on content type and difficulty. Content type is set as an array.
 */
 ZFM_Loot_Get_Contents ={
	private["_difficulty","_contents","_contentsArray","_minimumItems","_itemRemaining","_fixArray","_rowContents","_contentsRow","_contentsCount","_outputArray"];
	_difficulty = _this select 0;
	_contents = _this select 1;

	_outputArray = [];
 
	diag_log(format["PAREMETERS FOR ZFM_Loot_Get_Contents %1",_this]);
 
	if(_difficulty in ZFM_DIFFICULTY_TEXT_TYPES && typeName _contents == "ARRAY") then
	{
		diag_log(format["CONTENTS",_contents]);
	
		// Validate to see if the contents are actually there..
		if(count _contents >0) then
		{
			_contentsCount = count _contents;
			_contentsArray = [];
			
			for [{_x =0},{_x <= _contentsCount-1},{_x = _x +1} ] do
			{
				_contentsRow = _contents select _x;
				_contentsArray = _contentsArray + call compile format["ZFM_LOOT_%1_%2",_contentsRow,_difficulty];
				
				diag_log(format["CONTENTS ARRAYZAZ %1",_contentsArray]);
			};
			
			_minimumItems = call compile format["ZFM_MINIMUM_ITEMS_PER_LOOT_CRATE_%1",_difficulty];
			
			if((count _contentsArray) < _minimumItems) then
			{
				_itemRemaining = _minimumItems - (count _contentsArray);
				_fixArray = call compile format["ZFM_ALL_LOOT_%1",_difficulty];
				
				for[{_x=0},{_x <= _itemRemaining},{_x = _x +1}] do
				{
					_rowContents = _fixArray call BIS_fnc_selectRandom;
					_contentsArray = _contentsArray + [_rowContents];
				};
			};

			// Now to add in ammunition for any weapons in the crate!
			_outputArray = [_contentsArray] call ZFM_Loot_Contents_Append_Magazines;
			diag_log(format["OUTPUT ARRAY FINAL %1",_outputArray]);
		};
	}
	else
	{
		if(typeName _contents == "ARRAY") then
		{
			// So that if someone passes actual classes to it, the function just returns it.
			_outputArray = _contents;
		};
	};
	
	_outputArray
 
 };
 
 /*
 * ZFM_Loot_Get_Container_Limits
 *
 * Supplied function to get the limits of the vehicle being filled.
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
	private["_toAddLootTo","_lootToAdd","_itemsCount","_rowItem","_rowType","_x","_amount"];
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


				_rowItem = _lootToAdd select _x;

				diag_log("DIAGLOGGING NULL VALUE");
				diag_log(format["%1",(_lootToAdd select _x)]);

				// This works surprisingly well. Check if the array element is null.
				if(format["%1",(_lootToAdd select _x)] != "<null>") then
				{
						if(typeName (_lootToAdd select _x) == "STRING") then
						{
							[_rowItem,(round random 5),_toAddLootTo] call ZFM_Loot_Add_Loot_To_Container_Sub;
						};
									
						if(typeName (_lootToAdd select _x) == "ARRAY") then
						{
							// classname, amount, container
							[(_rowItem select 0),(_rowItem select 1),_toAddLootTo] call ZFM_Loot_Add_Loot_To_Container_Sub;
						};
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
	private["_toAddLootTo","_location","_lootToAdd","_actualLootObject","_returnObject"];
	
	_toAddLootTo = _this select 0;
	_location = _this select 1;
	_lootToAdd = _this select 2;
	
	diag_log(format["Create_Loot_Object called %1",_this]);
	
	_returnObject = objNull;

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

			_returnObject = _actualLootObject;
		};
	};

	_returnObject
 };

 ZFM_Loot_Create = {
 	private["_difficulty","_position","_lootCrateType","_returnObject","_contents","_lootContents","_addContents","_createdContents","_createdLootItemClass"];

 	_difficulty = _this select 0;
 	_position = _this select 1;
 	_lootCrateType  = _this select 2;
 	_returnObject = objNull;

 	diag_log(format["Creating loot motherfucker %1",_this]);

 	if(count _this >3) then
 	{
 		_contents = _this select 3;
	}
	else
	{
		_contents = [];
	};

 	// Default in case something goes wrong
 	_createdLootItemClass = ZFM_Loot_Crates call BIS_fnc_selectRandom;


 	if(_difficulty in ZFM_DIFFICULTY_TEXT_TYPES) then 
 	{
 		// This is the most type-safe way of checking the parameter. If someone sets offset x, isNull will freak out.
 		// This is to check if _contents doesn't exist. 
 		if(typeName _contents != "ARRAY" || count _contents == 0) then
 		{
 			//Hardcoding at least two types. For loops should be used very sparingly for CPU considerations.
 			_addContents = ZFM_LOOT_CONTENT_TEXT_TYPES call BIS_fnc_selectRandom;
 			_contents = _contents + [_addContents];
 			_addContents = ZFM_LOOT_CONTENT_TEXT_TYPES call BIS_fnc_selectRandom;
 			_contents = _contents + [_addContents];
 			_contents = [_difficulty,_contents] call ZFM_Loot_Get_Contents;
 		}
 		else
 		{
 			_contents = [_difficulty,_contents] call ZFM_Loot_Get_Contents;
 		};

 		diag_log(format["CONTENTS OF LAYOUT LOOT ARRAY %1",_contents]);


 		if(typeName _lootCrateType == "STRING") then
 		{

	 		// Then select a random loot crate type from our pre-prepared list
	 		_createdLootItemClass = _lootCrateType;
 		};

 		diag_log(format["CREATED LOOT ITEM CLASS %1",_createdLootItemClass]);

 		//Create the loot box.
 		_returnObject = [_createdLootItemClass,_position,_contents] call ZFM_Loot_Create_Loot_Object;
 	};

 	_returnObject

 };

