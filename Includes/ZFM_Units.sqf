/*
Zambino Fair Mission
Copyright (C) 2014,2015 Jordan Ashley Craw

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

/*
*
*	Difficulties 
*	0 = Deadmeat, 1 = Easy, 2 =Medium, 3=Hard, 4=FuckYouUp	
*
*	Unit array layout
*	0 = Skin (array)
*	1 = Primary weapon (array)
*	2 = Primary weapon magazines (scalar)
*	3 = Backpack (array)
*	4 = Backpack contents
*/
ZFM_UNIT_TYPES_SNIPER =[
	[
		"Bandit1_DZ",				// Deadmeat
		"Bandit1_DZ",				// Easy
		"Soldier_Sniper_PMC_DZ",	// Medium
		"B_soldier_M_F",	// Hard
		"GUE_Soldier_Sniper_DZ"		// Fuck Yo' Ass Up
	], // Skin
	[
		["srifle_LRR_SOS_F"],							// Deadmeat
		["srifle_LRR_SOS_F"],							// Easy
		["srifle_LRR_SOS_F"],							// Medium
		["srifle_LRR_SOS_F"],							// Hard
		["srifle_LRR_SOS_F"]							// Fuck Yo' Ass Up
	], // Primary weapon
	[
		2,							// Deadmeat
		3,							// Easy
		3,							// Medium
		4,							// Hard
		5							// Fuck Yo' Ass Up
	], // Magazines
	[
		["B_AssaultPack_cbr"],							// Deadmeat
		["B_AssaultPack_cbr"],							// Easy
		["B_AssaultPack_cbr"],							// Medium
		["B_Carryall_cbr"],							// Hard
		["B_AssaultPack_cbr"]							// Fuck Yo' Ass Up
	], // Backpack
	[
		["ToolKit"],							// Deadmeat
		["ToolKit"],							// Easy
		["ToolKit"],							// Medium
		["ToolKit"],							// Hard
		["ToolKit"]							// Fuck Yo' Ass Up
	] // Backpack contents
];

// I figure... why create these multiple times when we can do it once, dynamically?
// Sure, the unit types will be the same for a runtime, but fuck it. Once a restart is fine.
ZFM_UNIT_TYPES_SNIPER_DEADMEAT = [
	ZFM_UNIT_TYPES_SNIPER select 0 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_SNIPER select 1 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_SNIPER select 2 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_SNIPER select 3 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_SNIPER select 4 select ZFM_DEFINES_DIFFICULTY_DEADMEAT
];

ZFM_UNIT_TYPES_SNIPER_EASY = [
	ZFM_UNIT_TYPES_SNIPER select 0 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_SNIPER select 1 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_SNIPER select 2 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_SNIPER select 3 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_SNIPER select 4 select ZFM_DEFINES_DIFFICULTY_EASY
];

ZFM_UNIT_TYPES_SNIPER_MEDIUM = [
	ZFM_UNIT_TYPES_SNIPER select 0 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_SNIPER select 1 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_SNIPER select 2 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_SNIPER select 3 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_SNIPER select 4 select ZFM_DEFINES_DIFFICULTY_MEDIUM
];

ZFM_UNIT_TYPES_SNIPER_HARD = [
	ZFM_UNIT_TYPES_SNIPER select 0 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_SNIPER select 1 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_SNIPER select 2 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_SNIPER select 3 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_SNIPER select 4 select ZFM_DEFINES_DIFFICULTY_HARD
];

ZFM_UNIT_TYPES_SNIPER_WAR_MACHINE = [
	ZFM_UNIT_TYPES_SNIPER select 0 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_SNIPER select 1 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_SNIPER select 2 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_SNIPER select 3 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_SNIPER select 4 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE
];

