/*
File: fn_listRemoteTargets.sqf
Author: 

	Quiksilver

Last Modified:

	11/07/2017 A3 1.72 by Quiksilver

Description:

	List remote targets
____________________________________________________________________________*/

params ['_remoteTargets','_type'];
if (_remoteTargets isEqualTo []) exitWith {[]};
private _return = [];
{
	if (alive (effectiveCommander (_x select 0))) then {
		if ((side (effectiveCommander (_x select 0))) in [EAST,RESISTANCE]) then {
			_return pushBack (_x select 0);
		};
	};
} forEach _remoteTargets;
_return;