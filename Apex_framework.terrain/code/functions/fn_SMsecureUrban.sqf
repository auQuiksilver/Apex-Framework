/*
File: secureUrban.sqf
Author:

	Quiksilver
	
Last Modified:

	25/06/2016 A3 1.62 by Quiksilver
	
Description:

	Secure 3 weapons crates in a town
_________________________________________________________________________________________*/

scriptName 'Side Mission - Secure Urban Caches';
private [
	'_QS_locationsUrban','_QS_urbanEnemyUnits','_QS_civilianTypes','_QS_approvedBuildingTypes','_QS_civVehicleArrayRsc','_QS_locationSelect','_QS_locationCenterPos',
	'_QS_locationCenterName','_QS_buildingList','_QS_roadArrayRsc','_QS_flatEmptyPos','_QS_tempRoadPos','_QS_roadConnectedTo','_QS_connectedRoad','_QS_roadDir',
	'_QS_vType','_QS_v','_QS_allArray','_QS_building','_QS_targetBuildings','_index','_QS_buildingPositions','_QS_obj1BP','_QS_obj2BP','_QS_obj3BP','_QS_buildingPositions1',
	'_QS_buildingPositions2','_QS_buildingPositions3','_QS_object1','_QS_object2','_QS_object3','_QS_objectArray','_QS_objectType','_QS_eastGrp','_QS_unitType','_QS_pos',
	'_QS_enemyArray','_QS_objectTypes','_QS_garrisonGrp','_QS_allBuildingPositions','_QS_buildingPos','_QS_inBuildingCount','_QS_garrisonCount','_QS_civilianCount',
	'_QS_patrolCount','_wp1Pos','_wp2Pos','_wp3Pos','_wp4Pos','_QS_WP','_QS_patrolGroup','_QS_route','_QS_civilianGroup','_QS_spawnPos','_QS_unit','_QS_checkEnemyDelay',
	'_QS_enemyDetected','_QS_BADGUY','_QS_dirTo','_QS_enemyDetected_endTime','_QS_firstDetected','_QS_positionAccepted','_QS_clearPos','_QS_qrfGroup','_markerStoragePos',
	'_markers','_QS_urbanTimerBroadcast_delay','_box1_secured','_box2_secured','_box3_secured','_QS_attackPos','_grp','_safePos','_QS_building_position','_QS_buildingList_pre'
];
_box1_secured = FALSE;
_box2_secured = FALSE;
_box3_secured = FALSE;
_QS_allArray = [];
_QS_v = objNull;
_QS_targetBuildings = [];
_QS_building = objNull;
_QS_obj1BP = [0,0,0];
_QS_obj2BP = [0,0,0];
_QS_obj3BP = [0,0,0];
_QS_objectArray = [];
_QS_objectTypes = ['Land_PlasticCase_01_small_F','Land_PlasticCase_01_medium_F','Land_PlasticCase_01_large_F'];
_QS_objectType = '';
_QS_unitType = '';
_QS_enemyArray = [];
_QS_allBuildingPositions = [];
_QS_playerCount = count allPlayers;
if (_QS_playerCount > -1) then {
	_QS_inBuildingCount = 4;
	_QS_garrisonCount = 10;
	_QS_patrolCount = 1;
	_QS_civilianCount = 6;
};
if (_QS_playerCount > 10) then {
	_QS_inBuildingCount = 4;
	_QS_garrisonCount = 12;
	_QS_patrolCount = 2;
	_QS_civilianCount = 7;
};
if (_QS_playerCount > 20) then {
	_QS_inBuildingCount = 4;
	_QS_garrisonCount = 14;
	_QS_patrolCount = 3;
	_QS_civilianCount = 8;
};
if (_QS_playerCount > 30) then {
	_QS_inBuildingCount = 4;
	_QS_garrisonCount = 16;
	_QS_patrolCount = 4;
	_QS_civilianCount = 9;		
};
if (_QS_playerCount > 40) then {
	_QS_inBuildingCount = 5;
	_QS_garrisonCount = 18;
	_QS_patrolCount = 7;
	_QS_civilianCount = 15;
};
_QS_locationsUrban = [];
if (worldName isEqualTo 'Altis') then {
	if ((random 1) > 0.666) then {
		_QS_locationsUrban = [
			[[16815.7,12713.1,0.00153923],'Pyrgos'],
			[[3545.59,12876.3,0.00159645],'Kavala'],
			[[3570.33,13216.9,0.00135326],'Kavala'],
			[[3745.62,13523.4,0.00136662],'Aggelochori']
		];
	} else {
		_QS_locationsUrban = [
			[[27045,23253.2,0.00144577],'Molos'],
			[[25691.3,21341.1,0.00152779],'Sofia'],
			[[20943.3,16946.3,0.001297],'Paros'],
			[[21344.4,16363.6,0.00137901],'Kalochori'],
			[[18807.7,16617.3,0.0011158],'Rodopoli'],
			[[18110.7,15240,0.00145912],'Charkia'],
			[[19403.9,13248.8,0.00131607],'Dorida'],
			[[16815.7,12713.1,0.00153923],'Pyrgos'],
			[[20263.4,11697.5,0.00170517],'Chalkeia'],
			[[20545.7,8887.54,0.00150681],'Panagia'],
			[[21694.1,7598.99,0.00143719],'Feres'],
			[[20792.2,6742.76,0.00128174],'Selakano'],
			[[9053.03,11992.1,0.00123405],'Zaros'],
			[[5083.8,11269.1,0.00134659],'Panochori'],
			[[4137.55,11738.4,0.00159454],'Neri'],
			[[4896.54,16145.4,0.00138092],'Negades'],
			[[4582.15,21385.3,0.00143433],'Oreokastro'],
			[[7115.64,16438.3,0.00151062],'Kore'],
			[[21820.2,21017.5,0.00152969],'Ghost Hotel'],
			[[8628.46,18285.3,0.00126648],'Syrta'],
			[[9289.68,15860.5,0.00139618],'Agios Dionysios'],
			[[11132.6,14564.5,0.00153732],'Alikampos'],
			[[10938.4,13448.7,0.00143051],'Poliakko'],
			[[10659.8,12248.4,0.00145149],'Therisa'],
			[[12574,14355.5,0.001544],'Neochori'],
			[[14587,20797.1,0.00150299],'Frini'],
			[[3926.72,17280.1,0.00147152],'Agios Konstantinos'],
			[[21820.2,21017.5,0.00152969],'Ghost Hotel']
		];
	};
};
if (worldName isEqualTo 'Tanoa') then {
	_QS_locationsUrban = [
		[[3835.71,13937.2,0.00147247],""],
		[[1804.05,11985.5,0.00139904],""],
		[[3070.42,11130.2,0.0014267],""],
		[[5711.28,10112.5,0.00134039],""],
		[[5822.39,10493.6,0.00141716],""],
		[[6190.7,10251,0.00141144],""],
		[[2647.52,9298.66,0.0016818],"Sosovu"],
		[[706.218,11263.3,0.00135899],""],
		[[1593.6,8490.57,0.00161314],"Muaceba"],
		[[2358.57,8193.74,0.00143909],"Leqa"],
		[[2558.7,7379.02,0.00144291],""],
		[[954.714,7687.94,0.00143886],"Tavu"],
		[[3438.49,6729.4,0.00195313],""],
		[[1719.82,6126.92,0.0015955],""],
		[[2787.07,5714.25,0.00140142],"Namuvaka"],
		[[7174.35,4270.05,0.00161338],"Savaka"],
		[[5477.41,4053.45,0.0014267],""],
		[[3644.85,2180.54,0.00159454],""],
		[[1523.13,3014.39,0.00132847],""],
		[[9386.09,4033.87,0.00143099],""],
		[[8873.91,3646.92,0.00164318],""],
		[[10336.8,2667.68,0.00143886],""],
		[[11635.7,2809.52,0.00122118],""],
		[[12988,2122.54,0.0013597],""],
		[[11507.9,2421.26,0.00146079],""],
		[[10185.2,5015.5,0.00124979],""],
		[[11234.6,5230.09,0.00143886],""],
		[[12803,4779.65,0.00143886],"Doodstil"],
		[[13322.9,2968.59,0.000923157],""],
		[[12312.8,1846.36,0.00130463],""],
		[[10854.5,6304.85,0.00143147],""],
		[[7928.13,7754.23,0.00137758],""],
		[[7258.91,8005.59,0.00143886],"Lifou"],
		[[5060.15,8634.61,0.00144863],""],
		[[5393.14,8767.79,0.0014739],""],
		[[5781.36,11209.4,0.00144386],"Saint-Julien"],
		[[5753.33,12577.5,0.00151587],""],
		[[6419.53,12806.2,0.00143123],""],
		[[6854.86,13352.5,0.00119734],""],
		[[7911.27,13510.5,0.00142193],""],
		[[8413.7,13677.1,0.000969887],""],
		[[9513.94,13382.9,0.00125408],""],
		[[10963.6,13228,0.00133801],""],
		[[11369.6,12335.3,0.00131989],""],
		[[11049.2,9815.75,0.00144958],""],
		[[14285.7,11618,0.00154829],""],
		[[14418,8892.59,0.00158453],""],
		[[13934,8375.15,0.00160646],""],
		[[12826.5,7440.6,0.00147581],""],
		[[8848.02,10220,0.00134659],""],
		[[8264.82,11119.2,0.0018158],""],
		[[11174.1,14380.7,0.00142932],""],
		[[12275.1,13970.7,0.00143909],""],
		[[12434.7,14231.3,0.00154877],""],
		[[13142.1,13780.6,0.00154161],""],
		[[6173.41,8635.02,0.00165176],""],
		[[8166.03,9766.41,0.00147152],""]
	];
};

