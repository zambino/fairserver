/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 
 /*
 *	ZFM AI Groups
 *
 *	The AI Groups.. ;-)
 */
ZFM_GROUP_EAST = objNull;
ZFM_GROUP_WEST = objNull;
ZFM_GROUP_CIVILIAN = objNull;
ZFM_GROUP_RESISTANCE = objNull;
 
ZFM_AI_TYPE_SNIPER = "1x101010";
ZFM_AI_TYPE_RIFLEMAN = "1x101011";
ZFM_AI_TYPE_HEAVY = "1x101012";
ZFM_AI_TYPE_COMMANDER = "1x101013";
ZFM_AI_TYPE_MEDIC = "1x101014";
ZFM_AI_TYPE_PILOT = "1x101015";


 //Unit types
  ZFM_AI_TYPES = [
	ZFM_AI_TYPE_SNIPER,
	ZFM_AI_TYPE_RIFLEMAN,
	ZFM_AI_TYPE_HEAVY,
	ZFM_AI_TYPE_COMMANDER
	// Not adding Medic or Pilot yet, for later version
 ];

/*
*	ZFM_UNIT_TYPES_TEXT
*	
*	Used for checking existing unit types in ZFM. As of ZFM Alpha, there are 4 distinct types. 
*/
ZFM_UNIT_TYPES_TEXT =[
	"SNIPER",
	"RIFLEMAN",
	"HEAVY",
	"COMMANDER"
];	
