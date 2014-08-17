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


 //Unit types
  ZFM_AI_TYPES = [
	ZFM_AI_TYPE_SNIPER,
	ZFM_AI_TYPE_RIFLEMAN,
	ZFM_AI_TYPE_HEAVY,
	ZFM_AI_TYPE_COMMANDER
	// Not adding Medic or Pilot yet, for later version
 ];
 
 ZFM_MISSION_TYPES =[
	ZFM_MISSION_TYPE_CRASH
 ];


 /*
	ZFM BanditGroup Names

	Used to add spice to dynamic missions
 */
 ZFM_BanditGroup_Names =[
	"well-trained mercenaries",
	"well-trained ex-army soldiers",
	"special forces",
	"opportunistic thieves",
	"gathered low-lives",
	"armed cult members",
	"Chernarussian separatists",
	"cold-blooded murderers",
	"cold-blooded criminals",
	"ruthless killers",
	"trained killers",
	"rogue policemen",
	"corrupted officials",
	"war criminals",
	"escaped prisoners",
	"rugged survivalists",
	"nearby survivors",
	"nearby saboteurs",
	"ruthless reclusives",
	"deadly mercenaries",
	"malicious psychopaths",
	"angry survivors",
	"cold-blooded killers",
	"for-profit bandits",
	"power-hungry bandits",
	"local bandits",
	"devious survivalists",
	"devious bandits",
	"ruthless bandits",
	"greedy bandits",
	"desperate bandits",
	"angry bandits",
	"merciless bandits",
	"well-trained bandits",
	"opportunistic bandits",
	"a group of thugs",
	"a group of ex-gangsters",
	"a group of murderers",
	"escaped convicts"
 ];
 
ZFM_OnTheWayTo =[
	"en route to",
	"in transit to",
	"transporting medical personnel to",
	"on a routine trip to",
	"on a rescue mission to",
	"on a support mission to",
	"on an urgent rescue mission to",
	"on a humanitarian mission to",
	"on its way to rescue survivors from",
	"on a desperate mission to",
	"making a delivery to",
	"making an ammo drop to",
	"making a humanitarian drop to",
	"making its way to"
];

ZFM_OnTheWayToPlace =[
	"Balota",
	"Berezino", 
	"Bor", 
	"Chapaevsk", 
	"Chernaya Polana", 
	"Chernogorsk", 
	"Dolina",
	"Drozhino", 
	"Dubky", 
	"Dubrovka", 
	"Elektrozavodsk", 
	"Gorka", 
	"Grishino", 
	"Guglovo", 
	"Gvozdno", 
	"Kabanino", 
	"Kamenka", 
	"Kamyshovo", 
	"Karmanovka", 
	"Khelm", 
	"Komarovo", 
	"Kozlovka", 
	"Krasnostav", 
	"Lopatino", 
	"Mogilevka", 
	"Msta", 
	"Myshkino", 
	"Nadezhdino", 
	"Nizhnoye", 
	"Novodmitrovsk", 
	"Novoselky", 
	"Novy Sobor", 
	"Olsha", 
	"Orlovets", 
	"Pavlovo", 
	"Pogorevka", 
	"Polana", 
	"Prigorodki", 
	"Pulkovo", 
	"Pusta",
	"Pustoshka", 
	"Rogovo", 
	"Shakhovka", 
	"Smirnovo", 
	"Solnichniy", 
	"Sosnovka", 
	"Staroye", 
	"Stary Sobor", 
	"Svetlojarsk", 
	"Tulga", 
	"Vybor", 
	"Vyshnaya Dubrovka", 
	"Vyshnoye", 
	"Zelenogorsk"
];