if (worldName isEqualTo 'Malden') then {
	_QS_locationsUrban = [
		[[5556.07,11190.1,0.00144196],""],
		[[6009.42,8635.96,0.00144196],""],
		[[7133.01,8967.3,0.00144196],""],
		[[7268.67,7929.93,0.00141907],""],
		[[7042.14,7130.72,0.00144958],""],
		[[5542.62,7017.51,0.00143433],""],
		[[3584.93,8513.97,0.00143433],""],
		[[3109.86,6335.95,0.00143433],""],
		[[7121.4,6069.8,0.00144958],""],
		[[5558.85,4232.48,0.00144958],""],
		[[3726.6,3259.39,0.00144386],""],
		[[5407.72,2797.74,0.00141525],""],
		[[5853.02,3523.48,0.00143814],""],
		[[8208.08,3157.17,0.00145531],""]
	];
};
if (worldName isEqualTo 'Enoch') then {
	_QS_locationsUrban = [
		[[3682.06,11815.2,0.00144958],""],
		[[1392.82,9691.77,0.00149536],""],
		[[4998.03,9953.58,0.00149155],""],
		[[6481.91,11269.7,0.00144482],""],
		[[1866.89,7364.82,0.00138092],""],
		[[3125.47,6820.26,0.0014534],""],
		[[4036.04,7943.7,0.00145721],""],
		[[865.074,5509.75,0.00141907],""],
		[[4558.2,6423.24,0.00141907],""],
		[[4799.16,7569.35,0.00126648],""],
		[[6051.08,8179.25,0.00148773],""],
		[[6305.7,10183.8,0.00143814],""],
		[[8120,8730.02,0.00144196],""],
		[[9274.04,10886.9,0.00143814],""],
		[[8420.9,12020.3,0.00139666],""],
		[[10681.8,10985.2,0.00155544],""],
		[[11419.1,9613.33,0.00145626],""],
		[[9828.27,8501.86,0.00118637],""],
		[[5942.96,6817.91,0.00165558],""],
		[[5231.64,5581.69,0.00143433],""],
		[[7314.85,6351.98,0.00144958],""],
		[[8513.57,6806.43,0.00139618],""],
		[[10298.4,6802.31,0.00151062],""],
		[[1159.42,7254.45,0.00143814],""],
		[[7379.64,2628.73,0.00144196],""],
		[[11361.8,627.466,0.00143051],""],
		[[11086.2,4278.94,0.00143433],""],
		[[11560.2,4668.16,0.00143433],""],
		[[7692.92,5283.55,0.00143433],""],
		[[6097.49,4136.39,0.00151062],""],
		[[3281,2061.02,0.00146484],""]
	];
};

