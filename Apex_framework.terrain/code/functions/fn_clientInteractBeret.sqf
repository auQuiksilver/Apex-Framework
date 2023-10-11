/*
File: fn_clientInteractBeret.sqf
Author:

	Quiksilver
	
Last Modified:

	25/08/2022 A3 2.10 by Quiksilver
	
Description:

	-
__________________________________________*/

private _target = cursorTarget;
if (_this isEqualType objNull) then {
	_target = _this;
};
if (
	(!isNull _target) &&
	{((player distance _target) < 3)} &&
	{(_target isKindOf 'CAManBase')} &&
	{((headgear _target) isNotEqualTo '')} &&
	{(!isPlayer _target)}
) exitWith {
	_score = [1,3] select ((toLowerANSI (headgear _target)) isEqualTo 'h_beret_csat_01_f');
	[61,[player,(getPlayerUID player),profileName,_target]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	['ScoreBonus',[localize 'STR_QS_Notif_039',(format ['%1',_score])]] call (missionNamespace getVariable 'QS_fnc_showNotification');
	player playAction 'PutDown';
	playSound 'ClickSoft';
	50 cutText [localize 'STR_QS_Text_081','PLAIN DOWN',0.5];
	TRUE;
};
FALSE;