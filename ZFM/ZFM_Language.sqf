/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

 ZFM_Language_BootStrap ={
	private["_includePath","_includes","_iRow"];

	if(typeName ZFM_LANGUAGES_SUPPORTED== "ARRAY" && typeName ZFM_DEFAULT_LANGUAGE == "STRING") then
	{
		if(count ZFM_LANGUAGES_SUPPORTED >0) then
		{
			if(ZFM_DEFAULT_LANGUAGE in ZFM_LANGUAGES_SUPPORTED) then
			{
				_includePath = ZFM_LANGUAGE_INCLUDE_DIR + format[ZFM_LANGUAGE_INCLUDE_NAME,ZFM_DEFAULT_LANGUAGE];
				["IncludePath is %1","ZFM_Language::ZFM_Language_BootStrap",_includePath] call ZFM_Common_Log;
				call compile preprocessFileLineNumbers _includePath;
			};
		}
		else
		{
			["Fatal error! There isn't any usable language defined! Please replace ZFM_LANGUAGES_SUPPORTED with correct contents.","ZFM_Language::ZFM_Language_BootStrap"] call ZFM_Common_Log;
		};
	}
	else
	{
		["Fatal error! There isn't any usable language defined! Please replace ZFM_LANGUAGES_SUPPORTED with correct contents.","ZFM_Language::ZFM_Language_BootStrap"] call ZFM_Common_Log;
	};

};	