if (_QS_locationsUrban isEqualTo []) exitWith {diag_log '***** fn_secureUrban ***** No valid locations *****';};
_QS_approvedBuildingTypes = [
	'Land_i_House_Small_03_V1_F',
	'Land_u_House_Big_02_V1_F',
	'Land_i_House_Big_02_V3_F',
	'Land_i_House_Big_02_V1_F',
	'Land_i_House_Big_02_V2_F',
	'Land_u_House_Big_01_V1_F',
	'Land_i_House_Big_01_V3_F',
	'Land_i_House_Big_01_V1_F',
	'Land_i_House_Big_01_V2_F',
	'Land_u_Shop_02_V1_F',
	'Land_i_Shop_02_V3_F',
	'Land_i_Shop_02_V1_F',
	'Land_i_Shop_02_V2_F',
	'Land_u_Shop_01_V1_F',
	'Land_i_Shop_01_V3_F',
	'Land_i_Shop_01_V1_F',
	'Land_i_Shop_01_V2_F',
	'Land_u_House_Small_01_V1_F',
	'Land_u_House_Small_02_V1_F',
	'Land_i_House_Small_02_V3_F',
	'Land_i_House_Small_02_V1_F',
	'Land_i_House_Small_02_V2_F',
	'Land_i_House_Small_01_V3_F',
	'Land_i_House_Small_01_V1_F',
	'Land_i_House_Small_01_V2_F',
	'Land_i_Stone_HouseBig_V3_F',
	'Land_i_Stone_HouseBig_V1_F',
	'Land_i_Stone_HouseBig_V2_F',
	'Land_i_Stone_HouseSmall_V3_F',
	'Land_i_Stone_HouseSmall_V1_F',
	'Land_i_Stone_Shed_V2_F',
	'Land_i_Stone_Shed_V1_F',
	'Land_i_Stone_Shed_V3_F',
	'Land_i_Stone_HouseSmall_V2_F',
	'Land_i_House_Big_02_b_blue_F',
	'Land_i_House_Big_02_b_pink_F',
	'Land_i_House_Big_02_b_whiteblue_F',
	'Land_i_House_Big_02_b_white_F',
	'Land_i_House_Big_02_b_brown_F',
	'Land_i_House_Big_02_b_yellow_F',
	'Land_i_House_Big_01_b_blue_F',
	'Land_i_House_Big_01_b_pink_F',
	'Land_i_House_Big_01_b_whiteblue_F',
	'Land_i_House_Big_01_b_white_F',
	'Land_i_House_Big_01_b_brown_F',
	'Land_i_House_Big_01_b_yellow_F',
	'Land_i_Shop_02_b_blue_F',
	'Land_i_Shop_02_b_pink_F',
	'Land_i_Shop_02_b_whiteblue_F',
	'Land_i_Shop_02_b_white_F',
	'Land_i_Shop_02_b_brown_F',
	'Land_i_Shop_02_b_yellow_F',
	'Land_Barn_01_brown_F',
	'Land_Barn_01_grey_F',
	'Land_i_House_Small_01_b_blue_F',
	'Land_i_House_Small_01_b_pink_F',
	'Land_i_House_Small_02_b_blue_F',
	'Land_i_House_Small_02_b_pink_F',
	'Land_i_House_Small_02_b_whiteblue_F',
	'Land_i_House_Small_02_b_white_F',
	'Land_i_House_Small_02_b_brown_F',
	'Land_i_House_Small_02_b_yellow_F',
	'Land_i_House_Small_02_c_blue_F',
	'Land_i_House_Small_02_c_pink_F',
	'Land_i_House_Small_02_c_whiteblue_F',
	'Land_i_House_Small_02_c_white_F',
	'Land_i_House_Small_02_c_brown_F',
	'Land_i_House_Small_02_c_yellow_F',
	'Land_i_House_Small_01_b_whiteblue_F',
	'Land_i_House_Small_01_b_white_F',
	'Land_i_House_Small_01_b_brown_F',
	'Land_i_House_Small_01_b_yellow_F',
	'Land_i_Stone_House_Big_01_b_clay_F',
	'Land_i_Stone_Shed_01_b_clay_F',
	'Land_i_Stone_Shed_01_b_raw_F',
	'Land_i_Stone_Shed_01_b_white_F',
	'Land_i_Stone_Shed_01_c_clay_F',
	'Land_i_Stone_Shed_01_c_raw_F',
	'Land_i_Stone_Shed_01_c_white_F',
	'Land_House_Big_04_F',
	'Land_House_Small_04_F',
	'Land_House_Small_05_F',
	'Land_Addon_04_F',
	'Land_House_Big_03_F',
	'Land_House_Small_02_F',
	'Land_House_Big_02_F',
	'Land_House_Small_03_F',
	'Land_House_Small_06_F',
	'Land_House_Big_01_F',
	'Land_Slum_02_F',
	'Land_Slum_01_F',
	'Land_GarageShelter_01_F',
	'Land_House_Small_01_F',
	'Land_Slum_03_F',
	'Land_Temple_Native_01_F',
	'Land_House_Native_02_F',
	'Land_House_Native_01_F',
	'Land_GH_House_1_F',
	'Land_GH_House_2_F',
	'Land_GH_MainBuilding_entry_F',
	'Land_GH_MainBuilding_right_F',
	'Land_GH_MainBuilding_left_F',
	'Land_GH_Gazebo_F',
	'Land_Barn_02_F',
	'Land_Barn_04_F',
	'Land_Barn_03_large_F',
	'Land_Barn_03_small_F',
	'Land_Cowshed_01_A_F',
	'Land_Cowshed_01_B_F',
	'Land_Cowshed_01_C_F',
	'Land_CementWorks_01_brick_F',
	'Land_CementWorks_01_grey_F',
	'Land_CoalPlant_01_MainBuilding_F',
	'Land_Factory_02_F',
	'Land_GarageRow_01_large_F',
	'Land_GarageRow_01_small_F',
	'Land_GarageOffice_01_F',
	'Land_IndustrialShed_01_F',
	'Land_i_Shed_Ind_old_F',
	'Land_Workshop_05_F',
	'Land_Workshop_05_grey_F',
	'Land_Workshop_03_grey_F',
	'Land_Workshop_04_grey_F',
	'Land_Workshop_01_grey_F',
	'Land_Workshop_02_grey_F',
	'Land_Workshop_01_F',
	'Land_Workshop_02_F',
	'Land_Barracks_06_F',
	'Land_Barracks_02_F',
	'Land_Barracks_03_F',
	'Land_Barracks_04_F',
	'Land_Barracks_05_F',
	'Land_GuardHouse_02_F',
	'Land_GuardHouse_03_F',
	'Land_GuardHouse_02_grey_F',
	'Land_Radar_01_HQ_F',
	'Land_Radar_01_kitchen_F',
	'Land_Rail_Station_Big_F',
	'Land_Rail_Warehouse_Small_F',
	'Land_Church_04_lightblue_F',
	'Land_Church_04_lightblue_damaged_F',
	'Land_Church_04_small_lightblue_F',
	'Land_Church_04_small_lightblue_damaged_F',
	'Land_Church_04_lightyellow_F',
	'Land_Church_04_lightyellow_damaged_F',
	'Land_Church_04_small_lightyellow_F',
	'Land_Church_04_small_lightyellow_damaged_F',
	'Land_Church_04_red_F',
	'Land_Church_04_red_damaged_F',
	'Land_Church_04_small_red_F',
	'Land_Church_04_small_red_damaged_F',
	'Land_Church_04_white_red_F',
	'Land_Church_04_white_red_damaged_F',
	'Land_Church_04_small_white_red_F',
	'Land_Church_04_small_white_red_damaged_F',
	'Land_Church_04_white_F',
	'Land_Church_04_white_damaged_F',
	'Land_Church_04_small_white_F',
	'Land_Church_04_small_white_damaged_F',
	'Land_Church_04_yellow_F',
	'Land_Church_04_yellow_damaged_F',
	'Land_Church_04_small_yellow_F',
	'Land_Church_04_small_yellow_damaged_F',
	'Land_OrthodoxChurch_02_F',
	'Land_OrthodoxChurch_03_F',
	'Land_Church_05_F',
	'Land_FuelStation_03_shop_F',
	'Land_PowerStation_01_F',
	'Land_House_1B01_F',
	'Land_House_2B01_F',
	'Land_House_2B02_F',
	'Land_House_2B03_F',
	'Land_House_2B04_F',
	'Land_Camp_House_01_brown_F',
	'Land_VillageStore_01_F',
	'Land_HealthCenter_01_F',
	'Land_Shed_13_F',
	'Land_PoliceStation_01_F',
	'Land_House_1W01_F',
	'Land_House_1W10_F',
	'Land_House_1W11_F',
	'Land_House_1W12_F',
	'Land_House_1W13_F',
	'Land_House_1W02_F',
	'Land_House_1W03_F',
	'Land_House_1W04_F',
	'Land_House_1W05_F',
	'Land_House_1W06_F',
	'Land_House_1W07_F',
	'Land_House_1W08_F',
	'Land_House_1W09_F',
	'Land_House_2W01_F',
	'Land_House_2W02_F',
	'Land_House_2W03_F',
	'Land_House_2W04_F',
	'Land_House_2W05_F',
	'Land_Shed_14_F',
	'Land_Shed_10_F'
];
_QS_urbanEnemyUnits = [
	'O_soldierU_A_F','O_soldierU_AAR_F','O_soldierU_AR_F','O_soldierU_medic_F','O_engineer_U_F','O_soldierU_exp_F','O_SoldierU_GL_F',
	'O_Urban_HeavyGunner_F','O_soldierU_M_F','O_soldierU_AA_F','O_soldierU_AT_F','O_soldierU_F','O_soldierU_LAT_F','O_Urban_Sharpshooter_F',
	'O_SoldierU_SL_F','O_soldierU_TL_F'
];
_QS_civilianTypes = [
	"C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F",
	"C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_p_shorts_1_F",
	"C_man_hunter_1_F","C_man_w_worker_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_p_beggar_F_afro",
	"C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro",
	"C_man_polo_6_F_afro","C_man_shorts_1_F_afro","C_man_p_shorts_1_F_afro","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro",
	"C_man_shorts_4_F_afro","C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F",
	"C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_shorts_1_F",
	"C_man_hunter_1_F","C_man_p_beggar_F_asia","C_man_polo_1_F_asia","C_man_polo_2_F_asia","C_man_polo_3_F_asia",
	"C_man_polo_4_F_asia","C_man_polo_5_F_asia","C_man_polo_6_F_asia","C_man_shorts_1_F_asia","C_man_p_shorts_1_F_asia",
	"C_man_shorts_2_F_asia","C_man_shorts_3_F_asia","C_man_shorts_4_F_asia","C_man_p_beggar_F_euro","C_man_polo_1_F_euro",
	"C_man_polo_2_F_euro","C_man_polo_3_F_euro","C_man_polo_4_F_euro","C_man_polo_5_F_euro","C_man_polo_6_F_euro",
	"C_man_shorts_1_F_euro","C_man_p_shorts_1_F_euro","C_man_shorts_2_F_euro","C_man_shorts_3_F_euro","C_man_shorts_4_F_euro"
];
_QS_civVehicleArrayRsc = [
	"C_Truck_02_covered_F","I_Truck_02_transport_F","C_Offroad_01_F",
	"C_Offroad_01_repair_F","C_Quadbike_01_F","C_Truck_02_box_F","C_Truck_02_fuel_F","C_Truck_02_transport_F",
	"C_Offroad_01_F","C_Offroad_01_F","C_SUV_01_F","C_SUV_01_F","C_SUV_01_F"
];
_QS_civilianTypes = missionNamespace getVariable ['QS_core_civilians_list',['C_man_1']];
_QS_locationsUrban = _QS_locationsUrban call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
_QS_locationsUrban = _QS_locationsUrban call (missionNamespace getVariable 'QS_fnc_arrayShuffle');

