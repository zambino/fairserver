/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 
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
