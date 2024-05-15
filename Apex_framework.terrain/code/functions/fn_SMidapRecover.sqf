/*/
File: idapRecover.sqf
Author:

	Quiksilver
	
Last Modified:

	17/11/2023 A3 2.14 by Quiksilver
	
Description:
	
	Recover some stuff stolen from an IDAP supply depot
_________________________________________________/*/

scriptName 'Side Mission - IDAP Recover';
_validTerrains = ['Altis','Tanoa','Malden','Enoch'];
if (!(worldName in _validTerrains)) exitWith {
	diag_log '***** Side mission IDAP RECOVER invalid terrain *****';
};
private _allArray = [];
private _unitArray = [];
private _enemyArray1 = [];
private _enemyArray2 = [];
private _enemyArray3 = [];
private _agentArray = [];
_fn_serverDetector = missionNamespace getVariable 'QS_fnc_serverDetector';
_fn_findSafePos = missionNamespace getVariable 'QS_fnc_findSafePos';
_fn_smIDAP = missionNamespace getVariable 'QS_fnc_smIDAP';
_validBuildingTypes = [
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
//comment 'Find position';
private _idapScenePosition = [0,0,0];
private _allPlayers = allPlayers;
_basePosition = markerPos 'QS_marker_base_marker';
_baseRadius = [1500,750] select (worldName isEqualTo 'Tanoa');
_fobPosition = markerPos 'QS_marker_module_fob';
_fobRadius = 300;
for '_x' from 0 to 299 step 1 do {
	_idapScenePosition = ['WORLD',-1,-1,'LAND',[10,-1,0.2,20,0,FALSE,objNull],TRUE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (
		((([(_idapScenePosition # 0),(_idapScenePosition # 1)] nearRoads 25) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo []) &&
		{((([(_idapScenePosition # 0),(_idapScenePosition # 1)] nearRoads 100) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isNotEqualTo [])} &&
		{((_allPlayers inAreaArray [_idapScenePosition,300,300,0,FALSE]) isEqualTo [])} &&
		{(!([_idapScenePosition,50,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))} &&
		{((_idapScenePosition distance2D _basePosition) > _baseRadius)} &&
		{((_idapScenePosition distance2D _fobPosition) > _fobRadius)}
	) exitWith {};
};
//comment 'Spawn IDAP scene';
//comment 'To do: 3 different scenes';
_scenes = [
	'QS_data_siteIDAPSupply_1'
];
_composition = [
	["Land_PaperBox_01_small_open_brown_IDAP_F",[-0.205566,0.450684,0],226.736,[],false,false,TRUE,{}],
	["Land_PaperBox_01_small_closed_white_IDAP_F",[1.38965,-0.00366211,0.0239992],225.339,[],false,false,TRUE,{}],
	["Land_PaperBox_01_small_closed_white_med_F",[1.34375,-0.788818,0.0240002],269.84,[],false,false,TRUE,{}],
	["Land_Garbage_square3_F",[-0.829102,1.52588,0],216.529,[],false,false,TRUE,{}],
	["Box_IDAP_Equip_F",[1.1167,1.4668,0.0240002],359.998,[],false,false,false,{(_this # 0) setVariable ['QS_interaction_disabled',TRUE,TRUE];(_this # 0) setVariable ['QS_curator_disableEditability',TRUE,FALSE];(_this # 0);}],
	["Land_MedicalTent_01_floor_light_F",[-2.0957,0.205566,0],0,[],false,false,TRUE,{}],
	["Land_PaperBox_01_small_closed_brown_IDAP_F",[0.925781,-2.00195,0.0239997],175.629,[],false,false,TRUE,{}],
	["Land_MedicalTent_01_white_IDAP_open_F",[-1.87842,0.0510254,0],0,[],false,false,false,{}],
	["Land_Garbage_square5_F",[-1.60205,-1.68433,0],0,[],false,false,TRUE,{}],
	["Land_PaperBox_01_small_closed_brown_IDAP_F",[0.591797,-2.70361,0.0239997],269.33,[],false,false,TRUE,{}],
	["Land_CampingChair_V2_white_F",[-0.229004,2.78223,0.0240054],226.776,[],false,false,false,{}],
	["Land_PaperBox_01_small_closed_brown_IDAP_F",[1.18799,-2.6958,0.0240002],116.207,[],false,false,TRUE,{}],
	["Land_PaperBox_01_small_open_brown_F",[-2.59863,-1.68677,0],147.061,[],false,false,TRUE,{}],
	["Land_EmergencyBlanket_02_stack_F",[1.22754,2.94873,0.0240002],0.000206766,[],false,false,TRUE,{}],
	["Land_PaperBox_01_small_ransacked_brown_F",[-3.5293,0.553223,0],120.114,[],false,false,TRUE,{}],
	["Land_PaperBox_01_small_closed_brown_IDAP_F",[0.530762,-3.53174,0.0239997],116.208,[],false,false,TRUE,{}],
	["Land_PaperBox_01_small_closed_brown_IDAP_F",[1.14111,-3.49829,0.0239997],270.803,[],false,false,TRUE,{}],
	["Land_CampingTable_white_F",[1.07666,3.57129,0.0239997],267.51,[],false,false,false,{}],
	["Land_CampingTable_small_white_F",[0.144043,4.10742,0.0239997],177.626,[],false,false,false,{}],
	["Land_FoodContainer_01_White_F",[0.220703,4.19629,0.0240068],359.991,[],false,false,TRUE,{}],
	["Land_Stretcher_01_folded_F",[-4.4917,-0.55957,0.0240002],267.445,[],false,false,TRUE,{}],
	["Land_Stretcher_01_folded_F",[-4.51221,-0.902344,0.0240002],267.445,[],false,false,TRUE,{}],
	["Land_Stretcher_01_folded_F",[-4.53955,-1.23242,0.0240002],267.445,[],false,false,TRUE,{}],
	["Land_PlasticCase_01_large_idap_F",[-4.84863,0.563477,0.0240006],141.195,[],false,false,false,{(_this # 0) setVariable ['QS_interaction_disabled',TRUE,TRUE];(_this # 0);}],
	["Land_PaperBox_01_small_closed_brown_IDAP_F",[-4.59521,-1.92725,0.0240002],116.207,[],false,false,TRUE,{}],
	["Land_PlasticCase_01_large_idap_F",[-4.93799,2.09912,0.0239997],183.922,[],false,false,TRUE,{}],
	["Land_FoodSacks_01_small_white_idap_F",[-4.17383,-3.59814,0.0240002],269.781,[],false,false,TRUE,{}],
	["Land_FoodContainer_01_White_F",[-3.53418,4.25049,0.0240068],359.991,[],false,false,TRUE,{}],
	["Land_EmergencyBlanket_02_stack_F",[-5.3833,-1.68066,0.0240002],0.00218866,[],false,false,TRUE,{}],
	["Land_EmergencyBlanket_02_stack_F",[-5.4165,-2.10913,0.0240002],0.00218866,[],false,false,TRUE,{}],
	["Land_PlasticCase_01_large_idap_F",[-4.47754,3.7168,0.0240006],240.538,[],false,false,false,{(_this # 0) setVariable ['QS_interaction_disabled',TRUE,TRUE];(_this # 0);}],
	["C_IDAP_Truck_02_F",[5.73877,1.8125,0.0442343],0.00148999,[],false,false,false,{(_this # 0) lock 2;(_this # 0) enableVehicleCargo FALSE;(_this # 0) enableRopeAttach FALSE;(_this # 0) setVariable ['QS_curator_disableEditability',TRUE,FALSE];(_this # 0);}],
	["Land_PaperBox_01_small_closed_brown_F",[-5.32422,-4.05298,0.023973],68.5451,[],false,false,TRUE,{}],
	["Land_Net_FenceD_8m_F",[4.28027,7.11304,0],0,[],false,false,false,{}],
	["Land_WheelieBin_01_F",[0.111816,-8.37134,0.0240202],178.618,[],false,false,false,{}],
	["Land_WheelieBin_01_F",[-0.552246,-8.37573,0.0240211],178.603,[],false,false,false,{}],
	["Land_Net_Fence_8m_F",[-3.69824,-8.97339,0],179.595,[],false,false,false,{}],
	["Land_PaperBox_01_small_stacked_F",[-9.0957,-1.04272,0.0240006],179.618,[],false,false,TRUE,{}],
	["Land_Net_Fence_8m_F",[2.37012,7.05811,0],180.311,[],false,false,false,{}],
	["Land_Net_Fence_8m_F",[-2.43213,6.95508,0],0.492948,[],false,false,false,{}],
	["C_IDAP_Van_02_vehicle_F",[9.3125,2.05249,0.0848665],0.000515136,[],false,false,false,{(_this # 0) lock 2;(_this # 0) enableVehicleCargo FALSE;(_this # 0) enableRopeAttach FALSE;(_this # 0) setVariable ['QS_curator_disableEditability',TRUE,FALSE];(_this # 0);}], 
	["Land_Sign_WarningNoWeapon_F",[3.12988,-9.2605,0],0,[],false,false,false,{}],
	["Flag_IDAP_F",[3.50391,-8.65796,0],0,[],false,true,false,{}], 
	["Land_FieldToilet_F",[-8.99414,-5.93384,0.0240054],269.987,[],false,false,TRUE,{}],
	["Land_Net_Fence_8m_F",[-10.4458,-0.914307,0],90.1643,[],false,false,false,{}],
	["Land_Net_Fence_8m_F",[-2.55664,-8.93701,0],0,[],false,false,false,{}],
	["Tire_Van_02_F",[11.1294,-0.251465,0.0240002],2.36354e-005,[],false,false,TRUE,{}],
	["Land_Net_Fence_8m_F",[-10.4487,-0.946045,0],270.329,[],false,false,false,{}],
	["Land_Net_Fence_Gate_F",[12.3018,-9.02319,0],0,[],false,true,false,{}],
	["Land_PaperBox_01_small_stacked_F",[-9.36426,-7.62183,0.0240002],179.617,[],false,false,TRUE,{}],
	["Land_LampShabby_F",[-10.1895,6.77344,0],139.81,[],false,true,false,{}], 
	["Land_WaterBottle_01_stack_F",[12.6294,1.07324,0.0291462],360,[],false,false,TRUE,{}],
	["Land_FoodSack_01_full_white_idap_F",[13.6191,-1.97363,0.0240002],236.526,[],false,false,TRUE,{}],
	["Land_LampShabby_F",[-10.3164,-8.75342,0],42.4054,[],false,true,false,{}], 
	["Land_FoodSacks_01_large_white_idap_F",[14.2363,-0.9021,0.0240002],277.766,[],false,false,TRUE,{}],
	["Land_FoodSacks_01_small_white_idap_F",[14.418,-2.02002,0.0240002],360,[],false,false,TRUE,{}],
	["Land_Cargo20_IDAP_F",[14.2031,3.91797,0.0240016],179.372,[],false,false,TRUE,{}],
	["Land_FoodSacks_01_cargo_white_idap_F",[14.8013,1.12427,0.0239997],90.0566,[],false,false,TRUE,{}],
	["Land_Net_Fence_8m_F",[10.2603,7.0415,0],180.311,[],false,false,false,{}],
	["Land_PaperBox_01_small_stacked_F",[14.1304,-7.65723,0.0240006],179.618,[],false,false,TRUE,{}],
	["Land_FoodSacks_01_cargo_white_idap_F",[16.292,1.1416,0.0240002],2.45896e-005,[],false,false,TRUE,{}],
	["Land_FoodSacks_01_cargo_white_idap_F",[16.4629,-0.996094,0.0240002],0.000610713,[],false,false,TRUE,{}],
	["Land_Net_Fence_8m_F",[18.2134,-8.94385,0],359.416,[],false,false,false,{}],
	["C_IDAP_supplyCrate_F",[16.7422,-2.97461,0.0240006],270.295,[],false,false,false,{(_this # 0) enableVehicleCargo FALSE;(_this # 0) enableRopeAttach FALSE;(_this # 0) setVariable ['QS_curator_disableEditability',TRUE,FALSE];(_this # 0);}],
	["Land_PaperBox_01_small_stacked_F",[15.8887,-7.61987,0.0240002],179.616,[],false,false,TRUE,{}],
	["Land_Net_Fence_8m_F",[18.1089,-0.992432,0],90.6397,[],false,false,false,{}],
	["Land_Net_Fence_8m_F",[18.1104,-0.993164,0],269.266,[],false,false,false,{}],
	["Land_LampShabby_F",[17.9814,6.82007,0],227.974,[],false,true,false,{}],
	["Land_LampShabby_F",[17.9429,-8.64966,0],317.324,[],false,true,false,{}]
];
_idapComposition = [
	_idapScenePosition,
	(random 360),
	_composition
] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
_uniforms = ['U_C_IDAP_Man_cargo_F','U_C_IDAP_Man_casual_F','U_C_IDAP_Man_Jeans_F','U_C_IDAP_Man_shorts_F','U_C_IDAP_Man_Tee_F','U_C_IDAP_Man_TeeShorts_F'];
_vests = ['',0.55,'V_Plain_crystal_F',0.15,'V_Plain_medical_F',0.15,'V_Safety_orange_F',0.15];
_headgear = ['',0.25,'H_Cap_Orange_IDAP_F',0.25,'H_Cap_White_IDAP_F',0.25,'H_Cap_Black_IDAP_F',0.25];
_backpacks = ['',0.55,'B_Messenger_Gray_Medical_F',0.15,'B_Messenger_IDAP_F',0.15,'B_Messenger_IDAP_Medical_F',0.15];
_idapTypes = ['C_IDAP_Man_AidWorker_01_F','C_IDAP_Man_AidWorker_07_F','C_IDAP_Man_AidWorker_08_F','C_IDAP_Man_AidWorker_09_F','C_IDAP_Man_AidWorker_02_F','C_IDAP_Man_AidWorker_05_F','C_IDAP_Man_AidWorker_06_F','C_IDAP_Man_AidWorker_04_F','C_IDAP_Man_AidWorker_03_F'];
_bloodTypes = ['BloodPool_01_Large_New_F','BloodPool_01_Medium_New_F','BloodSplatter_01_Large_New_F','BloodSplatter_01_Medium_New_F'];
private _agent = objNull;
private _blood = objNull;
private _emptyPosition = [0,0,0];
for '_x' from 0 to (4 + (round (random 3))) step 1 do {
	_emptyPosition = [_idapScenePosition,1,15,0.5,0,0.5,0] call _fn_findSafePos;
	_agent = createAgent [(selectRandom _idapTypes),_emptyPosition,[],0,'CAN_COLLIDE'];
	_agent setDir (random 360);
	_agent setDamage 0.75;
	_agent setUnitLoadout [
		[],
		[],
		[],
		[(selectRandom _uniforms),[]],
		[(selectRandomWeighted _vests),[]],
		[(selectRandomWeighted _backpacks),[]],
		(selectRandomWeighted _headgear),
		'',
		[],
		[]
	];
	_agent enableAIFeature ['ANIM',FALSE];
	_agent enableAIFeature ['ALL',FALSE];
	removeAllAssignedItems _agent;
	removeAllItems _agent;
	{
		_agent setVariable _x;
	} forEach [
		['QS_entity_examine',TRUE,TRUE],
		['QS_entity_examined',FALSE,TRUE],
		['QS_noHeal',TRUE,TRUE],
		['QS_curator_disableEditability',TRUE,FALSE],
		['QS_dead_prop',TRUE,TRUE],
		['QS_dynSim_ignore',TRUE,TRUE]
	];
	_allArray pushBack _agent;
	_agentArray pushBack _agent;
	_agent setPos _emptyPosition;
	[_agent,'unconscious'] remoteExec ['switchMove',0,_agent];
	_blood = createVehicle [(selectRandom _bloodTypes),_idapScenePosition,[],0,'CAN_COLLIDE'];
	_blood setDir (random 360);
	_blood setPos _emptyPosition;
	[_agent,_blood,FALSE] call (missionNamespace getVariable 'QS_fnc_attachToRelative');
	_agent spawn {
		uiSleep (3 + (random 3));
		//_this setDamage [1,TRUE];
		[0,_this] call QS_fnc_eventAttach;
	};
	_allArray pushBack _blood;
};

//comment 'Add examine intel';

private _enableDocumentTask = TRUE;
private _documentTask = FALSE;
private _intelDocument = objNull;
if (_enableDocumentTask) then {
	if ((random 1) > 0.666) then {
		private _documentTables = [];
		private _documentTable = objNull;
		{
			if ( (toLowerANSI ((getModelInfo _x) # 1)) in ['a3\structures_f\civ\camping\campingtable_small_f.p3d','a3\structures_f\civ\camping\campingtable_f.p3d']) then {
				_documentTables pushBack _x;
			};
		} forEach _idapComposition;
		if (_documentTables isNotEqualTo []) then {
			_documentTask = TRUE;
			_documentTable = selectRandom _documentTables;
			_intelDocument = createSimpleObject ['Land_File1_F',(getPosASL _documentTable)];
			[1,_intelDocument,[_documentTable,[(-0.3 + (random 0.6)),0.35,0.43]]] call QS_fnc_eventAttach;
			_intelDocument setDir (random 360);
			_allArray pushBack _intelDocument;
			_idapComposition pushBack _intelDocument;
			{
				_intelDocument setVariable _x;
			} forEach [
				['QS_entity_examine',TRUE,TRUE],
				['QS_entity_examined',FALSE,TRUE],
				['QS_entity_examine_intel',2,TRUE],
				['QS_dynSim_ignore',TRUE,TRUE]
			];
		};
	};
};

_intelCount = 3;
_intelAgentArray = [];
for '_x' from 0 to (_intelCount - 1) step 1 do {
	_agent = selectRandom _agentArray;
	_agentArray deleteAt (_agentArray find _agent);
	_agent setVariable ['QS_entity_examine_intel',1,TRUE];
	_intelAgentArray pushBack _agent;
};

//comment 'Spawn recoverable unit';

_emptyPosition = [_idapScenePosition,1,12,0.5,0,0.5,0] call _fn_findSafePos;
_recoverableUnit = createAgent [(selectRandom _idapTypes),[-50,-50,0],[],0,'CAN_COLLIDE'];
_recoverableUnit setDir (random 360);
_recoverableUnit setDamage 0.75;
_recoverableUnit allowDamage FALSE;
_recoverableUnit enableAIFeature ['ANIM',FALSE];
_recoverableUnit enableAIFeature ['MOVE',FALSE];
removeAllAssignedItems _recoverableUnit;
removeAllItems _recoverableUnit;
_recoverableUnit setUnitLoadout [
	[],
	[],
	[],
	[(selectRandom _uniforms),[]],
	[(selectRandomWeighted _vests),[]],
	[(selectRandomWeighted _backpacks),[]],
	(selectRandomWeighted _headgear),
	'',
	[],
	[]
];
{
	_recoverableUnit setVariable _x;
} forEach [
	['QS_dynSim_ignore',TRUE,TRUE],
	['QS_revive_disable',TRUE,TRUE],
	['QS_unit_needsStabilise',TRUE,TRUE],
	['QS_noHeal',TRUE,TRUE],
	['QS_curator_disableEditability',TRUE,FALSE]
];
_allArray pushBack _recoverableUnit;
_recoverableUnit setPos _emptyPosition;
_recoverableUnit setUnconscious TRUE;
_recoverableUnit spawn {
	uiSleep 10;
	_this switchMove ['acts_InjuredLyingRifle02'];
	['switchMove',_this,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
};
private _enemyDelay = 30;
private _enemyCheckDelay = time + _enemyDelay;
private _enemyArray1_threshold = 4;
private _enemyArray2_threshold = 6;
_enemyArray1 = [_idapScenePosition,0,0] call _fn_smIDAP;

//comment 'Create some enemies at IDAP scene';

//comment 'Wait for intel found';

private _uncertainPosition = [
	((_idapScenePosition # 0) + 300 - (random 600)),
	((_idapScenePosition # 1) + 250 - (random 600)),
	0
];
'QS_marker_sideMarker' setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_034']);
{
	_x setMarkerPosLocal _uncertainPosition;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
[
	'QS_TASK_SM_IDAP_1',
	TRUE,
	[
		(format [
			'<br/>%1<br/>%2<br/>%3<br/>%4<br/>%5<br/><br/><br/>%6<br/><br/>%7<br/><br/>%8',
			localize 'STR_QS_Task_085',
			localize 'STR_QS_Task_086',
			localize 'STR_QS_Task_087',
			localize 'STR_QS_Task_088',
			localize 'STR_QS_Task_089',
			localize 'STR_QS_Task_090',
			localize 'STR_QS_Task_091',
			localize 'STR_QS_Task_092'
		]),
		localize 'STR_QS_Task_084',
		localize 'STR_QS_Task_084'
	],
	_uncertainPosition,
	'CREATED',
	5,
	FALSE,
	TRUE,
	'Help',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['SM_IDAP_BRIEF',[localize 'STR_QS_Notif_081',localize 'STR_QS_Notif_088']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
for '_x' from 0 to 1 step 0 do {
	sleep 3;
	if (
		(({(_x getVariable ['QS_entity_examined',FALSE])} count _intelAgentArray) isEqualTo _intelCount) ||
		(({(!isNull _x)} count _intelAgentArray) < (count _intelAgentArray))
	) exitWith {};
};
{
	_x setVariable ['QS_entity_examine',FALSE,TRUE];
} forEach _agentArray;
//comment 'Stage 2';
private _sceneChance = [];
for '_x' from 0 to 5 step 1 do {
	_sceneChance pushBack (selectRandom [0,1,0]);
};
_sceneChance pushBack 1;
//comment 'Find stage 2 position';
_findHouse = {
	params ['_centerPos','_minRadius','_maxRadius','_validHouseTypes','_usedPositions'];
	private _house = objNull;
	private _list = [(_centerPos # 0),(_centerPos # 1)] nearObjects ['House',_maxRadius];
	_list = _list select {(((typeOf _x) in _validHouseTypes) && ((_x distance2D _centerPos) > _minRadius) && ((_x buildingPos -1) isNotEqualTo []))};
	if (_list isNotEqualTo []) then {
		_house = selectRandom _list;
	};
	_house;
};
private _currentSceneChance = 0;
private _house = objNull;
private _housePosition = [0,0,0];
private _houseFound = FALSE;
private _findNewLocation = TRUE;
private _usedPositions = [[-1000,-1000,0]];
private _initLocation = FALSE;
private _searchMinRadius = 600;
private _searchMaxRadius = 1800;
private _searchAttempt = 0;

private _unit = objNull;
private _grp = grpNull;
private _sceneType = -1;

private _monitorScene = FALSE;

private _crate = objNull;
private _crateType = 'box_c_idap_uav_06_medical_f';
private _crateIcon = 'a3\ui_f\data\map\VehicleIcons\iconcrate_ca.paa';
private _iconData = [];
private _iconID = 'QS_sm_crateIcon';

private _taskState = 'CREATED';

private _houseBuildingPositions = [];
private _cratePosition = [0,0,0];
private _cratePositionIndex = -1;

private _crateCompletionRadius = 6;
private _crateState = 'DETACHED';
private _crateAttachedTo = objNull;
private _crateSpawned = FALSE;
private _timeoutFailsafe = -1;

private _houseMarker = '';
private _houseFoundAttempts = 0;

private _sceneForceProtectionTypes = [0,1];
private _sceneForceProtection = 0;

private _houseForceProtectionTypes = [0,1];
private _houseForceProtection = 0;

private _spawnPosition = [0,0,0];
private _spawnArray = [];

private _houseMines = [];

private _medevacTime = 1800;
private _medevacTimeout = -1;
private _medevacTaskID = 'QS_IA_TASK_SM_2';
private _headBandage = selectRandom ['H_HeadBandage_stained_F','H_HeadBandage_bloody_F'];

private _truckPos = [0,0,0];
private _spawnPos = [0,0,0];
private _truckTypes = [];
private _truck = objNull;
private _suppliesFound = FALSE;
private _truckType = '';

missionNamespace setVariable ['QS_sidemission_buildingDestroyed',FALSE,FALSE];

scopeName 'main';

_medevacBase = markerPos 'QS_marker_medevac_hq';

private _woundedSounds = TRUE;
private _woundedSoundsDelay = 10;
private _woundedSoundsCheckDelay = time + _woundedSoundsDelay;
private _sound = '';
private _soundPosASL = [0,0,0];
private _headPos = [0,0,0];
private _sounds = [
	'A_01','A_02','A_03','A_04','A_05','A_06','A_07','A_08',
	'B_01','B_02','B_03','B_04','B_05','B_06','B_07','B_08',
	'C_01','C_02','C_03','C_04','C_05'
];	
private _unitStabilised = FALSE;
private _aidMarker = '';
_aidMarker = createMarker [(format ['QS_marker_aid_%1',(str (random 10e3))]),[0,0,0]];
_aidMarker setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_035']);
_aidMarker setMarkerPosLocal (getPosATL _recoverableUnit);
_aidMarker setMarkerShapeLocal 'ICON';
_aidMarker setMarkerSizeLocal [0.5,0.5];
_aidMarker setMarkerColorLocal 'ColorGREEN';
_aidMarker setMarkerTypeLocal 'mil_triangle';
_aidMarker setMarkerAlpha 1;

for '_x' from 0 to 1 step 0 do {
	if (_woundedSounds) then {
		if (time > _woundedSoundsCheckDelay) then {
			if (_recoverableUnit getVariable ['QS_unit_needsStabilise',FALSE]) then {
				playSound3D [(format ['A3\Missions_F_EPA\data\sounds\WoundedGuy%1.wss',(selectRandom _sounds)]),_recoverableUnit,FALSE,(_recoverableUnit modelToWorldWorld (_recoverableUnit selectionPosition ['head','hitpoints'])),6,1,25];
			};
			_woundedSoundsCheckDelay = time + (random [7,10,16]);
		};
	};
	if (_taskState isEqualTo 'SUCCEEDED') exitWith {
		['SM_IDAP_BRIEF',[localize 'STR_QS_Notif_081',localize 'STR_QS_Notif_089']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		sleep 5;
		[1,[0,0,0]] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
	};
	if (_taskState isEqualTo 'FAILED') exitWith {
		['SM_IDAP_BRIEF',[localize 'STR_QS_Notif_081',localize 'STR_QS_Notif_090']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		sleep 5;
		[0,[0,0,0]] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
	};	
	if (_findNewLocation) then {
		_houseFoundAttempts = 0;
		_searchMaxRadius = 1800;
		_allPlayers = allPlayers;
		for '_x' from 0 to 1 step 0 do {
			_house = [_idapScenePosition,_searchMinRadius,_searchMaxRadius,_validBuildingTypes,_usedPositions] call _findHouse;
			if (!isNull _house) then {
				_house allowDamage FALSE;
				_housePosition = position _house;
				if ((_usedPositions inAreaArray [_housePosition,300,300,0,FALSE]) isEqualTo []) then {
					if ((_allPlayers inAreaArray [_housePosition,300,300,0,FALSE]) isEqualTo []) then {
						if ((_housePosition distance2D _basePosition) > 500) then {
							_houseFound = TRUE;
							_findNewLocation = FALSE;
							_initLocation = TRUE;
							_monitorScene = TRUE;
							_sceneType = 0;
						};
					};
				};
			};
			if (_houseFound) exitWith {};
			if (_houseFoundAttempts > 50) then {
				_searchMaxRadius = _searchMaxRadius + 50;
			};
			_houseFoundAttempts = _houseFoundAttempts + 1;
		};
	};
	if (_initLocation) then {
		_initLocation = FALSE;
		if (_sceneType isEqualTo 0) then {
			missionNamespace setVariable ['QS_sidemission_building',_house,FALSE];
			_housePosition = position _house;
			_houseMarker = createMarker [(format ['QS_marker_house_%1',(str (random 10e3))]),[0,0,0]];
			_houseMarker setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_036']);
			_houseMarker setMarkerAlphaLocal 0;
			_houseMarker setMarkerPosLocal _housePosition;
			_houseMarker setMarkerShapeLocal 'ICON';
			_houseMarker setMarkerSizeLocal [0.5,0.5];
			_houseMarker setMarkerColorLocal 'ColorGREEN';
			_houseMarker setMarkerTypeLocal 'mil_triangle';
			_houseMarker setMarkerAlpha 1;
			
			['SM_IDAP_UPDATE',[localize 'STR_QS_Notif_091',localize 'STR_QS_Notif_092']] remoteExec ['QS_fnc_showNotification',-2,FALSE];

			_truckPos = [_housePosition,10,25,5,0,0.5,0] call _fn_findSafePos;
			if ((_truckPos distance2D _housePosition) < 30) then {
				_truckPos set [2,0];
				_truckTypes = [
					'o_g_offroad_01_f',
					'o_g_van_01_transport_f',
					'i_c_van_01_transport_f',
					'c_truck_02_transport_f'
				];
				_truckType = selectRandom _truckTypes;
				_truck = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _truckType,_truckType],[-500,-500,50],[],25,'NONE'];
				_truck setDir (random 360);
				_truck setVectorUp (surfaceNormal _truckPos);
				_truck setVehiclePosition [(AGLToASL _truckPos),[],0,'NONE'];
				_allArray pushBack _truck;
			};
			_usedPositions pushBack _housePosition;
			_houseBuildingPositions = _house buildingPos -1;
			_houseBuildingPositions = _houseBuildingPositions apply { [(_x # 0),(_x # 1),((_x # 2) + 0.5)] };
			_currentSceneChance = _sceneChance # 0;
			_sceneChance deleteAt 0;
			if (_currentSceneChance isEqualTo 1) then {
				//comment 'Create intel object';
				_crate = createVehicle [_crateType,[-175,-175,0],[],20,'NONE'];
				_crate allowDamage FALSE;
				_cratePosition = selectRandom _houseBuildingPositions;
				_crate setPos _cratePosition;
				{
					_crate setVariable _x;	
				} forEach [
					['QS_medbox_disableRevive',TRUE,TRUE],
					['QS_inventory_disabled',TRUE,TRUE],
					['QS_dynSim_ignore',TRUE,TRUE],
					['QS_ST_customDN',localize 'STR_QS_Text_484',TRUE]
				];
				_timeoutFailsafe = serverTime + 3600;
				_crateSpawned = TRUE;
				_cratePositionIndex = _houseBuildingPositions find _cratePosition;
				_houseBuildingPositions set [_cratePositionIndex,FALSE];
				_houseBuildingPositions deleteAt _cratePositionIndex;
				_allArray pushBack _crate;
			};
			//comment 'Spawn house guards';
			//comment 'Spawn civilians?';
			if (_houseMines isNotEqualTo []) then {
				deleteVehicle _houseMines;
				_houseMines = [];
			};
			if (_enemyArray2 isNotEqualTo []) then {
				{
					_x setDamage [1,FALSE];
				} forEach _enemyArray2;
			};
			if ((random 1) > 0.333) then {
				_houseMines = [_housePosition,10,15,20,['APERSMine',1],FALSE,FALSE] call (missionNamespace getVariable 'QS_fnc_createMinefield');
				{
					_allArray pushBack _x;
				} forEach _houseMines;
			};
			_spawnArray = [_housePosition,1,0,_house,_houseBuildingPositions] call _fn_smIDAP;
			{
				_enemyArray2 pushBack _x;
				_allArray pushBack _x;
			} forEach _spawnArray;
		};
	};
	if (_monitorScene) then {
		if (_sceneType isEqualTo 0) then {
			if (
				(_currentSceneChance isEqualTo 0) &&
				{((((units WEST) inAreaArray [_housePosition,15,15,0,FALSE,-1])) isNotEqualTo [])} &&
				{(((((units EAST) + (units RESISTANCE)) inAreaArray [_housePosition,15,15,0,FALSE,-1])) isEqualTo [])}
			) then {
				[
					[],
					{
						50 cutText [localize 'STR_QS_Text_247','PLAIN DOWN',0.75];
					}
				] remoteExec ['call',(allPlayers inAreaArray [_housePosition,300,300,0,FALSE]),FALSE];
				['SM_IDAP_UPDATE',[localize 'STR_QS_Notif_091',localize 'STR_QS_Notif_093']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
				_findNewLocation = TRUE;
				_monitorScene = FALSE;
				_houseFound = FALSE;
				deleteMarker _houseMarker;
			};
			if (_currentSceneChance isEqualTo 1) then {
				if (!alive _crate) then {
					_taskState = 'FAILED';
				};
				if (alive _crate) then {
					if (!(_crate inArea QS_terrain_worldArea)) then {
						// crate no longer in terrain area
						if (!isNull (attachedTo _crate)) then {
							[0,_crate] call QS_fnc_eventAttach;	
						};
						// reset to initial position
						_crate setVehiclePosition [_cratePosition,[],0,'NONE'];
					};
					if (isNull (attachedTo _crate)) then {
						if (
							(((getPosASL _crate) # 2) < -1) ||
							(((getPosATL _crate) # 2) < -1)
						) then {
							// crate is detached and underwater or under terrain
							sleep 0.25;
							// small delay then double check attached state
							if (isNull (attachedTo _crate)) then {
								// reset to initial position
								_crate setVehiclePosition [_cratePosition,[],0,'NONE'];
							};
						};
					};
					if (_crateState isEqualTo 'DETACHED') then {
						if (!isNull (attachedTo _crate)) then {
						
							if (!(_suppliesFound)) then {
								_suppliesFound = TRUE;
								['SM_IDAP_UPDATE',[localize 'STR_QS_Notif_091',localize 'STR_QS_Notif_094']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
								[
									[],
									{
										50 cutText [localize 'STR_QS_Text_248','PLAIN DOWN',0.75];
									}
								] remoteExec ['call',(allPlayers inAreaArray [_housePosition,300,300,0,FALSE]),FALSE];
							};
							_crateAttachedTo = attachedTo _crate;
							_crateState = 'ATTACHED';
							_iconData = [
								_iconID,
								'ICON',
								[
									_crateIcon,
									[0,1,0,0.75],
									(attachedTo _crate),
									15,
									15,
									0,
									(localize 'STR_QS_Text_484'),
									2,
									0.04,
									'RobotoCondensed',
									'left'
								]
							];
							[78,2,'QS_client_customDraw2D',_iconID,_iconData] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
						};
					} else {
						if (_crateState isEqualTo 'ATTACHED') then {
							if ((isNull (attachedTo _crate)) || {((!isNull (attachedTo _crate)) && ((attachedTo _crate) isNotEqualTo _crateAttachedTo))}) then {
								_crateState = 'DETACHED';
								_iconData = [
									_iconID,
									'ICON',
									[
										_crateIcon,
										[0,1,0,0.75],
										_crate,
										15,
										15,
										0,
										(localize 'STR_QS_Text_484'),
										2,
										0.04,
										'RobotoCondensed',
										'left'
									]
								];
								[78,2,'QS_client_customDraw2D',_iconID,_iconData] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
							};
						};
					};
					if ((_crate distance2D _recoverableUnit) < _crateCompletionRadius) then {
						if (isNull (attachedTo _crate)) then {
							for '_x' from 0 to 2 step 1 do {
								_recoverableUnit setVariable ['QS_interact_stabilise',TRUE,TRUE];
								_recoverableUnit setVariable ['QS_interact_stabilised',FALSE,TRUE];
								_recoverableUnit setVariable ['QS_RD_loadable',TRUE,TRUE];
							};
							_recoverableUnit addHeadgear _headBandage;
							_recoverableUnit setDamage 0.15;
							_recoverableUnit allowDamage TRUE;
							{
								_x setMarkerAlpha 0;
							} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
							['QS_TASK_SM_IDAP_1'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
							['SM_IDAP_UPDATE',[localize 'STR_QS_Notif_091',localize 'STR_QS_Notif_095']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
							_sceneType = 1;
							deleteMarker _aidMarker;
							deleteVehicle _crate;
							_crateSpawned = FALSE;
							deleteMarker _houseMarker;
							[78,0,'QS_client_customDraw2D',_iconID,_iconData] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
							_medevacTimeout = serverTime + _medevacTime;
							[
								_medevacTaskID,
								TRUE,
								[
									localize 'STR_QS_Task_093',
									localize 'STR_QS_Task_029',
									localize 'STR_QS_Task_029'
								],
								[_recoverableUnit,TRUE],
								'CREATED',
								5,
								FALSE,
								TRUE,
								'Heal',
								TRUE
							] call (missionNamespace getVariable 'BIS_fnc_setTask');
							[_medevacTaskID,TRUE,_medevacTimeout] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
							if (_enemyArray2 isNotEqualTo []) then {
								{
									_x setDamage [1,FALSE];
								} forEach _enemyArray2;
							};
							if (_houseMines isNotEqualTo []) then {
								deleteVehicle _houseMines;
							};
						};
					};
				};
				if (missionNamespace getVariable ['QS_sidemission_buildingDestroyed',FALSE]) then {
					_taskState = 'FAILED';
				};
			};
		};
		if (_sceneType isEqualTo 1) then {
			if (isNull (objectParent _recoverableUnit)) then {
				if (isNull (attachedTo _recoverableUnit)) then {
					if (((_recoverableUnit distance2D _medevacBase) < 5) || {([0,_recoverableUnit] call (missionNamespace getVariable 'QS_fnc_isNearFieldHospital'))}) then {
						_taskState = 'SUCCEEDED';
					};
				};
			};
			if (!alive _recoverableUnit) then {
				_taskState = 'FAILED';
			};
			if (serverTime > _medevacTimeout) then {
				_taskState = 'FAILED';
			};
		};
	};
	if (!(_unitStabilised)) then {
		if (time > _enemyCheckDelay) then {
			if (!isNull _house) then {
				_house allowDamage FALSE;
			};
			_enemyArray2 = _enemyArray2 select {(alive _x)};
			if (({((alive _x) && (_x isKindOf 'CAManBase'))} count _enemyArray1) < _enemyArray1_threshold) then {
				_allPlayers = allPlayers;
				for '_x' from 0 to 9 step 1 do {
					_spawnPosition = [_idapScenePosition,250,500,3,0,0.7,0] call _fn_findSafePos;
					if (([_spawnPosition,250,[WEST,CIVILIAN],_allPlayers,0] call _fn_serverDetector) isEqualTo []) exitWith {};
				};
				_spawnPosition set [2,0];
				_spawnArray = [_idapScenePosition,0,1,_spawnPosition] call _fn_smIDAP;
				{
					(group _x) setSpeedMode 'FULL';
					(group _x) setBehaviour 'AWARE';
					_enemyArray1 pushBack _x;
					_allArray pushBack _x;
				} forEach _spawnArray;
			};
			if (_sceneType isEqualTo 0) then {
				if (_houseFound) then {
					if ((_crate distance2D _housePosition) < 200) then {
						if (({((alive _x) && (_x isKindOf 'CAManBase'))} count _enemyArray2) < _enemyArray2_threshold) then {
							_allPlayers = allPlayers;
							for '_x' from 0 to 9 step 1 do {
								_spawnPosition = [_housePosition,250,500,3,0,0.7,0] call _fn_findSafePos;
								if (([_spawnPosition,250,[WEST,CIVILIAN],_allPlayers,0] call _fn_serverDetector) isEqualTo []) exitWith {};
							};
							if ((_spawnPosition distance2D _housePosition) < 1000) then {
								_spawnPosition set [2,0];
								_spawnArray = [_housePosition,1,1,_house,_houseBuildingPositions,_spawnPosition] call _fn_smIDAP;
								{
									(group _x) setSpeedMode 'FULL';
									(group _x) setBehaviour 'AWARE';
									_enemyArray2 pushBack _x;
									_allArray pushBack _x;
								} forEach _spawnArray;
							};
						};
					};
				};
			} else {
				_enemyArray2 = _enemyArray2 select {((alive _x) && (_x isKindOf 'CAManBase'))};
				
				if (_enemyArray2 isNotEqualTo []) then {
				
				
					doStop _enemyArray2;
					_enemyArray2 doMove ((getPosATL _crate) vectorAdd [0,0,1]);
				};
			};
			_enemyCheckDelay = time + _enemyDelay;
		};
	};
	if (_suppliesFound) then {
		if (_sceneType isEqualTo 0) then {
			if (!isNull _crate) then {
				_houseMarker setMarkerPos (getPosWorld _crate);
			};
		};
	};
	if (_crateSpawned) then {
		if (
			(!alive _crate) ||
			{((((getPosASL _crate) # 2) < -0.5) && (isNull (attachedTo _crate)))}
		) then {
			[[WEST,'BLU'],localize 'STR_QS_Chat_064'] remoteExec ['sideChat',-2,FALSE];
			_taskState = 'FAILED';
		};
		if (serverTime > _timeoutFailsafe) then {
			[[WEST,'BLU'],localize 'STR_QS_Chat_065'] remoteExec ['sideChat',-2,FALSE];
			_taskState = 'FAILED';
		};
	};
	sleep 3;
};
{
	_x setMarkerAlpha 0;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
[_medevacTaskID] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
['QS_TASK_SM_IDAP_1'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
deleteVehicle [_recoverableUnit,_crate];
private _toDelete = objNull;
if (_allArray isNotEqualTo []) then {
	{
		_toDelete = _x;
		if (_toDelete isKindOf 'LandVehicle') then {
			if (alive _toDelete) then {
				if (((crew _toDelete) findIf {(alive _x)}) isEqualTo -1) then {
					deleteVehicle _toDelete;
				} else {
					_toDelete setVariable ['QS_vehicle_delayedDelete',(diag_tickTime + 600),FALSE];
					_toDelete addEventHandler [
						'GetOut',
						{
							params ['_vehicle'];
							if (diag_tickTime > (_vehicle getVariable ['QS_vehicle_delayedDelete',-1])) then {
								if (((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) then {
									deleteVehicle _vehicle;
								};
							};
						}
					];
					(missionNamespace getVariable 'QS_garbageCollector') pushBack [_toDelete,'DELAYED_DISCREET',300];
				};
			};
		} else {
			deleteVehicle _toDelete;
		};
	} forEach _allArray;
};
{
	(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
} forEach _idapComposition;
if (_houseMines isNotEqualTo []) then {
	deleteVehicle _houseMines;
};
{
	if (alive _x) then {
		_x setDamage [1,FALSE];
	};
} forEach _enemyArray1;
{
	if (alive _x) then {
		_x setDamage [1,FALSE];
	};
} forEach _enemyArray2;
if (!isNil '_houseMarker') then {
	deleteMarker _houseMarker;
};
deleteMarker _aidMarker;
[78,0,'QS_client_customDraw2D',_iconID,_iconData] remoteExec ['QS_fnc_remoteExec',-2,FALSE];