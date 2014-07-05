/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
  
/*
*	ZFM_Layouts_Array
*	
*	Used for spawning layouts for bases automatically.
*	Each item = Array =
*	0 = classname
*	1 = orientation
*	2 = parameters (i.e. for vehicles, their contents)
*/
ZFM_Layouts_Crap_To_Clear =[
	"b_corylus2s.p3d",
	"b_craet1.p3d",
	"r2_boulder1.p3d",
	"r2_boulder2.p3d",
	"t_picea2s_snow.p3d",
	"b_corylus.p3d",
	"t_quercus3s.p3d",
	"t_larix3s.p3d",
	"t_pyrus2s.p3d",
	"str_briza_kriva.p3d",
	"dd_borovice.p3d",
	"les_singlestrom_b.p3d",
	"les_singlestrom.p3d",
	"smrk_velky.p3d",
	"smrk_siroky.p3d",
	"smrk_maly.p3d",
	"les_buk.p3d",
	"str krovisko vysoke.p3d",
	"str_fikovnik_ker.p3d",
	"str_fikovnik.p3d",
	"str vrba.p3d",
	"hrusen2.p3d",
	"str dub jiny.p3d",
	"str lipa.p3d",
	"str briza.p3d",
	"p_akat02s.p3d",
	"jablon.p3d",
	"p_buk.p3d",
	"str_topol.p3d",
	"str_topol2.p3d",
	"p_osika.p3d",
	"t_picea3f.p3d",
	"t_picea2s.p3d",
	"t_picea1s.p3d",
	"t_fagus2w.p3d",
	"t_fagus2s.p3d",
	"t_fagus2f.p3d",
	"t_betula1f.p3d",
	"t_betula2f.p3d",
	"t_betula2s.p3d",
	"t_betula2w.p3d",
	"t_alnus2s.p3d",
	"t_acer2s.p3d",
	"t_populus3s.p3d",
	"t_quercus2f.p3d",
	"t_sorbus2s.p3d",
	"t_malus1s.p3d",
	"t_salix2s.p3d",
	"t_picea1s_w.p3d",
	"t_picea2s_w.p3d",
	"t_ficusb2s_ep1.p3d",
	"t_populusb2s_ep1.p3d",
	"t_populusf2s_ep1.p3d",
	"t_amygdalusc2s_ep1.p3d",
	"t_pistacial2s_ep1.p3d",
	"t_pinuse2s_ep1.p3d",
	"t_pinuss3s_ep1.p3d",
	"t_prunuss2s_ep1.p3d",
	"t_pinusn2s.p3d",
	"t_pinusn1s.p3d",
	"t_pinuss2f.p3d",
	"t_poplar2f_dead_pmc.p3d",
	"misc_torzotree_pmc.p3d",
	"misc_burnspruce_pmc.p3d",
	"brg_cocunutpalm8.p3d",
	"brg_umbrella_acacia01b.p3d",
	"brg_jungle_tree_canopy_1.p3d",
	"brg_jungle_tree_canopy_2.p3d",
	"brg_cocunutpalm4.p3d",
	"brg_cocunutpalm3.p3d",
	"palm_01.p3d",
	"palm_02.p3d",
	"palm_03.p3d",
	"palm_04.p3d",
	"palm_09.p3d",
	"palm_10.p3d",
	"brg_cocunutpalm2.p3d",
	"brg_jungle_tree_antiaris.p3d",
	"brg_cocunutpalm1.p3d",
	"str habr.p3d"
];
  
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
 
ZFM_Layouts_Array =[
	[["CampEast",0,[]],["CampEast",0,[]],["CampEast",0,[]]],
	[0,["Land_tent_east",0,[]],0]
];

 
ZFM_Layouts_Class_Get_SuperClass = {
	private ["_class","_vehicles","_weapons","_magazines","_retVal"];
	_class = _this select 0;
	
	_vehicles = isClass(configFile >> "CfgVehicles" >> _class);
	_weapons = isClass(configFile >> "CfgWeapons" >> _class);
	_magazine = isClass(configFile >> "CfgMagazines" >> _class);
	
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
		_classType = [_className] call ZFM_Layouts_Class_Get_SuperClass;
		
		if(_classType == "CfgVehicles") then
		{
			_createdObject = createVehicle [_className,_outputLoc,[],0,"NONE"];
			_createdObject setDir _orientation;
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
				
				// Okay, we need to use "Scout", once. Running through map objects N times is very resource-intensive.
				[_centerLocation,(_width*_arraySpacing)] call ZFM_Layout_Scout;
				
				// Now we loop through the main body of the layoutArray -- the row of arrays
				for [{_x =0},{_x <= _layoutCount-1},{_x = _x +1} ] do
				{
					// Get the row by number.
					_row = _layout select _x;

					
					if(typeName _row == "ARRAY") then
					{
						// How wide is this array?
						_rowCount = count _row;
						

						// Did some dingbat give a row too short and a center too far? :O
						if(_centerPosX > _rowCount) then
						{
							_centerPosX = _rowCount;
						};
						
						// Okay, so we're sure it's an array and we're going through each part 
						// of the individual elements 
					
						
						// Is it actually non-empty?
						if(_rowCount >0) then
						{
							for [{_y =0},{_y <= _rowCount-1},{_y = _y +1} ] do
							{
								// Get the item from the array..
								_rowItem = _row select _y;
							
								if(typeName _rowItem == "ARRAY") then
								{
									if((count _rowItem) == 3) then
									{
										_className = _rowItem select 0;
										_orientation = _rowItem select 1;
										_classParameters = _rowItem select 1;
										

										// SEt center as default. 99% of the time this will never equal center. This is for that weird 1% that doesn't work.
										_offsetX = _centerLocation select 0;
										_offsetY = _centerLocation select 1;
										
										if(_x == _centerPosX) then
										{
											_outputX = _centerLocation select 0;
										};

										if(_x < _centerPosX) then
										{
											_offsetX = (_centerPosX + 1)-(_x+1);
											_outputX = (_centerLocation select 0)-(_offsetX * _arraySpacing);
										};
										
										if(_x > _centerPosX) then
										{
											_offsetX = (_x+1)-(_centerPosX+1);
											_outputX = (_centerLocation select 0)+(_offsetX * _arraySpacing);
										};											
										
										if(_y == _centerPosY) then
										{
											_outputY = _centerLocation select 1;
										};

										if(_y < _centerPosY) then
										{
											_offsetY = (_centerPosY + 1)-(_y+1);
											_outputY = (_centerLocation select 1)-(_offsetY * _arraySpacing);
										};
										if(_y > _centerPosY) then
										{
										
											// _centerPosY+1 = 2+1 = 3, y=3 +1 = 4
											// _y+1 - _centerPosY+1
											_offsetY = (_y+1)-(_centerPosY+1); // So here, _y = 3 + 1 = 4
											// _centerPosY = 2 + 1 = 3, so 3 + 4 = 7, 7*5 = 35 = 4635
											_outputY = (_centerLocation select 1)+(_offsetY * _arraySpacing);
										};												

										_outputLoc = [_outputX,_outputY,(_centerLocation select 2)];
										
										diag_log(format["[%1,%2] > %3",_x,_y,_outputLoc]);
										
										[_outputLoc,_className,_orientation,[_classParameters]] call ZFM_Layout_Create_Object;
										
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


ZFM_Debug_Create_Layout ={
	// 13400,3960,0
	[ZFM_Layouts_Array,[1,1],[4600,10160,0],20] call ZFM_Layout_Parse;
};



