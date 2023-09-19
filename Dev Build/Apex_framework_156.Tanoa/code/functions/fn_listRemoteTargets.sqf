/*
File: fn_listRemoteTargets.sqf
Author: 

	Quiksilver

Last Modified:

	19/12/2017 A3 1.80 by Quiksilver

Description:

	List remote targets
____________________________________________________________________________*/

params ['_remoteTargets','_type'];
if (_remoteTargets isEqualTo []) exitWith {[]};
private _return = [];
{
	if (alive (effectiveCommander (_x # 0))) then {
		if ((side (effectiveCommander (_x # 0))) in [EAST,RESISTANCE]) then {
			if ((_x # 0) getVariable ['QS_remoteTarget_reported',FALSE]) then {
				_return pushBack (_x # 0);
			};
		};
	};
} forEach _remoteTargets;
_return;