ZFM_UNIT_TYPES_RIFLEMAN = [
	[
		"Bandit1_DZ",				// Deadmeat
		"Bandit1_DZ",				// Easy
		"GUE_Soldier_MG_DZ",	// Medium
		"GUE_Soldier_Crew_DZ",	// Hard
		"Ins_Soldier_GL_DZ"		// Fuck Yo' Ass Up
	], // Skin
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	], // Primary weapon
	[
		2,							// Deadmeat
		3,							// Easy
		3,							// Medium
		4,							// Hard
		5							// Fuck Yo' Ass Up
	], // Magazines
	[
		"",							// Deadmeat
		"",							// Easy
		"",							// Medium
		"",							// Hard
		""							// Fuck Yo' Ass Up
	], // Backpack
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	] // Backpack contents
];

ZFM_UNIT_TYPES_RIFLEMAN_DEADMEAT = [
	ZFM_UNIT_TYPES_RIFLEMAN select 0 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_RIFLEMAN select 1 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_RIFLEMAN select 2 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_RIFLEMAN select 3 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_RIFLEMAN select 4 select ZFM_DEFINES_DIFFICULTY_DEADMEAT
];

ZFM_UNIT_TYPES_RIFLEMAN_EASY = [
	ZFM_UNIT_TYPES_RIFLEMAN select 0 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_RIFLEMAN select 1 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_RIFLEMAN select 2 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_RIFLEMAN select 3 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_RIFLEMAN select 4 select ZFM_DEFINES_DIFFICULTY_EASY
];

ZFM_UNIT_TYPES_RIFLEMAN_MEDIUM = [
	ZFM_UNIT_TYPES_RIFLEMAN select 0 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_RIFLEMAN select 1 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_RIFLEMAN select 2 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_RIFLEMAN select 3 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_RIFLEMAN select 4 select ZFM_DEFINES_DIFFICULTY_MEDIUM
];

ZFM_UNIT_TYPES_RIFLEMAN_HARD = [
	ZFM_UNIT_TYPES_RIFLEMAN select 0 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_RIFLEMAN select 1 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_RIFLEMAN select 2 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_RIFLEMAN select 3 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_RIFLEMAN select 4 select ZFM_DEFINES_DIFFICULTY_HARD
];

ZFM_UNIT_TYPES_RIFLEMAN_WAR_MACHINE = [
	ZFM_UNIT_TYPES_RIFLEMAN select 0 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_RIFLEMAN select 1 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_RIFLEMAN select 2 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_RIFLEMAN select 3 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_RIFLEMAN select 4 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE
];



ZFM_UNIT_TYPES_HEAVY = [
	[
		"Bandit1_DZ",				// Deadmeat
		"Bandit1_DZ",				// Easy
		"Bandit1_DZ",				// Medium
		"GUE_Soldier_CO_DZ",		// Hard
		"GUE_Soldier_CO_DZ"			// Fuck Yo' Ass Up
	], // Skin
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	], // Primary weapon
	[
		2,							// Deadmeat
		3,							// Easy
		3,							// Medium
		4,							// Hard
		5							// Fuck Yo' Ass Up
	], // Magazines
	[
		"",							// Deadmeat
		"",							// Easy
		"",							// Medium
		"",							// Hard
		""							// Fuck Yo' Ass Up
	], // Backpack
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	] // Backpack contents
];

ZFM_UNIT_TYPES_HEAVY_DEADMEAT = [
	ZFM_UNIT_TYPES_HEAVY select 0 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_HEAVY select 1 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_HEAVY select 2 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_HEAVY select 3 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_HEAVY select 4 select ZFM_DEFINES_DIFFICULTY_DEADMEAT
];

ZFM_UNIT_TYPES_HEAVY_EASY = [
	ZFM_UNIT_TYPES_HEAVY select 0 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_HEAVY select 1 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_HEAVY select 2 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_HEAVY select 3 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_HEAVY select 4 select ZFM_DEFINES_DIFFICULTY_EASY
];

ZFM_UNIT_TYPES_HEAVY_MEDIUM = [
	ZFM_UNIT_TYPES_HEAVY select 0 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_HEAVY select 1 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_HEAVY select 2 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_HEAVY select 3 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_HEAVY select 4 select ZFM_DEFINES_DIFFICULTY_MEDIUM
];

