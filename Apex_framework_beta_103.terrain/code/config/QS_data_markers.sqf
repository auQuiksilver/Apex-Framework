/*/
File: QS_data_markers.sqf
Author:

	Quiksilver
	
Last modified:

	4/12/2017 A3 1.78 by Quiksilver
	
Description:

	Markers Data
__________________________________________________________________________/*/
_worldName = worldName;
_teamspeakText = missionNamespace getVariable ['QS_missionConfig_commTS',''];
if (_worldName isEqualTo 'Altis') exitWith {
	_markerStoragePos = [-5000,-5000,0];
	[
		['respawn',[8455.03,25102.1,0.00178528],'Empty','Icon','','ColorWEST',[0.5,0.5],0,[8455.03,25102.1,0.00178528],0,''],
		['QS_marker_aoMarker',_markerStoragePos,'o_unknown','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,''],
		['QS_marker_aoCircle',_markerStoragePos,'Empty','Ellipse','FDiagonal','ColorOPFOR',[800,800],0,_markerStoragePos,0,''],
		['QS_marker_sideMarker',_markerStoragePos,'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,''],
		['QS_marker_sideCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,''],
		['QS_marker_radioMarker',_markerStoragePos,'loc_Transmitter','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,'Radiotower'],
		['QS_marker_radioCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,''],
		['QS_marker_hqMarker',_markerStoragePos,'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,'HQ'],
		['QS_marker_hqCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,''],
		['QS_marker_mortMarker',_markerStoragePos,'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,'Mortars'],
		['QS_marker_mortCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,''],
		['QS_marker_base_marker',[14631.5,16765.1,0.00143814],'respawn_unknown','Icon','','ColorWEST',[0.5,0.5],0.5,[14631.5,16765.1,0.00143814],0,'Base'],
		['QS_marker_airbaseDefense',[14853,16707.7,0.00143814],'Empty','Icon','','ColorWEST',[0.5,0.5],0,[14853,16707.7,0.00143814],0,''],
		['QS_marker_airbaseArtillery',[14729.6,16578.8,0.00143814],'b_art','Icon','','ColorWEST',[0.5,0.5],0.75,[14729.6,16578.8,0.00143814],0,'Arty'],
		['QS_marker_casJet_spawn',[14453.4,16279.6,0.00116539],'respawn_plane','Icon','','ColorWEST',[0.5,0.5],0.75,[14453.4,16279.6,0.00116539],0,'CAS'],
		['QS_marker_crate_area',[14759.4,16668.7,0.00143814],'b_support','Icon','','ColorWEST',[0.5,0.5],0.75,[14759.4,16668.7,0.00143814],0,'Crate Area'],
		['QS_marker_heli_spawn',[14786.8,16821.2,0.00143814],'respawn_air','Icon','','ColorWEST',[0.5,0.5],0.75,[14786.8,16821.2,0.00143814],0,'Heli'],
		['QS_marker_veh_spawn',[14539.9,16852.2,0.00130081],'respawn_armor','Icon','','ColorWEST',[0.5,0.5],0.75,[14539.9,16852.2,0.00130081],0,'Vehicle'],
		['QS_marker_boats_1',[15345.2,15769,0.00143814],'b_naval','Icon','','ColorWEST',[0.5,0.5],0.75,[15345.2,15769,0.00143814],0,'Dock'],
		['QS_marker_boats_2',[17781.3,18210.6,0.00150323],'b_naval','Icon','','ColorWEST',[0.5,0.5],0.75,[17781.3,18210.6,0.00150323],0,'Dock'],
		['QS_marker_side_rewards',[14817.9,16613.3,0.00130081],'b_unknown','Icon','','ColorWEST',[0.5,0.5],0.75,[14817.9,16613.3,0.00130081],0,'Rewards'],
		['QS_marker_gitmo',[14687.3,16808.5,0.00143814],'b_unknown','Icon','','ColorWEST',[0.5,0.5],0.75,[14687.3,16808.5,0.00143814],0,'Gitmo'],
		['QS_marker_medevac_hq',[14666.2,16798.8,0.00143814],'b_med','Icon','','ColorWEST',[0.5,0.5],0.75,[14666.2,16798.8,0.00143814],0,'Medevac HQ'],
		['QS_marker_base_toc',[14673.1,16791.1,0.00143814],'b_hq','Icon','','ColorWEST',[0.5,0.5],0.75,[14673.1,16791.1,0.00143814],0,'TOC'],
		['QS_marker_base_atc',[14621.3,16723.9,0.00143623],'b_support','Icon','','ColorWEST',[0.5,0.5],0.75,[14621.3,16723.9,0.00143623],0,'ATC'],
		['QS_marker_veh_baseservice_01',[14565.7,16823.3,0.00143814],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[14565.7,16823.3,0.00143814],0,'Vehicle Service'],
		['QS_marker_veh_baseservice_02',[14607,16631.2,0.00143814],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[14607,16631.2,0.00143814],0,'Heli Service'],
		['QS_marker_veh_baseservice_03',[15178.4,16809.5,0.00143814],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[15178.4,16809.5,0.00143814],0,'Plane Service'],
		['QS_marker_veh_fieldservice_01',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Vehicle Service'],
		['QS_marker_veh_fieldservice_02',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Vehicle Service'],
		['QS_marker_veh_fieldservice_03',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Vehicle Service'],
		['QS_marker_veh_fieldservice_04',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Air Service'],
		['QS_marker_Almyra_blacklist_area',[23567.8,18332.3,0],'Empty','Icon','','ColorWEST',[0.25,0.25],0,[23567.8,18332.3,0],0,''],
		['QS_marker_fpsMarker',[0,0,0],'mil_dot','Icon','','ColorWhite',[1,1],0,[(worldSize + 1000),worldSize,0],0,''],
		['QS_marker_curators',[0,0,0],'mil_dot','Icon','','ColorWhite',[1,1],0,[(worldSize + 1000),(worldSize - 500),0],0,'Active Zeus - []'],
		['QS_marker_module_fob',[0,0,0],'b_hq','Icon','','ColorWEST',[0.5,0.5],0,[0,0,0],0,'FOB'],
		['QS_marker_veh_inventoryService_01',[14517.5,16776,0.00150681],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[14517.5,16776,0.00150681],0,'Inventory'],
		['QS_marker_teamspeak',[(worldSize / 2),(worldSize / 2),0],'mil_dot','Icon','','ColorYELLOW',[0.75,0.75],0.75,[(worldSize / 2),(worldSize / 2),0],0,(format ['Teamspeak:   %1',_teamspeakText])],
		['QS_marker_ferry_1',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[12521.2,12780.3,0],0,'Boat'],
		['QS_marker_ferry_2',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[16610.1,12276.9,0],0,'Boat'],
		['QS_marker_ferry_3',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[22211.2,8555.02,0],0,'Boat'],
		['QS_marker_ferry_4',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[27943.3,23745.7,0],0,'Boat'],
		['QS_marker_ferry_5',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[20622,19509.1,0],0,'Boat'],
		['QS_marker_ferry_6',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[5046.29,9914.46,0],0,'Boat'],
		['QS_marker_ferry_7',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[23272.6,24203.1,0],0,'Boat'],
		['QS_marker_ferry_8',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[22745.3,13818.1,0],0,'Boat'],
		['QS_marker_ferry_9',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[9735.86,22341.3,0],0,'Boat'],
		['QS_marker_ferry_10',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[16743.5,20514,0],0,'Boat'],
		['QS_marker_ferry_11',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[10632.4,10972.6,0],0,'Boat'],
		['QS_marker_ferry_12',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[3366.78,12924.7,0],0,'Boat'],
		['QS_marker_carrier_1',_markerStoragePos,'b_naval','Icon','','ColorWEST',[0.25,0.25],0,[-1500,-1500,0],0,'Aircraft Carrier']
	]
};
if (_worldName isEqualTo 'Tanoa') exitWith {
	_markerStoragePos = [-5000,-5000,0];
	[
		['respawn',[7624.04,14926.3,0.00173545],'Empty','Icon','','ColorWEST',[0.5,0.5],0,[7624.04,14926.3,0.00173545],0,''],
		['QS_marker_aoMarker',_markerStoragePos,'o_unknown','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,''],
		['QS_marker_aoCircle',_markerStoragePos,'Empty','Ellipse','FDiagonal','ColorOPFOR',[800,800],0,_markerStoragePos,0,''],
		['QS_marker_sideMarker',_markerStoragePos,'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,''],
		['QS_marker_sideCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,''],
		['QS_marker_radioMarker',_markerStoragePos,'loc_Transmitter','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,'Radiotower'],
		['QS_marker_radioCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,''],
		['QS_marker_hqMarker',_markerStoragePos,'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,'HQ'],
		['QS_marker_hqCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[150,150],0,_markerStoragePos,0,''],
		['QS_marker_mortMarker',_markerStoragePos,'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,'Mortars'],
		['QS_marker_mortCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,'   '],
		['QS_marker_base_marker',[6924.49,7404.88,0.00143862],'respawn_unknown','Icon','','ColorWEST',[0.5,0.5],0.5,[6924.49,7404.88,0.00143862],0,'Base'],
		['QS_marker_airbaseDefense',[7044.96,7461.98,0.00143862],'Empty','Icon','','ColorWEST',[0.5,0.5],0,[7044.96,7461.98,0.00143862],0,''],
		['QS_marker_airbaseArtillery',[7067.9,7339.97,0.00143886],'b_art','Icon','','ColorWEST',[0.5,0.5],0.75,[7067.9,7339.97,0.00143886],0,'Arty'],
		['QS_marker_casJet_spawn',[6844.88,7261.57,-0.0181315],'respawn_plane','Icon','','ColorWEST',[0.5,0.5],0.75,[6844.88,7261.57,-0.0181315],0,'CAS'],
		['QS_marker_crate_area',[7051.9,7405.88,0.00143886],'b_support','Icon','','ColorWEST',[0.5,0.5],0.75,[7051.9,7405.88,0.00143886],0,'Crate Area'],
		['QS_marker_heli_spawn',[7088.87,7302.3,0.00143886],'respawn_air','Icon','','ColorWEST',[0.5,0.5],0.75,[7088.87,7302.3,0.00143886],0,'Heli'],
		['QS_marker_veh_spawn',[6834.82,7413.37,0.00143886],'respawn_armor','Icon','','ColorWEST',[0.5,0.5],0.75,[6834.82,7413.37,0.00143886],0,'Vehicle'],
		['QS_marker_boats_1',[6610.16,6916.09,-0.310007],'b_naval','Icon','','ColorWEST',[0.5,0.5],0.75,[6610.16,6916.09,-0.310007],0,'Boat'],
		['QS_marker_side_rewards',[7073.947,7409.39,0.00157118],'b_unknown','Icon','','ColorWEST',[0.5,0.5],0.75,[7073.947,7409.39,0.00157118],0,'Rewards'],
		['QS_marker_gitmo',[6925.69,7369.88,0.00143862],'b_unknown','Icon','','ColorWEST',[0.5,0.5],0.75,[6925.69,7369.88,0.00143862],0,'Gitmo'],
		['QS_marker_medevac_hq',[6924.32,7430.16,0.00143886],'b_med','Icon','','ColorWEST',[0.5,0.5],0.75,[6924.32,7430.16,0.00143886],0,'Medevac HQ'],
		['QS_marker_base_toc',[6908.04,7426.44,0.00143886],'b_hq','Icon','','ColorWEST',[0.5,0.5],0.75,[6908.04,7426.44,0.00143886],0,'TOC'],
		['QS_marker_base_atc',[6899.53,7423.97,-0.0224762],'b_support','Icon','','ColorWEST',[0.5,0.5],0.75,[6899.53,7423.97,-0.0224762],0,'ATC'],
		['QS_marker_veh_baseservice_01',[6798.45,7413.39,0.00143886],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[6798.45,7413.39,0.00143886],0,'Vehicle Service'],
		['QS_marker_veh_baseservice_02',[7046.03,7555.64,0.00143886],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[7046.03,7555.64,0.00143886],0,'Heli Service'],
		['QS_marker_veh_baseservice_03',[7003.56,7571.34,0.00143886],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[7003.56,7571.34,0.00143886],0,'Plane Service'],
		['QS_marker_veh_fieldservice_01',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Vehicle Service'],
		['QS_marker_veh_fieldservice_02',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Vehicle Service'],
		['QS_marker_veh_fieldservice_03',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Vehicle Service'],
		['QS_marker_veh_fieldservice_04',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Air Service'],
		['QS_marker_Almyra_blacklist_area',_markerStoragePos,'Empty','Icon','','ColorWEST',[0.25,0.25],0,_markerStoragePos,0,''],
		['QS_marker_fpsMarker',[0,0,0],'mil_dot','Icon','','ColorWhite',[1,1],0,[(worldSize + 1000),worldSize,0],0,''],
		['QS_marker_curators',[0,0,0],'mil_dot','Icon','','ColorWhite',[1,1],0,[(worldSize + 1000),(worldSize - 500),0],0,'Active Zeus - []'],
		['QS_marker_module_fob',_markerStoragePos,'b_hq','Icon','','ColorWEST',[0.5,0.5],0,_markerStoragePos,0,'FOB'],
		['QS_marker_veh_inventoryService_01',[6802.23,7397.13,0.00143886],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[6802.23,7397.13,0.00143886],0,'Inventory'],
		['QS_marker_teamspeak',[(worldSize / 2),(worldSize / 2),0],'mil_dot','Icon','','ColorYELLOW',[0.75,0.75],0.75,[(worldSize / 2),(worldSize / 2),0],0,(format ['Teamspeak:   %1',_teamspeakText])],
		['QS_marker_ferry_1',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[4959.74,11316.6,-0.626744],0,'Boat'],
		['QS_marker_ferry_2',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[4235.79,11645.3,-0.559435],0,'Boat'],
		['QS_marker_ferry_3',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[2215.99,8642.79,-0.586619],0,'Boat'],
		['QS_marker_ferry_4',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[11061.8,13375.1,-0.493759],0,'Boat'],
		['QS_marker_ferry_5',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[13248.8,13663.7,-0.584546],0,'Boat'],
		['QS_marker_ferry_6',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[4528.14,5215.41,-0.625423],0,'Boat'],
		['QS_marker_carrier_1',_markerStoragePos,'b_naval','Icon','','ColorWEST',[0.25,0.25],0,[-1500,-1500,0],0,'Aircraft Carrier']
	]
};
if (_worldName isEqualTo 'Malden') exitWith {
	_markerStoragePos = [-5000,-5000,0];
	[
		['respawn',[0,worldSize,1.5],'Empty','Icon','','ColorWEST',[0.5,0.5],0,[12000.8,4139.13,0],0,''],
		['QS_marker_aoMarker',_markerStoragePos,'o_unknown','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,''],
		['QS_marker_aoCircle',_markerStoragePos,'Empty','Ellipse','FDiagonal','ColorOPFOR',[800,800],0,_markerStoragePos,0,''],
		['QS_marker_sideMarker',_markerStoragePos,'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,''],
		['QS_marker_sideCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,''],
		['QS_marker_radioMarker',_markerStoragePos,'loc_Transmitter','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,'Radiotower'],
		['QS_marker_radioCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,''],
		['QS_marker_hqMarker',_markerStoragePos,'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,'HQ'],
		['QS_marker_hqCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[150,150],0,_markerStoragePos,0,''],
		['QS_marker_mortMarker',_markerStoragePos,'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,_markerStoragePos,0,'Mortars'],
		['QS_marker_mortCircle',_markerStoragePos,'Empty','Ellipse','Border','ColorOPFOR',[300,300],0,_markerStoragePos,0,'   '],
		['QS_marker_base_marker',[8132.88,10122.6,0],'respawn_unknown','Icon','','ColorWEST',[0.5,0.5],0.5,[8132.88,10122.6,0],0,'Base'],
		['QS_marker_airbaseDefense',[7957.03,10026.5,0],'Empty','Icon','','ColorWEST',[0.5,0.5],0,[7957.03,10026.5,0],0,''],
		['QS_marker_airbaseArtillery',[7958.52,10180,0],'b_art','Icon','','ColorWEST',[0.5,0.5],0.75,[7958.52,10180,0],0,'Arty'],
		['QS_marker_casJet_spawn',[8069.07,9994.63,0],'respawn_plane','Icon','','ColorWEST',[0.5,0.5],0.75,[8069.07,9994.63,0],0,'CAS'],
		['QS_marker_crate_area',[7970.25,10109.8,0],'b_support','Icon','','ColorWEST',[0.5,0.5],0.75,[7970.25,10109.8,0],0,'Crate Area'],
		['QS_marker_heli_spawn',[8078.72,10315.5,0],'respawn_air','Icon','','ColorWEST',[0.5,0.5],0.75,[8078.72,10315.5,0],0,'Heli'],
		['QS_marker_veh_spawn',[8174.2,10144.4,0],'respawn_armor','Icon','','ColorWEST',[0.5,0.5],0.75,[8174.2,10144.4,0],0,'Vehicle'],
		['QS_marker_boats_1',[8543.58,10116.4,0],'b_naval','Icon','','ColorWEST',[0.5,0.5],0.75,[8543.58,10116.4,0],0,'Boat'],
		['QS_marker_side_rewards',[8027.57,10467.7,0],'b_unknown','Icon','','ColorWEST',[0.5,0.5],0.75,[8027.57,10467.7,0],0,'Rewards'],
		['QS_marker_gitmo',[8105.83,10048.9,0.00145149],'b_unknown','Icon','','ColorWEST',[0.5,0.5],0.75,[8105.83,10048.9,0.00145149],0,'Gitmo'],
		['QS_marker_medevac_hq',[8111.93,10075.7,0],'b_med','Icon','','ColorWEST',[0.5,0.5],0.75,[8111.93,10075.7,0],0,'Medevac HQ'],
		['QS_marker_base_toc',[8138.65,10109,0],'b_hq','Icon','','ColorWEST',[0.5,0.5],0.75,[8138.65,10109,0],0,'TOC'],
		['QS_marker_base_atc',[8109.89,10103.6,0],'b_support','Icon','','ColorWEST',[0.5,0.5],0.75,[8109.89,10103.6,0],0,'ATC'],
		['QS_marker_veh_baseservice_01',[8248.01,10152.2,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[8248.01,10152.2,0],0,'Vehicle Service'],
		['QS_marker_veh_baseservice_02',[7997.01,10228.2,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[7997.01,10228.2,0],0,'Heli Service'],
		['QS_marker_veh_baseservice_03',[7970,9611.15,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[7970,9611.15,0],0,'Plane Service'],
		['QS_marker_veh_fieldservice_01',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Vehicle Service'],
		['QS_marker_veh_fieldservice_02',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Vehicle Service'],
		['QS_marker_veh_fieldservice_03',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Vehicle Service'],
		['QS_marker_veh_fieldservice_04',[0,0,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0,[-5000,-5000,0],0,'Air Service'],
		['QS_marker_Almyra_blacklist_area',_markerStoragePos,'Empty','Icon','','ColorWEST',[0.25,0.25],0,_markerStoragePos,0,''],
		['QS_marker_fpsMarker',[0,0,0],'mil_dot','Icon','','ColorWhite',[1,1],0,[(worldSize + 1000),worldSize,0],0,''],
		['QS_marker_curators',[0,0,0],'mil_dot','Icon','','ColorWhite',[1,1],0,[(worldSize + 1000),(worldSize - 500),0],0,'Active Zeus - []'],
		['QS_marker_module_fob',_markerStoragePos,'b_hq','Icon','','ColorWEST',[0.5,0.5],0,_markerStoragePos,0,'FOB'],
		['QS_marker_veh_inventoryService_01',[8259.2,10156.5,0],'b_maint','Icon','','ColorWEST',[0.5,0.5],0.75,[8259.2,10156.5,0],0,'Inventory'],
		['QS_marker_teamspeak',[(worldSize / 2),(worldSize / 2),0],'mil_dot','Icon','','ColorYELLOW',[0.75,0.75],0.75,[(worldSize / 2),(worldSize / 2),0],0,(format ['Teamspeak:   %1',_teamspeakText])],
		['QS_marker_ferry_1',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[927.554,11824.1,0],0,'Boat'],
		['QS_marker_ferry_2',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[5493.62,11660.8,0],0,'Boat'],
		['QS_marker_ferry_3',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[9286.06,3720.37,0],0,'Boat'],
		['QS_marker_ferry_4',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[8497.2,3799.11,0],0,'Boat'],
		['QS_marker_ferry_5',_markerStoragePos,'c_ship','Icon','','ColorCIVILIAN',[0.25,0.25],0.5,[3676.83,3035.56,0],0,'Boat'],
		['QS_marker_carrier_1',_markerStoragePos,'b_naval','Icon','','ColorWEST',[0.25,0.25],0,[-1500,-1500,0],0,'Aircraft Carrier']
	]
};
[]