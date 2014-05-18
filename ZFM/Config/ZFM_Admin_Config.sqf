/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

 
/*
*	ZFM_Admin_UIDs
*	
*	Add the UID of the client that you want to be an Administrator, and permissions they will have.
*	If you're building complex permissions, then you need to comma-separate them. 
*
*	Format: [ID,[PermissionsArray]]
*	i.e. ["123456789",[ZFM_Admin_Permissions_Spawn_Weapons_Snipers,..,..]]
*/
ZFM_Admin_UIDs =[
	["239539334",[ZFM_Admin_All_Permissions]]
];

ZFM_Cached_No_Online_Players = 0;

/*
* 	Permissions
*
*	These are specific permissions that are granted to a person.
*/
ZFM_Admin_Permissions_Spawn_Weapons_Pistols = "3x101011";
ZFM_Admin_Permissions_Spawn_Weapons_Rifles = "3x101012";
ZFM_Admin_Permissions_Spawn_Weapons_Shotguns = "3x101013";
ZFM_Admin_Permissions_Spawn_Weapons_Snipers = "3x101014";
ZFM_Admin_Permissions_Spawn_Weapons_Explosives = "3x101015";
ZFM_Admin_Permissions_Spawn_Backpacks = "3x101016";
ZFM_Admin_Permissions_Spawn_Food = "3x101017";
ZFM_Admin_Permissions_Spawn_Drinks = "3x101018";
ZFM_Admin_Permissions_Spawn_MedicalSupplies = "3x101019";
ZFM_Admin_Permissions_Spawn_Clothing = "3x101020";
ZFM_Admin_Permissions_Spawn_Tools = "3x101021";
ZFM_Admin_Permissions_Spawn_Building_Supplies = "3x101022";
ZFM_Admin_Permissions_Spawn_Vehicle_Parts = "3x101023";
ZFM_Admin_Permissions_Actions_Heal = "3x101024";
ZFM_Admin_Permissions_Actions_Repair = "3x101025";
ZFM_Admin_Permissions_Actions_Blood = "3x101026";
ZFM_Admin_Permissions_Actions_Teleport = "3x101027";


// Supplies all permissions by default. This was added so if new permissions come about, it's easy to just add to this.
ZFM_Admin_All_Permissions = [
	ZFM_Admin_Permissions_Weapons_Pistols,
	ZFM_Admin_Permissions_Weapons_Rifles,
	ZFM_Admin_Permissions_Weapons_Shotguns,
	ZFM_Admin_Permissions_Weapons_Snipers,
	ZFM_Admin_Permissions_Weapons_Explosives,
	ZFM_Admin_Permissions_Backpacks,
	ZFM_Admin_Permissions_Food,
	ZFM_Admin_Permissions_Drinks,
	ZFM_Admin_Permissions_MedicalSupplies,
	ZFM_Admin_Permissions_Clothing,
	ZFM_Admin_Permissions_Tools,
	ZFM_Admin_Permissions_Building_Supplies,
	ZFM_Admin_Permissions_Vehicle_Parts,
	ZFM_Admin_Permissions_Actions_Heal,
	ZFM_Admin_Permissions_Actions_Repair,
	ZFM_Admin_Permissions_Actions_Blood,
	ZFM_Admin_Permissions_Actions_Teleport 
];


