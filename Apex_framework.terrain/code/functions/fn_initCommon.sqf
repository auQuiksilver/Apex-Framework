/*/
File: fn_initCommon.sqf
Author:

	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver

Description:

	Common pre-init
_______________________________________________/*/

missionNamespace setVariable ['QS_terrain_worldName',(getText (configFile >> 'CfgWorlds' >> worldName >> 'description')),FALSE];
private _environment = 'arid';		// Altis, Stratis, Malden, Sefrou-Ramal
if (worldName in ['Tanoa','Cam_Lao_Nam','vn_khe_sanh','vn_the_bra']) then {
	_environment = 'tropic';
};
if (worldName in ['Enoch','stozec','gm_weferlingen_summer','gm_weferlingen_winter']) then {
	_environment = 'temperate';
};
uiNamespace setVariable ['rscmissionstatus_buttonclick',compileFinal {TRUE}];
{
	missionNamespace setVariable [_x,compileFinal {TRUE},FALSE];
} forEach [
	'rscmissionstatus_buttonclick',
	'bis_fnc_missiontaskslocal',
	'bis_fnc_missionconversationslocal'
];
{
	missionNamespace setVariable [_x # 0,(compileScript [_x # 1,TRUE]),FALSE];
} forEach [
	['QS_data_actions','code\config\QS_data_actions.sqf'],
	['QS_data_patches','code\config\QS_data_patches.sqf'],
	['QS_data_classNames','code\config\QS_data_classNames.sqf'],
	['QS_data_tableUnits','code\config\QS_data_tableUnits.sqf'],
	['QS_data_tableVehicles','code\config\QS_data_tableVehicles.sqf'],
	['QS_data_groupCompositions','code\config\QS_data_groupCompositions.sqf'],
	['QS_data_tableCivilians','code\config\QS_data_tableCivilians.sqf'],
	['QS_data_notifications','code\config\QS_data_notifications.sqf'], 
	['QS_Insignia','code\config\QS_insigniaTextures.sqf'], 
	['QS_UTextures','code\config\QS_uniformTextures.sqf'], 
	['QS_VTextures','code\config\QS_vehicleTextures.sqf'], 
	['AR_Advanced_Rappelling_Install','code\scripts\AR_AdvancedRappelling_ext.sqf'],
	['QS_aoHQ1',(format ['code\config\hqCompositions\%1\QS_composition1.sqf',_environment])],
	['QS_aoHQ2',(format ['code\config\hqCompositions\%1\QS_composition2.sqf',_environment])],
	['QS_aoHQ3',(format ['code\config\hqCompositions\%1\QS_composition3.sqf',_environment])],
	['QS_aoHQ4',(format ['code\config\hqCompositions\%1\QS_composition4.sqf',_environment])],
	['QS_aoHQ5',(format ['code\config\hqCompositions\%1\QS_composition5.sqf',_environment])],
	['QS_aoHQ6',(format ['code\config\hqCompositions\%1\QS_composition6.sqf',_environment])],
	['QS_aoHQ7',(format ['code\config\hqCompositions\%1\QS_composition7.sqf',_environment])],
	['QS_aoHQ8',(format ['code\config\hqCompositions\%1\QS_composition8.sqf',_environment])],
	['QS_aoHQ9',(format ['code\config\hqCompositions\%1\QS_composition9.sqf',_environment])],
	['QS_aoHQ10',(format ['code\config\hqCompositions\%1\QS_composition10.sqf',_environment])],
	['QS_aoHQ11',(format ['code\config\hqCompositions\%1\QS_composition11.sqf',_environment])],
	['QS_aoHQ12',(format ['code\config\hqCompositions\%1\QS_composition12.sqf',_environment])],
	['QS_aoHQ13',(format ['code\config\hqCompositions\%1\QS_composition13.sqf',_environment])],
	['QS_aoHQ14',(format ['code\config\hqCompositions\%1\QS_composition14.sqf',_environment])],
	['QS_aoHQ15',(format ['code\config\hqCompositions\%1\QS_composition15.sqf',_environment])],
	['QS_aoHQ16',(format ['code\config\hqCompositions\%1\QS_composition16.sqf',_environment])],
	['QS_aoHQ17',(format ['code\config\hqCompositions\%1\QS_composition17.sqf',_environment])],
	['QS_aoHQ18',(format ['code\config\hqCompositions\%1\QS_composition18.sqf',_environment])],
	['QS_aoHQ19',(format ['code\config\hqCompositions\%1\QS_composition19.sqf',_environment])],
	['QS_aoHQ20',(format ['code\config\hqCompositions\%1\QS_composition20.sqf',_environment])],
	['QS_aoHQ21',(format ['code\config\hqCompositions\%1\QS_composition21.sqf',_environment])],
	['QS_aoHQ22',(format ['code\config\hqCompositions\%1\QS_composition22.sqf',_environment])],
	['QS_aoHQ23',(format ['code\config\hqCompositions\%1\QS_composition23.sqf',_environment])],
	['QS_aoHQ24',(format ['code\config\hqCompositions\%1\QS_composition24.sqf',_environment])],
	['QS_sc_composition_small_1','code\config\scCompositions\small\QS_sc_composition_small_1.sqf'],
	['QS_sc_composition_small_2','code\config\scCompositions\small\QS_sc_composition_small_2.sqf'],
	['QS_sc_composition_small_3','code\config\scCompositions\small\QS_sc_composition_small_3.sqf'],
	['QS_sc_composition_medium_1','code\config\scCompositions\medium\QS_sc_composition_medium_1.sqf'],
	['QS_sc_composition_medium_2','code\config\scCompositions\medium\QS_sc_composition_medium_2.sqf'],
	['QS_sc_composition_medium_3','code\config\scCompositions\medium\QS_sc_composition_medium_3.sqf'],
	['QS_sc_composition_large_1','code\config\scCompositions\large\QS_sc_composition_large_1.sqf'],
	['QS_sc_composition_large_2','code\config\scCompositions\large\QS_sc_composition_large_2.sqf'],
	['QS_sc_composition_large_3','code\config\scCompositions\large\QS_sc_composition_large_3.sqf'],
	['QS_sc_composition_hq_1','code\config\hqCompositions\sc\QS_hqComposition_1.sqf'],
	['QS_data_supplyDepot_1','code\config\QS_data_supplyDepot_1.sqf'],
	['QS_data_radioTower_1','code\config\QS_data_radioTower_1.sqf'],
	['QS_data_siteIDAPSupply_1','code\config\QS_data_siteIDAPSupply_1.sqf'],
	['QS_data_IDAPHospital','code\config\QS_data_IDAPHospital.sqf'],
	['QS_data_siteIG','code\config\QS_data_siteIG.sqf'],
	['QS_data_siteMortar','code\config\QS_data_siteMortar.sqf'],
	['QS_data_siteFoxhole','code\config\QS_data_siteFoxhole.sqf'],
	['QS_data_fortifiedAA','code\config\QS_data_fortifiedAA.sqf'],
	['QS_site_radar','code\config\smCompositions\QS_data_siteRadar.sqf'],
	['QS_RSC_weatherData','code\config\QS_data_weather.sqf'],
	['QS_data_vehicles','code\config\QS_data_vehicles.sqf'],
	['QS_data_recruitableAI','code\config\QS_data_recruitableAI.sqf'],
	['QS_data_carrierLaunch','code\config\QS_data_carrierLaunch.sqf'],
	['QS_data_fobs','code\config\QS_data_fobs.sqf'],
	['QS_data_forestCamp','code\config\QS_data_forestCamp.sqf'],
	['QS_data_mortarPit','code\config\QS_data_mortarPit.sqf'],
	['QS_data_artyPit','code\config\QS_data_artyPit.sqf'],
	['QS_data_destroyerBuildingPositions','code\config\QS_data_destroyerBuildingPositions.sqf'],
	['QS_data_sniperRifles','code\config\QS_data_sniperRifles.sqf'],
	['QS_data_smallBuildingTypes','code\config\QS_data_smallBuildingTypes.sqf'],
	['QS_data_siteHP1','code\config\QS_data_siteHP1.sqf'],
	['QS_data_siteDatalink1','code\config\QS_data_siteDatalink1.sqf'],
	['QS_data_rainParams','code\config\QS_data_rainParams.sqf'],
	['QS_data_tracers','code\config\QS_data_tracers.sqf'],
	['QS_data_rockets','code\config\QS_data_rocketTypes.sqf'],
	['QS_data_restrictedGear','code\config\QS_data_restrictedGear.sqf'],
	['QS_data_planeLoadouts','code\config\QS_data_planeLoadouts.sqf'],
	['QS_data_listItems','code\config\QS_data_listItems.sqf'],
	['QS_data_listUnits','code\config\QS_data_listUnits.sqf'],
	['QS_data_listVehicles','code\config\QS_data_listVehicles.sqf'],
	['QS_data_listOther','code\config\QS_data_listOther.sqf'],
	['QS_data_pullPoints','code\config\QS_data_pullPoints.sqf'],
	['QS_data_winchPoints','code\config\QS_data_winchPoints.sqf'],
	['QS_data_wreckTypes','code\config\QS_data_wreckTypes.sqf'],
	['QS_data_attachParams','code\config\QS_data_attachParams.sqf'],
	['QS_data_animationParams','code\config\QS_data_animationParams.sqf'],
	['QS_data_lasers','code\config\QS_data_lasers.sqf'],
	['QS_data_virtualCargoPresets','code\config\QS_data_virtualCargoPresets.sqf'],
	['QS_data_vehicleCostTableDefault','code\config\QS_data_vehicleCostTableDefault.sqf'],
	['QS_data_pfh_whitelist','code\config\QS_data_pfhWhitelist.sqf'],
	['BIS_HC_path_menu','code\functions\fn_menuHCPath.sqf']
];
QS_hashmap_pullPoints = createHashMapFromArray (call QS_data_pullPoints);
QS_hashmap_winchAttachPoints = createHashMapFromArray (call QS_data_winchPoints);
QS_hashmap_animationParams = createHashMapFromArray (call QS_data_animationParams);
QS_hashmap_wreckTypes = createHashMapFromArray (call QS_data_wreckTypes);
QS_hashmap_lasers = createHashMapFromArray ([0] call QS_data_lasers);
QS_hashmap_lasersCustomOffsets = createHashMapFromArray ([1] call QS_data_lasers);
QS_hashmap_unitLoadouts = createHashMapFromArray (call (compileScript ['code\config\QS_data_unitClassLoadouts.sqf']));
QS_hashmap_vehicleCostTable = createHashMapFromArray (call (compileScript ['code\config\QS_data_vehicleCostTable.sqf']));
QS_hashmap_maxCargoCapacity = createHashMap;
QS_hashmap_classLists = createHashMap;
// Get active DLC
private _activeDLC = call (missionNamespace getVariable 'QS_fnc_getActiveDLC');
// Get DLC-context classnames
call (missionNamespace getVariable 'QS_data_classNames');
// Create DLC-context hashmaps
QS_core_units_map = createHashMapFromArray (call QS_data_tableUnits);
QS_core_vehicles_map = createHashMapFromArray (call QS_data_tableVehicles);
QS_core_groups_map = createHashMapFromArray (call QS_data_groupCompositions);
QS_core_civilians_list = call QS_data_tableCivilians;
QS_data_playerBuildables = call (compileScript ['code\config\QS_data_playerBuildables.sqf',TRUE]);
if (_activeDLC isEqualTo '') then {
	_activeDLC = 'NONE';
};
localNamespace setVariable ['QS_emptyLoadout',(configFile >> 'EmptyLoadout')];
diag_log format ['***** Active DLC ***** %1 *****',_activeDLC];