/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
      
ZFM_DZE_getModelName = {
	_objInfo = toArray(str(_this));
	_lenInfo = count _objInfo - 2;
	_objName = [];
	_i = 0;
	// determine where the object name starts
	{
	if (58 == _objInfo select _i) exitWith {};
	_i = _i + 1;
	} count _objInfo;
	_i = _i + 2; // skip the ": " part
	for "_k" from _i to _lenInfo do {
	_objName set [(count _objName), (_objInfo select _k)];
	};
	_objName = toLower(toString(_objName));
	_objName
};


ZFM_Layouts_Class_Get_SuperClass = {
	private ["_class","_vehicles","_weapons","_magazines","_retVal"];
	_class = _this select 0;
	
	_vehicles = isClass(configFile >> "CfgVehicles" >> _class);
	_weapons = isClass(configFile >> "CfgWeapons" >> _class);
	_magazine = isClass(configFile >> "CfgMagazines" >> _class);

	_retVal = "CfgNothing";

	if(isClass(configFile >> "CfgVehicles" >> _class)) then
	{
		_retVal = "CfgVehicles";
	};
	if(isClass(configFile >> "CfgWeapons" >> _class)) then
	{
		_retVal = "CfgWeapons";
	};
	if(isClass(configFile >> "CfgMagazines" >> _class)) then
	{
		_retVal = "CfgMagazines";
	};
	
	_retVal
	
	
}; 
 
/*
*	ZFM_Layout_Create_Object
*
*	Creates an object for the ZFM layout.
*/
ZFM_Layout_Create_Object ={
	private["_outputLoc","_className","_orientation","_classParameters","_classType","_createdObject","_createdObjects"];
	
	_outputLoc = _this select 0;
	_className = _this select 1;
	_orientation = _this select 2;
	_classParameters = _this select 3;

	// Don't care if the input is wrong. It's important that the input be checked if this is going to be monkeyed with by casual developers.
	if(typeName _outputLoc == "ARRAY" && typeName _className == "STRING" && typeName _orientation == "SCALAR" && typeName _classParameters == "ARRAY") then
	{

		diag_log(format["CREATE OBJECT WAS CALLED %1",_this]);

		// Creating a loot crate
		if(_className == ZFM_LAYOUT_OBJECT_LOOT) then
		{
			diag_log(format["FOUND LOOT OBJECT! YAY!"]);
			diag_log(format["CLASSPARAMETERS %1",_classParameters]);

			// We need it to be an array, or it won't work.
			if(typeName _classParameters == "ARRAY") then
			{
				// So, the parameters are what are passed to this function to create a loot iten.
				_createdObject = [(_classParameters select 0),_outputLoc,(_classParameters select 1),(_classParameters select 2)] call ZFM_Loot_Create;
			};
		};

		if(_className == ZFM_LAYOUT_OBJECT_UNIT_GROUP) then
		{
			if(typeName _classParameters == "ARRAY") then
			{
				[(_classParameters select 0),(_classParameters select 1),(_classParameters select 2),_outputLoc,(_classParameters select 3)] call ZFM_Units_CreateUnitGroup;
			};
		}
		else
		{
			diag_log(format["FOUND NON-LAYOUT OBJECT YAY! %1",_this]);

			_classType = [_className] call ZFM_Layouts_Class_Get_SuperClass;

			diag_log(format["CLASSNAME ARR %1",_classType]);

			if(_classType == "CfgVehicles") then
			{
				_createdObject = createVehicle [_className,_outputLoc,[],0,"NONE"];
				diag_log(format["CREATED NON LOOT OBJECT %1",_createdObject]);
				_createdObject setDir _orientation;
			};
		};

	};
	
	_createdObject
	
};

/*
*	ZFM_Layout_Scout
*
*	Looks to see if the area contains any buildings. If it does, Layout will quit making stuff.
*	If it doesn't, and there are trees, it will clear them away to ensure that the 
*/
ZFM_Layout_Scout ={
	private["_location","_nearbyObjects","_countObjects","_objName","_thisObj","_x"];
	_location = _this select 0;
	_size = _this select 1;
	
	if(typeName _location == "ARRAY") then
	{
		_nearbyObjects = nearestObjects[_location,[],_size];
		_countObjects = count _nearbyObjects;
		
		for [{_x =0},{_x <= _countObjects-1},{_x = _x +1} ] do
		{
			_objName = [(_nearbyObjects select _x)] call ZFM_DZE_getModelName;

			if(_objName in ZFM_Layouts_Crap_To_Clear) then
			{
				_thisObj = _nearbyObjects select _x;
				_thisObj setDamage 1;
			};
		};
	};
};

