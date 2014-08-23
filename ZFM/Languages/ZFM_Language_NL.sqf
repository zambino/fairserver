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
    "Erstelle eine Join-In-Progress Markierung - Fahrzeugtyp [%1],Position [%2],Schwierigkeit[%3].",

    // Debug
    "Debug Parameter für _this sind %1.",
    "Debug null-Wert check für %1",
    "DZMS oder EMS gefunden. Werde es los, packe deine PBO wieder zusammen, fühl dich großartig.",
    "Die AI Scripts der ZFM Alpha sind noch nicht vollständig getestet. Nutzung auf eigene Gefahr, Landratte. Y'arr.",

    // Units
    "Einheiten - Erstelle eine Einheitengruppe für die Mission ID %1",
    "Einheiten - Erstelle einzelne Einheit %1 von %2 [Typ: %3]",
    "Einheiten - Ausrüstung der Einheiten mit Primärwaffe [%1], Magazinen [%2], Rucksack [%3],Einheit [%4] und Magazin [%5]",

    // Missions
    "Dieser Bandit %1 wurde von %2 getötet! [%3 / %4].", // User message
    "Alle Einheiten wurden eleminiert! [%1 / %2]", // User message
    "Missions Debug [Ziel %1] %2",
    "Mission ErhalteMissionDurchID Debug %1 und %2",
    "Mission %1 - Missionsfeld Typ %2",
    "Mission %1 - Alle Einheiten wurden ausgelöscht, beende Mission.",
    "Mission %1 - Beende aufgerufene mit Missionsfeld %2.",
    "Mission %1 - Missionsobjekte die entfernt wurden: %2.",
    "Mission %1 - Missionsmarker %2 entfernt.",
    "Mission %1 - Mission hinzugefügt.",
    "Mission %1 - Mission entfernt.",
    "Missionsteuerung - Initialisiert",
    "Missionsteuerung - Missionsstart Checkup fertiggestellt - Maximale Anzahl an laufenden Missionen nicht erreicht.",
    "Missionsteuerung - Hauptschleife gestartet",
    "Missionsteuerung - momentan spielbare Einheiten %1",
    "Missionsteuerung - Start Typ %1, Zufälliger Typ %2",
    "Missionsteuerung - Kann eine neue Mission hinzugefügt werden? %1",
    "Missionsteuerung - Warte %1 Sekunden auf nächste Schleife.",
    "Missionsgenerator - Ausgeführt von Methode %1",
    "Missionsgenerator - Loot Modus [%1], Typ [%2], Variablen [%3], Einheiten [%4]",

    // Crash missions
    "Verunglügt %1",
    "%1 [Schwierigkeit: %2]",
    "MissionsTyp CRASH - Crash Mission wird ausgeführt.",
    "MissionsTyp CRASH - Crash Position gefunden.",
    "MissionsTyp CRASH - das verunglückte Fahrzeug wurde durch ein Modell ersetzt. Ersetze das Modell durch nicht brennendes Modell.",
    "MissionsTyp CRASH - Crash Markierung erstellt bei %1",

    // Crash dynamic stuff
    "Ein %1 %2 %3 %4. %5",
];

ZFM_ERROR_STRINGS =[
    // Fatal errors (ex language ones)
    "Fatal error! Keine Missionstypen definiert oder aktiviert! Bitte beheben Sie dies, durch die Sicherstellung, dass ZFM_MISSION_TYPES_ENABLED or ZFM_MISSION_TYPES_SUPPORTED die korrekten Inhalte hat.",

    // Units
    "Unbekannter Einheitentyp erhalten. Schließe Einheiten Erstellung.",
    "Falscher Format des Ausrüstungsfeldes für Einheiten. Sie müssen ZFM neu aufsetzen oder Ihre Fehler beheben.",    

    // Missions
    "Die Maximale Anzahl an Missionen wurde auf 0 festgelegt. Sie wollen doch Missionen, oder?",
    "Nur eine Instanz der Missionssteuerung kann gleichzeitig laufen. Verlasse Hauptschleife.",
    "Momentan ist keiner auf dem Serber und ZFM_MISSIONS_START_WHILE_SERVER_EMPTY ist auf FALSE gestellt. Warte auf Spieler.",
];

// Module-specific language strings

ZFM_CRASH_MISSION_OTWT =[
    
];

ZFM_CRASH_MISSION_OTWT_PLACE =[

];

ZFM_CRASH_MISSION_OTWT_ACTION =[
    
];
ZFM_CRASH_MISSION_OTWT_CONSEQUENCE =[
    "Es scheint so als würde",
    "Sieht aus als",
    "Unglücklicherweise,",
    "Bedauerlicherweise,",
    "Verdammt, sieht aus als",
    "Oh Scheiße,",
    "Ohh Kumpel,",
    "Heilige Scheiße,",
];

// Double formatting to replace a wildcard replaced by a wildcard.. ;-)
ZFM_CRASH_MISSION_OTWT_CONSEQUENCE_CONCLUSION =[
    "%1 haben die Kontrolle über das Gebiet erlangt.",
    "%1 haben sich im Gebiet verschantzt.",
    "%1 patollieren in der Nähe.",
    "%1 feiern eine Orgie in der Nähe.",
    "%1 haben die Scharfschützenposition erobert.",
    "%1 haben sich im Gebiet versteckt",
    "%1 haben Defensive Positionen aufgestellt.",
    "%1 haben jetzt die Kontrolle.",
    "%1 sind nun die Befehlshaber.",
    "%1 sind die großen Bosse in der Stadt."
];


ZFM_CRASH_MISSION_OTWT_BG_NAMES_HERO =[
    "Der Name meiner Heldengruppe",
];
ZFM_CRASH_MISSION_OTWT_BG_NAMES_BANDIT =[
    "Der Name meiner Banditengruppe"
];