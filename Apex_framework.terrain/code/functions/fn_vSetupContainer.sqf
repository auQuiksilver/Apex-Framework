/*
File: fn_vSetupContainer.sqf
Author:
	
	Quiksilver
	
Last Modified:

	31/05/2023 A3 2.12 by Quiksilver

Description:

	Container setup
_____________________________________*/

params ['_entity'];
if (
	(!alive _entity) ||
	{(_entity getVariable ['QS_logistics_wreck',FALSE])} ||
	{((['Cargo_base_F','Slingload_01_Base_F','Pod_Heli_Transport_04_base_F'] findIf { _entity isKindOf _x }) isEqualTo -1)}
) exitWith {};
_entityType = toLowerANSI (typeOf _entity);
{
	_entity setVariable _x;
} forEach [
	['QS_logistics',TRUE,TRUE],
	['QS_logistics_dragDisabled',TRUE,TRUE],
	['QS_customCargoCapacity',[300000,300000,1],TRUE]
];
if (
	(_entity isKindOf 'Slingload_01_Base_F') ||
	{(_entity isKindOf 'Pod_Heli_Transport_04_base_F')}
) then {
	_entity setVariable ['QS_logistics',TRUE,TRUE];
	_entity setVariable ['QS_ST_showDisplayName',TRUE,TRUE];
};
if (['cargo20',_entityType] call QS_fnc_inString) then {
	if ((getMass _u) > 10000) then {
		_u setMass 10000;
	};
};
if (_entity isKindOf 'Land_Cargo10_blue_F') exitWith {
	//comment 'Mobile SAM';
	_class = QS_core_vehicles_map getOrDefault ['b_sam_system_03_f','b_sam_system_03_f'];
	{
		_entity setVariable _x;
	} forEach [
		['QS_importance',1,FALSE],
		['QS_logistics_deployParams',[5,300,25,300,-1,30,500],TRUE],
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
		['QS_logistics_deployParams',[5,300,25,300,-1,30,500],TRUE],
		['QS_deploy_preset',7,TRUE],
		['QS_logistics_deployable',TRUE,TRUE],
		['QS_ST_customDN',(getText (configFile >> 'CfgVehicles' >> _class >> 'displayName')),TRUE],
		['QS_ST_showDisplayName',TRUE,TRUE]
	];
	_entity setMass 2500;
};
if (_entity isKindOf 'Land_Cargo10_light_blue_F') exitWith {
	//comment 'Nothing yet';
	{
		_entity setVariable _x;
	} forEach [
		//['QS_logistics_deployable',TRUE,TRUE],
		['QS_importance',1,FALSE],
		['QS_logistics_deployParams',[5,300,25,300,-1,30,500],TRUE],
		['QS_deploy_preset',8,TRUE]
	];
};

//comment 'Wrecks';
if (_entity isKindOf 'Land_Cargo10_red_F') exitWith {
	//comment 'Air Wrecks';
	{
		_entity setVariable _x;
	} forEach [
		['QS_deploy_preset',9,TRUE]
	];		
};
if (_entity isKindOf 'Land_Cargo10_brick_red_F') exitWith {
	//comment 'Heavy Armor Wrecks';
	{
		_entity setVariable _x;
	} forEach [
		['QS_deploy_preset',10,TRUE]
	];		
};
if (_entity isKindOf 'Land_Cargo10_orange_F') exitWith {
	//comment 'Light Armor Wrecks';
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
		['QS_logistics_deployParams',[5,900,300,3600,-1,200,1200],TRUE],
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
		['QS_logistics_deployParams',[5,600,200,1800,-1,150,800],TRUE],
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
		['QS_logistics_deployParams',[5,300,100,900,-1,100,400],TRUE],
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
		['QS_logistics_deployParams',[5,60,25,900,-1,100,500],TRUE],
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
		['QS_logistics_deployParams',[5,300,300,900,-1,25,1000],TRUE],
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
		['QS_logistics_deployParams',[5,60,25,60,-1,100,500],TRUE],
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
// Not ready yet
/*/
if (
	(_entity isKindOf 'b_slingload_01_medevac_f') ||
	(_entity isKindOf 'land_pod_heli_transport_04_medevac_f')
) exitWith {
	[
		'SET_VCARGO_SERVER',
		_entity,
		([13] call QS_data_virtualCargoPresets)
	] call QS_fnc_virtualVehicleCargo;
};
/*/