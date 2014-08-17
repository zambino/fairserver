/*
	ZFSS - Zambino's FairServer System v0.5
	A DayZ epoch script to limit the impact of assholes on servers.  Very loosely based on the "Safezone commander" script by AlienX.
	Copyright (C) 2014 Jordan Ashley Craw

	This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
 */

 /*
*	ZFM_Layouts_Array
*	
*	Used for spawning layouts for bases automatically.
*	Each item = Array =
*	0 = classname
*	1 = orientation
*	2 = parameters (i.e. for vehicles, their contents)
*/
ZFM_Layouts_Crap_To_Clear =[
	"b_corylus2s.p3d",
	"b_craet1.p3d",
	"r2_boulder1.p3d",
	"r2_boulder2.p3d",
	"t_picea2s_snow.p3d",
	"b_corylus.p3d",
	"t_quercus3s.p3d",
	"t_larix3s.p3d",
	"t_pyrus2s.p3d",
	"str_briza_kriva.p3d",
	"dd_borovice.p3d",
	"les_singlestrom_b.p3d",
	"les_singlestrom.p3d",
	"smrk_velky.p3d",
	"smrk_siroky.p3d",
	"smrk_maly.p3d",
	"les_buk.p3d",
	"str krovisko vysoke.p3d",
	"str_fikovnik_ker.p3d",
	"str_fikovnik.p3d",
	"str vrba.p3d",
	"hrusen2.p3d",
	"str dub jiny.p3d",
	"str lipa.p3d",
	"str briza.p3d",
	"p_akat02s.p3d",
	"jablon.p3d",
	"p_buk.p3d",
	"str_topol.p3d",
	"str_topol2.p3d",
	"p_osika.p3d",
	"t_picea3f.p3d",
	"t_picea2s.p3d",
	"t_picea1s.p3d",
	"t_fagus2w.p3d",
	"t_fagus2s.p3d",
	"t_fagus2f.p3d",
	"t_betula1f.p3d",
	"t_betula2f.p3d",
	"t_betula2s.p3d",
	"t_betula2w.p3d",
	"t_alnus2s.p3d",
	"t_acer2s.p3d",
	"t_populus3s.p3d",
	"t_quercus2f.p3d",
	"t_sorbus2s.p3d",
	"t_malus1s.p3d",
	"t_salix2s.p3d",
	"t_picea1s_w.p3d",
	"t_picea2s_w.p3d",
	"t_ficusb2s_ep1.p3d",
	"t_populusb2s_ep1.p3d",
	"t_populusf2s_ep1.p3d",
	"t_amygdalusc2s_ep1.p3d",
	"t_pistacial2s_ep1.p3d",
	"t_pinuse2s_ep1.p3d",
	"t_pinuss3s_ep1.p3d",
	"t_prunuss2s_ep1.p3d",
	"t_pinusn2s.p3d",
	"t_pinusn1s.p3d",
	"t_pinuss2f.p3d",
	"t_poplar2f_dead_pmc.p3d",
	"misc_torzotree_pmc.p3d",
	"misc_burnspruce_pmc.p3d",
	"brg_cocunutpalm8.p3d",
	"brg_umbrella_acacia01b.p3d",
	"brg_jungle_tree_canopy_1.p3d",
	"brg_jungle_tree_canopy_2.p3d",
	"brg_cocunutpalm4.p3d",
	"brg_cocunutpalm3.p3d",
	"palm_01.p3d",
	"palm_02.p3d",
	"palm_03.p3d",
	"palm_04.p3d",
	"palm_09.p3d",
	"palm_10.p3d",
	"brg_cocunutpalm2.p3d",
	"brg_jungle_tree_antiaris.p3d",
	"brg_cocunutpalm1.p3d",
	"str habr.p3d"
];
  
/*
*	Config entities for layouts.
*/ 
ZFM_LAYOUT_OBJECT_UNIT_CLASS = "Lx101010";  
ZFM_LAYOUT_OBJECT_UNIT_GROUP = "Lx101011";  
ZFM_LAYOUT_OBJECT_LOOT = "Lx101012";  
 
  