/*
File: fn_clientInteractTooth.sqf
Author:

	Quiksilver
	
Last Modified:

	25/08/2022 A3 2.10 by Quiksilver
	
Description:

	-
_______________________________________*/

private _obj = cursorTarget;
if (
	(isNull _obj) ||
	(_obj isNil 'QS_collectible_tooth') ||
	(alive _obj) ||
	(!(_obj isKindOf 'CAManBase')) ||
	((!(player isNil 'QS_teeth_collected')) && (_obj in (player getVariable 'QS_teeth_collected')))
) exitWith {

};
if (player isNil 'QS_teeth_collected') then {
	player setVariable ['QS_teeth_collected',[],FALSE];
};
_obj setVariable ['QS_collectible_tooth',FALSE,TRUE];
player setVariable ['QS_teeth_collected',((player getVariable 'QS_teeth_collected') + [_obj]),FALSE];
[62,[player,(getPlayerUID player),profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
['ScoreBonus',[localize 'STR_QS_Notif_042','10']] call (missionNamespace getVariable 'QS_fnc_showNotification');
player playAction 'PutDown';
playSound 'ClickSoft';
50 cutText [localize 'STR_QS_Text_155','PLAIN DOWN'];
TRUE;