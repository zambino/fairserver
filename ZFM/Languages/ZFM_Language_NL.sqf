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
"Creeren van de Join-In-Progress markers - voertuigtype [%1],positie [%2],moeilijkheid[%3].",
 
// Debug
"Debug parameters voor _this zijn %1.",
"Debug null-waarde check voor %1",
"DZMS of EMS is geinstalled. Verwijder, herbouw PBO, voel je goed.",
"De Ai scripts zijn niet getest voor ZFM Alpha. Gebruik onder supervisie van een ouder of verzorger, landrot. Y'arr.",
 
 
// Troepen
"Troepen – Creeren van troepen groep voor missie ID %1",
"Troepen – Creeren van individuele soldaat %1 of %2 [Type: %3]",
"Troepen – Bewapenen van de soldaat met Primair [%1], Magazijn [%2], Rugzak [%3],Soldaat [%4] en Magazine [%5]",
 
// Missies
"Die bandiet %1! Is gedood door %2 [%3 / %4].", // gebruiker mededeling
"Alle eenheden zijn gedood! [%1 / %2]", // User message
"Missie Debug [Purpose %1] %2",
"Missie KrijgMissieIDDoor Debug %1 and %2",
"Missie %1 - MissieArray type %2",
"Missie %1 – Alle troepen zijn gedood, missie afronden.",
"Missie %1 – Afronden opgeroepen door MissieArray %2.",
"Missie %1 – Missie objecten verwijderd door %2.",
"Missie %1 - Missie markeer object %2 verwijderd.",
"Missie %1 - Missie toegevoegd.",
"Missie %1 - Missie verwijderd.",
"Missie Handelaar - Gestart",
"Missie Handelaar – Opstart check voltooid – Maximum aan missies niet bereikt.",
"Missie Handelaar – Hoofd lus gestart",
"Missie Handelaar – Huidige speelbare troepen %1",
"Missie Handelaar - Start Type %1, Willekeurig type %2",
"Missie Handelaar – Kan ik een nieuwe missie toevoegen? %1",
"Missie Handelaar – Wachten, nog %1 seconden tot de volgende lus.",
"Missie Genereren – Gestart via methode %1",
"Missie Genereren – Buit modus [%1], Type [%2], Variabelen [%3], Troepen [%4]",
 
// Ongeluk missies
"Verongelukt %1",
"%1 [Moeilijkheid: %2]",
"MissieType ONGELUK - Ongeluk Missie Start.",
"MissieType ONGELUK - Ongeluk locatie gevonden.",
"MissieType ONGELUK – Verongelukt model heeft een vervangende versie. Het model wordt vervangen met een die niet brandt.",
"MissieType ONGELUK – Ongelukmarker is gecreerd door %1",
 
// Dynamisch ongeluk spul
"A %1 %2 %3 %4. %5"
];
 
ZFM_ERROR_STRINGS =[
    // Fatale fouten (ex language ones)
    "Fatale fout! Er is geem type missie gedefineerd of toepasbaar! Verhelp dit middels een controle om te zien dat ZFM_MISSION_TYPES_ENABLED of ZFM_MISSION_TYPES_SUPPORTED de juiste inhoud heeft",
     
    // Troepen
    "Onbekend type soldaat aangeleverd. Stoppen met soldaat creeren.",
    "Verkeerde formaat van EquipArray voor de soldaat. Je zult ZFM moeten terug brengen naar standaard instellingen or maken wat je kapot hebt gemaakt.",
     
    // Missies
    "Het maximale aantal missies is 0. Je wilt wel missies, toch?",
    "Er kan maar een missie handelaar draaien per keer. Missie lus afsluiten.",
    "Er is niemand in de server en ZFM_MISSIONS_START_WHILE_SERVER_EMPTY staat op FALSE. Wachten tot er spelers zich in de server bevinden."
];
 
// Module-specifieke taal strings
 
ZFM_CRASH_MISSION_OTWT =[
 
];
 
ZFM_CRASH_MISSION_OTWT_PLACE =[
 
];
 
ZFM_CRASH_MISSION_OTWT_ACTION =[
 
];
ZFM_CRASH_MISSION_OTWT_CONSEQUENCE =[
"Het lijkt er op dat",
"Blijkbaar",
"Helaas Pindakaas,",
"Jammer genoeg,",
"KUT! Het lijkt er op dat",
"O kut,",
"Jeetje mineetje,",
"Mijn god,"
];
 
// Double formatting to replace a wildcard replaced by a wildcard.. ;-)
ZFM_CRASH_MISSION_OTWT_CONSEQUENCE_CONCLUSION =[
"%1 heeft controle genomen over het gebied.",
"%1 verschuilen zich in het gebied.",
"%1 patrouilleren dichtbij.",
"%1 hebben een orgie in de nabije omgeving.",
"%1 hebben scherschutterposities ingenomen in de omgeving.",
"%1 verstoppen zich in de omgeving",
"%1 hebben defensieve plekken ingenomen.",
"%1 zijn in controle.",
"%1 zijn de baas.",
"%1 zijn nu de ekte ekte bazen in de stad jwz."
];
 
 
ZFM_CRASH_MISSION_OTWT_BG_NAMES_HERO =[
"Mijn heldengroep naam",
];
ZFM_CRASH_MISSION_OTWT_BG_NAMES_BANDIT =[
"Mijn bandietengroep naam"
];