/*
File: fn_clientInteractTooth.sqf
Author:

	Quiksilver
	
Last Modified:

	7/02/2015 A3 1.54 by Quiksilver
	
Description:

	-
_____________________________________________________________*/

private ['_obj'];
_obj = cursorTarget;
if (isNull _obj) exitWith {};
if (isNil {_obj getVariable 'QS_collectible_tooth'}) exitWith {};
if (alive _obj) exitWith {};
if (!(_obj isKindOf 'Man')) exitWith {};
if ((!isNil {player getVariable 'QS_teeth_collected'}) && (_obj in (player getVariable 'QS_teeth_collected'))) exitWith {};
if (isNil {player getVariable 'QS_teeth_collected'}) then {
	player setVariable ['QS_teeth_collected',[],FALSE];
};
player playAction 'PutDown';
_obj setVariable ['QS_collectible_tooth',FALSE,TRUE];
player setVariable [
	'QS_teeth_collected',
	((player getVariable 'QS_teeth_collected') + [_obj]),
	FALSE
];
[62,[player,(getPlayerUID player),profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
['ScoreBonus',['Gold digger','10']] call (missionNamespace getVariable 'QS_fnc_showNotification');
playSound 'ClickSoft';
50 cutText ['Gold tooth collected','PLAIN DOWN'];
TRUE;