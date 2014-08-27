/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

ZFM_Language_DoBootStrap ={
	private["_includePath","_includes","_iRow"];

	if(typeName ZFM_LANGUAGES_SUPPORTED== "ARRAY" && typeName ZFM_DEFAULT_LANGUAGE == "STRING") then
	{
		if(count ZFM_LANGUAGES_SUPPORTED >0) then
		{
			if(ZFM_DEFAULT_LANGUAGE in ZFM_LANGUAGES_SUPPORTED) then
			{
				_includePath = ZFM_LANGUAGE_INCLUDE_DIR + format[ZFM_LANGUAGE_INCLUDE_NAME,ZFM_DEFAULT_LANGUAGE];
				["IncludePath is %1","ZFM_Language::ZFM_Language_BootStrap","INFORMATION",[_includePath]] call ZFM_Common_Log;
				call compile preprocessFileLineNumbers _includePath;
			};
		}
		else
		{
			// Must be hardcoded. Can't use functions not bootstrapped. Everything else is available in your language!
			["Fatal error! There isn't any usable language defined! Please replace ZFM_LANGUAGES_SUPPORTED with correct contents.","ZFM_Language::ZFM_Language_BootStrap"] call ZFM_Common_Log;
		};
	}
	else
	{
		["Fatal error! There isn't any usable language defined! Please replace ZFM_LANGUAGES_SUPPORTED with correct contents.","ZFM_Language::ZFM_Language_BootStrap"] call ZFM_Common_Log;
	};
};	

ZFM_Language_Get_String ={
	private["_type"];
	_type = _this select 0;
	_retVal = "RARR";

	switch((_this select 0)) do
	{
		case "INFORMATION": {
			if(typeName ZFM_INFORMATION_STRINGS == "ARRAY") then
			{
				if((count ZFM_INFORMATION_STRINGS) >0) then
				{
					_retVal = ZFM_INFORMATION_STRINGS select (_this select 1);
					_retVal
				};
			};
		};
		case "ERROR" :{
			if(typeName ZFM_ERROR_STRINGS == "ARRAY") then
			{
				if((count ZFM_ERROR_STRINGS) >0) then
				{
					_retVal = ZFM_ERROR_STRINGS select (_this select 1);
					_retVal
				};
			};
		};
	};
};

ZFM_Language_Log ={
	private["_langString"];

	switch(count _this) do
	{
		// Just the text, assume information
		case 1: {
			if(typeName (_this select 0) == "SCALAR") then
			{
				_langString = ["INFORMATION",(_this select 0)] call  ZFM_Language_Get_String;
				[_langString] call ZFM_Common_Log;
			};
		};

		case 2: {
			if(typeName (_this select 0) == "SCALAR" && typeName (_this select 1) == "STRING") then
			{
				_langString = [(_this select 1),(_this select 0)] call  ZFM_Language_Get_String;
				[_langString,(_this select 1)] call ZFM_Common_Log;
			};
		};

		case 3:{
			if(typeName (_this select 0) == "SCALAR" && typeName (_this select 1) == "STRING" && typeName (_this select 2) =="STRING") then
			{
				_langString = [(_this select 1),(_this select 0)] call  ZFM_Language_Get_String;
				[_langString,(_this select 1),(_this select 2)] call ZFM_Common_Log;
			};
		};
		case 4:{
			if(typeName (_this select 0) == "SCALAR" && typeName (_this select 1) == "STRING" && typeName (_this select 2) =="STRING" && typeName(_this select 3) == "ARRAY") then
			{
				_langString = [(_this select 1),(_this select 0)] call  ZFM_Language_Get_String;
				[_langString,(_this select 1),(_this select 2),(_this select 3)] call ZFM_Common_Log;
			};
		};
	};
};
