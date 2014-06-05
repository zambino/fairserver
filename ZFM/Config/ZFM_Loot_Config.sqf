/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
 ZFS_Loot_Type_Fixed = "4x10101A";
 ZFS_Loot_Type_Probabilty = "4x10101B";
 
 
 ZFM_Loot_Crates =[
	"TKSpecialWeapons_EP1",
	"CZBasicWeapons_EP1",
	"TKVehicleBox_EP1",
	"USVehicleBox_EP1",
	"USSpecialWeapons_EP1"
 ];
 
 
 
 //Todo : Change to ZFM, not ZFS! ;-)
 
 ZFM_LOOT_MODE_TYPES = [
	ZFS_Loot_Type_Fixed,
	ZFS_Loot_Type_Probability
 ];
 
 
 ZFS_Loot_Pistol_Magazines = [
	["7Rnd_45ACP_1911","magazine"], // M1911
	["8Rnd_9x18_MakarovSD","magazine"],
	["8Rnd_9x18_Makarov","magazine"],
	["6Rnd_45ACP","magazine"],
	["15Rnd_9x19_M9SD","magazine"],
	["30Rnd_9x19_MP5SD","magazine"],
	["30Rnd_9x19_UZI_SD""magazine"]
 ];
 
 ZFS_Loot_Sniper_Magazines = [
	["20Rnd_762x51_B_SCAR","magazine"],
	["20Rnd_762x51_SB_SCAR","magazine"],
	["10Rnd_762x54_SVD","magazine"],
	["5Rnd_127x108_KSVK","magazine"],
	["20Rnd_762x51_DMR","magazine"],
	["10Rnd_127x99_m107","magazine"],
	["5Rnd_762x51_M24""magazine"]
 ];
 
 ZFS_Loot_MachineGun_Magazines =[
	["100Rnd_762x51_M240","magazine"],
	["20Rnd_556x45_Stanag","magazine"],
	["30Rnd_556x45_Stanag","magazine"], 
	["30Rnd_556x45_StanagSD","magazine"], 
	["30Rnd_556x45_G36","magazine"], 
	["30Rnd_556x45_G36SD","magazine"], 
	["200Rnd_556x45_M249","magazine"], 
	["100Rnd_556x45_BetaCMag","magazine"]	 
 ];
 
 ZFS_Loot_MainRifles_Magazines = [
	["30Rnd_545x39_AK","magazine"],
	["30Rnd_545x39_AKSD","magazine"],
	["75Rnd_545x39_RPK","magazine"],
	["30Rnd_762x39_AK47","magazine"], 
	["30Rnd_762x39_SA58","magazine"],
	["30Rnd_556x45_G36","magazine"],
	["30Rnd_556x45_Stanag","magazine"], 
	["30Rnd_556x45_StanagSD","magazine"],
	["64Rnd_9x19_Bizon","magazine"], 
	["64Rnd_9x19_SD_Bizon","magazine"],
	["20Rnd_762x51_FNFAL","magazine"],
	["30Rnd_556x45_G36SD","magazine"],
	["30Rnd_556x45_StanagSD","magazine"],
	["8Rnd_B_Beneli_74Slug","magazine"],
	["8Rnd_B_Beneli_Pellets","magazine"],
	["30Rnd_556x45_G36","magazine"], 
	["30Rnd_556x45_G36SD","magazine"], 
	["100Rnd_556x45_BetaCMag","magazine"]
 ];
 
 ZFS_Loot_ALL_Magazines = ZFS_Loot_Pistol_Magazines + ZFS_Loot_Sniper_Magazines + ZFS_Loot_MachineGun_Magazines + ZFS_Loot_MainRifles_Magazines;
 

 
 /*
 *	Variable loot spawns
 */
 ZFS_LootTable_Main_Pistols =
[
	["Colt1911","weapon",0.2,0.4,0.6],
	["revolver_EP1","weapon",0.2,0.4,0.6],
	["UZI_EP1","weapon",0.2,0.4,0.6],
	["Makarov","weapon",0.4,0.8,1],
	["MakarovSD","weapon",0.5,0.8,1],
	["glock17_EP1","weapon",0.5,0.7,0.9],
	["M9","weapon",0.8,1,1],
	["M9SD","weapon",0.8,1,1]
];

ZFS_LootTable_Main_Snipers =
[
	["DMR_DZ","weapon",0.1,0.2,0.4], 		// Too many people spamming this weapon, 10% drop rate is fair. 
	["KSVK_DZE","weapon",0.05,0.1,0.2],		// Also a powerful weapon, should be rare.
	["m107","weapon",0.1,0.2,0.3],			// Same as above..
	["SCAR_H_LNG_Sniper_SD","weapon",0.1,0.2,0.3],
	["SVD_CAMO","weapon",0.4,0.5,0.6],
	["SVD_des_EP1","weapon",0.4,0.5,0.6],
	["M24","weapon",0.8,0.9,1]	
];

