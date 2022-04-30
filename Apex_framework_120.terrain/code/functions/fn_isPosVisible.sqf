/*/
File: fn_isPosVisible.sqf
Author:

	Quiksilver
	
Last modified:

	29/04/2017 ArmA 3 1.68 by Quiksilver
	
Description:

	Is position reasonably visible to players
__________________________________________________/*/

params ['_position','_radius','_units','_sides','_tolerance','_returnType'];
scopeName 'main';
private _return = 0;
private _visibility = 0;
_position set [2,((_position # 2) + 0.5)];
{
	if ((side _x) in _sides) then {
		if ((_x distance2D _position) <= _radius) then {
			_visibility = ([_x,'VIEW',objNull] checkVisibility [(getPosASL _x),_position]) + ([_x,'GEOM',objNull] checkVisibility [(getPosASL _x),_position]);
			if (_visibility > _tolerance) then {
				_return = _return + _visibility;
				breakTo 'main';
			};
		};
	};
} forEach _units;
if (_returnType isEqualType TRUE) exitWith {
	(_return > _tolerance)
};
_return;