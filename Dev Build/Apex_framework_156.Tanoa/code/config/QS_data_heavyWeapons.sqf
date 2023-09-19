/*
File: QS_data_heavyWeapons.sqf
Author:

	Quiksilver
	
Last modified:

	28/10/2022 A3 2.10 by Quiksilver
	
Description:

	A list of weapons that players should be discouraged from firing unsupported.
	
	For instance, heavy Sniper rifles and Medium Machine Guns.
	
	Reducing the ability of player to fire these weapons unsupported from the standing position. 
	
	Creates Role space for Light Machine Gun classes and Marksman classes.
	
	Vanilla allows players to "run & gun" with heavy sniper and heavy machine guns, especially if Stamina is disabled.
	
	By doing this, we can have Stamina disabled while still making it difficult to fire these weapons from unsupported position.
___________________________________*/

[
	'srifle_lrr_f','srifle_lrr_lrps_f','srifle_lrr_sos_f','srifle_lrr_camo_f','srifle_lrr_camo_lrps_f','srifle_lrr_camo_sos_f','srifle_lrr_tna_f','srifle_lrr_tna_lrps_f',		// LRR
	'srifle_gm6_camo_f','srifle_gm6_camo_lrps_f','srifle_gm6_camo_sos_f','srifle_gm6_ghex_f','srifle_gm6_ghex_lrps_f','srifle_gm6_f','srifle_gm6_lrps_f','srifle_gm6_sos_f',	// GM6
	'mmg_01_base_f','mmg_01_hex_arco_lp_f','mmg_01_hex_f','mmg_01_tan_f',																										// Navid
	'mmg_02_base_f','mmg_02_black_f','mmg_02_black_rco_bi_f','mmg_02_camo_f','mmg_02_sand_f','mmg_02_sand_rco_lp_f'																// MMG
]