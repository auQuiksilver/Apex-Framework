/*/
File: rescuePOW.sqf
Author:

	Quiksilver
	
Last Modified:

	3/02/2018 A3 1.80 by Quiksilver
	
Description:

	Rescue POW
_________________________________________________________/*/

scriptName 'Side Mission - Rescue POW';

private [
	'_QS_allArray','_QS_locationsUrban','_QS_approvedBuildingTypes','_QS_opforTruckTypes','_QS_powTypes','_QS_badGuyTypes',
	'_QS_opforTruckType','_QS_powType','_QS_badGuyType','_QS_locationCenterPos','_QS_locationCenterName','_QS_locationSelect',
	'_QS_buildingList','_QS_building','_QS_buildingPositions','_QS_buildingPosition','_QS_dirToRelPos','_QS_relPos','_QS_powPos',
	'_QS_badPos','_QS_nearRoadsList','_QS_nearestRoadPos','_QS_roadConnectedTo','_QS_connectedRoad','_QS_connectedRoadDir','_dirToBG',
	'_dirToPow','_QS_posInFront','_QS_posBehind','_QS_opforOnlyTruckTypes','_QS_truck2_safePos','_QS_truck3_safePos','_QS_truckType',
	'_QS_urbanEnemyUnits','_QS_buildingPosATL',
	'_QS_WP0','_QS_WP1','_QS_WP2','_QS_WP3','_QS_WP4','_QS_group','_QS_randomUnitType','_QS_randomUnit','_QS_nearRoadsList','_QS_testedRoadPos',
	'_QS_roadWP0','_QS_roadWP1','_QS_roadWP2','_QS_roadWP3','_QS_roadWP4','_QS_nearHouses','_QS_toSpawn','_i','_QS_nearHousesGroup','_QS_index',
	'_QS_inBuildingCount','_QS_eastGarrisonGroup','_QS_nearRoadsListCopy','_QS_roadPosition','_QS_range','_QS_roadPosFound',
	'_QS_route','_QS_patrolHouse1','_QS_patrolHouse1_buildingPositions','_QS_patrolHouse1_buildingPosition_selected',
	'_QS_patrolHouse2','_QS_patrolHouse2_buildingPositions','_QS_patrolHouse2_buildingPosition_selected','_QS_patrolHouse3',
	'_QS_patrolHouse3_buildingPositions','_QS_patrolHouse3_buildingPosition_selected','_QS_patrolHouse4','_QS_patrolHouse4_buildingPositions',
	'_QS_patrolHouse4_buildingPosition_selected','_QS_route2','_QS_WP','_QS_patrolGroup2','_QS_patrolGroup1','_QS_spawnPos','_QS_civilianTypes',
	'_QS_civilianType','_QS_civKilled_EH','_QS_buildingCivSelected','_QS_buildingPositionSelected','_QS_civAgent','_QS_setDir','_QS_civVehicleArrayRsc',
	'_QS_roadArrayRsc','_QS_tempRoadPos','_QS_roadDir','_QS_vType','_QS_safeSetPos','_QS_enemyArray','_QS_priorMissionStatistics','_QS_pow_explosivesVest',
	'_QS_priorMissionStatistics_completions','_QS_priorMissionStatistics_failures','_QS_powRescued','_QS_civArray','_QS_POW','_QS_mission_startTime',
	'_QS_enemyDetected','_QS_enemyDetected_startTime','_QS_powBleedout_timer_started','_QS_powBleedout_timer','_QS_firstDetected',
	'_QS_v','_QS_arr','_QS_BADGUY','_QS_fuzzyPos','_QS_medicalVehicles','_QS_medics','_QS_missionComplete','_QS_missionFailed','_QS_civilianNeutrality',
	'_QS_civ','_QS_newWP','_QS_civIntelQuality_update','_QS_civIntelQuality_current','_QS_newRadius','_QS_qrfDeployed','_QS_flatEmptyPos','_QS_civiliansUnhappy',
	'_QS_medicalTruck_checkDelay','_QS_medicalTruck_detected','_QS_nearVehicles','_QS_qrfGroup','_QS_positionAccepted','_QS_clearPos',
	'_QS_medicalTruck_waypointCheckDelay','_QS_qrfWaypointIssued','_QS_firstRun','_QS_firstRun_delay','_QS_bleedTimerBroadcast_delay','_QS_killTimer_started',
	'_QS_killTimerBroadcast_delay','_QS_missionAttempts','_QS_missionSuccessRate','_QS_rescueWP_updateDelay','_QS_text','_text','_QS_buildingList_pre',
	'_QS_allBuildingPositions'
];

_QS_allArray = [];
_QS_enemyArray = [];
_QS_civArray = [];
_QS_locationsUrban = [];

if (worldName isEqualTo 'Altis') then {
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
		[[8628.46,18285.3,0.00126648],'Syrta'],
		[[9289.68,15860.5,0.00139618],'Agios Dionysios'],
		[[11132.6,14564.5,0.00153732],'Alikampos'],
		[[10938.4,13448.7,0.00143051],'Poliakko'],
		[[10659.8,12248.4,0.00145149],'Therisa'],
		[[12574,14355.5,0.001544],'Neochori'],
		[[14587,20797.1,0.00150299],'Frini'],
		[[3926.72,17280.1,0.00147152],'Agios Konstantinos']
	];
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
		/*/[[7258.91,8005.59,0.00143886],"Lifou"],/*/	// too close to base
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

if (_QS_locationsUrban isEqualTo []) exitWith {diag_log '***** fn_rescuePOW ***** No valid locations *****';};
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

/*/ hatchback cars dont do well with createsimpleobject alt syntax/*/
if (worldName isEqualTo 'Altis') then {
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
		"C_Offroad_01_F","C_Offroad_01_F","C_SUV_01_F","C_SUV_01_F","C_SUV_01_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_F"
	];
} else {
	_QS_civilianTypes = [
		"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan",
		"C_Man_casual_6_F_tanoan","C_man_sport_1_F_tanoan"
	];
	_QS_civVehicleArrayRsc = [
		"C_Truck_02_covered_F","I_Truck_02_transport_F","C_Offroad_01_F",
		"C_Offroad_01_repair_F","C_Quadbike_01_F","C_Truck_02_box_F","C_Truck_02_fuel_F","C_Truck_02_transport_F",
		"C_Offroad_01_F","C_Offroad_01_F","C_SUV_01_F","C_SUV_01_F","C_SUV_01_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_F","C_Offroad_02_unarmed_F"
	];
};
_QS_civilianTypes = missionNamespace getVariable ['QS_core_civilians_list',['C_man_1']];
_QS_medics = [
	'B_medic_F','B_recon_medic_F','B_G_medic_F','O_medic_F','I_medic_F','O_recon_medic_f','O_G_medic_F','I_G_medic_F','O_soldierU_medic_F'
];

