/*
File: fn_clientInteractLift.sqf
Author:

	Quiksilver
	
Last Modified:

	28/10/2023 A3 2.12 by Quiksilver
	
Description:

	Lift
__________________________________________*/

if (isNull (objectParent QS_player)) exitWith {};
private _parent = cameraOn;
private _target = [0,_parent] call QS_fnc_getFrontObject;
if (isNull _target) exitWith {50 cutText [localize 'STR_QS_Text_335','PLAIN DOWN',0.5];};
if (!alive _target) exitWith {};
if (_target getVariable ['QS_logistics_immovable',FALSE]) exitWith {50 cutText [localize 'STR_QS_Text_335','PLAIN DOWN',0.25];};
_dn1 = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _target)],
	{(getText ((configOf _target) >> 'displayName'))},
	TRUE
];
50 cutText [format [localize 'STR_QS_Text_407',(_target getVariable ['QS_ST_customDN',_dn1])],'PLAIN DOWN',0.333];
[_parent,_target,FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,attachedTo _target,FALSE,TRUE,'',FALSE] call QS_fnc_unloadCargoPlacementMode;