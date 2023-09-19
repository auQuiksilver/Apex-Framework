/*/
File: fn_AISetRockets.sqf
Author: 

	Quiksilver

Last Modified:

	7/11/2022 A3 2.10 by Quiksilver
	
Description:

	-
__________________________________________________________/*/

params ['_unit',['_group',grpNull]];
if (
	(!((lifeState _unit) in ['HEALTHY','INJURED'])) ||
	(isNull _group)
) exitWith {FALSE};
_magazines = (magazines _unit) apply {toLowerANSI _x};
private _mag = '';
private _newMag = '';
private _value = [];
private _savedResult = [];
{
	_mag = _x;
	if (_mag in _savedResult) then {
		_unit removeMagazine _mag;
		_unit addMagazine (_savedResult # ((_savedResult find _mag) + 1));
	} else {
		_value = QS_hashmap_rockets getOrDefault [_mag,''];
		if (_value isNotEqualTo '') then {
			_newMag = _value;
			_savedResult pushBackUnique _mag;
			_savedResult pushBackUnique _newMag;
			_unit removeMagazine _mag;
			_unit addMagazine _newMag;
		};
	};
} forEach _magazines;
if ((secondaryWeaponMagazine _unit) isNotEqualTo []) then {
	_mag = toLowerANSI ((secondaryWeaponMagazine _unit) # 0);
	if (_mag in _savedResult) then {
		_unit removeSecondaryWeaponItem _mag;
		_unit addSecondaryWeaponItem (_savedResult # ((_savedResult find _mag) + 1));
	} else {
		_value = QS_hashmap_rockets getOrDefault [_mag,''];
		if (_value isNotEqualTo '') then {
			_unit removeSecondaryWeaponItem _mag;
			_unit addSecondaryWeaponItem _value;
		};
	};
};
_unit setVariable ['QS_AI_rocketsAdded',TRUE,FALSE];
TRUE;