ZFM_UNIT_TYPES_HEAVY_HARD = [
	ZFM_UNIT_TYPES_HEAVY select 0 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_HEAVY select 1 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_HEAVY select 2 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_HEAVY select 3 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_HEAVY select 4 select ZFM_DEFINES_DIFFICULTY_HARD
];

ZFM_UNIT_TYPES_HEAVY_WAR_MACHINE = [
	ZFM_UNIT_TYPES_HEAVY select 0 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_HEAVY select 1 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_HEAVY select 2 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_HEAVY select 3 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_HEAVY select 4 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE
];


ZFM_UNIT_TYPES_COMMANDER = [
	[
		"GUE_Commander_DZ",			// Deadmeat
		"GUE_Commander_DZ",			// Easy
		"GUE_Commander_DZ",			// Medium
		"GUE_Commander_DZ",			// Hard
		"GUE_Commander_DZ"			// Fuck Yo' Ass Up
	], // Skin
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	], // Primary weapon
	[
		2,							// Deadmeat
		3,							// Easy
		3,							// Medium
		4,							// Hard
		5							// Fuck Yo' Ass Up
	], // Magazines
	[
		"",							// Deadmeat
		"",							// Easy
		"",							// Medium
		"",							// Hard
		""							// Fuck Yo' Ass Up
	], // Backpack
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	] // Backpack contents
];

ZFM_UNIT_TYPES_COMMANDER_DEADMEAT = [
	ZFM_UNIT_TYPES_COMMANDER select 0 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_COMMANDER select 1 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_COMMANDER select 2 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_COMMANDER select 3 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_COMMANDER select 4 select ZFM_DEFINES_DIFFICULTY_DEADMEAT
];

ZFM_UNIT_TYPES_COMMANDER_EASY = [
	ZFM_UNIT_TYPES_COMMANDER select 0 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_COMMANDER select 1 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_COMMANDER select 2 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_COMMANDER select 3 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_COMMANDER select 4 select ZFM_DEFINES_DIFFICULTY_EASY
];

ZFM_UNIT_TYPES_COMMANDER_MEDIUM = [
	ZFM_UNIT_TYPES_COMMANDER select 0 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_COMMANDER select 1 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_COMMANDER select 2 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_COMMANDER select 3 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_COMMANDER select 4 select ZFM_DEFINES_DIFFICULTY_MEDIUM
];

ZFM_UNIT_TYPES_COMMANDER_HARD = [
	ZFM_UNIT_TYPES_COMMANDER select 0 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_COMMANDER select 1 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_COMMANDER select 2 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_COMMANDER select 3 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_COMMANDER select 4 select ZFM_DEFINES_DIFFICULTY_HARD
];

ZFM_UNIT_TYPES_COMMANDER_WAR_MACHINE = [
	ZFM_UNIT_TYPES_COMMANDER select 0 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_COMMANDER select 1 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_COMMANDER select 2 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_COMMANDER select 3 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_COMMANDER select 4 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE
];


ZFM_UNIT_TYPES_EXPLOSIVES =[
	[
		"Bandit1_DZ",				// Deadmeat
		"Bandit1_DZ",				// Easy
		"Soldier_Sniper_PMC_DZ",	// Medium
		"GUE_Soldier_Sniper_DZ",	// Hard
		"GUE_Soldier_Sniper_DZ"		// Fuck Yo' Ass Up
	], // Skin
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	], // Primary weapon
	[
		2,							// Deadmeat
		3,							// Easy
		3,							// Medium
		4,							// Hard
		5							// Fuck Yo' Ass Up
	], // Magazines
	[
		"",							// Deadmeat
		"",							// Easy
		"",							// Medium
		"",							// Hard
		""							// Fuck Yo' Ass Up
	], // Backpack
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	] // Backpack contents
];

ZFM_UNIT_TYPES_EXPLOSIVES_DEADMEAT = [
	ZFM_UNIT_TYPES_EXPLOSIVES select 0 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_EXPLOSIVES select 1 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_EXPLOSIVES select 2 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_EXPLOSIVES select 3 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_EXPLOSIVES select 4 select ZFM_DEFINES_DIFFICULTY_DEADMEAT
];

