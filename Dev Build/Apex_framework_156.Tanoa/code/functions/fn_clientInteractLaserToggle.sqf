/*
File: fn_clientInteractLaserToggle.sqf
Author:
	
	Quiksilver
	
Last Modified:

	14/04/2023 A3 2.12 by Quiksilver

Description:

	Laser Toggle
____________________________________________*/

params ['','',['_actionIds',-1],'',['_comms',TRUE]];
private _unit = QS_player;
if (
	(
		(isNull (objectParent _unit)) ||
		(isTurnedOut _unit)
	) &&
	((currentWeapon _unit) isNotEqualTo '')
) then {
	_laserBeamParams = _unit getVariable ['QS_unit_laserBeamParams',[[1000,0,0],[1000,0,0],0.25,0.25,150,FALSE,FALSE,[500,0,0]]];
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
	_highPowerEnabled = missionNamespace getVariable ['QS_missionConfig_weaponLasersHiPower',FALSE];
	_currentWeapon = currentWeapon _unit;
	_emitters = localNamespace getVariable ['QS_laser_emitters',[]];
	private _weaponItems = (_unit weaponAccessories _currentWeapon) apply {toLowerANSI _x};
	if (
		(_currentWeapon isNotEqualTo '') &&
		{(_currentWeapon isEqualTo (binocular _unit))}
	) then {
		_weaponItems = ((binocularItems _unit) + (binocularMagazine _unit)) apply {toLowerANSI _x};
	};
	if (
		(uiNamespace getVariable ['QS_uiaction_turbo',FALSE]) &&
		_highPowerEnabled
	) then {
		if (_highPower) then {
			_highPower = FALSE;
			if (_actionIds isNotEqualTo -1) then {
				_unit setUserActionText [_actionIds,localize 'STR_QS_Text_438',format ["<t size='3'>%1</t>",localize 'STR_QS_Text_438']];
			};
		} else {
			_highPower = TRUE;
			if (_actionIds isNotEqualTo -1) then {
				_unit setUserActionText [_actionIds,localize 'STR_QS_Text_437',format ["<t size='3'>%1</t>",localize 'STR_QS_Text_437']];
			};
		};
		playSoundUI ['click',soundVolume,2,TRUE];
		_unit setVariable ['QS_unit_laserBeamParams',[_beamColor,_dotColor,_dotSize,_beamDiameter,_beamMaxDist,_isIR,_highPower,_dotColorLP],TRUE];
	} else {
		_current = _unit getVariable ['QS_toggle_visibleLaser',FALSE];
		if (!_current) then {
			if (
				((_emitters findAny _weaponItems) isNotEqualTo -1) &&
				((((magazines _unit) apply {toLowerANSI _x}) findAny qs_core_classnames_laserbatteries) isNotEqualTo -1)
			) then {
				if (diag_tickTime > (uiNamespace getVariable ['QS_laserToggle_cooldown',-1])) then {
					uiNamespace setVariable ['QS_laserToggle_cooldown',diag_tickTime + 2];
					_unit setVariable ['QS_toggle_visibleLaser',TRUE,TRUE];
					playSoundUI ['click',soundVolume,2,TRUE];
					if (_actionIds isNotEqualTo -1) then {
						private _text = localize 'STR_QS_Text_436';
						_unit setUserActionText [_actionIds,_text,format ["<t size='3'>%1</t>",_text]];
					};
				} else {
					if (_comms) then {
						50 cutText [localize 'STR_QS_Text_371','PLAIN DOWN',0.2];
					};
				};
			} else {
				if (_comms) then {
					50 cutText [localize 'STR_QS_Text_441' + ' - ' + localize 'STR_QS_Text_440','PLAIN DOWN',0.25];
				};
			};
		} else {
			if (_actionIds isNotEqualTo -1) then {
				private _text = localize 'STR_QS_Text_435';
				_unit setUserActionText [_actionIds,_text,format ["<t size='3'>%1</t>",_text]];
			};
			_unit setVariable ['QS_toggle_visibleLaser',FALSE,TRUE];
			playSoundUI ['click',soundVolume,2,TRUE];
		};
	};
};