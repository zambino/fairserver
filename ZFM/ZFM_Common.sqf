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
	private["_prefix","_interpText"];

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
			if(typeName (_this select 0) == "STRING" && typeName (_this select 1) == "STRING" && typeName (_this select 2) == "ARRAY") then
			{
				if(count(_this select 2) >0) then
				{
					// Use the array passed to this function and pass it to format along with the inputText param. Assuming the array matches the tokens..
					_interpText = format[(_this select 0),(_this select 2)];

					diag_log(
						format["%1 - %2 - %3 - %4",_prefix,(_this select 1),"INFORMATION",_interpText]
					);
				}
				else
				{
					diag_log(
						format["%1 - %2 - %3 - %4",_prefix,(_this select 1),"INFORMATION",(_this select 0)]
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
					["MissionBootStrap IncludePath is %1","ZFM_Common::ZFM_Common_DoMissionBootStrap",[_includePath]] call ZFM_Common_Log;
					call compile preprocessFileLineNumbers _includePath;
				};
			};
		}
		else
		{
			["Fatal error! No mission types are defined or enabled! Please rectify this by ensuring ZFM_MISSION_TYPES_ENABLED or ZFM_MISSION_TYPES_SUPPORTED has the correct contents","ZFM_Common::ZFM_Common_DoMissionBootStrap"] call ZFM_Common_Log;
		};
	}
	else
	{
		["Fatal error! No mission types are defined or enabled! Please rectify this by ensuring ZFM_MISSION_TYPES_ENABLED or ZFM_MISSION_TYPES_SUPPORTED has the correct contents","ZFM_Common::ZFM_Common_DoMissionBootStrap"] call ZFM_Common_Log;
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
				["DayZBootStrap Include Path is %1","ZFM_Common::ZFM_Common_DoDayZBootStrap",[_includePath]] call ZFM_Common_Log;
				call compile preprocessFileLineNumbers _includePath;
			}
			else
			{
				["Fatal error! No DayZ types are defined or enabled! Please rectify this by ensuring ZFM_DAYZ_TYPES_SUPPORTED is correct.","ZFM_Common::ZFM_Common_DoDayZBootStrap"] call ZFM_Common_Log;
			};
		}
		else
		{
			["Fatal error! No DayZ types are defined or enabled! Please rectify this by ensuring ZFM_DAYZ_TYPES_SUPPORTED is correct.","ZFM_Common::ZFM_Common_DoDayZBootStrap"] call ZFM_Common_Log;
		};
	}
	else
	{
		["Fatal error! No DayZ types are defined or enabled! Please rectify this by ensuring ZFM_DAYZ_TYPES_SUPPORTED is correct.","ZFM_Common::ZFM_Common_DoDayZBootStrap"] call ZFM_Common_Log;
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
ZFM_CheckExistingMissionSystems = {
	
	_doExit = false;
	_outputMessage = ZFM_Name + ZFM_version;
	
	/*
	*	Check for DZMS or EMS (Still curious why they couldn't use their own constants, the EMS guys. Oh well!)
	*/
	if(!isNil(DZMSInstalled)) then
	{
		diag_log(_outputMessage + "CheckExistingMissionSystems - DZMS or EMS is currently installed. This will interfere with ZFM, and needs to be disabled before ZFM can run. Exiting.");
		_doExit = true;
	};
	
	/*
	*	Check to see if "Dayz Missions" is installed.
	*/
	if(!isNil(MissionGoMinor)) then
	{
		diag_log(_outputMessage + "CheckExistingMissionSystems - DayZ Missions is currently installed. This will interfere with ZFM, and needs to be disabled before ZFM can run. Exiting.");
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
ZFM_CheckExistingAI = {
    private["_doExit","_outputMessage"];
    
    
	_doExit = false;
	_outputMessage = ZFM_Name + ZFM_Version;
	
	/*
	* 	 Check For WickedAI.
	*/
	if(typeName WAIconfigloaded == "BOOLEAN") then
	{
		diag_log(_outputMessage + "CheckExistingAI - WickedAI discovered. This will interfere with ZFM, and must be disabled before ZFM can run. Exiting.");
		_doExit = true;
	};
	
	/*
	*	Check for SARGE AI
	*/
	if(!isNil(SAR_version)) then
	{
		diag_log(_outputMessage + "CheckExistingAI - SARGE AI discovered. This will interfere with ZFM, and must be disabled before ZFM can run. Exiting.");
		_doExit = true;
	};
	
	/*
	*	Check for DZ AI
	*/
	if(typeName DZAI_isActive == "BOOLEAN") then
	{
		diag_log(_outputMessage + "CheckExistingAI - DZ AI discovered. This will interfere with ZFM, and must be disabled before ZFM can run. Exiting.");
		_doExit = true;	
	};

	_doExit
};
