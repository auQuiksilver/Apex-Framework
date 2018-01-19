/*/
File: fn_initCommon.sqf
Author:

	Quiksilver
	
Last Modified:

	18/12/2017 A3 1.80 by Quiksilver

Description:

	Common pre-init
_______________________________________________/*/

QS_data_actions = compileFinal preprocessFileLineNumbers 'code\config\QS_data_actions.sqf'; 
QS_data_notifications = compileFinal preprocessFileLineNumbers 'code\config\QS_data_notifications.sqf'; 
QS_data_patches = compileFinal preprocessFileLineNumbers 'code\config\QS_data_patches.sqf'; 
QS_Insignia = compileFinal preprocessFileLineNumbers 'code\config\QS_insigniaTextures.sqf'; 
QS_UTextures = compileFinal preprocessFileLineNumbers 'code\config\QS_uniformTextures.sqf'; 
QS_VTextures = compileFinal preprocessFileLineNumbers 'code\config\QS_vehicleTextures.sqf'; 
AR_Advanced_Rappelling_Install = compileFinal preprocessFileLineNumbers 'code\scripts\AR_AdvancedRappelling_ext.sqf';
_environment = ['mediterranean','tropic'] select (worldName isEqualTo 'Tanoa');
QS_aoHQ1 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition1.sqf',_environment]);
QS_aoHQ2 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition2.sqf',_environment]);
QS_aoHQ3 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition3.sqf',_environment]);
QS_aoHQ4 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition4.sqf',_environment]);
QS_aoHQ5 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition5.sqf',_environment]);
QS_aoHQ6 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition6.sqf',_environment]);
QS_aoHQ7 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition7.sqf',_environment]);
QS_aoHQ8 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition8.sqf',_environment]);
QS_aoHQ9 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition9.sqf',_environment]);
QS_aoHQ10 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition10.sqf',_environment]);
QS_aoHQ11 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition11.sqf',_environment]);
QS_aoHQ12 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition12.sqf',_environment]);
QS_aoHQ13 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition13.sqf',_environment]);
QS_aoHQ14 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition14.sqf',_environment]);
QS_aoHQ15 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition15.sqf',_environment]);
QS_aoHQ16 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition16.sqf',_environment]);
QS_aoHQ17 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition17.sqf',_environment]);
QS_aoHQ18 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition18.sqf',_environment]);
QS_aoHQ19 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition19.sqf',_environment]);
QS_aoHQ20 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition20.sqf',_environment]);
QS_aoHQ21 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition21.sqf',_environment]);
QS_aoHQ22 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition22.sqf',_environment]);
QS_aoHQ23 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition23.sqf',_environment]);
QS_aoHQ24 = compileFinal preprocessFileLineNumbers (format ['code\config\hqCompositions\%1\QS_composition24.sqf',_environment]);
QS_sc_composition_small_1 = compileFinal preprocessFileLineNumbers 'code\config\scCompositions\small\QS_sc_composition_small_1.sqf';
QS_sc_composition_small_2 = compileFinal preprocessFileLineNumbers 'code\config\scCompositions\small\QS_sc_composition_small_2.sqf';
QS_sc_composition_small_3 = compileFinal preprocessFileLineNumbers 'code\config\scCompositions\small\QS_sc_composition_small_3.sqf';
QS_sc_composition_medium_1 = compileFinal preprocessFileLineNumbers 'code\config\scCompositions\medium\QS_sc_composition_medium_1.sqf';
QS_sc_composition_medium_2 = compileFinal preprocessFileLineNumbers 'code\config\scCompositions\medium\QS_sc_composition_medium_2.sqf';
QS_sc_composition_medium_3 = compileFinal preprocessFileLineNumbers 'code\config\scCompositions\medium\QS_sc_composition_medium_3.sqf';
QS_sc_composition_large_1 = compileFinal preprocessFileLineNumbers 'code\config\scCompositions\large\QS_sc_composition_large_1.sqf';
QS_sc_composition_large_2 = compileFinal preprocessFileLineNumbers 'code\config\scCompositions\large\QS_sc_composition_large_2.sqf';
QS_sc_composition_large_3 = compileFinal preprocessFileLineNumbers 'code\config\scCompositions\large\QS_sc_composition_large_3.sqf';
QS_sc_composition_hq_1 = compileFinal preprocessFileLineNumbers 'code\config\hqCompositions\sc\QS_hqComposition_1.sqf';
QS_data_supplyDepot_1 = compileFinal preprocessFileLineNumbers 'code\config\QS_data_supplyDepot_1.sqf';
QS_data_radioTower_1 = compileFinal preprocessFileLineNumbers 'code\config\QS_data_radioTower_1.sqf';
QS_data_siteIDAPSupply_1 = compileFinal preprocessFileLineNumbers 'code\config\QS_data_siteIDAPSupply_1.sqf';
QS_data_IDAPHospital = compileFinal preprocessFileLineNumbers 'code\config\QS_data_IDAPHospital.sqf';
QS_data_siteIG = compileFinal preprocessFileLineNumbers 'code\config\QS_data_siteIG.sqf';
QS_data_siteMortar = compileFinal preprocessFileLineNumbers 'code\config\QS_data_siteMortar.sqf';
QS_data_siteFoxhole = compileFinal preprocessFileLineNumbers 'code\config\QS_data_siteFoxhole.sqf';
QS_site_radar = compileFinal preprocessFileLineNumbers 'code\config\smCompositions\QS_data_siteRadar.sqf';
QS_RSC_weatherData = compileFinal preprocessFileLineNumbers 'code\config\QS_data_weather.sqf';
QS_data_vehicles = compileFinal preprocessFileLineNumbers 'code\config\QS_data_vehicles.sqf';
QS_data_arsenal = compileFinal preprocessFileLineNumbers 'code\config\QS_data_arsenal.sqf';
QS_data_gearRestrictions = compileFinal preprocessFileLineNumbers 'code\config\QS_data_gearRestrictions.sqf';
QS_data_carrierLaunch = compileFinal preprocessFileLineNumbers 'code\config\QS_data_carrierLaunch.sqf';
QS_data_fobs = compileFinal preprocessFileLineNumbers 'code\config\QS_data_fobs.sqf';
QS_data_forestCamp = compileFinal preprocessFileLineNumbers 'code\config\QS_data_forestCamp.sqf';
QS_data_mortarPit = compileFinal preprocessFileLineNumbers 'code\config\QS_data_mortarPit.sqf';
QS_data_artyPit = compileFinal preprocessFileLineNumbers 'code\config\QS_data_artyPit.sqf';
BIS_HC_path_menu = compileFinal preprocessFileLineNumbers 'code\functions\fn_menuHCPath.sqf';