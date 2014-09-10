/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

/*
*	ZFM_Common_Log
*	
*	Common function used to log errors and information.
*/
ZFM_Common_Log ={
	private["_prefix","_interpText","_interpArray","_outputText","_formatText"];

	// Exit the function, no output. Isn't this such a beautiful function? :D
	if(!ZFM_ENABLE_DEBUG_MESSAGES) exitWith{};

	// Always prefix the string with this as it's a common static part
	_prefix = format["%1 %2",ZFM_NAME,ZFM_VERSION];

	switch(count(_this)) do
	{
		// Debug text only
		case 1: {
			if(typeName (_this select 0) == "STRING") then
			{
				diag_log(
					format["%1 - %2 - %3 - %4",_prefix,"NotSpecified","INFORMATION",(_this select 0)]
				);
			}
			else
			{
				diag_log(
					format["%1 - ERROR - Wrong parameter types for Common_Log! (#1 is %2)",_prefix,typeName (_this select 0)]
				);	
			};
		};

		// Debug text and caller name
		case 2: {
			if(typeName (_this select 0) == "STRING" && typeName (_this select 1) == "STRING") then
			{
				diag_log(
					format["%1 - %2 - %3 - %4",_prefix,(_this select 1),"INFORMATION",(_this select 0)]
				);		
			}
			else
			{
				diag_log(
					format["%1 - ERROR - Wrong parameter types for Common_Log! (#1 is %2,#2 is %3)",_prefix,typeName (_this select 0),typeName (_this select 1)]
				);
			};
		};


		// Debug text, caller name and message type
		case 3: {
			if(typeName (_this select 0) == "STRING" && typeName (_this select 1) == "STRING" && typeName (_this select 2) == "STRING") then
			{
					diag_log(
						format["%1 - %2 - %3 - %4",_prefix,(_this select 1),(_this select 2),(_this select 0)]
					);
			}
			else
			{
				diag_log(
					format["%1 - ERROR - Wrong parameter types for Common_Log! (#1 is %2,#2 is %3, #3 is %4)",_prefix,typeName (_this select 0),typeName (_this select 1),typeName (_this select 2)]
				);
			};
		};

		// Debug text, caller name, message type & parameters
		case 4: {
			if(typeName (_this select 0) == "STRING" && typeName (_this select 1) == "STRING" && typeName (_this select 2) == "STRING" && typeName (_this select 3) == "ARRAY") then
			{
				if(count(_this select 3) >0) then
				{
					// Create an array for the format function
					_interpArray = [(_this select 0)] + (_this select 3);
					_interpText = format _interpArray;
					_outputText = ["%1 - %2 - %3 - %4",_prefix,(_this select 1),(_this select 2),_interpText];
					_formatText = format _outputText;
					diag_log(_formatText);
				}
				else
				{
					diag_log(
						format["%1 - %2 - %3 - %4",_prefix,(_this select 1),(_this select 2),(_this select 0)]
					);
				};
			}
			else
			{
				diag_log(
					format["%1 - ERROR - Wrong parameter types for Common_Log! (#1 is %2,#2 is %3, #3 is %4)",_prefix,typeName (_this select 0),typeName (_this select 1),typeName (_this select 2)]
				);
			};
		};
	};
};


/*
*	ZFM_Common_DoMissionBootStrap
*
*	Load files for each mission type. At present, only crashes are supported.
*/
ZFM_Common_DoMissionBootStrap ={
	private["_includePath","_includes","_iRow"];

	if(typeName ZFM_MISSION_TYPES_ENABLED == "ARRAY" && typeName ZFM_MISSION_TYPES_SUPPORTED == "ARRAY") then
	{
		if(count ZFM_MISSION_TYPES_SUPPORTED >0 && count ZFM_MISSION_TYPES_ENABLED >0) then
		{

			_includes = count ZFM_MISSION_TYPES_ENABLED;

			for [{_x =0},{_x <= _includes-1},{_x = _x +1} ] do
			{
				_iRow = ZFM_MISSION_TYPES_ENABLED select _x;

				if(_iRow in ZFM_MISSION_TYPES_SUPPORTED) then
				{
					_includePath = ZFM_MISSION_TYPE_INCLUDE_DIR + format[ZFM_MISSION_TYPE_INCLUDE_NAME,_iRow];
					[2,"INFORMATION","ZFM_Common::ZFM_Common_DoMissionBootStrap",[_includePath]] call ZFM_Language_Log;
					//["MissionBootStrap IncludePath is %1","ZFM_Common::ZFM_Common_DoMissionBootStrap",[_includePath]] call ZFM_Common_Log;
					call compile preprocessFileLineNumbers _includePath;
				};
			};
		}
		else
		{
			[0,"ERROR"] call ZFM_Language_Log;
			//["Fatal error! No mission types are defined or enabled! Please rectify this by ensuring ZFM_MISSION_TYPES_ENABLED or ZFM_MISSION_TYPES_SUPPORTED has the correct contents","ZFM_Common::ZFM_Common_DoMissionBootStrap"] call ZFM_Common_Log;
		};
	}
	else
	{
		[0,"ERROR"] call ZFM_Language_Log;
		//["Fatal error! No mission types are defined or enabled! Please rectify this by ensuring ZFM_MISSION_TYPES_ENABLED or ZFM_MISSION_TYPES_SUPPORTED has the correct contents","ZFM_Common::ZFM_Common_DoMissionBootStrap"] call ZFM_Common_Log;
	};

};	