_QS_medicalVehicles = [
	'B_Truck_01_medical_F','O_Truck_03_medical_F','I_Truck_02_medical_F','O_Truck_02_medical_F',
	'Land_Pod_Heli_Transport_04_medevac_F','O_Heli_Transport_04_medevac_F','Land_Pod_Heli_Transport_04_medevac_black_F'
];

_QS_civKilled_EH = {
	private ['_killed','_killer','_text'];
	_killed = _this # 0;
	_killer = _this # 1;
	if (isPlayer _killer) then {
		_name = name _killer;
		missionNamespace setVariable [
			'QS_sideMission_civsKilled',
			((missionNamespace getVariable 'QS_sideMission_civsKilled') + 1),
			TRUE
		];
		if ((random 1) > 0.666) then {
			_text = format [localize 'STR_QS_Chat_141',_name];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		} else {
			_text = format ['%1 %2!',_name,localize 'STR_QS_Chat_153'];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};	
};

_QS_pow_explosivesVest = {
	private ['_QS_unit','_QS_exp1','_QS_exp2','_QS_exp3','_QS_expArr'];
	_QS_unit = _this # 0;
	_QS_expArr = [];
	_QS_exp1 = createVehicle ['DemoCharge_Remote_Ammo',[0,0,100],[],0,'NONE'];
	0 = _QS_expArr pushBack _QS_exp1;
	_QS_exp2 = createVehicle ['DemoCharge_Remote_Ammo',[0,0,101],[],0,'NONE'];
	0 = _QS_expArr pushBack _QS_exp2;
	_QS_exp3 = createVehicle ['DemoCharge_Remote_Ammo',[0,0,102],[],0,'NONE'];
	0 = _QS_expArr pushBack _QS_exp3;
	[_QS_unit,_QS_exp1,_QS_exp2,_QS_exp3] remoteExec ['QS_fnc_explosiveVestMP',0,FALSE];
	_QS_expArr;
};
_QS_opforTruckTypes = ['O_Truck_03_transport_F','O_Truck_03_covered_F','O_Truck_02_transport_F','O_Truck_02_covered_F','O_MRAP_02_F'];
_QS_opforOnlyTruckTypes = ['O_Truck_03_transport_F','O_Truck_03_covered_F','O_Truck_02_transport_F','O_Truck_02_covered_F'];
_QS_powTypes = ['B_Story_Protagonist_F','b_survivor_F'];
_QS_badGuyTypes = ["O_Soldier_TL_F","O_Recon_TL_F","O_Officer_F","O_Soldier_SL_F"];

_QS_opforTruckType = selectRandom _QS_opforTruckTypes;
_QS_powType = selectRandom _QS_powTypes;
_QS_badGuyType = selectRandom _QS_badGuyTypes;

_QS_locationsUrban = _QS_locationsUrban call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
_QS_locationsUrban = _QS_locationsUrban call (missionNamespace getVariable 'QS_fnc_arrayShuffle');

for '_x' from 0 to 49 step 1 do {
	_QS_locationSelect = selectRandom _QS_locationsUrban;
	_QS_locationCenterPos = _QS_locationSelect # 0;
	_QS_locationCenterName = _QS_locationSelect # 1;
	if ((_QS_locationCenterPos distance2D (missionNamespace getVariable 'QS_AOpos')) > 1500) exitWith {};
	sleep 0.5;
};
/*/
if (worldName isEqualto 'Tanoa') then {
	_QS_approvedBuildingTypes = ['House'];
};
/*/

_QS_buildingList = [];
_QS_buildingList_pre = nearestObjects [_QS_locationCenterPos,_QS_approvedBuildingTypes,200,TRUE];
if (_QS_buildingList_pre isEqualTo []) then {
	_QS_buildingList_pre = nearestObjects [_QS_locationCenterPos,_QS_approvedBuildingTypes,300,TRUE];
};
_QS_allBuildingPositions = [];
{
	_QS_buildingPositions = _x buildingPos -1;
	if (_QS_buildingPositions isNotEqualTo []) then {
		0 = _QS_buildingList pushBack _x;
		{
			0 = _QS_allBuildingPositions pushBack _x;
		} forEach _QS_buildingPositions;
	};
} count _QS_buildingList_pre;

_QS_buildingList = _QS_buildingList call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
_QS_building = selectRandom _QS_buildingList;
_QS_buildingPosATL = getPosATL _QS_building;
_QS_buildingPositions = _QS_building buildingPos -1;
_QS_buildingPosition = selectRandom _QS_buildingPositions;
_QS_dirToRelPos = _QS_buildingPosition getDir (getPosWorld _QS_building);
_QS_relPos = _QS_buildingPosition getPos [1,_QS_dirToRelPos];
_QS_powPos = _QS_buildingPosition;
_QS_badPos = _QS_relPos;
_QS_nearRoadsList = ((getPosATL _QS_building) nearRoads 15) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
if ((count _QS_nearRoadsList) > 0) then {
	_QS_nearestRoadPos = _QS_nearRoadsList # 0;
	_QS_roadConnectedTo = roadsConnectedTo _QS_nearestRoadPos;
	_QS_connectedRoad = _QS_roadConnectedTo # 0;
	_QS_connectedRoadDir = _QS_nearestRoadPos getDir _QS_connectedRoad;
	_QS_truckType = selectRandom _QS_opforTruckTypes;
	_QS_truck = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_truckType,_QS_truckType],_QS_nearestRoadPos,[],0,'NONE'];
	_QS_truck allowDamage FALSE;
	0 = _QS_allArray pushBack _QS_truck;
	_QS_truck setDir (_QS_connectedRoadDir + 5 - (random 10));
	_QS_truck lock 2;
	_QS_truck setFuel 0;
	_QS_truck enableRopeAttach FALSE;
	_QS_truck2_safePos = (_QS_truck modelToWorld [0,12,0]) findEmptyPosition [0,5,_QS_opforTruckType];
	if ((count _QS_truck2_safePos) > 0) then {
		_QS_truck2Type = selectRandom _QS_opforOnlyTruckTypes;
		_QS_truck2 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_opforTruckType,_QS_opforTruckType],_QS_truck2_safePos,[],0,'NONE'];
		_QS_truck2 allowDamage FALSE;
		0 = _QS_allArray pushBack _QS_truck2;
		_QS_truck2 setDir _QS_connectedRoadDir;
		_QS_truck2 lock 2;
		_QS_truck2 setFuel 0;
		_QS_truck2 enableRopeAttach FALSE;
	};
	_QS_truck3_safePos = (_QS_truck modelToWorld [0,-12,0]) findEmptyPosition [0,5,_QS_opforTruckType];
	if ((count _QS_truck3_safePos) > 0) then {
		_QS_truck3Type = selectRandom _QS_opforTruckTypes;
		_QS_truck3 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_truck3Type,_QS_truck3Type],_QS_truck3_safePos,[],0,'NONE'];
		_QS_truck3 allowDamage FALSE;
		0 = _QS_allArray pushBack _QS_truck3;
		_QS_truck3 setDir (_QS_connectedRoadDir + 5 - (random 10));
		_QS_truck3 lock 2;
		_QS_truck3 setFuel 0;
		_QS_truck3 enableRopeAttach FALSE;
	};
	_QS_nearestRoadPos;
	_QS_connectedRoadDir;
} else {
	_QS_nearRoadsList = ((getPosATL _QS_building) nearRoads 30) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
	if ((count _QS_nearRoadsList) > 0) then {
		_QS_nearestRoadPos = _QS_nearRoadsList # 0;
	
		_QS_roadConnectedTo = roadsConnectedTo _QS_nearestRoadPos;
		_QS_connectedRoad = _QS_roadConnectedTo # 0;
		_QS_connectedRoadDir = _QS_nearestRoadPos getDir _QS_connectedRoad;
		
		_QS_truckType = selectRandom _QS_opforTruckTypes;
		_QS_truck = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_truckType,_QS_truckType],_QS_nearestRoadPos,[],0,'NONE'];
		_QS_truck allowDamage FALSE;
		0 = _QS_allArray pushBack _QS_truck;
		_QS_truck setDir (_QS_connectedRoadDir + 5 - (random 10));
		_QS_truck lock 2;
		_QS_truck setFuel 0;
		_QS_truck enableRopeAttach FALSE;
		
		_QS_truck2_safePos = (_QS_truck modelToWorld [0,12,0]) findEmptyPosition [0,5,_QS_opforTruckType];
		if ((count _QS_truck2_safePos) > 0) then {
			_QS_truck2Type = selectRandom _QS_opforOnlyTruckTypes;
			_QS_truck2 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_opforTruckType,_QS_opforTruckType],_QS_truck2_safePos,[],0,'NONE'];
			_QS_truck2 allowDamage FALSE;
			0 = _QS_allArray pushBack _QS_truck2;
			_QS_truck2 setDir _QS_connectedRoadDir;
			_QS_truck2 lock 2;
			_QS_truck2 setFuel 0;
			_QS_truck2 enableRopeAttach FALSE;
		};
		
		_QS_truck3_safePos = (_QS_truck modelToWorld [0,-12,0]) findEmptyPosition [0,5,_QS_opforTruckType];
		if ((count _QS_truck3_safePos) > 0) then {
			_QS_truck3Type = selectRandom _QS_opforTruckTypes;
			_QS_truck3 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_truck3Type,_QS_truck3Type],_QS_truck3_safePos,[],0,'NONE'];
			_QS_truck3 allowDamage FALSE;
			0 = _QS_allArray pushBack _QS_truck3;
			_QS_truck3 setDir (_QS_connectedRoadDir + 5 - (random 10));
			_QS_truck3 lock 2;
			_QS_truck3 setFuel 0;
			_QS_truck3 enableRopeAttach FALSE;
		};

		_QS_nearestRoadPos;
		_QS_connectedRoadDir;
	} else {
		_QS_nearRoadsList = ((getPosATL _QS_building) nearRoads 45) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
		if ((count _QS_nearRoadsList) > 0) then {
			_QS_nearestRoadPos = _QS_nearRoadsList # 0;
		
			_QS_roadConnectedTo = roadsConnectedTo _QS_nearestRoadPos;
			_QS_connectedRoad = _QS_roadConnectedTo # 0;
			_QS_connectedRoadDir = _QS_nearestRoadPos getDir _QS_connectedRoad;
			
			_QS_truckType = selectRandom _QS_opforTruckTypes;
			_QS_truck = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_truckType,_QS_truckType],_QS_nearestRoadPos,[],0,'NONE'];
			_QS_truck allowDamage FALSE;
			0 = _QS_allArray pushBack _QS_truck;
			_QS_truck setDir (_QS_connectedRoadDir + 5 - (random 10));
			_QS_truck lock 2;
			_QS_truck setFuel 0;
			_QS_truck enableRopeAttach FALSE;
			_QS_truck2_safePos = (_QS_truck modelToWorld [0,12,0]) findEmptyPosition [0,5,_QS_opforTruckType];
			if ((count _QS_truck2_safePos) > 0) then {
				_QS_truck2Type = selectRandom _QS_opforOnlyTruckTypes;
				_QS_truck2 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_opforTruckType,_QS_opforTruckType],_QS_truck2_safePos,[],0,'NONE'];
				_QS_truck2 allowDamage FALSE;
				0 = _QS_allArray pushBack _QS_truck2;
				_QS_truck2 setDir _QS_connectedRoadDir;
				_QS_truck2 lock 2;
				_QS_truck2 setFuel 0;
				_QS_truck2 enableRopeAttach FALSE;
			};
			_QS_truck3_safePos = (_QS_truck modelToWorld [0,-12,0]) findEmptyPosition [0,5,_QS_opforTruckType];
			if ((count _QS_truck3_safePos) > 0) then {
				_QS_truck3Type = selectRandom _QS_opforTruckTypes;
				_QS_truck3 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_truck3Type,_QS_truck3Type],_QS_truck3_safePos,[],0,'NONE'];
				_QS_truck3 allowDamage FALSE;
				0 = _QS_allArray pushBack _QS_truck3;
				_QS_truck3 setDir (_QS_connectedRoadDir + 5 - (random 10));
				_QS_truck3 lock 2;
				_QS_truck3 setFuel 0;
				_QS_truck3 enableRopeAttach FALSE;
			};
			_QS_nearestRoadPos;
			_QS_connectedRoadDir;
		} else {
			_QS_nearRoadsList = ((getPosATL _QS_building) nearRoads 75) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
			if ((count _QS_nearRoadsList) > 0) then {
				_QS_nearestRoadPos = _QS_nearRoadsList # 0;
			
				_QS_roadConnectedTo = roadsConnectedTo _QS_nearestRoadPos;
				_QS_connectedRoad = _QS_roadConnectedTo # 0;
				_QS_connectedRoadDir = _QS_nearestRoadPos getDir _QS_connectedRoad;
				
				_QS_truck = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_opforTruckType,_QS_opforTruckType],_QS_nearestRoadPos,[],0,'NONE'];
				_QS_truck allowDamage FALSE;
				0 = _QS_allArray pushBack _QS_truck;
				_QS_truck setDir (_QS_connectedRoadDir + 5 - (random 10));
				_QS_truck lock 2;
				_QS_truck setFuel 0;
				_QS_truck enableRopeAttach FALSE;
				
				_QS_truck2 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_opforTruckType,_QS_opforTruckType],((_QS_truck modelToWorld [0,12,0]) findEmptyPosition [0,5,_QS_opforTruckType]),[],0,'NONE'];
				_QS_truck2 allowDamage FALSE;
				0 = _QS_allArray pushBack _QS_truck2;
				_QS_truck2 setDir _QS_connectedRoadDir;
				_QS_truck2 lock 2;
				_QS_truck2 setFuel 0;
				_QS_truck2 enableRopeAttach FALSE;

				_QS_truck3 = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _QS_opforTruckType,_QS_opforTruckType],((_QS_truck modelToWorld [0,-12,0]) findEmptyPosition [0,5,_QS_opforTruckType]),[],0,'NONE'];
				_QS_truck3 allowDamage FALSE;
				0 = _QS_allArray pushBack _QS_truck3;
				_QS_truck3 setDir (_QS_connectedRoadDir + 5 - (random 10));
				_QS_truck3 lock 2;
				_QS_truck3 setFuel 0;
				_QS_truck3 enableRopeAttach FALSE;
				_QS_nearestRoadPos;
				_QS_connectedRoadDir;
			};
		};
	};
};

