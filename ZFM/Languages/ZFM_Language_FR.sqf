/*
	ZFSS - Zambino's FairServer System v0.5
	A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
	Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
/*
ZFSS - Zambino's FairServer System v0.5
A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. 
Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)
Copyright (C) 2014 Jordan Ashley Craw


This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */
ZFM_INFORMATION_STRINGS = [


// Join-In-Progress
"Creation du markeur pour les joignements-en-cours - Type du vehicule [%1],Position [%2],Difficultée [%3].",

// Debug
"Les parametres du debug _this sonts %1.",
"Verification des null-value du debug pour %1",
"DZMS ou EMS est installé. Supprimez le, re PBO vos fichiers et voila!",
"Les scriptes pour AI de ZFM Alpha ne sonts pas testé parfaitements. A vos risques et périls. Yarrrr.",

// Units
"Unitées - En création des unitées pour la mission %1",
"Unitées - En création d'une unitée singulière %1 de %2 [Type: %3]",
"Unitées - En cours d'équipement avec pour arma principale [%1], Chargeurs [%2], Sac à dos [%3],Unitée [%4] and Chargeurs [%5]",

// Missions
"Le bandit %1 a été tué par %2 [%3 / %4].", // User message
"Toutes unitées ont étées tuées! [%1 / %2]", // User message
"Debug de Mission [Raison %1] %2",
"Mission GetMissionByID Debug %1 and %2", //Hard to translate//
"Mission %1 - MissionArray type %2",
"Mission %1 - Toutes unitées ont étées tuées, finissement de la mission.",
"Mission %1 - Finissement appelée avec MissionArray %2.",
"Mission %1 - Les objects de la mission qui ont étées supprimées: %2.",
"Mission %1 - Les markeurs de la mission %2 supprimées.",
"Mission %1 - Mission ajoutée.",
"Mission %1 - Mission supprimée.",
"Mission Handler - Initialisée",
"Mission Handler - Les verifications de commencement finies - Nombre maximum de missions non atteint.",
"Mission Handler - Commencement du Main Loop",
"Mission Handler - Unitées jouables présantes %1",
"Mission Handler - Type de commencement %1, Type au hasard %2",
"Mission Handler - Pouvons nous ajouter une mission? %1",
"Mission Handler - En attente de %1 secondes pour le loop suivant.",
"Mission Generation - Executée par méthode %1",
"Mission Generation - Mode du Loot [%1], Type [%2], Variables [%3], Unitées [%4]",

// Crash missions
"%1 Crashé",
"%1 [Difficultée: %2]",
"Type de mission CRASH - Crash Mission Executée.",
"Type de mission CRASH - Emplacement du Crash trouvé.",
"Type de mission CRASH - Les véhicule crashé a un model défaillant. Nous remplacons son modèle par un non enflammé.",
"Type de mission CRASH - Le markeur du crash a été ajouté à %1",

// Crash dynamic stuff
"Un %1 %2 %3 %4. %5",
];


ZFM_ERROR_STRINGS =[
// Fatal errors (ex language ones)
"Erreure fatale! Aucune mission n'est définie ou activée! Veuillez vous assurer que ZFM_MISSION_TYPES_ENABLED ou ZFM_MISSION_TYPES_SUPPORTED sonts bien configurées!",

// Units
"Unitée inconnue definie. Nous passons la phase de creation d'unitées.",
"Mauvais format dans EquipArray pour une unitée. Veuillez restorer les valeurs définies par ZFM ou bien résoudre ce que vous avez cassé.", 

// Missions
"Le nombre maximum de missions en meme temps a été defini a 0. Ne voulez vous aucune mission?",
"Seulement une instance de MissionHandler ne peut s'executer en meme temps qu'un autre. Nous quittons le loop principal.",
"Peronne de connecté sur le serveur et ZFM_MISSIONS_START_WHILE_SERVER_EMPTY A été defini sur faux. En attente de joueur.",
];


// Module-specific language strings 


ZFM_CRASH_MISSION_OTWT =[

];

ZFM_CRASH_MISSION_OTWT_PLACE =[

];

ZFM_CRASH_MISSION_OTWT_ACTION =[

];
ZFM_CRASH_MISSION_OTWT_CONSEQUENCE =[
    "On dirait que",
    "Ca ressemble à",
    "Malheureusement,",
    "Regretablement,",
    "Merde, on dirait que",
    "Et merde,",
    "Chien chaud,", //I'd rather skip that string ahah, Hot Dawg doesn't mean anything in French :p
    "Tonnere de Brest,",
];


// Double formatting to replace a wildcard replaced by a wildcard.. ;-)
ZFM_CRASH_MISSION_OTWT_CONSEQUENCE_CONCLUSION =[
    "lendroit a été capturé par %1",
    "%1 on posées leurs camps dans la zone.",
    "%1 sont entain de patrouiller la zone.",
    "%1 se sonts posées dans la zone.", //I really don't know how I could even translate that to something good in French ahah
    "%1 ont pris des positions de sniper proche d'ici.",
    "%1 sont cachées proche d'ici.",
    "%1 sont entrain de former des patrouilles défensives.",
    "%1 ont maintenant le controle.",
    "%1 dirigent tout.",
    "%1 sonts les plus grands pilleurs de la ville."
];

ZFM_CRASH_MISSION_OTWT_BG_NAMES_HERO =[    
    "Mon nom de groupe d'unitées de type HERO",
];
ZFM_CRASH_MISSION_OTWT_BG_NAMES_BANDIT =[
    "Mon nom de groupe d'unitées de type BANDIT"
];