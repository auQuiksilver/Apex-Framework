/*
File: fn_syncNamespace.sqf
Author:

	Quiksilver
	
Last Modified:

	10/09/2016 A3 1.62 by Quiksilver
	
Description:

	Synchronize Namespace
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