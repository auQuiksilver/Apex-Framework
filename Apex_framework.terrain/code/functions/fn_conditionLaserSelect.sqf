/*/
File: fn_conditionLaserSelect.sqf
Author:
	
	Quiksilver
	
Last Modified:

	14/04/2023 A3 2.12 by Quiksilver
	
Description:

	-
______________________________________________________/*/

params ['_target','','_originalTarget','_actionIds'];
_current = QS_player getVariable ['QS_toggle_visibleLaser',FALSE];
_highPowerEnabled = missionNamespace getVariable ['QS_missionConfig_weaponLasersHiPower',FALSE];
private _text = '';
if (
	(uiNamespace getVariable ['QS_uiaction_turbo',FALSE]) &&
	_highPowerEnabled
) then {
	_laserBeamParams = QS_player getVariable ['QS_unit_laserBeamParams',[[1000,0,0],[1000,0,0],0.25,0.25,150,FALSE,FALSE,[500,0,0]]];
	if (_laserBeamParams # 6) then {
		_text = localize 'STR_QS_Text_437';
		QS_player setUserActionText [_actionIds,_text,format ["<t size='3'>%1</t>",_text]];
	} else {
		_text = localize 'STR_QS_Text_438';
		QS_player setUserActionText [_actionIds,_text,format ["<t size='3'>%1</t>",_text]];
	};
} else {
	if (_current) then {
		_text = localize 'STR_QS_Text_436';
		QS_player setUserActionText [_actionIds,_text,format ["<t size='3'>%1</t>",_text]];
	} else {
		_text = localize 'STR_QS_Text_435';
		QS_player setUserActionText [_actionIds,_text,format ["<t size='3'>%1</t>",_text]];
	};
};
TRUE;