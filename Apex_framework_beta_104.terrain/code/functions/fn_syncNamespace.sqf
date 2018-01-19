/*
File: fn_syncNamespace.sqf
Author:

	Quiksilver
	
Last Modified:

	10/09/2016 A3 1.62 by Quiksilver
	
Description:

	Synchronize Namespace
	
_i = [
	_manifest,
	_uid,
	0
] call (missionNamespace getVariable 'ZEN_fnc_arrayGetNestedIndex');
0 = _QS_clientManifest pushBack [_QS_function,_QS_version,_QS_useEncryption];

_profileManifest = [
	['QS_fnc_randomfunction',1,''],
	['QS_fnc_somefunction',2,''],
	['QS_fnc_thatfunction',3,'']
];




_____________________________________________________*/

private ['_i'];

_serverManifest = [] call QS_fnc_returnClientManifest;
_profileManifest = profileNamespace getVariable ['QS_IA_profileManifest',[]];




{	
	_functionName = _x select 0;
	_functionVersion = _x select 1;
	_useEncryption = _x select 2;
	if (isNil {profileNamespace getVariable _functionName}) then {
	
	
	
	} else {

	
	
	};
} forEach _serverManifest;