/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */


ZFM_LOOT_CONTENT_TYPES =[
	ZFM_LOOT_CONTENT_TYPE_SNIPERS,
	ZFM_LOOT_CONTENT_TYPE_MACHINEGUNS,
	ZFM_LOOT_CONTENT_TYPE_RIFLES,
	ZFM_LOOT_CONTENT_TYPE_PISTOLS,
	ZFM_LOOT_CONTENT_TYPE_TOOLS,
	ZFM_LOOT_CONTENT_TYPE_BUILDINGSUPPLIES ,
	ZFM_LOOT_CONTENT_TYPE_BACKPACKS,
	ZFM_LOOT_CONTENT_TYPE_MEDICAL
 ];
 
ZFM_LOOT_SNIPERS_DEADMEAT = [
	"SVD_CAMO",
	"SVD_des_EP1",
	"M24"
];
ZFM_LOOT_SNIPERS_EASY = [
	"SVD_CAMO",
	"SVD_des_EP1",
	"M24"
];
ZFM_LOOT_SNIPERS_MEDIUM = [
	"SVD_CAMO",
	"SVD_des_EP1",
	"M24"
];
ZFM_LOOT_SNIPERS_HARD = [
	"A550",
	"SCAR_H_LNG_Sniper_SD",
	"SVD_CAMO",
	"SVD_des_EP1",
	"M24"
];
ZFM_LOOT_SNIPERS_WAR_MACHINE = [
	"KSVK_DZE",
	"A550",
	"DMR_DZ",
	"SCAR_H_LNG_Sniper_SD",
	"SVD_CAMO",
	"SVD_des_EP1",
	"M24"
];
ZFM_LOOT_MACHINEGUNS_DEADMEAT = [
	"M240_DZ",
	"M249_DZ"
];
ZFM_LOOT_MACHINEGUNS_EASY = [
	"M240_DZ",
	"M249_DZ"
];
ZFM_LOOT_MACHINEGUNS_MEDIUM = [
	"M240_DZ",
	"M249_DZ",
	"M636_camo"
];
ZFM_LOOT_MACHINEGUNS_HARD = [
	"M240_DZ",
	"M249_DZ",
	"M636_camo",
	"Mk_48_DZ"
];
ZFM_LOOT_MACHINEGUNS_WAR_MACHINE = [
	"M240_DZ",
	"M249_DZ",
	"M636_camo",
	"Mk_48_DZ",
	"PK"
];

ZFM_LOOT_RIFLES_DEADMEAT = [
	"AK_47_M",
	"AK_74",
	"AKS_74_kobra",
	"AKS_74_U",
	"FN_FAL_ANPVS4",
	"FN_FAL",
	"G36A_camo",
	"M1014",
	"Sa58V_CCO_EP1",
	"Sa58V_EP1",
	"Sa58V_RCO_EP1"
];
ZFM_LOOT_RIFLES_EASY = [
	"AK_47_M",
	"AK_74",
	"AKS_74_kobra",
	"AKS_74_U",
	"Remington870_lamp",
	"Sa58P_EP1",
	"Sa58V_CCO_EP1",
	"Sa58V_EP1",
	"Sa58V_RCO_EP1"
];
ZFM_LOOT_RIFLES_MEDIUM = [
	"AK_47_M",
	"AK_74",
	"AKS_74_kobra",
	"AKS_74_U",
	"FN_FAL_ANPVS4",
	"FN_FAL",
	"G36A_camo",
	"M1014",
	"M16A2",
	"M4A1_Aim",
	"M4A1_HWS_GL_camo",
	"M4A1",
	"M4A3_CCO_EP1",
	"Remington870_lamp",
	"Sa58P_EP1",
	"Sa58V_CCO_EP1",
	"Sa58V_EP1",
	"Sa58V_RCO_EP1"
];
ZFM_LOOT_RIFLES_HARD = [
	"AK_47_M",
	"AK_74",
	"AKS_74_kobra",
	"AKS_74_U",
	"BAF_L85A2_RIS_Holo",
	"bizon_silenced",
	"FN_FAL_ANPVS4",
	"FN_FAL",
	"G36A_camo",
	"G36C_camo",
	"G36C",
	"G36K_camo",
	"M1014",
	"M16A2",
	"M16A2GL",
	"M4A1_AIM_SD_camo",
	"M4A1_Aim",
	"M4A1_HWS_GL_camo",
	"M4A1",
	"M4A3_CCO_EP1",
	"Remington870_lamp",
	"Sa58P_EP1",
	"Sa58V_CCO_EP1",
	"Sa58V_EP1",
	"Sa58V_RCO_EP1"
];
ZFM_LOOT_RIFLES_WAR_MACHINE = [
	"RPK_74",
	"AK_47_M",
	"AK_74",
	"AKS_74_kobra",
	"AKS_74_U",
	"BAF_L85A2_RIS_Holo",
	"bizon_silenced",
	"FN_FAL_ANPVS4",
	"FN_FAL",
	"G36A_camo",
	"G36C_camo",
	"G36C",
	"G36K_camo",
	"M1014",
	"M16A2",
	"M16A2GL",
	"M4A1_AIM_SD_camo",
	"M4A1_Aim",
	"M4A1_HWS_GL_camo",
	"M4A1",
	"M4A3_CCO_EP1",
	"Remington870_lamp",
	"Sa58P_EP1",
	"Sa58V_CCO_EP1",
	"Sa58V_EP1",
	"Sa58V_RCO_EP1"
];