ZFM_UNIT_TYPES_EXPLOSIVES_EASY = [
	ZFM_UNIT_TYPES_EXPLOSIVES select 0 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_EXPLOSIVES select 1 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_EXPLOSIVES select 2 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_EXPLOSIVES select 3 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_EXPLOSIVES select 4 select ZFM_DEFINES_DIFFICULTY_EASY
];

ZFM_UNIT_TYPES_EXPLOSIVES_MEDIUM = [
	ZFM_UNIT_TYPES_EXPLOSIVES select 0 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_EXPLOSIVES select 1 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_EXPLOSIVES select 2 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_EXPLOSIVES select 3 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_EXPLOSIVES select 4 select ZFM_DEFINES_DIFFICULTY_MEDIUM
];

ZFM_UNIT_TYPES_EXPLOSIVES_HARD = [
	ZFM_UNIT_TYPES_EXPLOSIVES select 0 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_EXPLOSIVES select 1 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_EXPLOSIVES select 2 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_EXPLOSIVES select 3 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_EXPLOSIVES select 4 select ZFM_DEFINES_DIFFICULTY_HARD
];

ZFM_UNIT_TYPES_EXPLOSIVES_WAR_MACHINE = [
	ZFM_UNIT_TYPES_EXPLOSIVES select 0 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_EXPLOSIVES select 1 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_EXPLOSIVES select 2 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_EXPLOSIVES select 3 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_EXPLOSIVES select 4 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE
];


ZFM_UNIT_TYPES_PILOT =[
	[
		"Bandit1_DZ",				// Deadmeat
		"Bandit1_DZ",				// Easy
		"Soldier_Sniper_PMC_DZ",	// Medium
		"GUE_Soldier_Sniper_DZ",	// Hard
		"GUE_Soldier_Sniper_DZ"		// Fuck Yo' Ass Up
	], // Skin
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	], // Primary weapon
	[
		2,							// Deadmeat
		3,							// Easy
		3,							// Medium
		4,							// Hard
		5							// Fuck Yo' Ass Up
	], // Magazines
	[
		"",							// Deadmeat
		"",							// Easy
		"",							// Medium
		"",							// Hard
		""							// Fuck Yo' Ass Up
	], // Backpack
	[
		[],							// Deadmeat
		[],							// Easy
		[],							// Medium
		[],							// Hard
		[]							// Fuck Yo' Ass Up
	] // Backpack contents
];

ZFM_UNIT_TYPES_PILOT_DEADMEAT = [
	ZFM_UNIT_TYPES_PILOT select 0 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_PILOT select 1 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_PILOT select 2 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_PILOT select 3 select ZFM_DEFINES_DIFFICULTY_DEADMEAT,
	ZFM_UNIT_TYPES_PILOT select 4 select ZFM_DEFINES_DIFFICULTY_DEADMEAT
];

ZFM_UNIT_TYPES_PILOT_EASY = [
	ZFM_UNIT_TYPES_PILOT select 0 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_PILOT select 1 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_PILOT select 2 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_PILOT select 3 select ZFM_DEFINES_DIFFICULTY_EASY,
	ZFM_UNIT_TYPES_PILOT select 4 select ZFM_DEFINES_DIFFICULTY_EASY
];

ZFM_UNIT_TYPES_PILOT_MEDIUM = [
	ZFM_UNIT_TYPES_PILOT select 0 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_PILOT select 1 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_PILOT select 2 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_PILOT select 3 select ZFM_DEFINES_DIFFICULTY_MEDIUM,
	ZFM_UNIT_TYPES_PILOT select 4 select ZFM_DEFINES_DIFFICULTY_MEDIUM
];

ZFM_UNIT_TYPES_PILOT_HARD = [
	ZFM_UNIT_TYPES_PILOT select 0 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_PILOT select 1 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_PILOT select 2 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_PILOT select 3 select ZFM_DEFINES_DIFFICULTY_HARD,
	ZFM_UNIT_TYPES_PILOT select 4 select ZFM_DEFINES_DIFFICULTY_HARD
];

