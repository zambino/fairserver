/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 
 ZFM_MINIMUM_AI_PER_MISSION = 8;
 ZFM_MINIMUM_LOOT_CONTAINERS_PER_MISSION = 2;
 ZFM_MAXIMUM_MISSIONS = 3;
 ZFM_MAXIMUM_CRASH_MISSIONS = 3;
 
 ZFM_HUMANITY_FOR_BANDIT_KILLS = true;
 ZFM_HUMANITY_AMOUNT_FIXED = true;
 ZFM_HUMANITY_AMOUNT_PER_BANDIT = 20;
   
ZFM_CrashVehicles_Planes =[
	"AV8B","AV8B2","C130J","C130J_US_EP1","F35B","MQ9PredatorB_US_EP1","MV22",
	"Su25_CDF","Su25_TK_EP1","Su34"
];
ZFM_CrashVehicles_Helicopters =[
	"AH1Z","MH60S","Mi17_Civilian","Mi17_TK_EP1","Mi17_medevac_Ins","Mi17_medevac_CDF","Mi17_medevac_RU",
	"Mi17_Ins","Mi17_CDF","Mi17_rockets_RU","Mi17_Civilian","Mi17_UN_CDF_EP1","Mi171Sh_rockets_CZ_EP1",
	"Mi17_TK_EP1","Mi24_V","Mi24_P","Mi24_D","Mi24_D_TK_EP1","Ka52","Ka52Black","UH1Y"
];
 
//All crash vehicles
ZFM_CrashVehicles = ZFM_CrashVehicles_Planes + ZFM_CrashVehicles_Helicopters;
 
ZFM_MISSIONS_START_MISSIONS_WHILE_SERVER_EMPTY = false;
ZFM_MISSIONS_MAXIMUM_CONCURRENT_MISSIONS = 3;
ZFM_MISSIONS_MAXIMUM_CONCURRENT_MISSIONS_CRASH = 3;
ZFM_MISSIONS_DEFAULT_MISSION_START_TYPE = ZFM_MISSION_START_TYPE_TIMED_RANDOM;
ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MIN = 15; // Minutes
ZFM_MISSIONS_MINIMUM_TIME_BETWEEN_MISSIONS_MAX = 45; // Minutes (Means randomly, missions will fire between 15 and 45 minutes)

ZFM_MISSION_TYPES =[
	ZFM_MISSION_TYPE_CRASH
 ];