ZFM_LOOT_PISTOLS_DEADMEAT = [
	"glock17_EP1",
	"M9",
	"M9SD"
];
ZFM_LOOT_PISTOLS_EASY = [
	"glock17_EP1",
	"M9",
	"M9SD"
];
ZFM_LOOT_PISTOLS_MEDIUM = [
	"glock17_EP1",
	"M9",
	"M9SD"
];
ZFM_LOOT_PISTOLS_HARD = [
	"Makarov",
	"MakarovSD",
	"glock17_EP1",
	"M9",
	"M9SD"
];
ZFM_LOOT_PISTOLS_WAR_MACHINE = [
	"Colt1911",
	"revolver_EP1",
	"UZI_EP1",
	"Makarov",
	"MakarovSD",
	"glock17_EP1",
	"M9",
	"M9SD"
];

ZFM_LOOT_TOOLS_DEADMEAT = [
"ItemToolBox",
"ItemKeyKit",
"ItemCompass",
"ItemEtool",
"ItemFishingPole",
"ItemMap",
"ItemShovel",
"ItemSledge",
"ItemKnife",
"ItemHatchet_DZE",
"ItemMatchBox_DZE",
"ItemSledge"
];
ZFM_LOOT_TOOLS_EASY = [
"ItemToolBox",
"ItemKeyKit",
"ItemCompass",
"ItemEtool",
"ItemFishingPole",
"ItemMap",
"ItemShovel",
"ItemSledge",
"ItemKnife",
"ItemHatchet_DZE",
"ItemMatchBox_DZE",
"ItemSledge"
];
ZFM_LOOT_TOOLS_MEDIUM = [
"ItemToolBox",
"ItemKeyKit",
"ItemCompass",
"ItemEtool",
"ItemFishingPole",
"ItemMap",
"ItemShovel",
"ItemSledge",
"ItemKnife",
"ItemHatchet_DZE",
"ItemMatchBox_DZE",
"ItemSledge"
];
ZFM_LOOT_TOOLS_HARD = [
"ItemToolBox",
"ItemKeyKit",
"ItemCompass",
"ItemEtool",
"ItemFishingPole",
"ItemMap",
"ItemShovel",
"ItemSledge",
"ItemKnife",
"ItemHatchet_DZE",
"ItemMatchBox_DZE",
"ItemSledge"
];
ZFM_LOOT_TOOLS_WAR_MACHINE = [
"ItemToolBox",
"ItemKeyKit",
"ItemCompass",
"ItemEtool",
"ItemFishingPole",
"ItemMap",
"ItemShovel",
"ItemSledge",
"ItemKnife",
"ItemHatchet_DZE",
"ItemMatchBox_DZE",
"ItemSledge"
];

