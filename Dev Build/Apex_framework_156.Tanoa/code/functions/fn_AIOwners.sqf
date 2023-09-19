/*/
File: fn_AIOwners.sqf
Author:

	Quiksilver
	
Last Modified:

	3/10/2017 A3 1.76 by Quiksilver
	
Description:

	AI Network Owners
____________________________________________/*/

private _AIOwners = [2];
if (missionNamespace getVariable ['QS_HC_Active',FALSE]) then {
	{
		_AIOwners pushBack _x;
	} forEach (missionNamespace getVariable ['QS_headlessClients',[]]);
} else {
	if (isDedicated) then {
		_AIOwners = FALSE;
	};
};
_AIOwners;