/*/
File: fn_clientInteractExamine.sqf
Author:

	Quiksilver
	
Last Modified:

	2/12/2017 A3 1.78 by Quiksilver
	
Description:

	-
_____________________________________________________________/*/

_t = cursorObject;
if (
	(isNull _t) ||
	(_t isNil 'QS_entity_examine') ||
	(player getVariable ['QS_client_examining',FALSE])
) exitWith {};
player setVariable ['QS_client_examining',TRUE,FALSE];
playSound 'clicksoft';
_onProgress = {
	FALSE
};
_onCancelled = {
	params ['_entity','_position'];
	private _c = FALSE;
	if (!alive player) then {_c = TRUE;};
	if ((player distance2D _position) > 5.1) then {_c = TRUE;};
	if (!((lifeState player) in ['HEALTHY','INJURED'])) then {_c = TRUE;};
	if ((_entity isNotEqualTo cursorObject) && (_entity isNotEqualTo cursorTarget)) then {_c = TRUE;};
	if (!isNull (objectParent player)) then {_c = TRUE;};
	if (_entity getVariable ['QS_entity_examined',FALSE]) then {_c = TRUE;};
	if (_c) then {
		player setVariable ['QS_client_examining',FALSE,FALSE];
	};
	_c;
};
_onCompleted = {
	params ['_entity'];
	player setVariable ['QS_client_examining',FALSE,FALSE];
	_entity setVariable ['QS_entity_examined',TRUE,TRUE];
	_result = _entity getVariable ['QS_entity_examine_intel',-1];
	[_entity,_result] call (missionNamespace getVariable 'QS_fnc_clientExamineResult');
	50 cutText [localize 'STR_QS_Text_107','PLAIN DOWN',0.3];
};
_onFailed = {
	player setVariable ['QS_client_examining',FALSE,FALSE];
	FALSE
};
[
	localize 'STR_QS_Menu_168',
	(random [2,3.5,5.5]),
	0,
	[[_t],{FALSE}],
	[[_t,(position _t)],_onCancelled],
	[[_t],_onCompleted],
	[[],{FALSE}],
	FALSE
] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');