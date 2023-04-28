/*/
File: QS_data_virtualCargoPresets.sqf
Author:

	Quiksilver
	
Last modified:

	23/04/2023 A3 2.12 by Quiksilver
	
Description:

	Virtual Cargo Presets
	
	[[_childType,_simpleObject,_damageAllowed,_simulationEnabled,_boundingRadius,_damage],0];
	
Notes:

	[
		'roadcone_f',		// classname
		0,					// 1 = simple object
		0,					// 1 = damage allowed
		1,					// 1 = simulation enabled
		4.83166,			// bounding radius
		0					// current damage
	]
________________________________________/*/

params ['_preset'];
_platformType = ['cargoplaftorm_01_brown_f','cargoplaftorm_01_jungle_f'] select (worldName in ['Tanoa','Enoch']);
_cargoType = [3,4] select (worldName in ['Tanoa','Enoch']);
if (_preset isEqualTo 0) exitWith {

};
if (_preset isEqualTo 1) exitWith {

};
if (_preset isEqualTo 3) exitWith {

};
if (_preset isEqualTo 4) exitWith {
	comment 'Patrol Base (small fort)';
	[
		[['land_hbarrier_big_f',1,0,0,4.83166,0],								5],
		[['land_hbarrier_5_f',1,0,0,3.12525,0],									5],
		[['land_hbarrier_3_f',1,0,0,2.12603,0],									5],
		[['land_bagfence_long_f',1,0,0,1.61456,0],								3],
		[['land_bagfence_round_f',1,0,0,1.50183,0],								3],
		[['land_bagfence_short_f',1,0,0,1.07522,0],								3],
		[['land_obstacle_ramp_f',1,0,0,2.26086,0],								2],
		[['land_portablelight_02_double_yellow_f',0,0,1,3,0],					1],
		[[format ['land_cargo_patrol_v%1_f',_cargoType],0,0,1,8.13845,0],		1],
		[['camonet_blufor_open_f',1,0,0,11.1545,0],								1],
		[[_platformType,0,0,1,4.83166,0],										1],
		[['b_g_hmg_02_high_f',0,0,1,11.1545,0],									1]
	]
};
if (_preset isEqualTo 5) exitWith {
	comment 'Combat Outpost (medium fort)';
	[
		[['land_hbarrier_big_f',1,0,0,4.83166,0],								7],
		[['land_hbarrier_5_f',1,0,0,3.12525,0],									7],
		[['land_hbarrier_3_f',1,0,0,2.12603,0],									5],
		[['land_sandbagbarricade_01_half_f',1,0,0,2.3,0],						5],
		[['land_sandbagbarricade_01_hole_f',1,0,0,2.5,0],						2],
		[['land_bagfence_long_f',1,0,0,1.61456,0],								3],
		[['land_bagfence_round_f',1,0,0,1.50183,0],								3],
		[['land_bagfence_short_f',1,0,0,1.07522,0],								3],
		[['land_obstacle_ramp_f',1,0,0,2.26086,0],								2],
		[['land_mil_wallbig_4m_f',1,0,0,4,0],									4],
		[['land_portablelight_02_double_yellow_f',0,0,1,3,0],					2],
		[[format ['land_cargo_patrol_v%1_f',_cargoType],0,0,1,8.13845,0],		2],
		[[format ['land_cargo_house_v%1_f',_cargoType],0,0,1,6.5,0],			1],
		[['camonet_blufor_open_f',1,0,0,11.1545,0],								1],
		[[_platformType,0,0,1,4.83166,0],										3],
		[['flagpole_f',0,0,1,4,0],												1],
		[['b_g_hmg_02_high_f',0,0,1,11.1545,0],									2]
	]
};
if (_preset isEqualTo 6) exitWith {
	comment 'FOB (large fort)';
	[
		[['land_hbarrier_big_f',1,0,0,4.83166,0],								15],
		[['land_hbarrier_5_f',1,0,0,3.12525,0],									10],
		[['land_hbarrier_3_f',1,0,0,2.12603,0],									5],
		[['land_sandbagbarricade_01_half_f',1,0,0,2.3,0],						10],
		[['land_sandbagbarricade_01_hole_f',1,0,0,2.5,0],						7],
		[['land_bagfence_long_f',1,0,0,1.61456,0],								5],
		[['land_bagfence_round_f',1,0,0,1.50183,0],								5],
		[['land_bagfence_short_f',1,0,0,1.07522,0],								5],
		[['land_obstacle_ramp_f',1,0,0,2.26086,0],								4],
		[['land_mil_wallbig_4m_f',1,0,0,4,0],									8],
		[['land_helipadcircle_f',1,0,0,7,0],									1],
		[['land_lamphalogen_f',0,0,1,5,0],										4],
		[['land_portablelight_02_quad_yellow_f',0,0,1,3,0],						4],
		[[format ['land_cargo_hq_v%1_f',_cargoType],0,0,1,15,0],				1],
		[[format ['land_cargo_patrol_v%1_f',_cargoType],0,0,1,8.13845,0],		4],
		[[format ['land_cargo_house_v%1_f',_cargoType],0,0,1,6.5,0],			2],
		[['camonet_blufor_open_f',1,0,0,11.1545,0],								2],
		[[_platformType,0,0,1,4.83166,0],										6],
		[['flagpole_f',0,0,1,4,0],												1],
		[['b_g_hmg_02_high_f',0,0,1,11.1545,0],									3],
		[['i_e_gmg_01_high_f',0,0,1,11.1545,0],									1],
		[['b_supplycrate_f',1,0,0,2,0],											1]		// Arsenal
	]
};
if (_preset isEqualTo 7) exitWith {
	comment 'platform/bridging kit';
	[
		[[_platformType,0,0,1,4.83166,0],					16],
		[['land_pierladder_f',0,0,1,4,0],					2]
	]
};
if (_preset isEqualTo 8) exitWith {
	[
		[['sign_arrow_yellow_f',1,0,0,4.83166,0],					10]
	]
};
if (_preset isEqualTo 9) exitWith {
	[
		[['roadcone_f',0,0,1,4.83166,0],					3]
	]
};
if (_preset isEqualTo 10) exitWith {
	[
		[['roadcone_f',0,0,1,4.83166,0],						6],
		[['roadbarrier_f',0,0,1,4.83166,0],						3],
		[['land_portablelight_02_double_yellow_f',0,0,1,3,0],	1]
	]
};
[]