for '_x' from 0 to 49 step 1 do {
	_QS_locationSelect = selectRandom _QS_locationsUrban;
	_QS_locationCenterPos = _QS_locationSelect # 0;
	_QS_locationCenterName = _QS_locationSelect # 1;
	if ((_QS_locationCenterPos distance (markerPos 'QS_marker_aoMarker')) > 3000) exitWith {};
	sleep 0.5;
};
if (worldName isEqualTo 'Tanoa') then {
	_QS_approvedBuildingTypes = ['House'];
};
_QS_buildingList_pre = (nearestObjects [_QS_locationCenterPos,_QS_approvedBuildingTypes,400,TRUE]) call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
_QS_buildingList = [];
{
	_QS_buildingPositions = _x buildingPos -1;
	if (_QS_buildingPositions isNotEqualTo []) then {
		0 = _QS_buildingList pushBack _x;
		{
			0 = _QS_allBuildingPositions pushBack _x;
		} forEach _QS_buildingPositions;
	};
} count _QS_buildingList_pre;

if (_QS_buildingList isEqualTo []) exitWith {diag_log format ['***** DEBUG ***** secureUrban.sqf ***** No building positions ***** %1 *****',_QS_locationCenterName];};

for '_x' from 0 to 2 step 1 do {
	_QS_building = selectRandom _QS_buildingList;
	0 = _QS_targetBuildings pushBack _QS_building;
	_index = _QS_buildingList find _QS_building;
	_QS_buildingList set [_index,FALSE];
	_QS_buildingList deleteAt _index;
};
_index = 1;
{
	_QS_building = _x;
	_QS_building_position = getPosATL _x;
	if (_index isEqualTo 1) then {
		_QS_buildingPositions1 = _QS_building buildingPos -1;
		_QS_obj1BP = selectRandom _QS_buildingPositions1;
		_QS_objectType = selectRandom  _QS_objectTypes;
		_QS_object1 = createVehicle [_QS_objectType,[0,0,0],[],0,'NONE'];
		_QS_object1 allowDamage FALSE;
		_QS_object1 enableRopeAttach FALSE;
		_QS_object1 enableVehicleCargo FALSE;
		_QS_object1 setPosATL _QS_obj1BP;
		_QS_object1 setVariable ['QS_interaction_disabled',TRUE,TRUE];
		_QS_object1 enableSimulationGlobal TRUE;
		for '_x' from 0 to 2 step 1 do {
			_QS_object1 setVariable ['QS_secureable',TRUE,TRUE];
		};
		0 = _QS_objectArray pushBack _QS_object1;
		0 = _QS_allArray pushBack _QS_object1;
		_QS_eastGrp = createGroup [EAST,TRUE];
		_QS_eastGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		for '_x' from 0 to (_QS_inBuildingCount - 1) step 1 do {
			_QS_unitType = selectRandom _QS_urbanEnemyUnits;
			_QS_unit = _QS_eastGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_unitType,_QS_unitType],[0,0,0],[],0,'NONE'];
			_QS_unit = _QS_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_QS_spawnPos = selectRandom _QS_buildingPositions1;
			_QS_unit setPos _QS_spawnPos;
			_QS_unit enableStamina FALSE;
			0 = _QS_allArray pushBack _QS_unit;
			0 = _QS_enemyArray pushBack _QS_unit;
			_QS_unit enableAIFeature ['PATH',FALSE];
			if ((random 1) > 0.25) then {
				_QS_unit setUnitPos 'Up';
			} else {
				_QS_unit setUnitPos 'Middle';
			};
		};
		_safePos = [_QS_building_position,15,50,4,0,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
		_grp = [_safePos,(random 360),EAST,'OIA_GuardSentry',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		{
			0 = _QS_allArray pushBack _x;
			0 = _QS_enemyArray pushBack _x;		
		} count (units _grp);
		_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		[_grp,_safePos,50] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	};
	if (_index isEqualTo 2) then {
		_QS_buildingPositions2 = _QS_building buildingPos -1;
		_QS_obj2BP = selectRandom _QS_buildingPositions2;
		_QS_objectType = selectRandom _QS_objectTypes;
		_QS_object2 = createVehicle [_QS_objectType,[0,0,0],[],0,'NONE'];
		_QS_object2 allowDamage FALSE;
		_QS_object2 enableRopeAttach FALSE;
		_QS_object2 enableVehicleCargo FALSE;
		_QS_object2 setPosATL _QS_obj2BP;
		_QS_object2 setVariable ['QS_interaction_disabled',TRUE,TRUE];
		/*/_QS_object2 setPosATL [((getPosATL _QS_building) # 0),((getPosATL _QS_building) # 1),1];/*/
		_QS_object2 enableSimulationGlobal TRUE;
		for '_x' from 0 to 2 step 1 do {
			_QS_object2 setVariable ['QS_secureable',TRUE,TRUE];
		};
		0 = _QS_objectArray pushBack _QS_object2;
		0 = _QS_allArray pushBack _QS_object2;
		_QS_eastGrp = createGroup [EAST,TRUE];
		_QS_eastGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		for '_x' from 0 to (_QS_inBuildingCount - 1) step 1 do {
			_QS_unitType = selectRandom _QS_urbanEnemyUnits;
			_QS_unit = _QS_eastGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_unitType,_QS_unitType],[0,0,0],[],0,'NONE'];
			_QS_unit = _QS_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_QS_spawnPos = selectRandom _QS_buildingPositions2;
			_QS_unit setPos _QS_spawnPos;
			_QS_unit enableStamina FALSE;
			0 = _QS_allArray pushBack _QS_unit;
			0 = _QS_enemyArray pushBack _QS_unit;
			_QS_unit enableAIFeature ['PATH',FALSE];
			if ((random 1) > 0.25) then {
				_QS_unit setUnitPos 'Up';
			} else {
				_QS_unit setUnitPos 'Middle';
			};
		};
		_safePos = [_QS_building_position,15,50,4,0,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
		_grp = [_safePos,(random 360),EAST,'OIA_GuardSentry',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		{
			0 = _QS_allArray pushBack _x;
			0 = _QS_enemyArray pushBack _x;		
		} count (units _grp);
		_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		[_grp,_safePos,50] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	};
	if (_index isEqualTo 3) then {
		_QS_buildingPositions3 = _QS_building buildingPos -1;
		_QS_obj3BP = selectRandom _QS_buildingPositions3;
		_QS_objectType = selectRandom _QS_objectTypes;
		_QS_object3 = createVehicle [_QS_objectType,[0,0,0],[],0,'NONE'];
		_QS_object3 allowDamage FALSE;
		_QS_object3 enableRopeAttach FALSE;
		_QS_object3 enableVehicleCargo FALSE;
		_QS_object3 setPosATL _QS_obj3BP;
		_QS_object3 setVariable ['QS_interaction_disabled',TRUE,TRUE];
		/*/_QS_object3 setPosATL [((getPosATL _QS_building) # 0),((getPosATL _QS_building) # 1),1];/*/
		_QS_object3 enableSimulationGlobal TRUE;
		for '_x' from 0 to 2 step 1 do {
			_QS_object3 setVariable ['QS_secureable',TRUE,TRUE];
		};
		0 = _QS_objectArray pushBack _QS_object3;
		0 = _QS_allArray pushBack _QS_object3;
		_QS_eastGrp = createGroup [EAST,TRUE];
		_QS_eastGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		for '_x' from 0 to (_QS_inBuildingCount - 1) step 1 do {
			_QS_unitType = selectRandom _QS_urbanEnemyUnits;
			_QS_unit = _QS_eastGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_unitType,_QS_unitType],[0,0,0],[],0,'NONE'];
			_QS_unit = _QS_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_QS_spawnPos = selectRandom _QS_buildingPositions3;
			_QS_unit setPos _QS_spawnPos;
			_QS_unit enableStamina FALSE;
			0 = _QS_allArray pushBack _QS_unit;
			0 = _QS_enemyArray pushBack _QS_unit;
			if ((random 1) > 0.2) then {
				_QS_unit enableAIFeature ['PATH',FALSE];
			};
			if ((random 1) > 0.25) then {
				_QS_unit setUnitPos 'Up';
			} else {
				_QS_unit setUnitPos 'Middle';
			};
		};
		_safePos = [_QS_building_position,10,40,4,0,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
		_grp = [_safePos,(random 360),EAST,'OIA_GuardSentry',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		{
			0 = _QS_allArray pushBack _x;
			0 = _QS_enemyArray pushBack _x;		
		} count (units _grp);
		_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		[_grp,_safePos,50] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	};
	_index = _index + 1;
} count _QS_targetBuildings;