ZFM_OnTheWayToDeath =[
	"has crashed",
	"was destroyed",
	"was decimated",
	"was annihilated",
	"and looks to have crashed",
	"and looks to be in serious trouble",
	"and looks like it's fucked",
	"and looks like they're not going to make it",
	"and looks like it's crashed",
	"and looks like it's been sabotaged",
	"and looks like its pilot crash landed",
	"has been downed",
	"hit a tree and crashed",
	"suffered a malfunction and crashed",
	"and was sabotaged and crashed",
	"and was damaged and crashed",
	"and was hit and crashed",
	"and lost fuel and crashed",
	"crashed in an apparent suicide",
	"crashed in an apparent suicide pact",
	"crashed after losing radio contact",
	"went silent and is presumed crashed",
	"went off the radar and is presumed destroyed",
	"lost radio contact and is presumed crashed"
	//"hit Dean Hall's ego and exploded"
];

 /*
	ZFM DeathPhrases
	
	Shown when AI or a player dies. Funny :)
 */
ZFM_DeathPhrases =[
	"is cooking with the Kennedys",
	"went tits up",
	"kissed their miserable life goodbye",
	"bit the big one",
	"kicked the bucket",
	"is six feet under",
	"got fucked up",
	"got fucked BIG TIME",
	"was snuffed out",
	"is worm food",
	"bought a pine condo", 
	"became living-challenged", 
	"sleeps with the fishes",
	"is pushing up daisies",
	"bit the dust",
	"fucked the dog",
	"screwed the pooch",
	"croaked",
	"tripped the light fantastic",
	"cashed in their chips",
	"ceased to be",
	"checked out",
	"took a dirt nap",
	"tried to walk through a wall of bullets",
	"became a bullet collector",
	"left the building",
	"reached the finish line",
	"is a goner",
	"won one for the reaper",
	"got fucked by a train",
	"joined a necrophiliac's singles club",
	"took a dirt nap",
	"is immortality challenged",
	"went into the fertilizer business",
	"was put in the crisper",
	"is pining for the fjords",
	"said YES to death"
]; 

ZFM_BanditGroup_Names_NL =[
"goed getrainde huurlingen",
"goed getrainde ex soldaten",
"special forces",
"opportunistische dieven",
"verzamelde zwervers",
"gewapende sekteleden",
"Chernarussische separatisten",
"koudbloedige moordenaars",
"koudbloedige criminelen",
"meedogenloze moordenaars",
"getrainde moordenaars",
"corrupte politieagenten",
"corrupte ambtenaren",
"oorlog criminelen",
"ontsnapte gevangenen",
"ruige overlevenden",
"nabijgelegen overlevenden",
"nabijgelegen saboteurs",
"meedogenloze kluizenaar",
"dodelijke huurlingen",
"kwaadaardige psychopaten",
"boze overlevenden",
"koudbloedige moordenaars",
"for-profit bandieten",
"macht beluste bandieten",
"plaatselijke bandieten",
"omslachtige overlevenden",
"omslachtige bandieten",
"meedogenloze bandieten",
"hebzuchtige bandieten",
"wanhopige bandieten",
"boze bandieten",
"meedogenloze bandieten",
"goed getrainde bandieten",
"opportunistische bandieten",
"een groep gangsters",
"een groep ex-gangsters",
"een groep moordenaars",
"ontsnapte veroordeelden"
 ];
 
//
ZFM_OnTheWayTo_NL =[
"op weg naar",
"op doorreis naar",
"transport van medisch personeel naar",
"op een routine reis naar",
"op een reddingsmissie naar",
"onderweg als steun naar",
"op een dringende reddingmissie naar",
"op een humanitaire missie naar",
"onderweg om overlevenden te redden van",
"op een wanhopige missie naar",
"maken van een levering aan",
"maakt een ammo drop te",
"maken van een humanitaire drop te",
"maakt zijn weg naar"
];
 
