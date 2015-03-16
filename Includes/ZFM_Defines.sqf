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

// ZFM info
ZFM_NAME = "FairMission";
ZFM_VERSION = "0.1.0";


// The base installation for ZFM based in the PBO
ZFM_DEFINES_INSTALL_LOCATION_BASE = "\z\addons\dayz_server\ZFM\";

// The names of the folders in which the scripts reside.
ZFM_DEFINES_INSTALL_CONFIGURE_DIRECTORY_NAME = "Configuration";
ZFM_DEFINES_INSTALL_INCLUDES_DIRECTORY_NAME = "Includes";
ZFM_DEFINES_INSTALL_MISSIONS_DIRECTORY_NAME = "Missions";

// Full runtime variables for inclusion.
ZFM_DEFINES_INSTALL_LOCATION_CONFIGURE = ZFM_DEFINES_INSTALL_LOCATION_BASE + ZFM_DEFINES_INSTALL_CONFIGURE_DIRECTORY_NAME +"\";
ZFM_DEFINES_INSTALL_LOCATION_INCLUDES = ZFM_DEFINES_INSTALL_LOCATION_BASE + ZFM_DEFINES_INSTALL_INCLUDES_DIRECTORY_NAME +"\";
ZFM_DEFINES_INSTALL_LOCATION_MISSIONS = ZFM_DEFINES_INSTALL_LOCATION_BASE + ZFM_DEFINES_INSTALL_MISSIONS_DIRECTORY_NAME +"\";

// Centers
ZFM_DEFINES_GROUP_EAST = createCenter east;
ZFM_DEFINES_GROUP_WEST = createCenter west;
ZFM_DEFINES_GROUP_CIVILIAN = createCenter civilian;
ZFM_DEFINES_GROUP_RESISTANCE = createCenter resistance;

// EAST is psycho like no other mother fucker
east setFriend [west,0];
east setFriend [resistance,0];
east setFriend [civilian,1]; // Ignore zombies

// RESISTANCE is designated as hero AI
resistance setFriend [west,0];
resistance setFriend [east,0];
resistance setFriend [civilian,1]; // Ignore zombies

// WEST is the player
west setFriend [east,0]; // Bandits will fuck up the player..
west setFriend [resistance,0]; // Heroes will fuck up the player..

// Difficulties
ZFM_DEFINES_DIFFICULTY_DEADMEAT = 0;
ZFM_DEFINES_DIFFICULTY_EASY = 1;
ZFM_DEFINES_DIFFICULTY_MEDIUM = 2;
ZFM_DEFINES_DIFFICULTY_HARD = 3;
ZFM_DEFINES_DIFFICULTY_WAR_MACHINE = 4;

// Difficulties
ZFM_DEFINES_DIFFICULTIES =[
	"DEADMEAT",
	"EASY",
	"MEDIUM",
	"HARD",
	"WAR_MACHINE"
];

// Unit factions
ZFM_DEFINES_FACTIONS =[
	"BANDIT",
	"HERO"
];