missionNamespace setVariable [
	'QS_sideMission_POW',
	(createAgent [_QS_powType,[0,0,1000],[],0,'NONE']),
	TRUE
];
_QS_sidemission_pow = missionNamespace getVariable 'QS_sideMission_POW';
0 = _QS_allArray pushBack (missionNamespace getVariable 'QS_sideMission_POW');
_QS_sidemission_pow allowDamage FALSE;
for '_x' from 0 to 2 step 1 do {
	_QS_sidemission_pow setCaptive TRUE;
};
{
	_QS_sidemission_pow setVariable _x;
} forEach [
	['QS_noHeal',TRUE,TRUE],
	['QS_missionObjective',1,TRUE],
	['QS_rescueable',TRUE,TRUE],
	['QS_rescuedState',0,TRUE],
	['QS_following',0,TRUE]
];
_QS_sidemission_pow setUnitPos 'Up';
_QS_sidemission_pow allowFleeing 0;
{
	_QS_sidemission_pow enableAIFeature [_x,FALSE];
} forEach [
	'MOVE','FSM','TARGET','AUTOTARGET','AIMINGERROR','SUPPRESSION','ANIM','PATH'
];
removeAllWeapons _QS_sidemission_pow;
removeHeadgear _QS_sidemission_pow;
removeGoggles _QS_sidemission_pow;
removeAllItems _QS_sidemission_pow;
removeAllAssignedItems _QS_sidemission_pow;
removeBackpack _QS_sidemission_pow;
removeVest _QS_sidemission_pow;
removeGoggles _QS_sidemission_pow;
_QS_sidemission_pow setDamage 0.5;
_QS_sidemission_pow setPos _QS_powPos;
_QS_sidemission_pow playAction 'Surrender';
_QS_sidemission_pow allowDamage TRUE;
_QS_sidemission_pow setVariable ['QS_underEscort',FALSE,TRUE];
_QS_sidemission_pow addEventHandler [
	'Local',
	{
		_QS_unit = _this # 0;
		_QS_isLocal = _this # 1;
		if (_QS_isLocal) then {
			_QS_unit enableAIFeature ['MOVE',FALSE];
			_QS_unit enableAIFeature ['FSM',FALSE];
		};
	}
];

