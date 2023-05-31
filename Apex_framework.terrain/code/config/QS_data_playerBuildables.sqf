/*/
File: QS_data_playerBuildables.sqf
Author:

	Quiksilver
	
Last modified:

	23/02/2023 A3 2.12 by Quiksilver
	
Description:

	Objects buildable by players without logistic support
	
Notes:

	ONLY PROPS ARE SUPPORTED AT THIS TIME, (NO AMMO CRATES,VEHICLES,ETC)
________________________________________/*/

[
	[1,'land_bagfence_long_f',1,{(!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Altis','Stratis','Malden'])}],
	[1,'land_bagfence_round_f',1,{(!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Altis','Stratis','Malden'])}],
	[1,'land_bagfence_short_f',1,{(!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Altis','Stratis','Malden'])}],
	[0.5,'land_bagfence_corner_f',1,{(!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Altis','Stratis','Malden'])}],
	[0.5,'land_bagfence_01_corner_green_f',1,{(!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Tanoa','Enoch'])}],
	[1,'land_bagfence_01_short_green_f',1,{(!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Tanoa','Enoch'])}],
	[1,'land_bagfence_01_round_green_f',1,{(!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Tanoa','Enoch'])}],
	[1,'land_bagfence_01_long_green_f',1,{(!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Tanoa','Enoch'])}],
	[2.5,'land_sandbagbarricade_01_half_f',1,{QS_player getUnitTrait 'engineer'}],
	[3.5,'land_sandbagbarricade_01_f',1,{QS_player getUnitTrait 'engineer'}],
	[4,'land_sandbagbarricade_01_hole_f',1,{QS_player getUnitTrait 'engineer'}],
	//[1,'land_woodenwindbreak_01_f',1,{QS_player getUnitTrait 'engineer'}],
	[3,'land_hbarrier_3_f',1,{FALSE && ((!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Altis','Stratis','Malden']))}],
	[5,'land_hbarrier_5_f',1,{FALSE && ((!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Altis','Stratis','Malden']))}],
	[8,'land_hbarrier_big_f',1,{FALSE && ((!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Altis','Stratis','Malden']))}],
	[2,'land_hbarrier_1_f',1,{FALSE && ((!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Altis','Stratis','Malden']))}],
	[2,'land_hbarrier_01_line_1_green_f',1,{FALSE && ((!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Tanoa','Enoch']))}],
	[3,'land_hbarrier_01_line_3_green_f',1,{FALSE && ((!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Tanoa','Enoch']))}],
	[5,'land_hbarrier_01_line_5_green_f',1,{FALSE && ((!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Tanoa','Enoch']))}],
	[8,'land_hbarrier_01_big_4_green_f',1,{FALSE && ((!(worldName in ['Altis','Stratis','Malden','Tanoa','Enoch'])) || (worldName in ['Tanoa','Enoch']))}],
	[1,'land_obstacle_ramp_f',1,{(QS_player getUnitTrait 'engineer')}],
	//[1,'land_obstacle_climb_f',2,{(QS_player getUnitTrait 'engineer')}],
	[1,'land_slumwall_01_s_2m_f',1,{(QS_player getUnitTrait 'engineer') && (((position QS_player) getEnvSoundController 'houses') > 0)}],
	//[2,'land_slumwall_01_s_4m_f',2,{(QS_player getUnitTrait 'engineer')}],
	//[1,'land_pierladder_f',2,{(QS_player getUnitTrait 'engineer')}],
	[3,'land_portablelight_02_single_folded_yellow_f',2,{(QS_player getUnitTrait 'engineer')}]
]