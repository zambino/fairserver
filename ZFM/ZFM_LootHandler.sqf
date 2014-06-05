/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)

	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

/*
*	ZFM_Create_Loot_Item
*	
*	Creates a crate, in which, items can be spawned.
*/
ZFM_Create_Loot_Item ={
	private ["_locationToSpawn","_outputText","_actualCrate"];
	_locationToSpawn = _this select 0; 
	
	// Create this vehicle box
	
	_crateTypes = ZFM_Loot_Crates call BIS_fnc_selectRandom;
	
	// Creates the crate.
	_actualCrate = createVehicle[_crateTypes,_locationToSpawn,[],0,"CAN_COLLIDE"];
	
	// Remove whatever is in the crate.
	clearWeaponCargoGlobal _actualCrate;
	clearMagazineCargoGlobal _actualCrate;
	
	// Put it in a random location..
	_actualCrate setDir round(random 360);

	// Set the position (why do we have to do this twice?)
	_actualCrate setPos _locationToSpawn;

	// Return it so we can put loot in it..
	_actualCrate
};
 
/*
*	ZFM_Walk_LootTable
*	
*	Walks through a supplied loot table and creates an array for that item
*/
ZFM_Walk_LootTable ={
	private ["_arrayIn","_difficulty","_probable","_availableItems","_outputMessage","_arrayOut","_item","_itemClass","_itemType","_itemProbability","_metProbability","_itemOut","_arrayOut"];
	
	_arrayIn = _this select 0;
	_difficulty = _this select 1;
	_probable = _this select 2;
	
	diag_log(format["ArrayIN: %1",_arrayIn]);
	
	_availableItems = count _arrayIn;
	_outputMessage = ZFM_Name + ZFM_Version;
	_arrayOut = [];
	
	diag_log(format["ArrayIn %1",_availableItems]);

	for [{_x =0},{_x <= _availableItems-1},{_x = _x +1} ] do
	{
		// Get the item
		_item = _arrayIn select _x; // Get the array from the array.
	
		diag_log(format["ArrayItem: %1",_item]);
	
		_itemClass = _item select 0;
		_itemType = _item select 1;
		_selectItem = 2;
		
		// Fix if non-probability
		if(count _item >2) then
		{
			if(_difficulty == "MEDIUM") then
			{
				_selectItem = 3;
			};
			
			if(_difficulty == "HARD") then
			{
				_selectItem = 4;
			};
		};
		// Get the relevant boundary for the probability of the item.
		_itemBoundary = _item select _selectItem;
	
		// Fix - always add 1 to the probability so it will never be 0..
		_itemProbability = abs ((round random 100)+1 / 100);
		_metProbability = _itemProbability >= _itemBoundary;
		diag_log(format["%1 - ZFM_Walk_LootTable - Item probability %2, Boundary %3, MetBoundary %3",_outputMessage,_itemProbability,_itemBoundary,_metProbability]);
		
		if(_probable) then
		{
			if(_itemProbability <= _itemBoundary) then
			{
				diag_log(format["%1 - Added %2 to container array..",_outputMessage,_itemClass]);
				
				_itemOut = [_itemClass,_itemType];
				_arrayOut set [_x,_itemOut]; // Ensure the structure of the array is kept.
			};
		}
		else
		{
			_itemOut = [_itemClass,_itemType];
			_arrayOut set [_x,_itemOut]; // Ensure the structure of the array is kept.
		};
	};
	
	_arrayOut
};

/*
*	ZFM_Fill_QuickerFilter
*
*	TODO: Replace using CfgWeapons
*	A fill function a little quicker (and a lot less obfuscated) as the DayZ function
*/
ZFM_QuickerFiller = {
	private ["_container","_classType","_randAmt","_outputText"];
	
	_container = _this select 0;
	_classType = _this select 1;
	_randAmt = _this select 2;

	switch (_classType) do
	{
		case "weapon": {
			diag_log(format[_outputText + " - Create_Loot_Item_AutoFill_AllTypes - Created %1 in container %2",_className,_container]);
			// Add the weapon to the container..
			_container addWeaponCargoGlobal[_className,_randAmt];
		
		};
		case "magazine": {
			diag_log(format[_outputText + " - Create_Loot_Item_AutoFill_AllTypes - Created %1 in container %2",_className,_container]);
			_container addMagazineCargoGlobal[_className,_randAmt];
		};
		
		case "backpack": {
			diag_log(format[_outputText + " - Create_Loot_Item_AutoFill_AllTypes - Created %1 in container %2",_className,_container]);
			_container addBackpackCargoGlobal[_className,_randAmt];
		};
	};
};

/*
*	ZFM_Fill_Loot_Item_AutoFill_AllTypes
*	
*	Fills a pre-supplied crate with random loot.
*/
ZFM_Fill_Loot_Item_AutoFill ={
	private ["_container","_probable","_difficulty","_lootArray","_outputArray","_count","_rowItem","_className","_classType","_randAmt"];
	
	_container = _this select 0;	// What are we adding it to?
	_probable = _this select 1; 	//Is this probability based?
	_difficulty = _this select 2;	//"EASY","MEDIUM","HARD"
	_lootArray = _this select 3;
	
	// Contains the items which pass probability test.
	_outputArray = [_lootArray,_difficulty,_probable] call ZFM_Walk_LootTable;
	_count = count _outputArray;
	
	// Debug..
	diag_log(format["Output ARRAY Count %1",_count]);
	
	// Is the AutoFill based on the probability system?

	for [{_x =1},{_x <= _count-1},{_x = _x +1} ] do
	{
		// Select the row.
		_rowItem = _outputArray select _x;
		
		// Debug..
		diag_log(format["rowItem %1",_rowItem]);
		
		// Ignore those empty items.
		if(typeName _rowItem == "ARRAY") then
		{
				// Get the row contents
				_className = _rowItem select 0;
				_classType = _rowItem select 1;
					
				_randAmt = 1; // Set default to 1, so at least 1 spawns..
					
				// 40% chance there will be a random amount added, too.
				if((round random 100) <20 && _probable) then
				{
					_randAmt = round random 6;
				};

				diag_log(format["ForEach CLASSNAME = %1, CLASSTYPE = %2, RANDOM AMOUNT = %3",_className,_classType,_randAmt]);
				
				// Fill the container, filtering out the type given 
				[_container,_classType,_randAmt] call ZFM_QuickerFiller;
		};
	};
};
 
/*
*	ZFM_Create_LootCrate
*	
*	Creates a random crate. The type of items in the crate are specified by the user.
*/
ZFM_Create_LootCrate ={
	private ["_locationToSpawn","_difficulty","_polyArray","_probable","_crateItem","_crateFill"];
	
	_locationToSpawn = _this select 0;
	_difficulty = _this select 1;
	_polyArray = _this select 2;
	_probable = _this select 3;
	
	// Create the random crate, empty..
	_crateItem = [_locationToSpawn] call ZFM_Create_Loot_Item;
	
	diag_log(format["Crate Item = %1",_crateItem]);
	
	//Fill the crate..
	_crateFill = [_crateItem,_probable,_difficulty,_polyArray] call ZFM_Fill_Loot_Item_AutoFill;
	
	_createItem
};