_QS_garrisonGrp = createGroup [EAST,TRUE];
_QS_garrisonGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
for '_x' from 0 to (_QS_garrisonCount - 1) do {
	_QS_unitType = selectRandom _QS_urbanEnemyUnits;
	_QS_unit = _QS_garrisonGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_unitType,_QS_unitType],[0,0,0],[],0,'NONE'];
	_QS_unit = _QS_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_QS_unit enableStamina FALSE;
	_QS_buildingPos = selectRandom _QS_allBuildingPositions;
	_QS_unit setPos _QS_buildingPos;
	if ((random 1) > 0.25) then {
		_QS_unit setUnitPosWeak 'UP';
	} else {
		_QS_unit setUnitPosWeak 'MIDDLE';
	};
	_QS_unit enableAIFeature ['PATH',FALSE];
	0 = _QS_allArray pushBack _QS_unit;
	0 = _QS_enemyArray pushBack _QS_unit;
};

for '_x' from 0 to (_QS_patrolCount - 1) step 1 do {
	_wp1Pos = selectRandom _QS_allBuildingPositions;
	_wp2Pos = selectRandom _QS_allBuildingPositions;
	_wp3Pos = selectRandom _QS_allBuildingPositions;
	_wp4Pos = selectRandom _QS_allBuildingPositions;
	_QS_route = [_wp1Pos,_wp2Pos,_wp3Pos,_wp4Pos];
	_QS_patrolGroup = createGroup [EAST,TRUE];
	for '_x' from 0 to 1 step 1 do {
		_QS_unitType = selectRandom _QS_urbanEnemyUnits;
		_QS_unit = _QS_patrolGroup createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_unitType,_QS_unitType],[0,0,0],[],0,'NONE'];
		_QS_unit = _QS_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_QS_unit enableStamina FALSE;
		_QS_unit setPos _wp1Pos;
		0 = _QS_allArray pushBack _QS_unit;
		0 = _QS_enemyArray pushBack _QS_unit;
	};
	_QS_patrolGroup setVariable ['QS_AI_GRP_TASK',['PATROL',_QS_route,serverTime,-1],QS_system_AI_owners];
	_QS_patrolGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
	_QS_patrolGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _QS_patrolGroup))],QS_system_AI_owners];
	_QS_patrolGroup setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
	_QS_patrolGroup setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_QS_patrolGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};
