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
_puid = _this select 0;
_validated = TRUE;
_blacklistedString = [
	'Fuck','Shit','Cunt','Bitch','Nigger','Prick','Fag','Phag',
	'Penis','Vagina','Asshole','Gay','Lesbian','Cvnt',
	'Sh1t','Shlt','G4y','Fvck','H4ck','N1gger','Nlgger','pussy','pvssy','puzzy','pvzzy',
	'rape','r4pe','r4p3','rapist','r4pist','r4p1st','Server','Admin'
];
{
	if ([_x,profileName,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) exitWith {
		if (userInputDisabled) then {
			disableUserInput FALSE;
		};
		['systemChat',(format ['Robocop kicked %1 for disallowed profile name.',profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		endMission 'QS_RD_end_5';
		[ 
			(format ['Auto-kicked for disallowed profile name string ( %1 ).',_x]),
			'Robocop',
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
	_nameArray = _reservedClients select _forEachIndex;
	_reservedName = _nameArray select 0;
	_reservedUID = _nameArray select 1;
	if (profileName == _reservedName) then {
		if (_puid isNotEqualTo _reservedUID) exitWith {
			if (userInputDisabled) then {
				disableUserInput FALSE;
			};
			['systemChat',(format ['Robocop kicked %1 for reserved profile name.',profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			endMission 'QS_RD_end_5';
			[ 
				'Auto-kicked for reserved profile name.',
				'Robocop',
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