ZFM_Layout_Parse ={
	private["_layout","_centerFound","_width","_layoutCount","_outputLoc","_outputX","_outputY","_offsetX","_offsetY","_offsetDiffX","_offsetDiffY","_centerPos","_arraySpacing","_centerPosX","_centerPosY","_x","_y","_row","_rowCount","_rowItem","_className","_orientation","_classParameters","_created"];
	_layout = _this select 0;
	_centerPos = _this select 1;
	_centerLocation = _this select 2;
	_arraySpacing = _this select 3;
	_outputLoc = _centerLocation;
	
	// Okay, first check -- are the two arrays actually arrays?
	if(typeName _layout == "ARRAY" && typeName _centerPos == "ARRAY") then
	{	
		// And, do they have >0 counts? No point them being empty, right?
		if( (count _layout >0) && (count _centerPos >0) ) then
		{
			// Okay, so next -- are they both integers (Argh, I dislike datatypes in SQF..)
			if(typeName (_centerPos select 0) == "SCALAR" && typeName (_centerPos select 1) == "SCALAR") then
			{
				// Regardless, we're re-using this, so.. keep it. 
				_layoutCount = count _layout;
			
				// Okay, we have the center pos. So here, a person says "On a grid of 9 x 9, [1,1] is the center. from which, other things emanate. ;-)
				_centerPosX = _centerPos select 0;
				_centerPosY = _centerPos select 1;
				
				// Someone said "On a 9x9 grid [for example], the center is on the 10th row. Yeah, not gonna happen.
				if(_centerPosY > count _layout) then
				{
					// Set it to the end of the array. Hmm
					_centerPosY = count _layout;
				};
			
				_width = count (_layout select 0)+1;
				
	
				// Now we loop through the main body of the layoutArray -- the row of arrays
				for [{_x =0},{_x <= _layoutCount-1},{_x = _x +1} ] do
				{
					// Get the row by number.
					_row = _layout select _x;

					diag_log(format["ROW NUMBER %1, X %2, LAYOUTCOUNT %3",_row,_x,_layoutCount]);

					
					if(typeName _row == "ARRAY") then
					{
						// How wide is this array?
						_rowCount = count _row;
						
						diag_log(format["ROWCOUNT %1",_rowCount]);
						// Did some dingbat give a row too short and a center too far? :O
						if(_centerPosX > _rowCount) then
						{
							_centerPosX = _rowCount;
							diag_log(format["CENTERPOSX %1",_centerPosX]);
						};
						
						// Okay, so we're sure it's an array and we're going through each part 
						// of the individual elements 
					
						
						// Is it actually non-empty?
						if(_rowCount >0) then
						{
							for [{_y =0},{_y <= _rowCount-1},{_y = _y +1} ] do
							{

								diag_log(format["ROW NUMBERY %1",_row]);


								diag_log(format["ROW COUNT %1 AND ROW %2",count _row,_row]);	

								// Get the item from the array..
								_rowItem = _row select _y;
							
								if(typeName _rowItem == "ARRAY") then
								{
									if((count _rowItem) == 3) then
									{
										_className = _rowItem select 0;
										_orientation = _rowItem select 1;
										_classParameters = _rowItem select 2;

										// SEt center as default. 99% of the time this will never equal center. This is for that weird 1% that doesn't work.
										_offsetX = _centerLocation select 0;
										_offsetY = _centerLocation select 1;
										
										if(_x == _centerPosX) then
										{
											_outputX = _centerLocation select 0;
											diag_log(format["OUTPUTX %1",_outputX]);

										};

										if(_x < _centerPosX) then
										{
											_offsetX = (_centerPosX + 1)-(_x+1);
											_outputX = (_centerLocation select 0)-(_offsetX * _arraySpacing);
											diag_log(format["OUTPUTX %1",_outputX]);

										};
										
										if(_x > _centerPosX) then
										{
											_offsetX = (_x+1)-(_centerPosX+1);
											_outputX = (_centerLocation select 0)+(_offsetX * _arraySpacing);
											diag_log(format["OUTPUTX %1",_outputX]);
										};											
										
										if(_y == _centerPosY) then
										{
											_outputY = _centerLocation select 1;
											diag_log(format["OUTPUTY %1",_outputY]);

										};

										if(_y < _centerPosY) then
										{
											_offsetY = (_centerPosY + 1)-(_y+1);
											_outputY = (_centerLocation select 1)-(_offsetY * _arraySpacing);
											diag_log(format["OUTPUTY %1",_outputY]);

										};
										if(_y > _centerPosY) then
										{
										
											// _centerPosY+1 = 2+1 = 3, y=3 +1 = 4
											// _y+1 - _centerPosY+1
											_offsetY = (_y+1)-(_centerPosY+1); // So here, _y = 3 + 1 = 4
											// _centerPosY = 2 + 1 = 3, so 3 + 4 = 7, 7*5 = 35 = 4635
											_outputY = (_centerLocation select 1)+(_offsetY * _arraySpacing);
											diag_log(format["OUTPUTY %1",_outputY]);

										};												

										_outputLoc = [_outputX,_outputY,(_centerLocation select 2)];
										
										diag_log(format["[%1,%2] > %3",_x,_y,_outputLoc]);
										
										diag_log(format["OUTPUTLOC %1, %2,%3,%4",_outputLoc,_className,_orientation,_classParameters]);

										[_outputLoc,_className,_orientation,_classParameters] call ZFM_Layout_Create_Object;
										
									};
								};
							};
						};					
					};
				};
				
				
			};
		};
	};
};