/*
File: fn_clientEventOnFlare.sqf
Author: 

	Quiksilver

Last Modified:

	26/05/2022 A3 2.08 by Quiksilver

Description:

	Event On Flare
________________________________________________________________*/

params ['_color','_unit','_projectile'];
if (isDedicated || {!hasInterface}) exitWith {
	QS_managed_flares pushBack [_projectile,diag_tickTime + 45];
};
if (
	(isNull _projectile) ||
	{(((cameraOn distance2D _projectile) >= 5000) && (isNull curatorCamera))}
) exitWith {};
_flare = createVehicleLocal ['#lightpoint',getPosWorld _projectile];
QS_managed_flares pushBack [_flare,diag_tickTime + 45];
QS_managed_flares pushBack [_projectile,diag_tickTime + 45];
[1,_flare,[_projectile,[0,0,0]]] call QS_fnc_eventAttach;
_flare setLightColor _color;
_flare setLightAmbient _color;
_flare setLightIntensity ([50000,75000] select (_color isEqualTo [0.5,0.5,0.5]));
_flare setLightFlareSize 10;
_flare setLightFlareMaxDistance 300;
_flare setLightDayLight TRUE;
_flare setLightAttenuation [4, 0, 0, 0.2, 500,1000];
if ((typeOf _projectile) isEqualTo 'F_40mm_Cir') then {
	_flare setLightIR TRUE;
	_flare setLightIntensity 60000;
};
if ((typeOf _projectile) isEqualTo 'Flare_82mm_AMOS_White') then {
	_flare setLightIntensity 120000;
	_flare setLightFlareMaxDistance 450;
	_flare setLightFlareSize 15;
	_flare setLightAttenuation [4,0,0,0.2,750,1500];
};
if ((typeOf _projectile) in ['F_Signal_Green','F_Signal_Red']) then {
	_flare setLightIntensity 50000;
	_flare setLightAttenuation [4, 0, 0, 0.2, 250,500];
	_flare setLightFlareSize 5;
	_flare setLightFlareMaxDistance 150;
};
_flare setLightUseFlare TRUE;
_projectile setVariable ['QS_flare',_flare,FALSE];
_projectile addEventHandler [
	'Deleted', 
	{
		params ['_projectile'];
		if ((attachedObjects _projectile) isNotEqualTo []) then {
			deleteVehicle (attachedObjects _projectile);
		};
		if (!isNull (_projectile getVariable ['QS_flare',objNull])) then {
			deleteVehicle (_projectile getVariable ['QS_flare',objNull]);
		};
	}
];