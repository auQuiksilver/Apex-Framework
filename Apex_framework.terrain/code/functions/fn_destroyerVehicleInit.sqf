/*/
File: fn_destroyerVehicleInit.sqf
Author:

	Quiksilver
	
Last modified:

	2/04/2023 A3 2.12 by Quiksilver
	
Description:

	Init for destroy aux boats
____________________________________________________/*/

if (_this isKindOf 'Ship') then {
	_this spawn {
		sleep 0.1;
		_this setVelocity [0,0,0];
		_boatRacks = nearestObjects [_this,['land_destroyer_01_boat_rack_01_f'],25,TRUE];
		if (_boatRacks isNotEqualTo []) then {
			_boatRack = _boatRacks # 0;
			if ((getVehicleCargo _boatRack) isEqualTo []) then {
				_this setDir (getDir _boatRack);
				_boatRack setVehicleCargo _this;
			};
		};
		sleep 1;
		_this addEventHandler [
			'GetIn',
			{
				params ['_v','','',''];
				_v enableSimulationGlobal TRUE;
				_v removeEventHandler [_thisEvent,_thisEventHandler];
			}
		];
		_this enableSimulationGlobal FALSE;
	};
};
if (_this isKindOf 'Helicopter') then {
	(missionNamespace getVariable 'QS_destroyerObject') setVariable ['QS_destroyer_hangarHeli',_this,TRUE];		// TODO: Set to FALSE on build release if not needed true
	_this setVelocity [0,0,0];
	_this spawn {
		sleep 2;
		_this addEventHandler [
			'GetIn',
			{
				params ['_v','','',''];
				_v enableSimulationGlobal TRUE;
				_v removeEventHandler [_thisEvent,_thisEventHandler];
			}
		];
		_this enableSimulationGlobal FALSE;
		_this lock 2;
	};
};