/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 
/*
*	ZFM_IS_INSTALLED
*
*	Used for other projects to see if ZFM is installed. Badge of honour !
*/
ZFM_IS_INSTALLED = true;

/*
*	ZFM_NAME
*	
*	Used for logging. This is displayed as the version
*/
ZFM_NAME = "FairMission System [ZFM]";

/*
*	ZFM_VERSION
*
*	Used for logging. Set manually when releases are made.
*/
ZFM_VERSION = "v0.4.3";

/*
*	ZFM_ERROR_TYPES
*	
*	Used fore logging. Two types of error.
*/
ZFM_ERROR_TYPES =[
	"INFORMATION",
	"ERROR"
];

/*
*	ZFM_DIFFICULTY_TEXT_TYPES
*
*	Defines the difficulties used throughout ZFM for use in call compile format, usually. Oh, call compile format, how I love you so.
*/
ZFM_DIFFICULTY_TEXT_TYPES =[
	"DEADMEAT",
	"EASY",
	"MEDIUM",
	"HARD",
	"WAR_MACHINE"
 ];	

/*
*	ZFM_MISSION_TYPE_INCLUDE_DIR
*
*	Full location of the include directory for missions.
*/
ZFM_MISSION_TYPE_INCLUDE_DIR = "\z\addons\dayz_server\ZFM\Missions\";

/*
*	ZFM_MISSION_TYPE_INCLUDE_FILE
*
*	Filename prefix for mission types.
*/
ZFM_MISSION_TYPE_INCLUDE_NAME = "ZFM_Mission_Type_%1.sqf";


/*
*	ZFM_MISSION_TYPES
*
*	Types of mission that are supported. As of Alpha, only "Crash" is supported. Don't change this.
*	The names in here correspond to filenames.
*/
ZFM_MISSION_TYPES_SUPPORTED =[
	"Crash"
];

/*
*	ZFM_MISSION_TYPES_ENABLED
*
*	The types of mission that are enabled. Again, until after alpha, please don't touch this. 
*/
ZFM_MISSION_TYPES_ENABLED =[
	"Crash"
];

/*
*	ZFM_LANGUAGES_SUPPORTED
*
*	Languages supported by ZFM.
*/
ZFM_LANGUAGES_SUPPORTED =[
	"EN", // English
	"DE", // Deutsch
	"NL"  // Nederlands
];

/*
*	ZFM_DEFAULT_LANGUAGE
*	
*	The default language for ZFM to use.
*/
ZFM_DEFAULT_LANGUAGE = "EN";

/*
*	ZFM_LANGUAGE_INCLUDE_DIR
*
*	The default directory for language includes.
*/
ZFM_LANGUAGE_INCLUDE_DIR = "\z\addons\dayz_server\ZFM\Languages\";

/*
*	ZFM_LANGUAGE_INCLUDE_NAME
*
*	The default name of the file for the language
*/
ZFM_LANGUAGE_INCLUDE_NAME = "ZFM_Language_%1.sqf";

/*
*	ZFM_DAYZ_TYPES_SUPPORTED
*
*	The types of dayz mod supported. Used for weapon loadouts
*/
ZFM_DAYZ_TYPES_SUPPORTED =[
	"Epoch",
	"Overpoch"
];
/*
*	ZFM_DAYZ_TYPE
*
*	The type of dayz that ZFM is running with.
*/
ZFM_DAYZ_TYPE = "Epoch";

/*
*	ZFM_LANGUAGE_INCLUDE_DIR
*
*	The default directory for language includes.
*/
ZFM_DAYZ_TYPE_INCLUDE_DIR = "\z\addons\dayz_server\ZFM\Config\%1\";

/*
*	ZFM_DAYZ_TYPE_INCLUDE_NAME
*
*	The include name for the dayz-specific config. 
*/
ZFM_DAYZ_TYPE_INCLUDE_NAME = "ZFM_DayZ_Config.sqf";