ZFM_UNIT_TYPES_PILOT_WAR_MACHINE = [
	ZFM_UNIT_TYPES_PILOT select 0 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_PILOT select 1 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_PILOT select 2 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_PILOT select 3 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE,
	ZFM_UNIT_TYPES_PILOT select 4 select ZFM_DEFINES_DIFFICULTY_WAR_MACHINE
];

ZFM_UNIT_TYPES = [
	"SNIPER",
	"RIFLEMAN",
	"HEAVY",
	"COMMANDER",
	"EXPLOSIVES",
	"PILOT"
];

// Used to contain the list of units killed
ZFM_UNIT_UNITS_KILLED =[];


/*
*	ZFM_Defines_Unit_Get_Loadout
*
*	Gets a loadout for a given unit difficulty and type.
*
*	0 = Unit type, 1 = difficulty
*/
ZFM_Defines_Unit_Get_Loadout ={
	call compile format["ZFM_UNIT_TYPES_%1_%2",(_this select 0),(_this select 1)]
};


/*
*	ZFM_Units_Create_Group
*
*	Creates a group with a 
*/
ZFM_Units_Create_Group ={
	private["_commander","_unitsArray"];
	_commander = _this select 0;
	_unitsArray = _this select 1;
	_side = _this select 2;
	_formation = if(count _this >=4) then { _this select 3; } else { ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"] call BIS_fnc_selectRandom; };

	// Create the group
	_thisGroup = createGroup _side;

	// Set the leader as the commander
	_thisGroup selectLeader _commander;

	// Set the formation..
	_thisGroup setFormation _formation;

	[
		_thisGroup,
		_formation,
		_commander,
		_unitsArray
	]

};


/*
*	ZFM_Units_Set_Handlers
*
*	Creates handlers for various types of events for created units.
*/
ZFM_Units_Set_Handlers ={
	private["_unitUnit"];
	_unitUnit = _this select 0;
	
	// Manually-registered hook for unit creation
	["UNIT_CREATED",[_createdUnit,_unitGroup]] call ZFM_Hooks_Handler;

	//RV handled eventhanders
	_unitUnit addMPEventHandler["MPKilled",{
		["UNIT_KILLED",_this] call ZFM_Hooks_Handler;
	}];
	
	_unitUnit addMPEventHandler["MPHit",{
		["UNIT_HIT",_this] call ZFM_Hooks_Handler;
	}];

	_unitUnit addMPEventHandler["FiredNear",{
		["UNIT_FIRED_NEAR",_this] call ZFM_Hooks_Handler;
	}];

};


/*
*	ZFM_Units_Create
*
*	Creates a unit based on the unit type and difficulty.
*/
ZFM_Units_Create ={
	private["_unitType","_difficulty","_unitGroup", "_unitLoadout","_skin","_primaryWeapon","_primaryWeaponMagazines","_backpack","_backpackContents","_magazineName","_unitBackpack"];
	_unitType = _this select 0;
	_difficulty = _this select 1;
	_position = _this select 2;
	_unitGroup = createGroup (_this select 3);
	
	// Getting the loadout for the specified unit type and difficulty
	_unitLoadout = [_unitType,_difficulty] call ZFM_Defines_Unit_Get_Loadout;

	// Skin, weapon, magazines, backpack, backpack contents
	_skin = _unitLoadout select 0;
	_primaryWeapon = (_unitLoadout select 1) call BIS_fnc_selectRandom; // Get random item from array
	_primaryWeaponMagazines = _unitLoadout select 2;
	_backpack = (_unitLoadout select 3) call BIS_fnc_selectRandom; // Get random item from array
	_backpackContents = _unitLoadout select 4;
	
	// Create a unit with the given skin, positionm, etc.
	_createdUnit = _unitGroup createUnit[_skin,_position,[],0,"FORM"];
	
	// Get rid of all the unit's stuff (backpack, etc)
	removeAllItems _createdUnit;
	removeBackpack _createdUnit;
	removeAllWeapons _createdUnit;

	// Enable AI stuff for the unit.
	_createdUnit enableAI "TARGET";
	_createdUnit enableAI "AUTOTARGET";
	_createdUnit enableAI "MOVE";
	_createdUnit enableAI "ANIM";
	_createdUnit enableAI "FSM";
	
	// Add handlers 
	[_createdUnit] call ZFM_Units_Set_Handlers;

	// Set them as the leader of the group given if they're commander
	if(_unitType =="COMMANDER") then
	{
		_unitGroup selectLeader _createdUnit;
		_unitGroup enableAttack true;
	};
	
	// Add their primary weapon..
	_createdUnit addWeapon _primaryWeapon;
	
	// Find out the magazine for that weapon
	_magazineName = getArray(configFile >> "cfgWeapons" >> _primaryWeapon >> "magazines") select 0;
	
	// Loop the number of magazines required..
	for [{_x=1},{_x<=_primaryWeaponMagazines},{_x=_x+1}] do
	{
		_createdUnit addMagazine _magazineName; // Add the magazine to the unit.
	};

	// Give them a backpack
	_createdUnit addBackPack _backpack;
	_unitBackpack = unitBackpack _createdUnit;
	
	// Add stuff to the backpack
	{
		[_unitBackpack,_x,true] call BIS_fnc_invAdd; // Add it to the inventory with FORCE.. :O
	} forEach _backpackContents;
		
	// Set their skills..
	[_createdUnit,_difficulty] call ZFM_Defines_Units_Set_AI_Skills;
	
	// return it for manipulating and such
	_createdUnit
};


/*
*	ZFM_SetAISkills
*	
*	Sets AI skills based on config arrays.
*/
ZFM_Defines_Units_Set_AI_Skills ={
	private ["_unit","_difficulty","_skillsArray","_numSkills","_thisRow","_skill","_currSkill","_x"];
	_unit = _this select 0;
	_difficulty = _this select 1;
	_skillsArray = [];

	//Changing this to procedural rather than array-bases, as arrays are resource-intensive.
	switch(_difficulty) do
	{
		case "DEADMEAT": {
			_skillsArray =[
				random(0.1),
				random(1),
				random(0.1),
				random(0.1),
				random(0.1),
				random(0.1),
				random(0.1),
				random(0.1),
				random(0.1),
				random(0.1)
			];
		};
		case "EASY": {
			_skillsArray =[
				random(0.25),
				random(0.8),
				random(0.25),
				random(0.25),
				random(0.25),
				random(0.25),
				random(0.25),
				random(0.25),
				random(0.25),
				random(0.25)
			];
		};
		case "MEDIUM": {
			_skillsArray =[
				random(0.65),
				random(0.6),
				random(0.65),
				random(0.65),
				random(0.65),
				random(0.65),
				random(0.65),
				random(0.65),
				random(0.65),
				random(0.65)
			];
		};
		case "HARD": {
			_skillsArray =[
				random(0.85),
				random(0.4),
				random(0.85),
				random(0.85),
				random(0.85),
				random(0.85),
				random(0.85),
				random(0.85),
				random(0.85),
				random(0.85)
			];
		};
		case "WAR_MACHINE": {
			_skillsArray =[
				1,
				0,
				1,
				1,
				1,
				1,
				1,
				1,
				1,
				1
			];
		};
	};

	// Set pseudo-manually as it's quicker and requires no array recursion.
	_unit setSkill ["aimingAccuracy",_skillsArray select 0];
	_unit setSkill ["aimingShake",_skillsArray select 1];
	_unit setSkill ["aimingSpeed",_skillsArray select 2];
	_unit setSkill ["endurance",_skillsArray select 3];
	_unit setSkill ["spotDistance",_skillsArray select 4];
	_unit setSkill ["spotTime",_skillsArray select 5];
	_unit setSkill ["courage",_skillsArray select 6];
	_unit setSkill ["reloadSpeed",_skillsArray select 7];
	_unit setSkill ["commanding",_skillsArray select 8];
	_unit setSkill ["general",_skillsArray select 9];
};