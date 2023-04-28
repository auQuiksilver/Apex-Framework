/*
File: fn_atNameCheck.sqf
Author:

	Quiksilver
	
Last modified:

	20/12/2016 A3 1.66 by Quiksilver
	
Description:

	-
__________________________________________________*/

private [
	'_puid','_validated','_blacklistedString',
	'_reservedClients','_nameArray','_reservedName','_reservedUID'
];
_puid = _this # 0;
_validated = TRUE;
_blacklistedString = ['profilename_blacklisted_text_1'] call QS_data_listOther;
{
	if ([_x,profileName,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) exitWith {
		if (userInputDisabled) then {
			disableUserInput FALSE;
		};
		['systemChat',(format ['%2 %1 %3',profileName,localize 'STR_QS_Chat_082',localize 'STR_QS_Chat_084'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		endMission 'QS_RD_end_5';
		[ 
			(format ['%2 ( %1 )',_x,localize 'STR_QS_Menu_108']),
			localize 'STR_QS_Menu_109',
			TRUE, 
			FALSE, 
			(findDisplay 46), 
			FALSE, 
			FALSE 
		] call (missionNamespace getVariable 'BIS_fnc_GUImessage');
		_validated = FALSE;
	};
} count _blacklistedString;
_reservedClients = [
	['Quiksilver','76561198084065754'],
	['QS','76561198084065754'],
	['QuiksiIver','76561198084065754'],
	['Quicksilver','76561198084065754'],
	['QuicksiIver','76561198084065754']
];
{
	_nameArray = _reservedClients # _forEachIndex;
	_reservedName = _nameArray # 0;
	_reservedUID = _nameArray # 1;
	if (profileName == _reservedName) then {
		if (_puid isNotEqualTo _reservedUID) exitWith {
			if (userInputDisabled) then {
				disableUserInput FALSE;
			};
			['systemChat',(format ['%2 %1 %3',profileName,localize 'STR_QS_Chat_082',localize 'STR_QS_Chat_085'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			endMission 'QS_RD_end_5';
			[ 
				format ['%1 (%2)',localize 'STR_QS_Menu_110',_reservedName],
				localize 'STR_QS_Menu_109',
				TRUE, 
				FALSE, 
				(findDisplay 46), 
				FALSE, 
				FALSE 
			] call (missionNamespace getVariable 'BIS_fnc_GUImessage');
			_validated = FALSE;
		};
	};
} forEach _reservedClients;
_validated;