/*
File: fn_vSetupContainer.sqf
Author:
	
	Quiksilver
	
Last Modified:

	01/05/2023 A3 2.12 by Quiksilver

Description:

	Container setup
_____________________________________*/

params ['_entity'];
comment 'Mobile AA';
{
	_entity setVariable _x;
} forEach [
	['QS_logistics',TRUE,TRUE],
	['QS_logistics_dragDisabled',TRUE,TRUE]
];
if (_entity isKindOf 'Land_Cargo10_blue_F') exitWith {
	//comment 'Mobile SAM';
	_class = QS_core_vehicles_map getOrDefault ['b_sam_system_03_f','b_sam_system_03_f'];
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',1,FALSE],
		['QS_logistics_deployParams',[50,60,50,60,100,25],TRUE],
		['QS_deploy_preset',6,TRUE],
		['QS_logistics_deployable',TRUE,TRUE],
		['QS_ST_customDN',(getText (configFile >> 'CfgVehicles' >> _class >> 'displayName')),TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE]
	];
	_entity setMass 2500;
};
if (_entity isKindOf 'Land_Cargo10_cyan_F') exitWith {
	//comment 'Mobile RADAR';
	_class = QS_core_vehicles_map getOrDefault ['b_radar_system_01_f','b_radar_system_01_f'];
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',1,FALSE],
		['QS_logistics_deployParams',[50,60,50,60,100,25],TRUE],
		['QS_deploy_preset',7,TRUE],
		['QS_logistics_deployable',TRUE,TRUE],
		['QS_ST_customDN',(getText (configFile >> 'CfgVehicles' >> _class >> 'displayName')),TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE]
	];
	_entity setMass 2500;
};
if (_entity isKindOf 'Land_Cargo10_light_blue_F') exitWith {
	//comment '';
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',1,FALSE],
		['QS_logistics_deployParams',[50,60,50,60,100,25],TRUE],
		['QS_deploy_preset',8,TRUE]
	];
};

comment 'Wrecks';
if (_entity isKindOf 'Land_Cargo10_red_F') exitWith {
	//comment 'Air Wrecks';
	{
		_entity setVariable _x;
	} forEach [
		['QS_deploy_preset',9,TRUE]
	];		
};
if (_entity isKindOf 'Land_Cargo10_brick_red_F') exitWith {
	//comment 'Tank Wrecks';
	{
		_entity setVariable _x;
	} forEach [
		['QS_deploy_preset',10,TRUE]
	];		
};
if (_entity isKindOf 'Land_Cargo10_orange_F') exitWith {
	//comment 'Car Wrecks';
	{
		_entity setVariable _x;
	} forEach [
		['QS_deploy_preset',11,TRUE]
	];
};
comment 'Bases';
if (_entity isKindOf 'Land_Cargo10_grey_F') exitWith {
	//comment 'FOB';
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',4,FALSE],
		['QS_deploy_type','FORT',TRUE],
		['QS_logistics_unloadDistance',50,TRUE],
		['QS_logistics_deployParams',[10,300,1000,300,2000,150],TRUE],
		['QS_logistics_unloadReqDep',TRUE,TRUE],
		['QS_deploy_preset',12,TRUE],
		['QS_logistics_deployable',TRUE,TRUE],
		['QS_ST_customDN',localize 'STR_QS_Text_451',TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE]
	];
};
if (_entity isKindOf 'Land_Cargo10_military_green_F') exitWith {
	//comment 'Base Medium or Heavy fortifications';
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',3,FALSE],
		['QS_deploy_type','FORT',TRUE],
		['QS_logistics_unloadDistance',25,TRUE],
		['QS_logistics_deployParams',[10,300,500,300,1000,100],TRUE],
		['QS_logistics_unloadReqDep',TRUE,TRUE],
		['QS_deploy_preset',13,TRUE],
		['QS_logistics_deployable',TRUE,TRUE],
		['QS_ST_customDN',localize 'STR_QS_Text_450',TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE]
	];
	_entity setMass 7500;
};
if (_entity isKindOf 'Land_Cargo10_light_green_F') exitWith {
	//comment 'Base Small or Medium/Light fortifications';
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',2,FALSE],
		['QS_deploy_type','FORT',TRUE],
		['QS_logistics_unloadDistance',25,TRUE],
		['QS_logistics_deployParams',[10,300,250,300,500,50],TRUE],
		['QS_logistics_unloadReqDep',TRUE,TRUE],
		['QS_deploy_preset',14,TRUE],
		['QS_logistics_deployable',TRUE,TRUE],
		['QS_ST_customDN',localize 'STR_QS_Text_449',TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE]
	];
	_entity setMass 4999;
};
if (_entity isKindOf 'Land_Cargo10_sand_F') exitWith {
	//comment 'Platform Kit';
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',1,FALSE],
		['QS_deploy_type','FORT',TRUE],
		['QS_logistics_unloadDistance',25,TRUE],
		['QS_logistics_deployParams',[10,60,500,300,500,100],TRUE],
		['QS_logistics_deployNearWater',TRUE,TRUE],
		['QS_deploy_preset',15,TRUE],
		['QS_logistics_deployable',TRUE,TRUE],
		['QS_ST_customDN',localize 'STR_QS_Text_448',TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE]
	];
};

if (_entity isKindOf 'Land_Cargo10_white_F') exitWith {
	//comment 'Mobile Respawn';
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',3,FALSE],
		['QS_deploy_type','FORT',TRUE],
		['QS_respawn_object',TRUE,TRUE],
		['QS_logistics_deployParams',[10,60,500,300,0,10],TRUE],
		['QS_logistics_unloadReqDep',TRUE,TRUE],
		['QS_deploy_preset',16,TRUE],
		['QS_ST_customDN',localize 'STR_QS_Text_447',TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE],
		['QS_logistics_deployable',TRUE,TRUE]
	];
};
if (_entity isKindOf 'Land_Cargo10_yellow_F') exitWith {
	//comment 'Terrain';
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',1,FALSE],
		['QS_deploy_type','FORT',TRUE],
		['QS_terrain_leveler',TRUE,TRUE],
		['QS_logistics_deployParams',[10,60,10,300,0,50],TRUE],
		['QS_ST_customDN',localize 'STR_QS_Text_455',TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE],
		['QS_logistics_deployable',TRUE,TRUE],
		['QS_deploy_preset',17,TRUE]
	];
};
if (_entity isKindOf 'land_cargo10_idap_f') exitWith {
	//comment 'Field Hospital';
	{
		_entity setVariable _x;
	} forEach [
		['QS_deploy_preset',18,TRUE]
	];
};