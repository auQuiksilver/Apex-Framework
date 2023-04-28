/*/
File: fn_updateLaserInfo.sqf
Author:
	
	Quiksilver
	
Last Modified:

	12/08/2023 A3 2.12 by Quiksilver
	
Description:

	Update Laser Info
	
	localNamespace setVariable ['QS_debug_laserCustomOffset',[0.03,0.035,-0.02]];
	
	[0.03,0.035,-0.02]
	
______________________________________________________/*/
params ['_unit','_currentWeapon'];
_laserData = QS_hashmap_lasers getOrDefault [_currentWeapon,[]];
if (
	(_laserData isNotEqualTo []) &&
	{(_currentWeapon isNotEqualTo '')}
) then {
	private _offset = _laserData # 0;
	_custom = QS_hashmap_lasersCustomOffsets getOrDefault [_currentWeapon,[0,0,0]];
	if (_custom isNotEqualTo [0,0,0]) then {
		_offset = _offset vectorAdd _custom;
	} else {
		if ((localNamespace getVariable ['QS_debug_laserCustomOffset',[0,0,0]]) isNotEqualTo [0,0,0]) then {
			_offset = _offset vectorAdd (localNamespace getVariable ['QS_debug_laserCustomOffset',[0,0,0]]);
		} else {
			_offset = _offset vectorAdd [0.06,0.044,-0.02];			// MX rifle generic offset
		};
	};
	_offset = _offset apply { [_x] };
	{
		_unit setVariable _x;
	} forEach [
		['QS_unit_laserOffset',_offset,FALSE],
		['QS_unit_weaponProxy',_laserData # 1,FALSE]
	];
} else {
	{
		_unit setVariable _x;
	} forEach [
		['QS_unit_laserOffset',[[0.06],[0.044],[-0.02]],FALSE],		// MX rifle generic offset
		['QS_unit_weaponProxy','',FALSE]
	];
};
_unit setVariable ['QS_unit_currentWeapon2',_currentWeapon,FALSE];