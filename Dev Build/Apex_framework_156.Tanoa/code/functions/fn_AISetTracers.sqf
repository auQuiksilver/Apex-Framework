/*/
File: fn_AISetTracers.sqf
Author: 

	Quiksilver

Last Modified:

	3/11/2022 A3 2.10 by Quiksilver
	
Description:

	Replace normal mags with tracer mags
__________________________________________________________/*/

params ['_unit',['_group',grpNull]];
_side = side _group;
_sideNumber = [EAST,WEST,RESISTANCE] find _side;
if (
	(!((lifeState _unit) in ['HEALTHY','INJURED'])) ||
	(isNull _group) ||
	(_sideNumber isEqualTo -1)
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
		_value = QS_hashmap_tracers getOrDefault [_mag,[]];
		if (_value isNotEqualTo []) then {
			_newMag = _value # _sideNumber;
			_savedResult pushBackUnique _mag;
			_savedResult pushBackUnique _newMag;
			_unit removeMagazine _mag;
			_unit addMagazine _newMag;
		};
	};
} forEach _magazines;
if ((primaryWeaponMagazine _unit) isNotEqualTo []) then {
	_mag = toLowerANSI ((primaryWeaponMagazine _unit) # 0);
	if (_mag in _savedResult) then {
		_unit removePrimaryWeaponItem _mag;
		_unit addPrimaryWeaponItem (_savedResult # ((_savedResult find _mag) + 1));
	} else {
		_value = QS_hashmap_tracers getOrDefault [_mag,[]];
		if (_value isNotEqualTo []) then {
			_unit removePrimaryWeaponItem _mag;
			_unit addPrimaryWeaponItem (_value # _sideNumber);
		};
	};
};
_unit setVariable ['QS_AI_tracersAdded',TRUE,FALSE];
TRUE;