ZFM_Common_DoDayZBootStrap ={
	private["_includePath"];	

	diag_log("DAYZBOOTSTRAP");

	if(typename ZFM_DAYZ_TYPES_SUPPORTED == "ARRAY" && typeName ZFM_DAYZ_TYPE_INCLUDE_NAME == "STRING") then
	{
		if(count ZFM_DAYZ_TYPES_SUPPORTED >0) then
		{
			diag_log(format["DAYZ COUNT %1",count ZFM_DAYZ_TYPES_SUPPORTED]);

			if(ZFM_DAYZ_TYPE in ZFM_DAYZ_TYPES_SUPPORTED) then
			{
				_includePath = format[ZFM_DAYZ_TYPE_INCLUDE_DIR,ZFM_DAYZ_TYPE] + ZFM_DAYZ_TYPE_INCLUDE_NAME;
				[1,"INFORMATION","ZFM_Common::ZFM_Common_DoMissionBootStrap",[_includePath]] call ZFM_Language_Log;
				call compile preprocessFileLineNumbers _includePath;
			}
			else
			{
				[1,"ERROR","ZFM_Common::ZFM_Common_DoMissionBootStrap",[_includePath]] call ZFM_Language_Log;
			};
		}
		else
		{
			[1,"ERROR","ZFM_Common::ZFM_Common_DoMissionBootStrap",[_includePath]] call ZFM_Language_Log;
		};
	}
	else
	{
		[1,"ERROR","ZFM_Common::ZFM_Common_DoMissionBootStrap",[_includePath]] call ZFM_Language_Log;
	};

};


/*
	ZFM_CrashSite_OffsetPosition
	
	Offsets the Position on x axis.
*/
ZFM_Common_Offset_Position ={

	private["_position","_x","_y","_z","_newX"];
	
	_position = _this select 0;
	_offsetX = _this select 1;
	_offsetY = _this select 2;

	_x = _position select 0;
	_y = _position select 1;
	_z = _position select 2;
	
	_newX = _x -_offsetY;
	_newY = _y - _offsetY;
	
	// Return the position
	[_newX,_newY,_z]
};


/*
	ZFM_Alter_Humanity
	
	Add/Remove humanity for a given player.
*/
ZFM_Common_Humanity_Alter ={
	private ["_player","_currentHumanity","_humanityToAdd"];
	
	_player = _this select 0;
	_humanityToAdd = ZFM_HUMANITY_AMOUNT_PER_BANDIT;
	
	if(typeName _player == "OBJECT") then
	{
		_currentHumanity = _player getVariable["humanity",0];
		
		if(ZFM_HUMANITY_AMOUNT_PER_BANDIT >0) then
		{
			if(!ZFM_HUMANITY_AMOUNT_FIXED) then
			{
				_humanityToAdd = round random ZFM_HUMANITY_AMOUNT;
			};
			_player setVariable["humanity",_currentHumanity + _humanityToAdd];
		};
	};
};


/*
*	ZFM_CheckExistingMissionSystems	
*
*	Checks to see if existing Misson Systems are included.
*/
ZFM_Common_CheckExistingMissionSystems = {
	
	_doExit = false;
	_outputMessage = ZFM_Name + ZFM_version;
	
	/*
	*	Check for DZMS or EMS (Still curious why they couldn't use their own constants, the EMS guys. Oh well!)
	*/
	if(!isNil(DZMSInstalled)) then
	{
		[7,"INFORMATION","ZFM_Common::ZFM_Common_CheckExistingMissionSystems"] call ZFM_Language_Log;
		_doExit = true;
	};
	
	/*
	*	Check to see if "Dayz Missions" is installed.
	*/
	if(!isNil(MissionGoMinor)) then
	{
		[7,"INFORMATION","ZFM_Common::ZFM_Common_CheckExistingMissionSystems"] call ZFM_Language_Log;
		_doExit = true;
	};
	
	_doExit
};

