/*
File: fn_AIcreate.sqf
Author:

	Quiksilver
	
Last modified:

	25/10/2015 ArmA 3 1.52 by Quiksilver
	
Description:

	AI Create
	
	['CREATE','PRIMARY','PATROL','INFANTRY',EAST,_randomPos,_pos,_infType,'',1];
	
_infTypes = ["OIA_InfSentry","OIA_InfSquad","OIA_InfTeam","OIA_InfTeam_AA","OI_reconPatrol","OI_reconSentry","OIA_InfAssault","OIA_ReconSquad"];
_infUrbanTypes = ["OIA_GuardSentry","OIA_GuardTeam"];

_infGroupTypes = [
	'OI_reconPatrol','OI_reconSentry','OI_reconTeam','OI_SniperTeam','OIA_InfAssault',
	'OIA_InfSentry','OIA_InfSquad','OIA_InfSquad_Weapons','OIA_InfTeam','OIA_InfTeam_AA',
	'OIA_InfTeam_AT','OIA_ReconSquad'
];
_infGroupTypesUrban = [
	'OIA_GuardSentry','OIA_GuardSquad','OIA_GuardTeam'
];

_infGroupTypesSupport = [
	'OI_recon_EOD','OI_support_CLS','OI_support_ENG','OI_support_EOD','OI_support_GMG','OI_support_MG','OI_support_Mort'
];
	
__________________________________________________*/

_infGroupTypes = [
	'OI_reconPatrol','OI_reconSentry','OI_reconTeam','OI_SniperTeam','OIA_InfAssault',
	'OIA_InfSentry','OIA_InfSquad','OIA_InfSquad_Weapons','OIA_InfTeam','OIA_InfTeam_AA',
	'OIA_InfTeam_AT','OIA_ReconSquad'
];
_infGroupTypesUrban = [
	'OIA_GuardSentry','OIA_GuardSquad','OIA_GuardTeam'
];

_infGroupTypesSupport = [
	'OI_recon_EOD','OI_support_CLS','OI_support_ENG','OI_support_EOD','OI_support_GMG','OI_support_MG','OI_support_Mort'
];
_infGroupTypesSpecOps = [
	'OI_diverTeam','OI_SmallTeam_UAV'
];

private ['_createOrDelete','_objective','_operation','_vehicleUse','_side','_spawnPos','_patrolPos','_groupType','_assignedVehicleType','_skillPreset','_configPath'];

_createOrDelete = _this select 0;
_objective = _this select 1;
_operation = _this select 2;
_vehicleUse = _this select 3;
_side = _this select 4;
_spawnPos = _this select 5;
_patrolPos = _this select 6;
_groupType = _this select 7;
_assignedVehicleType = _this select 8;
_skillPreset = _this select 9;

if (_groupType in _infGroupTypes) then {
	_configPath = configfile >> 'CfgGroups' >> 'East' >> 'OPF_F' >> 'Infantry' >> _groupType;
};
if (_groupType in _infGroupTypesUrban) then {
	_configPath = configfile >> 'CfgGroups' >> 'East' >> 'OPF_F' >> 'UInfantry' >> _groupType;
};
if (_groupType in _infGroupTypesSupport) then {
	_configPath = configfile >> 'CfgGroups' >> 'East' >> 'OPF_F' >> 'Support' >> _groupType;
};
if (_groupType in _infGroupTypesSpecOps) then {
	_configPath = configfile >> 'CfgGroups' >> 'East' >> 'OPF_F' >> 'SpecOps' >> _groupType;
};