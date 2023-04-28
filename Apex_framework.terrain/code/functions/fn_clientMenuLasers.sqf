/*
File: fn_clientMenuLasers.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/04/2023 A3 2.12 by Quiksilver

Description:

	Laser Color Menu
__________________________________________*/

disableSerialization;
params ['_type','_display'];
_data = [2] call QS_data_lasers;
if (_type isEqualTo 'onLoad') then {
	if (player getVariable ['QS_toggle_visibleLaser',FALSE]) then {
		player setVariable ['QS_toggle_visibleLaser',FALSE,TRUE];
	};
	_enabled = (
		(missionNamespace getVariable ['QS_missionConfig_weaponLasers',TRUE]) &&
		((missionNamespace getVariable ['QS_missionConfig_weaponLasersForced',[-1,-1,-1]]) isEqualTo [-1,-1,-1])
	);
	(_display displayCtrl 1810) ctrlEnable _enabled;
	if (!_enabled) then {
		(_display displayCtrl 1810) ctrlSetText (localize 'STR_QS_Dialogs_110');
		(_display displayCtrl 1810) ctrlSetToolTip (localize 'STR_QS_Dialogs_111');
	};
	private _displayName = '';
	private _tooltip = '';
	private _color = [0,0,0];
	{
		_displayName = _x # 0;
		_color = _x # 1;
		lbAdd [1804,_displayName];
		lbSetTooltip [1804,_forEachIndex,_displayName];
		lbSetColor [1804,_forEachIndex,(_color + [1])];
	} forEach _data;
	lbSetCurSel [1804,0];
};
if (_type isEqualTo 'Select') then {
	_index = lbCurSel 1804;
	_enabled = (
		(missionNamespace getVariable ['QS_missionConfig_weaponLasers',TRUE]) &&
		((missionNamespace getVariable ['QS_missionConfig_weaponLasersForced',[-1,-1,-1]]) isEqualTo [-1,-1,-1])
	);
	if (!_enabled) exitWith {50 cutText [localize 'STR_QS_Text_446','PLAIN DOWN',0.2];};
	if (_index isNotEqualTo -1) then {	
		_element = _data # _index;
		_element params ['_displayName','_color'];
		_laserBeamParams = player getVariable ['QS_unit_laserBeamParams',[[1000,0,0],[1000,0,0],0.25,0.25,150,FALSE,FALSE,[500,0,0]]];
		_laserBeamParams params [
			'_beamColor',
			'_dotColor',
			'_dotSize',
			'_beamDiameter',
			'_beamMaxDist',
			'_isIR',
			'_highPower',
			'_dotColorLP'
		];
		_dotColor = _color;
		_beamColor = _color;
		_lowPowerColor = _color apply {_x * 0.1};
		if (player getVariable ['QS_toggle_visibleLaser',FALSE]) then {
			player setVariable ['QS_toggle_visibleLaser',FALSE,TRUE];
		};
		missionProfileNamespace setVariable ['QS_profile_laserColor',_color];
		saveMissionProfileNamespace;
		player setVariable ['QS_unit_laserBeamParams',[_beamColor,_dotColor,_dotSize,_beamDiameter,_beamMaxDist,_isIR,_highPower,_lowPowerColor],TRUE];
		closeDialog 2;
		0 spawn {
			uiSleep 0.1;
			waitUntil {
				closeDialog 2;
				(!dialog)
			};
			50 cutText [localize 'STR_QS_Text_442','PLAIN DOWN',0.25];
		};
	};
};
if (_type isEqualTo 'Back') then {
	closeDialog 2;
	0 spawn {
		uiSleep 0.1;
		waitUntil {
			closeDialog 2;
			(!dialog)
		};
		createDialog 'QS_RD_client_dialog_menu_supporters';
	};
};