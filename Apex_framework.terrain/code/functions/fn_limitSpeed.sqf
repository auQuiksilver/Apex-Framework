/*/
File: fn_limitSpeed.sqf
Author:

	Quiksilver
	
Last modified:

	16/03/2023 A3 2.12 by Quiksilver
	
Description:

	Limit vehicle speed
__________________________________________________/*/

_speedIndicated = 10;
_speedLimit = 15;
if (!isNull (objectParent QS_player)) then {
	_vehicle = objectParent QS_player;
	_zone = [_vehicle,'SPEED'] call QS_fnc_inZone;
	private _area = [];
	if ((_zone # 0) && (_zone # 2)) then {
		_area = _zone # 3;
	};
	if (
		(_vehicle isKindOf 'LandVehicle') &&
		{(local _vehicle)} &&
		{(isTouchingGround _vehicle)} &&
		{(!(_vehicle getVariable ['QS_speedzone_ignore',FALSE]))}
	) then {
		_vectorSpeed = (vectorMagnitude (velocityModelSpace _vehicle)) * 3.6;
		if (_vectorSpeed > _speedLimit) then {
			if (!(uiNamespace getVariable ['QS_system_speedLimitMsg3',FALSE])) then {
				if (!(50 in allActiveTitleEffects)) then {
					50 cutText [localize 'STR_QS_Text_001','PLAIN',0.2,FALSE,TRUE];
				};
			};
			_velocityModelSpace = velocityModelSpace _vehicle;
			_newVelocity = _velocityModelSpace vectorMultiply 0.90;
			_vehicle setVelocityModelSpace _newVelocity;
		};
		if (_vectorSpeed > _speedIndicated) then {
			private _pos1 = [0,0,0];
			private _pos2 = [0,0,0];
			if (_area isNotEqualTo []) then {
				for '_i' from 0 to ((count _area) - 1) step 1 do {
					_pos1 = _area # _i;
					if (_i isEqualTo ((count _area) - 1)) then {
						_pos2 = _area # 0;
					} else {
						_pos2 = _area # (_i + 1);
					};
					{
						drawLine3D _x;
					} forEach [
						[_pos1,_pos2,[1,0,0,1]],
						[(_pos1 vectorAdd [0,0,0.5]),(_pos2 vectorAdd [0,0,0.5]),[1,0,0,1]],
						[(_pos1 vectorAdd [0,0,0.25]),(_pos2 vectorAdd [0,0,0.25]),[1,0,0,1]],
						[(_pos1 vectorAdd [0,0,-0.5]),(_pos2 vectorAdd [0,0,-0.5]),[1,0,0,1]],
						[(_pos1 vectorAdd [0,0,-0.25]),(_pos2 vectorAdd [0,0,-0.25]),[1,0,0,1]]
					];
				};
			};
		};
	};
};