ZFS_LootTable_Main_MachineGuns = 
[
	["M240_DZ","weapon",0.2,0.4,0.8],
	["M249_DZ","weapon",0.4,0.8,1],
	["MG36_camo","weapon",0.4,0.8,1],
	["Mk_48_DZ","weapon",0.8,1,1],
	["PK","weapon",0.8,1,1]
];

ZFS_LootTable_Main_Rifles =
[
	["RPK_74","weapon",0.2,0.4,0.8],
	["AK_47_M","weapon",0.3,0.5,0.8],
	["AK_74","weapon",0.3,0.5,0.8],
	["AKS_74_kobra","weapon",0.3,0.5,0.8],
	["AKS_74_U","weapon",0.3,0.5,0.8],
	["BAF_L85A2_RIS_Holo","weapon",0.3,0.5,0.8],
	["bizon_silenced","weapon",0.3,0.5,0.8],
	["FN_FAL_ANPVS4","weapon",0.3,0.5,0.8],
	["FN_FAL","weapon",0.3,0.5,0.8],
	["G36A_camo","weapon",0.3,0.5,0.8],
	["G36C_camo","weapon",0.3,0.5,0.8],
	["G36C","weapon",0.3,0.5,0.8],
	["G36K_camo","weapon",0.3,0.5,0.8],
	["M1014","weapon",0.3,0.5,0.8],
	["M16A2","weapon",0.3,0.5,0.8],
	["M16A2GL","weapon",0.3,0.5,0.8],
	["M4A1_AIM_SD_camo","weapon",0.3,0.5,0.8],
	["M4A1_Aim","weapon",0.3,0.5,0.8],
	["M4A1_HWS_GL_camo","weapon",0.3,0.5,0.8],
	["M4A1","weapon",0.3,0.5,0.8],
	["M4A3_CCO_EP1","weapon",0.3,0.5,0.8],
	["Remington870_lamp","weapon",0.3,0.5,0.8],
	["Sa58P_EP1","weapon",0.3,0.5,0.8],
	["Sa58V_CCO_EP1","weapon",0.3,0.5,0.8],
	["Sa58V_EP1","weapon",0.3,0.5,0.8],
	["Sa58V_RCO_EP1","weapon",0.3,0.5,0.8]
];

ZFS_LootTable_ToolItems = 
[
	["ItemToolBox","weapon",0.7,0.8,0.9],
	["ItemKeyKit","weapon",0.5,0.7,0.8],
	["ItemCompass","weapon",0.8,0.9,1],
	["ItemEtool","weapon",0.4,0.5,0.6],
	["ItemFishingPole","weapon",0.7,0.8,0.9],
	["ItemMap","weapon",1,1,1],
	["ItemShovel","weapon",0.2,0.3,0.4],
	["ItemSledge","weapon",0.2,0.3,0.4],
	["ItemKnife","weapon",0.7,0.8,0.9],
	["ItemHatchet_DZE","weapon",0.8,0.9,1],
	["ItemMatchBox_DZE","weapon",0.8,0.9,1],
	["ItemSledge","weapon",0.2,0.3,0.4]
];

ZFS_LootTable_BuildingSupplies = 
[
	["CinderBlocks","magazine",0.7,0.8,0.9],
	["MortarBucket","magazine",0.7,0.8,0.9],
	["ItemTankTrap","magazine",0.7,0.8,0.9],
	["ItemPole","magazine",0.2,0.3,0.5],
	["PartGeneric","magazine",0.7,0.8,0.9],
	["PartPlywoodPack","magazine",0.7,0.8,0.9],
	["PartPlankPack","magazine",0.7,0.8,0.9],
	["ItemTentOld","magazine",0.7,0.8,0.9],
	["ItemTentDomed","magazine",0.7,0.8,0.9],
	["ItemTentDomed2","magazine",0.7,0.8,0.9],
	["ItemSandbag","magazine",0.7,0.8,0.9],
	["ItemWire","magazine",0.7,0.8,0.9],
	["workbench_kit","magazine",0.7,0.8,0.9],
	["ItemGenerator","magazine",0.7,0.8,0.9]
];

ZFS_LootTable_BackPacks = 
[
	["DZ_ALICE_Pack_EP1","backpack",0.5,0.6,0.7],
	["DZ_TK_Assault_Pack_EP1","backpack",0.4,0.5,0.6],
	["DZ_British_ACU","backpack",0.3,0.4,0.6],
	["DZ_LargeGunBag_EP1","backpack",0.2,0.3,0.4]
];


ZFS_LootTable_MedicalSupplies =
[
	["ItemAntibiotic","magazine",0.7,0.8,0.9],
	["ItemBandage","magazine",1,1,1],
	["ItemBloodbag","magazine",0.6,0.8,1],
	["ItemEpinephrine","magazine",0.6,0.8,1],
	["ItemMorphine","magazine",0.6,0.8,1],
	["ItemPainkiller","magazine",0.6,0.8,1]
];


// Create a table with ALL the weapons in one array.
ZFS_LootTable_Main =ZFS_LootTable_Main_Pistols + ZFS_LootTable_Main_Snipers + ZFS_LootTable_Main_MachineGuns + ZFS_LootTable_Main_Rifles +ZFS_LootTable_ToolItems + ZFS_LootTable_BuildingSupplies + ZFS_LootTable_BackPacks + ZFS_LootTable_MedicalSupplies;
 
 // For random selection of loot types
