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