/*
*	ZFM_CheckExistingAI
* 
*	Check to see if existing AI systems are installed. 
*	As of alpha release, disabled to prevent issues with DZAI/etc.
*/
ZFM_Common_CheckExistingAI = {
	if(format["%1",WAIconfigloaded] != "" || format["%1",SAR_version] != "" || format["%1",DZAI_isActive] != "") then
	{
		[8,"INFORMATION","ZFM_Common::ZFM_Common_CheckExistingAI"] call ZFM_Language_Log;
	};
};

/*
*	ZFM_Common_GetModelName
*
*	Taken from DyZ code. DZE_getModelName. 
*/
ZFM_Common_GetModelName={
    _objInfo = toArray(str(_this));
    _lenInfo = count _objInfo - 1;
    _objName = [];
    _i = 0;
    // determine where the object name starts
    {
            if (58 == _objInfo select _i) exitWith {};
            _i = _i + 1;
    } forEach _objInfo;
    _i = _i + 2; // skip the ": " part
    for "_k" from _i to _lenInfo do {
            _objName = _objName + [_objInfo select _k];
    };
    _objName = toLower(toString(_objName));
    _objName
};

ZFM_Common_ClearTrees ={
	private["_location","_radiusIn","_trees","_objName","_findNearestTree"];
	_location = _this select 0;
	_radiusIn = _this select 1;

	_trees = ["t_picea2s_snow.p3d","b_corylus.p3d","t_quercus3s.p3d","t_larix3s.p3d","t_pyrus2s.p3d","str_briza_kriva.p3d","dd_borovice.p3d","les_singlestrom_b.p3d","les_singlestrom.p3d","smrk_velky.p3d","smrk_siroky.p3d","smrk_maly.p3d","les_buk.p3d","str krovisko vysoke.p3d","str_fikovnik_ker.p3d","str_fikovnik.p3d","str vrba.p3d","hrusen2.p3d","str dub jiny.p3d","str lipa.p3d","str briza.p3d","p_akat02s.p3d","jablon.p3d","p_buk.p3d","str_topol.p3d","str_topol2.p3d","p_osika.p3d","t_picea3f.p3d","t_picea2s.p3d","t_picea1s.p3d","t_fagus2w.p3d","t_fagus2s.p3d","t_fagus2f.p3d","t_betula1f.p3d","t_betula2f.p3d","t_betula2s.p3d","t_betula2w.p3d","t_alnus2s.p3d","t_acer2s.p3d","t_populus3s.p3d","t_quercus2f.p3d","t_sorbus2s.p3d","t_malus1s.p3d","t_salix2s.p3d","t_picea1s_w.p3d","t_picea2s_w.p3d","t_ficusb2s_ep1.p3d","t_populusb2s_ep1.p3d","t_populusf2s_ep1.p3d","t_amygdalusc2s_ep1.p3d","t_pistacial2s_ep1.p3d","t_pinuse2s_ep1.p3d","t_pinuss3s_ep1.p3d","t_prunuss2s_ep1.p3d","t_pinusn2s.p3d","t_pinusn1s.p3d","t_pinuss2f.p3d","t_poplar2f_dead_pmc.p3d","misc_torzotree_pmc.p3d","misc_burnspruce_pmc.p3d","brg_cocunutpalm8.p3d","brg_umbrella_acacia01b.p3d","brg_jungle_tree_canopy_1.p3d","brg_jungle_tree_canopy_2.p3d","brg_cocunutpalm4.p3d","brg_cocunutpalm3.p3d","palm_01.p3d","palm_02.p3d","palm_03.p3d","palm_04.p3d","palm_09.p3d","palm_10.p3d","brg_cocunutpalm2.p3d","brg_jungle_tree_antiaris.p3d","brg_cocunutpalm1.p3d","str habr.p3d","t_carpinus2s.p3d","t_fraxinus2s.p3d","t_fraxinus2w.p3d","t_larix3f.p3d","t_stub_picea.p3d"];

	_findNearestTree = [];

	// Get the nearest trees.
	{
        if("" == typeOf _x) then {
                if (alive _x) then {
                        _objName = _x call ZFM_Common_GetModelName;
                        if (_objName in _trees) then {
                                _x setDamage 1; // DIE, TREE!!
                        };
                };
        };
	} foreach nearestObjects [_location, [], _radiusIn];
};

