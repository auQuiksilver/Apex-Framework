/*
File: fn_Q51.sqf
Author:

	Quiksilver
	
Last modified:

	21/02/2023 A3 2.12 by Quiksilver
	
Description:

	Create a 'Q51' fighter
__________________________________________________*/

_vehicle = param [0,objNull];
if (
	(isNull _vehicle) ||
	(!((toLowerANSI (typeOf _vehicle)) in ['c_plane_civil_01_racing_f','c_plane_civil_01_f','i_c_plane_civil_01_f'])) ||
	(!alive _vehicle) ||
	(!local _vehicle)
) exitWith {};
{
	_vehicle addWeaponTurret _x;
} forEach [
	['CMFlareLauncher',[-1]],
	['M134_minigun',[-1]],
	['autocannon_40mm_CTWS',[-1]]
];
{
	_vehicle addMagazineTurret _x;
} forEach [
	['60Rnd_CMFlare_Chaff_Magazine',[-1]],
	['60Rnd_CMFlare_Chaff_Magazine',[-1]],
	['60Rnd_CMFlare_Chaff_Magazine',[-1]],
	['60Rnd_CMFlare_Chaff_Magazine',[-1]],
	['60Rnd_CMFlare_Chaff_Magazine',[-1]],
	['5000Rnd_762x51_Yellow_Belt',[-1]],
	['5000Rnd_762x51_Yellow_Belt',[-1]],
	['5000Rnd_762x51_Yellow_Belt',[-1]],
	['5000Rnd_762x51_Yellow_Belt',[-1]],
	['60Rnd_40mm_GPR_Tracer_Red_shells',[-1]],
	['60Rnd_40mm_GPR_Tracer_Red_shells',[-1]]
];
_vehicle setVariable ['QS_ST_customDN','Q-51 Mosquito',TRUE];
_vehicle setObjectTextureGlobal [0,"a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_1_brownhex_CO.paa"];
_vehicle setObjectTextureGlobal [1,"a3\Air_F_Gamma\Plane_Fighter_03\Data\Plane_Fighter_03_body_1_brownhex_CO.paa"];
_vehicle setVehicleReceiveRemoteTargets TRUE;
_vehicle setVehicleReportRemoteTargets TRUE;
_vehicle setVehicleReportOwnPosition FALSE;
_vehicle addEventHandler [
	'HandleDamage',
	{
		if (!(local (_this # 0))) exitWith {};
		params ['_vehicle','_selection','_damage'];
		_oldDamage = if (_selection isEqualTo '') then [{(damage _vehicle)},{(_vehicle getHit _selection)}];
		_damage = ((_damage - _oldDamage) * 0.1) + _oldDamage;
		_damage;
	}
];