ZFM_LOOT_BUILDINGSUPPLIES_DEADMEAT = [
	"CinderBlocks",
	"MortarBucket",
	"ItemTankTrap",
	"ItemPole",
	"PartGeneric",
	"PartPlywoodPack",
	"PartPlankPack",
	"ItemTentOld",
	"ItemTentDomed",
	"ItemTentDomed2",
	"ItemSandbag",
	"ItemWire",
	"workbench_kit",
	"ItemGenerator"
];
ZFM_LOOT_BUILDINGSUPPLIES_EASY = [
	"CinderBlocks",
	"MortarBucket",
	"ItemTankTrap",
	"ItemPole",
	"PartGeneric",
	"PartPlywoodPack",
	"PartPlankPack",
	"ItemTentOld",
	"ItemTentDomed",
	"ItemTentDomed2",
	"ItemSandbag",
	"ItemWire",
	"workbench_kit",
	"ItemGenerator"
];
ZFM_LOOT_BUILDINGSUPPLIES_MEDIUM = [
	"CinderBlocks",
	"MortarBucket",
	"ItemTankTrap",
	"ItemPole",
	"PartGeneric",
	"PartPlywoodPack",
	"PartPlankPack",
	"ItemTentOld",
	"ItemTentDomed",
	"ItemTentDomed2",
	"ItemSandbag",
	"ItemWire",
	"workbench_kit",
	"ItemGenerator"
];
ZFM_LOOT_BUILDINGSUPPLIES_HARD = [
	"CinderWallHalf_DZ",
	"CinderWall_DZ",
	"ItemWoodWallGarageDoorLocked",
	"ItemWoodFloorHalf",
	"ItemWoodWallDoorLg",
	"ItemWoodWallWithDoorLg",
	"ItemWoodWallWithDoorLgLocked",
	"ItemWoodWallLg"
];
ZFM_LOOT_BUILDINGSUPPLIES_WAR_MACHINE = [
	"ItemWoodWallGarageDoor",
	"ItemWoodWallGarageDoorLocked",
	"ItemWoodFloorHalf",
	"ItemWoodWallDoorLg",
	"ItemWoodWallWithDoorLg",
	"ItemWoodWallWithDoorLgLocked",
	"ItemWoodWallLg",
	"ItemWoodWallDoorLg",
	"ItemWoodWallWindowLg",
	"ItemWoodFloorQuarter",
	"ItemWoodWallDoor",
	"ItemWoodWallWithDoorLocked",
	"ItemWoodWall",
	"ItemWoodWallDoor",
	"ItemWoodWallWithDoor",
	"ItemWoodWallWindow",
	"ItemWoodWallThird",
	"ItemWoodLadder",
	"ItemWoodFloor",
	"ItemWoodStairs",
	"ItemWoodStairsSupport",
	"CinderWallHalf_DZ",
	"CinderWall_DZ",
	"CinderWallDoorway_DZ",
	"cinder_door_kit",
	"metal_floor_kit"
];

ZFM_LOOT_MEDICAL_DEADMEAT = [
	"ItemAntibiotic",
	"ItemBandage",
	"ItemBloodbag",
	"ItemEpinephrine",
	"ItemMorphine",
	"ItemPainkiller"
];
ZFM_LOOT_MEDICAL_EASY = [
	"ItemAntibiotic",
	"ItemBandage",
	"ItemBloodbag",
	"ItemEpinephrine",
	"ItemMorphine",
	"ItemPainkiller"
];
ZFM_LOOT_MEDICAL_MEDIUM = [
	"ItemAntibiotic",
	"ItemBandage",
	"ItemBloodbag",
	"ItemEpinephrine",
	"ItemMorphine",
	"ItemPainkiller"
];
ZFM_LOOT_MEDICAL_HARD = [
	"ItemAntibiotic",
	"ItemBandage",
	"ItemBloodbag",
	"ItemEpinephrine",
	"ItemMorphine",
	"ItemPainkiller"
];
ZFM_LOOT_MEDICAL_WAR_MACHINE = [
	"ItemAntibiotic",
	"ItemBandage",
	"ItemBloodbag",
	"ItemEpinephrine",
	"ItemMorphine",
	"ItemPainkiller"
];

