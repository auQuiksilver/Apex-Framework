/*
File: fn_getClientFromDPID.sqf
Author:

	Quiksilver
	
Last modified:

	8/04/2016 A3 1.56 by Quiksilver
	
Description:

	Return Clients DirectPlay ID
__________________________________________________________________________*/

private _client = objNull;
{
	if (!isNil {_x getVariable 'QS_directPlayID'}) then {
		if ((_x getVariable 'QS_directPlayID') isEqualType 0) then {
			if ((_x getVariable 'QS_directPlayID') isEqualTo (_this select 0)) then {
				_client = _x;
			};
		};
	};
	if (!isNull _client) exitWith {};
} count allPlayers;
_client;