if (worldName isEqualTo 'Tanoa') then {
	_QS_sidemission_pow forceAddUniform 'U_B_T_Soldier_F';
};

_QS_sidemission_pow addEventHandler [
	'Killed',
	{
		private ['_object','_killer','_name'];
		_object = _this # 0;
		_killer = _this # 1;
		if (isPlayer _killer) then {
			_name = name _killer;
			['sideChat',[WEST,'HQ'],(format ['%2 %1!',_name,localize 'STR_QS_Chat_068'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	}
];
missionNamespace setVariable [
	'QS_sideMission_BadGuy',
	((createGroup [EAST,TRUE]) createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_badGuyType,_QS_badGuyType],[worldSize,worldSize,worldSize],[],0,'NONE']),
	TRUE
];
(missionNamespace getVariable 'QS_sideMission_BadGuy') enableStamina FALSE;
0 = _QS_allArray pushBack (missionNamespace getVariable 'QS_sideMission_BadGuy');
0 = _QS_enemyArray pushBack (missionNamespace getVariable 'QS_sideMission_BadGuy');
(missionNamespace getVariable 'QS_sideMission_BadGuy') allowDamage FALSE;
(missionNamespace getVariable 'QS_sideMission_BadGuy') enableAIFeature ['PATH',FALSE];
(missionNamespace getVariable 'QS_sideMission_BadGuy') setUnitPos 'Up';
(missionNamespace getVariable 'QS_sideMission_BadGuy') setPos _QS_badPos;
_dirToBG = (getPosWorld _QS_sidemission_pow) getDir (getPosWorld (missionNamespace getVariable 'QS_sideMission_BadGuy'));
_QS_sidemission_pow setDir _dirToBG;
_dirToPow = (getPosWorld (missionNamespace getVariable 'QS_sideMission_BadGuy')) getDir (getPosWorld _QS_sidemission_pow);
(missionNamespace getVariable 'QS_sideMission_BadGuy') setDir _dirToPow;
(missionNamespace getVariable 'QS_sideMission_BadGuy') setFormDir _dirToPow;
removeAllItems (missionNamespace getVariable 'QS_sideMission_BadGuy');
{
	if ((toLowerANSI _x) in QS_core_classNames_grenades) then {
		(missionNamespace getVariable 'QS_sideMission_BadGuy') removeMagazine _x;
	};
} forEach (magazines (missionNamespace getVariable 'QS_sideMission_BadGuy'));

_QS_inBuildingCount = (round ((count _QS_buildingPositions) / 2)) min 3;
_QS_eastGarrisonGroup = createGroup [EAST,TRUE];
_QS_index = 0;
for '_x' from 1 to _QS_inBuildingCount step 1 do {
	_QS_toSpawn = [];
	_QS_randomUnitType = selectRandom _QS_urbanEnemyUnits;
	_QS_randomUnit = _QS_eastGarrisonGroup createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_randomUnitType,_QS_randomUnitType],(_QS_buildingPositions # _QS_index),[],0,'NONE'];
	_QS_randomUnit = _QS_randomUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_QS_randomUnit allowDamage FALSE;
	_QS_randomUnit setUnitPos 'Up';
	_QS_randomUnit enableAIFeature ['PATH',FALSE];
	{
		if ((toLowerANSI _x) in QS_core_classNames_grenades) then {
			_QS_randomUnit removeMagazine _x;
		};
	} forEach (magazines _QS_randomUnit);
	_QS_randomUnit allowFleeing 0;
	_QS_randomUnit setSkill ['spotDistance',0.25];
	0 = _QS_allArray pushBack _QS_randomUnit;
	0 = _QS_enemyArray pushBack _QS_randomUnit;
	_QS_index = _QS_index + 1;
};
_QS_eastGarrisonGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
[(units _QS_eastGarrisonGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_QS_nearHouses = _QS_buildingPosATL nearObjects ['House',100];
_QS_toSpawn = [];
for '_x' from 0 to 11 step 1 do {
	_QS_randomUnitType = selectRandom _QS_urbanEnemyUnits;
	0 = _QS_toSpawn pushBack _QS_randomUnitType;
};
_QS_nearHousesGroup = createGroup [EAST,TRUE];
for '_x' from 0 to 13 step 1 do {
	_QS_randomUnitType = selectRandom _QS_urbanEnemyUnits;
	_QS_randomUnit = _QS_nearHousesGroup createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_randomUnitType,_QS_randomUnitType],[-100,-100,0],[],0,'NONE'];
	_QS_randomUnit = _QS_randomUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_QS_randomUnit allowDamage FALSE;
	0 = _QS_allArray pushBack _QS_randomUnit;
	0 = _QS_enemyArray pushBack _QS_randomUnit;
	_QS_index = _QS_index + 1;
};
[_QS_buildingPosATL,75,(units _QS_nearHousesGroup),['House','Building']] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
{_x switchMove [''];} count (units _QS_nearHousesGroup);
[(units _QS_nearHousesGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');

_checkDist = {
	_c = TRUE;
	{
		if (((_this # 0) distance2D _x) <= (_this # 2)) then {
			_c = FALSE;
		};
	} forEach (_this # 1);
	_c;
};
_QS_nearRoadsList = ((_QS_buildingPosATL nearRoads 300) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) apply {(getPosATL _x)};
private _waypointPositions = [];
private _QS_groupSpawnPos = [worldsize,worldsize,0];
if ((count _QS_nearRoadsList) > 50) then {
	for '_x' from 0 to 3 step 1 do {
		_waypointPositions = [];
		for '_x' from 0 to (2 + (floor (random 2))) step 1 do {
			_waypointPosition = (_QS_nearRoadsList select { ([_x,_waypointPositions,75] call _checkDist) }) # 0;
			if (!isNil '_waypointPosition') then {
				_waypointPositions pushBack _waypointPosition;
			};
		};
		if ((count _waypointPositions) > 2) then {
			_QS_group = createGroup [EAST,TRUE];
			_QS_groupSpawnPos = selectRandom _waypointPositions;
			for '_x' from 0 to 1 step 1 do {
				diag_log 'QS spawning road patrol unit';
				_QS_randomUnitType = selectRandom _QS_urbanEnemyUnits;
				_QS_randomUnit = _QS_group createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_randomUnitType,_QS_randomUnitType],_QS_groupSpawnPos,[],5,'NONE'];
				_QS_randomUnit allowDamage FALSE;
				_QS_randomUnit = _QS_randomUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
				0 = _QS_allArray pushBack _QS_randomUnit;
				0 = _QS_enemyArray pushBack _QS_randomUnit;
			};
			[(units _QS_group),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_QS_group setBehaviour 'SAFE';
			_QS_group setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _QS_group))],QS_system_AI_owners];
			_QS_group setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
			_QS_group setVariable ['QS_AI_GRP_TASK',['PATROL',_waypointPositions,serverTime,-1],QS_system_AI_owners];
			_QS_group setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
			_QS_group setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
			_QS_group setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		};
	};
};

private _QS_patrolBuildings = nearestObjects [_QS_locationCenterPos,['House','Building'],300,TRUE];
_QS_patrolBuildings = _QS_patrolBuildings + ((allSimpleObjects []) inAreaArray [_QS_locationCenterPos,300,300,0,FALSE]);
private _arrayPositions = [];
private _buildingPositions = [];
private _building = objNull;
_QS_patrolBuildings = _QS_patrolBuildings call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
{
	_building = _x;
	_buildingPositions = _building buildingPos -1;
	_buildingPositions = [_building,_buildingPositions] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
	if (_buildingPositions isNotEqualTo []) then {
		{
			0 = _arrayPositions pushBack _x;
		} forEach _buildingPositions;
	};
} forEach _QS_patrolBuildings;
if (_arrayPositions isNotEqualTo []) then {
	_arrayPositions = _arrayPositions apply {[(_x # 0),(_x # 1),((_x # 2) + 0.5)]};
};
if ((count _arrayPositions) > 50) then {
	for '_x' from 0 to 3 step 1 do {
		_waypointPositions = [];
		for '_x' from 0 to (2 + (floor (random 2))) step 1 do {
			_waypointPosition = (_arrayPositions select { ([_x,_waypointPositions,50] call _checkDist) }) # 0;
			if (!isNil '_waypointPosition') then {
				_waypointPositions pushBack _waypointPosition;
			};
		};
		if ((count _waypointPositions) > 1) then {
			_QS_group = createGroup [EAST,TRUE];
			_QS_groupSpawnPos = selectRandom _waypointPositions;
			for '_x' from 0 to 1 step 1 do {
				diag_log 'QS spawning building patrol unit';
				_QS_randomUnitType = selectRandom _QS_urbanEnemyUnits;
				_QS_randomUnit = _QS_group createUnit [QS_core_units_map getOrDefault [toLowerANSI _QS_randomUnitType,_QS_randomUnitType],_QS_groupSpawnPos,[],5,'NONE'];
				_QS_randomUnit allowDamage FALSE;
				_QS_randomUnit = _QS_randomUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
				0 = _QS_allArray pushBack _QS_randomUnit;
				0 = _QS_enemyArray pushBack _QS_randomUnit;
			};
			[(units _QS_group),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_QS_group setBehaviour 'SAFE';
			_QS_group setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _QS_group))],QS_system_AI_owners];
			_QS_group setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
			_QS_group setVariable ['QS_AI_GRP_TASK',['PATROL',_waypointPositions,serverTime,-1],QS_system_AI_owners];
			_QS_group setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
			_QS_group setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		};
	};
};

for '_x' from 0 to 14 step 1 do {
	_QS_buildingCivSelected = selectRandom _QS_buildingList;
	_QS_buildingPositions = _QS_buildingCivSelected buildingPos -1;
	_QS_buildingPositionSelected = selectRandom _QS_buildingPositions;
	if (!isNil '_QS_buildingPositionSelected') then {
		_QS_civilianType = selectRandom _QS_civilianTypes;
		_QS_civAgent = createAgent [_QS_civilianType,[0,0,600],[],0,'NONE'];
		_QS_civAgent allowDamage FALSE;
		_QS_civAgent setPosATL _QS_buildingPositionSelected;
		0 = _QS_allArray pushBack _QS_civAgent;
		0 = _QS_civArray pushBack _QS_civAgent;
		_QS_civAgent addEventHandler ['Killed',_QS_civKilled_EH];
		{
			_QS_civAgent setVariable _x;
		} forEach [
			['QS_civilian_interactable',TRUE,TRUE],
			['QS_civilian_interacted',FALSE,TRUE],
			['QS_civilian_suicideBomber',FALSE,TRUE],
			['QS_civilian_interactable',TRUE,TRUE],
			['QS_civilian_neutrality',0,TRUE],
			['QS_civilian_acting',FALSE,TRUE]
		];
		_QS_setDir = random 360;
		_QS_civAgent setDir _QS_setDir;
		_QS_civAgent setFormDir _QS_setDir;
		{
			_QS_civAgent enableAIFeature [_x,FALSE];
		} count [
			'FSM',
			'MOVE',
			'TARGET',
			'AUTOTARGET',
			'AIMINGERROR',
			'SUPPRESSION',
			'AUTOCOMBAT',
			'COVER'
		];
	} else {
		diag_log '***** QS ERROR ***** rescuePOW ***** _QS_buildingPositionSelected is Nil';
	};
};
{
	_QS_civ = _x;
	_QS_civ addEventHandler ['Killed',_QS_civKilled_EH];
	_QS_civ setVariable ['QS_civilian_interactable',TRUE,TRUE];
	_QS_civ setVariable ['QS_civilian_interacted',FALSE,TRUE];
	_QS_civ setVariable ['QS_civilian_suicideBomber',FALSE,TRUE];
	_QS_civ setVariable ['QS_civilian_interactable',TRUE,TRUE];
	_QS_civ setVariable ['QS_civilian_neutrality',0,TRUE];
	_QS_civ setVariable ['QS_civilian_acting',FALSE,TRUE];
	0 = _QS_allArray pushBack _QS_civ;
	0 = _QS_civArray pushBack _QS_civ;
} forEach ([_QS_locationCenterPos,(150 + (random 150)),'FOOT',15,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnAmbientCivilians'));
_QS_roadArrayRsc = ((_QS_locationCenterPos nearRoads 300) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []) && ((_x distance2D _QS_buildingPosATL) > 50))}) apply { [_x,(position _x)] };
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
{
	if ((vehicle _x) isKindOf 'CAManBase') then {
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
	};
} count _QS_enemyArray;

/*/============================================================== MISSION THREAD VARIABLES/*/

_QS_POW = missionNamespace getVariable 'QS_sideMission_POW';
_QS_BADGUY = missionNamespace getVariable 'QS_sideMission_BadGuy';

_QS_missionComplete = FALSE;
_QS_missionFailed = FALSE;
_QS_mission_startTime = time;
_QS_enemyDetected = FALSE;
_QS_enemyDetected_startTime = 0;
_QS_enemyDetected_endTime = 0;

missionNamespace setVariable ['QS_sideMission_POW_deathTimer',0,TRUE];

_QS_priorMissionStatistics = [0,0];
_QS_powRescued = FALSE;

missionNamespace setVariable ['QS_sideMission_POW_rescued',FALSE,TRUE];
missionNamespace setVariable ['QS_sideMission_POW_bleedTimer',0,FALSE];

_QS_powBleedout_timer_started = FALSE;
_QS_powBleedout_timer = 100 + (round (random 10));
_QS_qrfDeployed = FALSE;
_QS_qrfWaypointIssued = FALSE;

_QS_medicalTruck_detected = FALSE;
_QS_medicalTruck_checkDelay = time + 20;
_QS_medicalTruck_waypointCheckDelay = time + 20;

_QS_civiliansUnhappy = FALSE;
_QS_firstDetected = FALSE;
_QS_firstRun = TRUE;
_QS_firstRun_delay = time + 20;
_QS_killTimer_started = FALSE;
_QS_killTimerBroadcast_delay = 0;
_QS_bleedTimerBroadcast_delay = 0;
_QS_arr = [];
_QS_rescueWP_updateDelay = time + 10;

missionNamespace setVariable ['QS_sideMission_civsKilled',0,TRUE];

_QS_civilianNeutrality = 0;
if !(missionProfileNamespace isNil 'QS_sideMission_rescuePOW_statistics') then {
	_QS_priorMissionStatistics = missionProfileNamespace getVariable 'QS_sideMission_rescuePOW_statistics';
} else {
	missionProfileNamespace setVariable ['QS_sideMission_rescuePOW_statistics',_QS_priorMissionStatistics];
	saveMissionProfileNamespace;
};
_QS_priorMissionStatistics_completions = _QS_priorMissionStatistics # 0;
_QS_priorMissionStatistics_failures = _QS_priorMissionStatistics # 1;

missionNamespace setVariable ['QS_sideMission_POW_civIntel_quality',0,TRUE];

_QS_civIntelQuality_update = FALSE;
_QS_civIntelQuality_current = missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality';

/*/============================================================== COMMUNICATE TO PLAYERS/*/

_QS_fuzzyPos = [((_QS_buildingPosATL # 0) - 290) + (random 580),((_QS_buildingPosATL # 1) - 290) + (random 580),0];
'QS_marker_sideMarker' setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_040']);
{
	_x setMarkerPosLocal _QS_fuzzyPos;
	_x setMarkerAlpha 1;
} forEach ['QS_marker_sideMarker','QS_marker_sideCircle'];
[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		localize 'STR_QS_Task_103',
		localize 'STR_QS_Task_104',
		localize 'STR_QS_Task_104'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'heal',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['NewSideMission',[localize 'STR_QS_Notif_101']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
missionNamespace setVariable ['QS_sideMissionUp',TRUE,TRUE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];
missionNamespace setVariable ['QS_sideMission_POW_active',TRUE,TRUE];
_medevacBase = markerPos 'QS_marker_medevac_hq';

/*/============================================================== LOOP/*/

for '_x' from 0 to 1 step 0 do {
	/*/================================ MISSION FAILED/*/
	
	if (!alive _QS_POW) then {
		_QS_missionFailed = TRUE;
	};
	
	if (_QS_missionFailed) exitWith {
		['QS_IA_TASK_SM_0',FALSE,-1] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
		missionNamespace setVariable ['QS_sideMission_POW_active',FALSE,TRUE];
		missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];
		['ST_MEDEVAC',[localize 'STR_QS_Notif_102',localize 'STR_QS_Notif_105']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		'QS_marker_sideCircle' setMarkerSize [300,300]; 
		{
			_x setMarkerPosLocal [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		missionProfileNamespace setVariable [
			'QS_sideMission_rescuePOW_statistics',
			[
				((missionProfileNamespace getVariable 'QS_sideMission_rescuePOW_statistics') # 0),
				(((missionProfileNamespace getVariable 'QS_sideMission_rescuePOW_statistics') # 1) + 1)
			]
		];
		saveMissionProfileNamespace;
		sleep 10;
		_QS_missionAttempts = _QS_priorMissionStatistics_completions + (_QS_priorMissionStatistics_failures + 1);
		_QS_missionSuccessRate = (_QS_priorMissionStatistics_completions / _QS_missionAttempts) * 100;
		_text = parseText format [
			'%4 <br/>%5 %2<br/>%6 %1<br/>%7 %3 %8',
			_QS_priorMissionStatistics_completions,
			_QS_missionAttempts,
			(round _QS_missionSuccessRate),
			localize 'STR_QS_Hints_141',
			localize 'STR_QS_Hints_142',
			localize 'STR_QS_Hints_143',
			localize 'STR_QS_Hints_144',
			localize 'STR_QS_Hints_145'
		];
		['hint',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		sleep 15;
		[0,_QS_buildingPosATL] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		sleep 300;
		{
			if (!isNull _x) then {
				if (_x isEqualType objNull) then {
					0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
				};
			};
		} count _QS_allArray;
	};

	/*/================================ MISSION SUCCESS/*/
	
	if (((typeOf (vehicle _QS_POW)) in _QS_medicalVehicles) || {((_QS_pow distance _medevacBase) < 2.5)}) then {
		_QS_medVehCrew = crew (vehicle _QS_POW);
		_QS_medicInVehicle = FALSE;
		if ((count _QS_medVehCrew) > 0) then {
			{
				if (_x getUnitTrait 'medic') then {
					if (alive _x) then {
						_QS_medicInVehicle = TRUE;
					};
				};
				if (_QS_medicInVehicle) exitWith {};
			} count _QS_medVehCrew;
		};
		if (_QS_medicInVehicle) then {
			_QS_missionComplete = TRUE;
		};
		if ((_QS_pow distance _medevacBase) < 2.5) then {
			_QS_missionComplete = TRUE;
		};
	};
	
	if (_QS_missionComplete) exitWith {
		['QS_IA_TASK_SM_0',FALSE,-1] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
		missionNamespace setVariable ['QS_sideMission_POW_active',FALSE,TRUE];
		['ST_MEDEVAC',[localize 'STR_QS_Notif_103',localize 'STR_QS_Notif_106']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		'QS_marker_sideCircle' setMarkerSize [300,300]; 
		{
			_x setMarkerPos [-5000,-5000,0];
			_x setMarkerAlpha 0;
		} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
		missionProfileNamespace setVariable [
			'QS_sideMission_rescuePOW_statistics',
			[
				(((missionProfileNamespace getVariable 'QS_sideMission_rescuePOW_statistics') # 0) + 1),
				((missionProfileNamespace getVariable 'QS_sideMission_rescuePOW_statistics') # 1)
			]
		];
		saveMissionProfileNamespace;
		sleep 10;
		_QS_priorMissionStatistics_completions = _QS_priorMissionStatistics_completions + 1;
		_QS_missionAttempts = (_QS_priorMissionStatistics_completions + 1) + _QS_priorMissionStatistics_failures;
		_QS_missionSuccessRate = (_QS_priorMissionStatistics_completions / _QS_missionAttempts) * 100;
		_text = parseText format ['P.O.W. Rescue Mission Statistics: <br/>Attempts: %2<br/>Successful Completions: %1<br/>Success Rate: %3 percent',_QS_priorMissionStatistics_completions,_QS_missionAttempts,(round _QS_missionSuccessRate)];
		['hint',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		//moveOut _QS_POW;	// https://feedback.bistudio.com/T128186
		[90,_QS_POW,0] remoteExec ['QS_fnc_remoteExec',0,FALSE];
		deleteVehicle _QS_POW;
		missionNamespace setVariable ['QS_sideMission_POW',objNull,TRUE];
		[1,_QS_buildingPosATL] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
		sleep 120;
		{
			if (!isNull _x) then {
				if (_x isEqualType objNull) then {
					0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
				};
			};
		} count _QS_allArray;
	};
	
	/*/================================ PLAYERS NOT DETECTED YET/*/
	
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
			['ST_MEDEVAC',[localize 'STR_QS_Notif_104',localize 'STR_QS_Notif_107']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			if (alive _QS_BADGUY) then {	
				if ((_QS_BADGUY distance _QS_POW) < 8) then {
					_QS_dirTo = _QS_BADGUY getDir _QS_POW;
					_QS_BADGUY setDir _QS_dirTo;
					_QS_BADGUY playMoveNow 'AinvPercMstpSrasWrflDnon_Putdown_AmovPercMstpSrasWrflDnon';
				};
			};
			{
				if (alive _x) then {
					if ((random 1) > 0.8) then {
						_x setUnitPos 'Middle';
					};
				};
			} count _QS_enemyArray;
			
			_QS_arr = [_QS_POW] call _QS_pow_explosivesVest;
			{0 = _QS_allArray pushBack _x;} count _QS_arr;
			_QS_enemyDetected_endTime = serverTime + (720 + (random 400));
			_QS_killTimer_started = TRUE;
			['QS_IA_TASK_SM_0',TRUE,_QS_enemyDetected_endTime] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
		};
	};
	
	/*/================================ PLAYERS DETECTED/*/
	
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
					_QS_clearPos = ['RADIUS',_QS_buildingPosATL,800,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
					if ((count _QS_clearPos) > 0) then {
						if (([_QS_clearPos,300,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
							_QS_positionAccepted = TRUE;
						};
					};
					if (_QS_positionAccepted) exitWith {};
				};
				_QS_qrfGroup = [_QS_clearPos,(random 360),EAST,'OI_reconTeam',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
				_QS_qrfGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
				{0 = _QS_allArray pushBack _x;_x enableStamina FALSE;_x enableFatigue FALSE;_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];} count (units _QS_qrfGroup);
				[(units _QS_qrfGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				{
					[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
					_x enableAIFeature ['AUTOCOMBAT',FALSE];
					0 = _QS_enemyArray pushBack _x;
				} count (units _QS_qrfGroup);
			};
			
			/*/========== Timer Expired/*/
			
			if (serverTime > _QS_enemyDetected_endTime) then {
				if (!(_QS_powRescued)) then {
					/*/ Detonate explosives Vest /*/
					_QS_POW setDamage 1;
					['systemChat',localize 'STR_QS_Chat_154'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				};
			};
		};
	};
	
	if (_QS_qrfDeployed) then {
		if (time > _QS_medicalTruck_checkDelay) then {
			_QS_medicalTruck_waypointCheckDelay = time + 20;
			_QS_medicalTruck_checkDelay = time + 20;
			_QS_nearVehicles = _QS_buildingPosATL nearEntities [_QS_medicalVehicles,1000];
			if ((count _QS_nearVehicles) > 0) then {
				_QS_targetVehicle = _QS_nearVehicles # 0;
				_QS_qrfWaypointIssued = TRUE;
				_QS_qrfGroup move (getPosATL _QS_targetVehicle);
			} else {
				_QS_qrfWaypointIssued = TRUE;
				_QS_qrfGroup move (getPosATL _QS_POW);
			};
		};
	};
	
	/*/================================ POW HAS BEEN RESCUED, START BLEEDOUT TIMER/*/
	
	if (!(_QS_powRescued)) then {
		if (missionNamespace getVariable 'QS_sideMission_POW_rescued') then {
			_QS_powRescued = TRUE;
			_QS_powBleedout_timer = serverTime + 600 + (round (random 400));
			_QS_powBleedout_timer_started = TRUE;
			['QS_IA_TASK_SM_0',_QS_POW] call (missionNamespace getVariable 'BIS_fnc_taskSetDestination');
			['QS_IA_TASK_SM_0',TRUE,_QS_powBleedout_timer] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
			{
				_x setMarkerAlpha 0;
			} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
			['systemChat',localize 'STR_QS_Chat_155'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			['ST_MEDEVAC',[localize 'STR_QS_Notif_104',localize 'STR_QS_Notif_108']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			if ((attachedObjects _QS_POW) isNotEqualTo []) then {
				deleteVehicle (attachedObjects _QS_POW);
			};
		};
	};
	
	/*/==================== Civilian Communication State/*/
	
	if ((missionNamespace getVariable 'QS_sideMission_civsKilled') > 0) then {
		if (!(_QS_civiliansUnhappy)) then {
			['ST_MEDEVAC',[localize 'STR_QS_Notif_104',localize 'STR_QS_Notif_109']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			_QS_civiliansUnhappy = TRUE;
			{
				_QS_civ = _x;
				if (!isNull _QS_civ) then {
					if (alive _QS_civ) then {
						_QS_civ setVariable ['QS_civilian_neutrality',-1,TRUE];
					};
				};
			} count _QS_civArray;
		};
	};
	{
		_QS_civ = _x;
		if (alive _QS_civ) then {
			if !(_QS_civ isNil 'QS_civilian_interacted') then {
				if (_QS_civ getVariable 'QS_civilian_interacted') then {
					if !(_QS_civ isNil 'QS_civilian_suicideBomber') then {
						if (_QS_civ getVariable 'QS_civilian_suicideBomber') then {
							_QS_arr = [_QS_civ] call _QS_pow_explosivesVest;
							_QS_civ setVariable ['QS_civilian_acting',TRUE,TRUE];
							uiSleep 3;
							'M_AT' createVehicle (position _QS_civ);
							deleteVehicle _QS_arr;
						};
					};
					if !(_QS_civ isNil 'QS_civilian_alertingEnemy') then {
						if (_QS_civ getVariable 'QS_civilian_alertingEnemy') then {
							if !(_QS_civ isNil 'QS_civilian_acting') then {
								if (!(_QS_civ getVariable 'QS_civilian_acting')) then {
									_QS_civ setVariable ['QS_civilian_acting',TRUE,TRUE];
								} else {
									if ((_QS_civ distance _QS_buildingPosATL) < 15) then {
										_QS_enemyDetected = TRUE;
									};
								};
							};
						};
					};
				};
			};
		};
	} count _QS_civArray;
	if (_QS_civIntelQuality_current isNotEqualTo (missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality')) then {
		if ((missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality') isEqualTo 1) then {
			_QS_civIntelQuality_current = missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality';
			_QS_newRadius = 125;
			'QS_marker_sideCircle' setMarkerSize [_QS_newRadius,_QS_newRadius]; 
			_QS_fuzzyPos = [((_QS_buildingPosATL # 0) - 125) + (random 250),((_QS_buildingPosATL # 1) - 125) + (random 250),0];
			{_x setMarkerPos _QS_fuzzyPos;} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
			['QS_IA_TASK_SM_0',(markerPos 'QS_marker_sideMarker')] call (missionNamespace getVariable 'BIS_fnc_taskSetDestination');
		};
		if ((missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality') isEqualTo 2) then {
			_QS_civIntelQuality_current = missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality';
			_QS_newRadius = 50;
			'QS_marker_sideCircle' setMarkerSize [_QS_newRadius,_QS_newRadius]; 
			_QS_fuzzyPos = [((_QS_buildingPosATL # 0) - 50) + (random 100),((_QS_buildingPosATL # 1) - 50) + (random 100),0];
			{_x setMarkerPos _QS_fuzzyPos;} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
			['QS_IA_TASK_SM_0',(markerPos 'QS_marker_sideMarker')] call (missionNamespace getVariable 'BIS_fnc_taskSetDestination');
		};
		if ((missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality') isEqualTo 3) then {
			_QS_civIntelQuality_current = missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality';
			_QS_newRadius = 10;
			'QS_marker_sideCircle' setMarkerSize [_QS_newRadius,_QS_newRadius]; 
			_QS_fuzzyPos = [((_QS_buildingPosATL # 0) - 10) + (random 20),((_QS_buildingPosATL # 1) - 10) + (random 20),0];
			{_x setMarkerPos _QS_fuzzyPos;} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
			['QS_IA_TASK_SM_0',(markerPos 'QS_marker_sideMarker')] call (missionNamespace getVariable 'BIS_fnc_taskSetDestination');
		};
	};
	if (_QS_firstRun) then {
		if (time > _QS_firstRun_delay) then {
			{_x allowDamage TRUE;} count _QS_allArray;
			_QS_firstRun = FALSE;
			_QS_POW allowDamage TRUE;
			_QS_BADGUY allowDamage TRUE;
		};
	};
	
	/*/========== Timers/*/
	
	if (!(_QS_powRescued)) then {
		if (_QS_killTimer_started) then {
			if (serverTime > _QS_enemyDetected_endTime) then {
				'M_AT' createVehicle (getPosATL _QS_POW);
				_QS_POW setDamage 1;
			};
		};
	};
		
	if (_QS_powRescued) then {
		if (time > _QS_rescueWP_updateDelay) then {
			{
				if (alive _x) then {
					if ((_x distance2D _QS_POW) < 3000) then {
						doStop _x;
						_x doMove (getPosATL _QS_POW);
					};
				};
			} count _QS_enemyArray;
			_QS_rescueWP_updateDelay = time + 10;
		};
		if ((damage _QS_POW) < 0.4) then {
			_QS_POW setDamage [0.5,FALSE];
		};
		if (_QS_powBleedout_timer_started) then {
			/*/
			if (time > _QS_bleedTimerBroadcast_delay) then {
				_QS_text = format ['P.O.W. will bleed out in: %1',[((round(_QS_powBleedout_timer - time))/60)+0.01,'HH:MM'] call (missionNamespace getVariable 'BIS_fnc_timeToString')];
				['systemChat',_QS_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				_QS_bleedTimerBroadcast_delay = time + 25;
			};
			/*/
			if (serverTime > _QS_powBleedout_timer) then {
				_QS_POW setDamage [1,TRUE];
			};
		};
		if (local _QS_POW) then {
			{
				_QS_POW enableAIFeature [_x,FALSE];
			} forEach [
				'MOVE','FSM','PATH'
			];
		};
	};
	sleep 0.5;
};