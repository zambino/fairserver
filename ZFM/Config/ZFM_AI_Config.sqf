/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 
  ZFS_Skills_AI_DEADMEAT = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",0.1],
    ["aimingShake",1],
    ["aimingSpeed",0.1],
    ["endurance",0.1],
    ["spotDistance",0.1],
    ["spotTime",0.1],
    ["courage",0.1],
    ["reloadSpeed",0.1],
    ["commanding",0.1],
    ["general",0.1]
 ];
 
 ZFS_Skills_AI_EASY = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",0.25],
    ["aimingShake",0.8],
    ["aimingSpeed",0.25],
    ["endurance",0.25],
    ["spotDistance",0.25],
    ["spotTime",0.25],
    ["courage",0.25],
    ["reloadSpeed",0.25],
    ["commanding",0.25],
    ["general",0.25]
 ];
 
 ZFS_Skills_AI_MEDIUM = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",0.65],
    ["aimingShake",0.3],
    ["aimingSpeed",0.65],
    ["endurance",0.65],
    ["spotDistance",0.65],
    ["spotTime",0.65],
    ["courage",0.65],
    ["reloadSpeed",0.65],
    ["commanding",0.65],
    ["general",0.65]
 ];
 
 ZFS_Skills_AI_HARD = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",0.85],
    ["aimingShake",0.2],
    ["aimingSpeed",0.85],
    ["endurance",0.85],
    ["spotDistance",0.85],
    ["spotTime",0.85],
    ["courage",0.85],
    ["reloadSpeed",0.85],
    ["commanding",0.85],
    ["general",0.85]
 ];
 
 ZFS_Skills_AI_WAR_MACHINE = [
	// ARMA Skill type, Max Skill Value
    ["aimingAccuracy",1],
    ["aimingShake",0.1],
    ["aimingSpeed",1],
    ["endurance",1],
    ["spotDistance",1],
    ["spotTime",1],
    ["courage",1],
    ["reloadSpeed",1],
    ["commanding",1],
    ["general",1]
 ];
 
	/*
		UNIT EQUIP ARRAYS
		
		These are used to determine what equipment units of various difficulties get.
		Most of this data is the same but is left this way so people can change this for their server.
		
		The array MUST be in this form: 
		
		[
			"SKIN_NAME",  // STRING only
			["Weapon1","Weapon2"], //[] ARRAY only
			1, // NUMERICAL only
			["BackPack1","BackPack2"] // ARRAY only, must be backpacks
			["Item1","Item2"] // ARRAY only, MUST be magazines. 
		]
	*/
  ZFS_Equipment_Sniper_EASY = [
	"Bandit1_DZ", 												// Skin (STRING)
	["M21","SVD_CAMO"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
 ];
 ZFS_Equipment_Sniper_MEDIUM = [
	"Soldier_Sniper_PMC_DZ", 														// Skin
	["SVD_CAMO","DMR_DZ","m107","SVD_des_EP1"],										// Snipers from FixedLoot. (Random pick)
	3,																				// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],				// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]	
 ];
 
 ZFS_Equipment_Sniper_HARD = [
	"GUE_Soldier_Sniper_DZ", 											// Skin
	["SCAR_H_LNG_Sniper_SD","SVD_CAMO","DMR_DZ"],						// Snipers from FixedLoot. (Random pick)
	5,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];

 ZFS_Equipment_Sniper_WAR_MACHINE = [
	"GUE_Soldier_Sniper_DZ",
	["KSVK_DZE","DMR_DZ","m107"],				// Will always have an awesome sniper rifle..
	5,
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];
 
   ZFS_Equipment_Rifleman_EASY = [
	"Bandit1_DZ", 												// Skin
	["M21","SVD_CAMO"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
 ];
 ZFS_Equipment_Rifleman_MEDIUM = [
	"GUE_Soldier_MG_DZ", 														// Skin
	["SVD_CAMO","DMR_DZ","m107","SVD_des_EP1"],										// Snipers from FixedLoot. (Random pick)
	3,																				// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],				// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]	
 ];
 
 ZFS_Equipment_Rifleman_HARD = [
	"GUE_Soldier_Crew_DZ", 											// Skin
	["SCAR_H_LNG_Sniper_SD","SVD_CAMO","DMR_DZ"],						// Snipers from FixedLoot. (Random pick)
	5,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];

 ZFS_Equipment_Rifleman_WAR_MACHINE = [
	"Ins_Soldier_GL_DZ",
	["KSVK_DZE","DMR_DZ","m107"],				// Will always have an awesome sniper rifle..
	5,
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
 ];
 
 
 