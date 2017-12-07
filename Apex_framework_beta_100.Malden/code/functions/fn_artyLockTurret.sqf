private ["_type","_veh"];
_type = _this select 1;
_veh = _this select 0;

if (_type isEqualTo 0) then {
	_veh lockTurret [[0],TRUE];
};
if (_type isEqualTo 1) then {
	_veh lockTurret [[0],FALSE];
};