// Failover arrays -- used to grab loot from if the minimum amount isn't reached.
ZFM_ALL_LOOT_DEADMEAT = ZFM_LOOT_SNIPERS_DEADMEAT + ZFM_LOOT_MACHINEGUNS_DEADMEAT + ZFM_LOOT_RIFLES_DEADMEAT + ZFM_LOOT_PISTOLS_DEADMEAT + ZFM_LOOT_TOOLS_DEADMEAT + ZFM_LOOT_MEDICAL_DEADMEAT + ZFM_LOOT_BUILDINGSUPPLIES_DEADMEAT;
ZFM_ALL_LOOT_EASY = ZFM_LOOT_SNIPERS_EASY + ZFM_LOOT_MACHINEGUNS_EASY + ZFM_LOOT_RIFLES_EASY + ZFM_LOOT_PISTOLS_EASY + ZFM_LOOT_TOOLS_EASY + ZFM_LOOT_MEDICAL_EASY + ZFM_LOOT_BUILDINGSUPPLIES_EASY;
ZFM_ALL_LOOT_MEDIUM = ZFM_LOOT_SNIPERS_MEDIUM + ZFM_LOOT_MACHINEGUNS_MEDIUM + ZFM_LOOT_RIFLES_MEDIUM + ZFM_LOOT_PISTOLS_MEDIUM + ZFM_LOOT_TOOLS_MEDIUM + ZFM_LOOT_MEDICAL_MEDIUM + ZFM_LOOT_BUILDINGSUPPLIES_MEDIUM;
ZFM_ALL_LOOT_HARD = ZFM_LOOT_SNIPERS_HARD + ZFM_LOOT_MACHINEGUNS_HARD + ZFM_LOOT_RIFLES_HARD + ZFM_LOOT_PISTOLS_HARD + ZFM_LOOT_TOOLS_HARD + ZFM_LOOT_MEDICAL_HARD + ZFM_LOOT_BUILDINGSUPPLIES_HARD;
ZFM_ALL_LOOT_WAR_MACHINE = ZFM_LOOT_SNIPERS_WAR_MACHINE + ZFM_LOOT_MACHINEGUNS_WAR_MACHINE + ZFM_LOOT_RIFLES_WAR_MACHINE + ZFM_LOOT_PISTOLS_WAR_MACHINE + ZFM_LOOT_TOOLS_WAR_MACHINE + ZFM_LOOT_MEDICAL_WAR_MACHINE + ZFM_LOOT_BUILDINGSUPPLIES_WAR_MACHINE;