ZFS_LootTable_Types =[
	ZFS_LootTable_Main_Pistols,
	ZFS_LootTable_Main_Snipers,
	ZFS_LootTable_Main_MachineGuns,
	ZFS_LootTable_Main_Rifles,
	ZFS_LootTable_ToolItems,
	ZFS_LootTable_BuildingSupplies,
	ZFS_LootTable_BackPacks,
	ZFS_LootTable_MedicalSupplies
 ];
 
// For random selection of loot types
ZFS_FixedLoot_Types =[
	ZFS_FixedLoot_Pistols,
	ZFS_FixedLoot_Snipers,
	ZFS_FixedLoot_MachineGuns,
	ZFS_FixedLoot_Main_Rifles,
	ZFS_FixedLoot_ToolItems,
	ZFS_FixedLoot_BuildingSupplies,
	ZFS_FixedLoot_BackPacks,
	ZFS_FixedLoot_MedicalSupplies
];
 
 /*
	Fixed loot spawns (without rare drop probabilities, etc)
 */
 
ZFS_FixedLoot_Pistols =
[
	["Colt1911","weapon"],
	["revolver_EP1","weapon"],
	["UZI_EP1","weapon"],
	["Makarov","weapon"],
	["MakarovSD","weapon"],
	["glock17_EP1","weapon"],
	["M9","weapon"],
	["M9SD","weapon"]
]; 
 
ZFS_FixedLoot_Snipers =
[
	["DMR_DZ","weapon"],
	["KSVK_DZE","weapon"],
	["m107","weapon"],
	["SCAR_H_LNG_Sniper_SD","weapon"],
	["SVD_CAMO","weapon"],
	["SVD_des_EP1","weapon"],
	["M24","weapon"]
];
 
ZFS_FixedLoot_MachineGuns =
[
	["M240_DZ","weapon"],
	["M249_DZ","weapon"],
	["MG36_camo","weapon"],
	["Mk_48_DZ","weapon"],
	["PK","weapon"]
];

ZFS_FixedLoot_Main_Rifles =
[
	["RPK_74","weapon"],
	["AK_47_M","weapon"],
	["AK_74","weapon"],
	["AKS_74_kobra","weapon"],
	["AKS_74_U","weapon"],
	["BAF_L85A2_RIS_Holo","weapon"],
	["bizon_silenced","weapon"],
	["FN_FAL_ANPVS4","weapon"],
	["FN_FAL","weapon"],
	["G36A_camo","weapon"],
	["G36C_camo","weapon"],
	["G36C","weapon"],
	["G36K_camo","weapon"],
	["M1014","weapon"],
	["M16A2","weapon"],
	["M16A2GL","weapon"],
	["M4A1_AIM_SD_camo","weapon"],
	["M4A1_Aim","weapon"],
	["M4A1_HWS_GL_camo","weapon"],
	["M4A1","weapon"],
	["M4A3_CCO_EP1","weapon"],
	["Remington870_lamp","weapon"],
	["Sa58P_EP1","weapon"],
	["Sa58V_CCO_EP1","weapon"],
	["Sa58V_EP1","weapon"],
	["Sa58V_RCO_EP1","weapon"]
]; 

ZFS_FixedLoot_ToolItems = 
[
	["ItemToolBox","weapon"],
	["ItemKeyKit","weapon"],
	["ItemCompass","weapon"],
	["ItemEtool","weapon"],
	["ItemFishingPole","weapon"],
	["ItemMap","weapon"],
	["ItemShovel","weapon"],
	["ItemSledge","weapon"],
	["ItemKnife","weapon"],
	["ItemHatchet_DZE","weapon"],
	["ItemMatchBox_DZE","weapon"],
	["ItemSledge","weapon"]
];

ZFS_FixedLoot_BuildingSupplies = 
[
	["CinderBlocks","magazine"],
	["MortarBucket","magazine"],
	["ItemTankTrap","magazine"],
	["ItemPole","magazine"],
	["PartGeneric","magazine"],
	["PartPlywoodPack","magazine"],
	["PartPlankPack","magazine"],
	["ItemTentOld","magazine"],
	["ItemTentDomed","magazine"],
	["ItemTentDomed2","magazine"],
	["ItemSandbag","magazine"],
	["ItemWire","magazine"],
	["workbench_kit","magazine"],
	["ItemGenerator","magazine"]
];

ZFS_FixedLoot_BackPacks = 
[
	["DZ_ALICE_Pack_EP1","backpack"],
	["DZ_TK_Assault_Pack_EP1","backpack"],
	["DZ_British_ACU","backpack"],
	["DZ_LargeGunBag_EP1","backpack"]
];


ZFS_FixedLoot_MedicalSupplies =
[
	["ItemAntibiotic","magazine"],
	["ItemBandage","magazine"],
	["ItemBloodbag","magazine"],
	["ItemEpinephrine","magazine"],
	["ItemMorphine","magazine"],
	["ItemPainkiller","magazine"]
];