ZFM_Common_CheckPercentageChanceSuccess ={
	private["_chanceFromOneHundred","_randomChance","_pass"];
	_chanceFromOneHundred = _this select 0;
	_randomChance = round random 100;
	_pass = false;

	if(_chanceFromOneHundred <= _randomChance) then
	{
		_pass = true;
	};

	_pass

};


/*
*	ZFM_Common_Hive_CreateVehicle
*
*	Creates a vehicle and communicates the new vehicle to the hive, to be stored. 
*/
ZFM_Common_Hive_CreateVehicle ={
	private["_vehicleClass","_return","_vehiclePosition","_objectInstance","_objectClass","_return","_query","_uID","_dzPos","_fuel"];

	_vehicleClass = _this select 0;
	_vehiclePosition = _this select 1;

	_return = false;
	_result = false; 

	// Create the Vehicle!
	_objectInstance = createVehicle[_vehicleClass,_vehiclePosition,[],0,"CAN_COLLIDE"];

	// The ARMA location is an array with 3 elements, the DZ is a 2-element array; 0 = direction, 1 = position (3-elem array)
	_dzPos = [(getDir _objectInstance),(getPos _objectInstance)];

	// Get the UID of the object 
	_uID = _dzPos call dayz_objectUID3;

	// Prepares a 308 query for the hive. 
	// If we look at EpochHive - handlers[308] = boost::bind(&HiveExtApp::objectPublish,this,_1);
	// 1 = className, 2= damage, 3= characterID, 4=WorldSpace, 5=inventory, 6=hitPoints, 7= fuel, 8= uniqueID
	_query = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:", dayZ_instance, _vehicleClass, 0, 0, _dzPos, [], [], 1, _uID];

	// Write this to the hive. 
	_query call server_hiveWrite;

	[5,"INFORMATION","ZFM_Common::ZFM_Common_Hive_CreateVehicle [347]",[_query,_objectInstance]] call ZFM_Language_Log;

	// Call this monstrous thing..
	PVDZE_serverObjectMonitor set [count PVDZE_serverObjectMonitor,_objectInstance];


	// Prepare the query again, baby <3
	_query = format["CHILD:388:%1:",_uID];

	// Prepare a 388 query for the hive so we can get the object ID from SQL
	// EpochHive - handlers[388] = boost::bind(&HiveExtApp::objectReturnId,this,_1);
	// 1 = UID
	for [{_x =0},{_x <= ZFM_HIVE_MAX_RETRIES},{_x = _x +1} ] do
	{
		_result = _query call server_hiveReadWrite;

		[5,"INFORMATION","ZFM_Common::ZFM_Common_Hive_CreateVehicle [361]",[_query,_result]] call ZFM_Language_Log;

		if((_result select 0) == "PASS") then
		{
			_objectInstance setVariable["ObjectID",(_result select 1),true];
			_objectInstance setVariable["lastUpdate",time];
			_objectInstance setVariable["CharacterID","0",true];

			[5,"INFORMATION","ZFM_Common::ZFM_Common_Hive_CreateVehicle [369]",[_result]] call ZFM_Language_Log;

			_fuel = 0.1 + (round random .9);
			_objectInstance setFuel _fuel;
			_objectInstance setDamage 0;
			_objectInstance setVelocity[0,0,1];
			_objectInstance call fnc_veh_ResetEH;

			_return = true;

			_x = ZFM_HIVE_MAX_RETRIES; // Hey ho, let's go.
		}
		else
		{
			[5,"INFORMATION","ZFM_Common::ZFM_Common_Hive_CreateVehicle HIVE RETRY",[_result]] call ZFM_Language_Log;
		};
	};

	// Hive read/write completely failed.
	if(_return) then
	{
		[5,"INFORMATION","ZFM_Common::ZFM_Common_Hive_CreateVehicle HIVE CREATE SUCCESS",[_vehicleClass,_result]] call ZFM_Language_Log;
	}
	else
	{
		[5,"INFORMATION","ZFM_Common::ZFM_Common_Hive_CreateVehicle HIVE CREATE FAILURE",[_vehicleClass,_result]] call ZFM_Language_Log;
		deleteVehicle _objectInstance;
	};
};


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