_nearestLocations = nearestLocations [_QS_locationCenterPos,['NameVillage','NameCity','NameCityCapital'],300];
if (_nearestLocations isNotEqualTo []) then {
	_nearestLocation = _nearestLocations # 0;
	_civilians = [_QS_locationCenterPos,300,'FOOT',(round (10 + (random 10))),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnAmbientCivilians');
	{
		_QS_allArray pushBack _x;
	} forEach _civilians;
};
_QS_roadArrayRsc = ((_QS_locationCenterPos nearRoads 300) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) apply { [_x,(position _x)] };
if ((count _QS_roadArrayRsc) > 8) then {
	private _QS_tempRoadData = [];
	private _QS_tempRoadObj = objNull;
	for '_x' from 0 to (round ((count _QS_roadArrayRsc) / 8)) step 1 do {
		_QS_flatEmptyPos = [];
		_QS_tempRoadData = selectRandom _QS_roadArrayRsc;
		_QS_roadArrayRsc deleteAt (_QS_roadArrayRsc find _QS_tempRoadData);
		_QS_roadDir = random 360;
		_QS_tempRoadData params [
			'_QS_tempRoadObj',
			'_QS_tempRoadPos'
		];
		if (_QS_tempRoadObj isEqualType objNull) then {
			if (!isNull _QS_tempRoadObj) then {
				_QS_roadConnectedTo = roadsConnectedTo _QS_tempRoadObj;
				if (_QS_roadConnectedTo isNotEqualTo []) then {
					_QS_connectedRoad = _QS_roadConnectedTo # 0;
					_QS_roadDir = _QS_tempRoadPos getDir _QS_connectedRoad;
				};
			};
		};
		_QS_vType = selectRandom _QS_civVehicleArrayRsc;
		_QS_v = createSimpleObject [_QS_vType,[(random -20),(random -20),2000]];
		_QS_v setDir _QS_roadDir;
		_QS_v setVectorUp (surfaceNormal _QS_tempRoadPos);
		_QS_v setPosASL (AGLToASL _QS_tempRoadPos);
		_QS_v setVariable ['QS_v_disableProp',TRUE,TRUE];
		0 = _QS_allArray pushBack _QS_v;
	};
};
_markerStoragePos = [0,0,0];
_markers = [];
{
	createMarker [(_x # 0),(_x # 1)];
	(_x # 0) setMarkerTypeLocal (_x # 2);
	(_x # 0) setMarkerShapeLocal (_x # 3);
	if ((_x # 3) isNotEqualTo 'Icon') then {
		(_x # 0) setMarkerBrushLocal (_x # 4);
	};
	(_x # 0) setMarkerColorLocal (_x # 5);
	(_x # 0) setMarkerSizeLocal (_x # 6);
	(_x # 0) setMarkerAlphaLocal (_x # 7);
	(_x # 0) setMarkerPosLocal (_x # 8);
	(_x # 0) setMarkerText (_x # 9);
	0 = _markers pushBack (_x # 0);
} forEach [
	['QS_marker_sideMission_urban_mkr1',_markerStoragePos,'mil_dot','Ellipse','SolidBorder','ColorOPFOR',[30,30],0.5,[(((getPosWorld(_QS_objectArray # 0)) # 0) + (15 - (random 30))),(((getPosWorld(_QS_objectArray # 0)) # 1) + (12.5 - (random 25))),0],(toString [32,32,32])],
	['QS_marker_sideMission_urban_mkr2',_markerStoragePos,'mil_dot','Ellipse','SolidBorder','ColorOPFOR',[30,30],0.5,[(((getPosWorld(_QS_objectArray # 1)) # 0) + (15 - (random 30))),(((getPosWorld(_QS_objectArray # 1)) # 1) + (12.5 - (random 25))),0],(toString [32,32,32])],
	['QS_marker_sideMission_urban_mkr3',_markerStoragePos,'mil_dot','Ellipse','SolidBorder','ColorOPFOR',[30,30],0.5,[(((getPosWorld(_QS_objectArray # 2)) # 0) + (15 - (random 30))),(((getPosWorld(_QS_objectArray # 2)) # 1) + (12.5 - (random 25))),0],(toString [32,32,32])]
];
_QS_missionSuccess = FALSE;
_QS_missionFailed = FALSE;
_QS_qrfDeployed = FALSE;
_QS_contactContacted = FALSE;
_allSecured = FALSE;
_QS_enemyDetected = FALSE;
_QS_checkEnemyDelay = time + 10;
_QS_bombTimer_started = FALSE;
missionNamespace setVariable ['QS_mission_urban_objectsSecured',0,FALSE];
'QS_marker_sideMarker' setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_046']);
{
	_x setMarkerPosLocal _QS_locationCenterPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
_QS_firstDetected = FALSE;
[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		localize 'STR_QS_Task_116',
		localize 'STR_QS_Task_117',
		localize 'STR_QS_Task_117'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'download',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');

missionNamespace setVariable ['QS_mission_urban_active',TRUE,TRUE];
['NewSideMission',[localize 'STR_QS_Notif_113']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
_box1_secured = FALSE;
_box2_secured = FALSE;
_box3_secured = FALSE;
deleteVehicle (_QS_allArray select {((_x distance2D [0,0,0]) < 500)});
for '_x' from 0 to 1 step 0 do {

	if (_QS_missionSuccess) exitWith {
		[1,_QS_locationCenterPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		missionNamespace setVariable ['QS_mission_urban_active',FALSE,TRUE];
		{
			deleteMarker _x;
		} count _markers;
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		sleep 120;
		{
			if (!isNull _x) then {
				if (_x isEqualType objNull) then {
					0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
				};
			};
		} count _QS_allArray;
	};

	if (_QS_missionFailed) exitWith {
		[0,_QS_locationCenterPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		missionNamespace setVariable ['QS_mission_urban_active',FALSE,TRUE];
		{
			deleteMarker _x;
		} count _markers;
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		sleep 120;
		{
			if (!isNull _x) then {
				if (_x isEqualType objNull) then {
					0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
				};
			};
		} count _QS_allArray;
	};
	if ((_QS_objectArray findIf {(alive _x)}) isEqualTo -1) then {
		_QS_missionSuccess = FALSE;
		_QS_missionFailed = TRUE;		
	};
	_QS_allSecured = TRUE;
	{
		if (!(_x getVariable ['QS_secured',FALSE])) exitWith {
			_QS_allSecured = FALSE;
		};
	} count _QS_objectArray;
	if (_QS_allSecured) then {
		_QS_missionSuccess = TRUE;
		_QS_missionFailed = FALSE;
	};

	if (!(_QS_enemyDetected)) then {
		{
			if (!isNull _x) then {
				if (alive _x) then {
					if ([_x,500] call (missionNamespace getVariable 'QS_fnc_enemyDetected')) then {
						sleep 3;
						if (alive _x) then {
							_QS_enemyDetected = TRUE;
						};
					};
				};
			};
			if (_QS_enemyDetected) exitWith {};
		} count _QS_enemyArray;
		if (_QS_enemyDetected) then {
			['ST_URBAN',[localize 'STR_QS_Notif_091',localize 'STR_QS_Notif_114']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			{
				if (alive _x) then {
					if ((random 1) > 0.75) then {
						_x setUnitPos 'Middle';
					};
				};
			} count _QS_enemyArray;
			_QS_enemyDetected_endTime = serverTime + (600 + (random 360));
			['QS_IA_TASK_SM_0',TRUE,_QS_enemyDetected_endTime] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
			_QS_bombTimer_started = TRUE;
			_QS_urbanTimerBroadcast_delay = time + 25;
			_QS_text = format [localize 'STR_QS_Chat_156',[((round(_QS_enemyDetected_endTime - serverTime))/60)+0.01,'HH:MM'] call (missionNamespace getVariable 'BIS_fnc_timeToString')];
			['systemChat',_QS_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
	
	if (!(_box1_secured)) then {
		if (!isNull _QS_object1) then {
			if (alive _QS_object1) then {
				if (_QS_object1 getVariable ['QS_secured',FALSE]) then {
					_box1_secured = TRUE;
					_QS_object1 hideObjectGlobal TRUE;
					_QS_object1 setPos [-5000,-5000,0];
					(_markers # 0) setMarkerAlpha 0;
					missionNamespace setVariable ['QS_mission_urban_objectsSecured',((missionNamespace getVariable 'QS_mission_urban_objectsSecured') + 1),FALSE];
					['ST_URBAN',[localize 'STR_QS_Notif_091',(format ['%1 / 3 %2',(missionNamespace getVariable 'QS_mission_urban_objectsSecured'),localize 'STR_QS_Notif_115'])]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
				};
			};
		};
	};
	if (!(_box2_secured)) then {
		if (!isNull _QS_object2) then {
			if (alive _QS_object2) then {
				if (_QS_object2 getVariable ['QS_secured',FALSE]) then {
					_box2_secured = TRUE;
					_QS_object2 hideObjectGlobal TRUE;
					_QS_object2 setPos [-5000,-5000,0];
					(_markers # 1) setMarkerAlpha 0;
					missionNamespace setVariable ['QS_mission_urban_objectsSecured',((missionNamespace getVariable 'QS_mission_urban_objectsSecured') + 1),FALSE];
					['ST_URBAN',[localize 'STR_QS_Notif_091',(format ['%1 / 3 %2',(missionNamespace getVariable 'QS_mission_urban_objectsSecured'),localize 'STR_QS_Notif_115'])]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
				};
			};
		};
	};
	if (!(_box3_secured)) then {
		if (!isNull _QS_object3) then {
			if (alive _QS_object3) then {
				if (_QS_object3 getVariable ['QS_secured',FALSE]) then {
					_box3_secured = TRUE;
					_QS_object3 hideObjectGlobal TRUE;
					_QS_object3 setPos [-5000,-5000,0];
					(_markers # 2) setMarkerAlpha 0;
					missionNamespace setVariable ['QS_mission_urban_objectsSecured',((missionNamespace getVariable 'QS_mission_urban_objectsSecured') + 1),FALSE];
					['ST_URBAN',[localize 'STR_QS_Notif_091',(format ['%1 / 3 %2',(missionNamespace getVariable 'QS_mission_urban_objectsSecured'),localize 'STR_QS_Notif_115'])]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
				};
			};
		};
	};
	if (_QS_enemyDetected) then {
		if (!(_QS_firstDetected)) then {
			_QS_firstDetected = TRUE;
			{
				(group _x) setBehaviour 'AWARE';
			} count _QS_enemyArray;
			
			if (!(_QS_qrfDeployed)) then {
				_QS_qrfDeployed = TRUE;
				_QS_positionAccepted = FALSE;
				_QS_unitArray = [];
				for '_x' from 0 to 1 step 0 do {
					_QS_clearPos = [];
					_QS_clearPos = ['RADIUS',_QS_locationCenterPos,800,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
					if ((count _QS_clearPos) > 0) then {
						if (([_QS_clearPos,200,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
							_QS_positionAccepted = TRUE;
						};
					};
					if (_QS_positionAccepted) exitWith {};
				};
				_QS_qrfGroup = [_QS_clearPos,(random 360),EAST,'OI_reconTeam',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
				{
					0 = _QS_allArray pushBack _x;
					_x enableStamina FALSE;
				} count (units _QS_qrfGroup);
				_QS_qrfGroup setFormDir (_QS_spawnPos getDir _QS_locationCenterPos);
				_QS_attackPos = selectRandom [_QS_locationCenterPos,_QS_obj1BP,_QS_obj2BP,_QS_obj3BP];
				[_QS_qrfGroup,_QS_attackPos,TRUE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
				_QS_qrfGroup setSpeedMode 'FULL';
				_QS_qrfGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
				[(units _QS_qrfGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				{0 = _QS_enemyArray pushBack _x;} count (units _QS_qrfGroup);
			};
			
			if (serverTime > _QS_enemyDetected_endTime) then {
				if (!(_allSecured)) then {
					['systemChat',localize 'STR_QS_Chat_157'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				};
			};
		};
	};

	if (_QS_bombTimer_started) then {
		/*/
		if (time > _QS_urbanTimerBroadcast_delay) then {
			_QS_text = format ['CSAT will destroy the intel in %1',[((round(_QS_enemyDetected_endTime - time))/60)+0.01,'HH:MM'] call (missionNamespace getVariable 'BIS_fnc_timeToString')];
			['systemChat',_QS_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			_QS_urbanTimerBroadcast_delay = time + 25;
		};
		/*/
		if (!(_QS_missionSuccess)) then {
			if (serverTime > _QS_enemyDetected_endTime) then {
				{
					if (!isNull _x) then {
						if (!(_x getVariable 'QS_secured')) then {
							_x setDamage 1;
							'M_AT' createVehicle (getPosATL _x);
						};
					};
				} forEach _QS_objectArray;
				_QS_missionSuccess = FALSE;
				_QS_missionFailed = TRUE;		
			};
		};
	};
	
	if (time > _QS_checkEnemyDelay) then {
		if (({(alive _x)} count _QS_enemyArray) < 14) then {
			for '_x' from 0 to 49 step 1 do {
				_QS_spawnPos = [_QS_locationCenterPos,300,600,3,0,0.7,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
				if (([_QS_spawnPos,250,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) exitWith {};
			};
			_QS_eastGrp = createGroup [EAST,TRUE];
			_QS_eastGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			for '_x' from 0 to 3 step 1 do {
				_QS_unitType = selectRandom _QS_urbanEnemyUnits;
				_QS_unit = _QS_eastGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_unitType,_QS_unitType],_QS_spawnPos,[],0,'FORM'];
				_QS_unit = _QS_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
				0 = _QS_allArray pushBack _QS_unit;
				0 = _QS_enemyArray pushBack _QS_unit;		
				_QS_unit enableStamina FALSE;
				[_QS_unit,'GryffinRegiment'] call (missionNamespace getVariable 'BIS_fnc_setUnitInsignia');
			};
			_QS_eastGrp setFormDir (_QS_spawnPos getDir _QS_locationCenterPos);
			_QS_attackPos = selectRandom [_QS_locationCenterPos,_QS_obj1BP,_QS_obj2BP,_QS_obj3BP];
			[_QS_eastGrp,_QS_attackPos,TRUE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
		};
		_QS_checkEnemyDelay = time + 10;
	};
	sleep 1;
};