ZFM_OnTheWayToDeath_NL =[
"is gecrashed",
"is verwoest",
"is gedecimeerd",
"is vernietigd",
"lijkt te zijn neergestort",
"lijkt in ernstige problemen te zitten",
"lijkt fucked te zijn",
"lijkt dat ze het niet halen",
"lijkt te zijn neergestort",
"lijkt te zijn gesaboteerd",
"lijkt dat de piloot een crash landing heeft gemaakt",
"is neergehaald",
"raakte een boom en crashte",
"getroffen door een storing en daardoor gecrasht",
"gesaboteerd en neergestort",
"beschadigd en neergestort",
"geraakt en neergestort",
"verloor brandstof en is daardoor neergestort",
"neergestort in een schijnbare zelfmoord",
"neergestort in een schijnbare zelfmoord pact",
"neergestort na verlies van radio contact",
"geen contact en wordt verondersteld als neergestort",
"verdwenen op de radar en wordt verondersteld als vernietigd",
"verloren radio contact en word verondersteld als neergestort"
];


ZFM_BanditGroup_Names_DE =[
	"gut ausgebildeter Söldner",
	"gut ausgebildete Ex-Armeesoldaten",
	"Spezialkräfte",
	"opportunistische Diebe",
	"versammeltes abschaum",
	"bewaffnete Sektenmitglieder",
	"Chernarus Vodka Separatisten",
	"kaltblütige Mörder",
	"kaltblütige Kriminelle",
	"rücksichtslose Mörder",
	"ausgebildete Killer",
	"skrupellose Polizisten",
	"bestechliche Beamte",
	"Kriegsverbrecher",
	"entflohene Häftlinge",
	"Wilde Überlebenskünstler",
	"Überlebende in der Nähe",
	"Saboteure in der Nähe",
	"rücksichtslose Einsiedler",
	"tödliche Söldner",
	"kranke Psychopathen",
	"wütend Überlebende",
	"kaltblütigen Mörder",
	"kommerzielle Banditen",
	"macht hungrige banditen",
	"lokale Banditen",
	"hinterhältige Überlebenskünstler",
	"hinterhältige Banditen",
	"skrupellose Banditen",
	"gierige banditen",
	"verzweifelte Banditen",
	"verärgerte Banditen",
	"unbarmherzige Banditen",
	"gut ausgebildete Banditen",
	"opportunistische banditen",
	"eine Gruppe von Schlägern",
	"eine Gruppe von Ex-Gangster",
	"eine Gruppe von Mördern",
	"Sträflinge"
 ];

//
ZFM_OnTheWayTo_DE =[
	"auf dem Weg zu",
	"auf dem Weg nach",
	"Transportieren medizinisches Personal zu",
	"auf einer Routine-Reise nach",
	"auf eine Rettungsmission zu",
	"auf einer Versorgungsmission zu",
	"über eine dringende Rettungsmission zu",
	"auf einer humanitären Mission zu",
	"auf der Rettungsmission von Überlebenden",
	"auf einer Aussichtslosen Mission",
	"überbringen eine lieferung nach",
	"bringen munition nach",
	"bringen Hilfsgüter nach",
	"seinen Weg zu"
];

ZFM_OnTheWayToDeath_DE =[
	"ist abgestürzt",
	"wurde zerstört",
	"wurde dezimiert",
	"wurde vernichtet",
	"er ist abgestürtzt",
	"und es sieht aus als wer er in ernsthaften Schwierigkeiten",
	"und sieht aus wie gefickt",
	"sieht so aus als ob sie es nicht schaffen würden",
	"und sieht als wer er abgestürzt",
	"und wie es aussieht, wurde sabotiert",
	"und sieht aus wie sein Pilot eine Bruchlandung gemacht hätte",
	"wurde abgeschossen",
	"prallte gegen einen Baum und stürzte ab",
	"erhielt eine Fehlfunktion und ging kaputt",
	"es wurde sabotiert und er stürtzte",
	"und wurde beschädigt oder ging kaputt",
	"wurde stark getroffen und stürzte ab",
	"verlor Treibstoff und ist abgestürzt",
	"stürzte in einem scheinbaren Selbstmord",
	"stürzte in einem scheinbaren Selbstmord-Pakt",
	"zerstört oder Funkkontakt ging verloren",
	"schweigt und wird vermutet, er sei abgestürzt",
	"ist aus der reichweite des radars und vermutlich zerstört",
	"Funkkontakt verloren es wird vermutet, er sei abgestürzt"
];