/*
File: fn_clientInteractEar.sqf
Author:

	Quiksilver
	
Last Modified:

	7/02/2015 A3 1.54 by Quiksilver
	
Description:

	-
_____________________________________________________________*/

private _obj = cursorTarget;
if (isNull _obj) exitWith {};
if (isNil {_obj getVariable 'QS_collectible_ears'}) exitWith {};
if (alive _obj) exitWith {};
if (!(_obj isKindOf 'Man')) exitWith {};
if ((!isNil {_obj getVariable 'QS_ears_remaining'}) && ((_obj getVariable 'QS_ears_remaining') < 1)) exitWith {};
if ((!isNil {player getVariable 'QS_ears_collected'}) && (_obj in (player getVariable 'QS_ears_collected'))) exitWith {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,3,-1,'Already collected an ear from this corpse!',[],-1];
};
if (isNil {player getVariable 'QS_ears_collected'}) then {
	player setVariable ['QS_ears_collected',[],FALSE];
};
player playAction 'PutDown';
_obj setVariable [
	'QS_ears_remaining',
	((_obj getVariable 'QS_ears_remaining') - 1),
	TRUE
];
player setVariable [
	'QS_ears_collected',
	((player getVariable 'QS_ears_collected') + [_obj]),
	FALSE
];
if ((_obj getVariable 'QS_ears_remaining') < 1) then {
	_obj setVariable ['QS_collectible_ears',FALSE,TRUE];
};
[61,[player,(getPlayerUID player),profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
['ScoreBonus',['Ear slicer','1']] call (missionNamespace getVariable 'QS_fnc_showNotification');
playSound 'ClickSoft';
50 cutText ['Ear collected','PLAIN DOWN'];
TRUE;