/*
*	ZFM UNIT ARRAYS
*
*	To change equipment, just add weapons into the 2nd element of the array for the unit. The layout is as follows:
*
*	UNIT_TYPE =[
*		Name of skin 							(String)
*		Weapons the unit can equip 				(Array of ClassNames from CfgWeapons)
*		Number of magazines 					(Number/Scalar)
*		Backpacks the unit can equip 			(Array of ClassNames from CfgVehicles)
		Additional items the unit carries 		(Array if ClassNames from CfgMagazines)
*	]
*/
ZFM_UNIT_EQUIPMENT_SNIPER_DEADMEAT =[
	"Bandit1_DZ", 												// Skin (STRING)
	["SVD_CAMO"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
];
ZFM_UNIT_EQUIPMENT_SNIPER_EASY =[
	"Bandit1_DZ", 												// Skin (STRING)
	["SVD_CAMO"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
];
ZFM_UNIT_EQUIPMENT_SNIPER_MEDIUM =[
	"Soldier_Sniper_PMC_DZ", 														// Skin
	["SVD_CAMO","DMR_DZ","m107","SVD_des_EP1"],										// Snipers from FixedLoot. (Random pick)
	3,																				// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],				// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]	
];
ZFM_UNIT_EQUIPMENT_SNIPER_HARD =[
	"GUE_Soldier_Sniper_DZ", 											// Skin
	["SCAR_H_LNG_Sniper_SD","SVD_CAMO","DMR_DZ"],						// Snipers from FixedLoot. (Random pick)
	5,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];
ZFM_UNIT_EQUIPMENT_SNIPER_WAR_MACHINE =[
	"GUE_Soldier_Sniper_DZ",
	["KSVK_DZE","DMR_DZ","m107"],				// Will always have an awesome sniper rifle..
	5,
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];
ZFM_UNIT_EQUIPMENT_RIFLEMAN_DEADMEAT =[
	"Bandit1_DZ", 												// Skin
	["AK_47_M","AK_74","AKS_74_kobra","AKS_74_U","G36C","G36K_camo","M4A1","M249_DZ"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
];
ZFM_UNIT_EQUIPMENT_RIFLEMAN_EASY =[
	"Bandit1_DZ", 												// Skin
	["AK_47_M","AK_74","AKS_74_kobra","AKS_74_U","G36C","G36K_camo","M4A1","M249_DZ"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
];
ZFM_UNIT_EQUIPMENT_RIFLEMAN_MEDIUM =[
	"GUE_Soldier_MG_DZ", 														// Skin
	["AK_47_M","AK_74","AKS_74_kobra","AKS_74_U","G36C","G36K_camo","M4A1","M249_DZ","G36A_camo","G36C_camo","M240_DZ"],										// Snipers from FixedLoot. (Random pick)
	3,																				// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],				// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]	
];
ZFM_UNIT_EQUIPMENT_RIFLEMAN_HARD =[
	"GUE_Soldier_Crew_DZ", 											// Skin
	["AK_47_M","AK_74","AKS_74_kobra","AKS_74_U","G36C","G36K_camo","M4A1","M249_DZ","G36A_camo","G36C_camo","M240_DZ","MG36_camo"],						// Snipers from FixedLoot. (Random pick)
	5,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];
ZFM_UNIT_EQUIPMENT_RIFLEMAN_WAR_MACHINE =[
	"Ins_Soldier_GL_DZ",
	["FN_FAL","FN_FAL_ANPVS4","G36A_camo","G36C_camo","M240_DZ","MG36_camo","PK"],				// Will always have an awesome sniper rifle..
	5,
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];

ZFM_UNIT_EQUIPMENT_COMMANDER_DEADMEAT =[
	"GUE_Commander_DZ",
	["FN_FAL","FN_FAL_ANPVS4","SCAR_H_LNG_Sniper_SD","PK"],				// Will always have an awesome sniper rifle..
	8,
	["DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];
ZFM_UNIT_EQUIPMENT_COMMANDER_EASY =[
	"GUE_Commander_DZ",
	["FN_FAL","FN_FAL_ANPVS4","SCAR_H_LNG_Sniper_SD","PK"],				// Will always have an awesome sniper rifle..
	8,
	["DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];
ZFM_UNIT_EQUIPMENT_COMMANDER_MEDIUM =[
	"GUE_Commander_DZ",
	["FN_FAL","FN_FAL_ANPVS4","SCAR_H_LNG_Sniper_SD","PK"],				// Will always have an awesome sniper rifle..
	8,
	["DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];
ZFM_UNIT_EQUIPMENT_COMMANDER_HARD =[
	"GUE_Commander_DZ",
	["FN_FAL","FN_FAL_ANPVS4","SCAR_H_LNG_Sniper_SD","PK"],				// Will always have an awesome sniper rifle..
	8,
	["DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];
ZFM_UNIT_EQUIPMENT_COMMANDER_WAR_MACHINE =[
	"GUE_Commander_DZ",
	["FN_FAL","FN_FAL_ANPVS4","SCAR_H_LNG_Sniper_SD","PK"],				// Will always have an awesome sniper rifle..
	8,
	["DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];

ZFM_UNIT_EQUIPMENT_HEAVY_DEADMEAT =[
	"Bandit1_DZ", 												// Skin
	["M249_DZ"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
];

ZFM_UNIT_EQUIPMENT_HEAVY_EASY =[
	"Bandit1_DZ", 												// Skin
	["M249_DZ"],														// Snipers from FixedLoot. (Random pick)
	2,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"] // Any medical supplies they should require.
];

ZFM_UNIT_EQUIPMENT_HEAVY_MEDIUM =[
	"Bandit2_DZ", 														// Skin
	["Mk_48_DZ","M249_DZ"],										// Snipers from FixedLoot. (Random pick)
	3,																				// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU"],				// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]	
];
ZFM_UNIT_EQUIPMENT_HEAVY_HARD =[
	"GUE_Soldier_CO_DZ", 											// Skin
	["MG36_camo","M249_DZ","M240_DZ"],						// Snipers from FixedLoot. (Random pick)
	5,																	// Boundary for the maximum number of magazines
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],		// Backpacks from FixedLoot (Random pick)
	["ItemBandage","ItemBandage", "ItemPainkiller","ItemKnife","ItemFlashlight"]
];
ZFM_UNIT_EQUIPMENT_HEAVY_WAR_MACHINE =[
	"GUE_Soldier_CO_DZ",
	["PK"],				// Will always have an awesome rifle..
	5,
	["DZ_ALICE_Pack_EP1","DZ_TK_Assault_Pack_EP1","DZ_British_ACU","DZ_LargeGunBag_EP1"],				// Doesn't really matter.
	["ItemBandage","ItemBandage","ItemPainkiller","ItemKnife","ItemFlashlight"]
];