/*/
File: fn_createUGVTrailer.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/05/2023 A3 2.12 by Quiksilver
	
Description:

	-
______________________________________________________/*/

params [['_vehicle',objNull],['_position',[0,0,0]],['_direction',0],['_side',1],['_surfaceNormal',TRUE]];
if (isNull _vehicle) then {
	if (_side isEqualTo 0) then {
		_type = ['o_ugv_01_f','o_t_ugv_01_ghex_f'] select (worldName in ['Tanoa','Enoch']);
	};
	if (_side isEqualTo 1) then {
		_type = ['b_ugv_01_f','b_t_ugv_01_olive_f'] select (worldName in ['Tanoa','Enoch']);
	};
	if (_side isEqualTo 2) then {
		_type = ['i_ugv_01_f','i_e_ugv_01_f'] select (worldName in ['Tanoa','Enoch']);
	};
	if (_side isEqualTo 3) then {
		_type = 'c_idap_ugv_01_f';
	};
	_vehicle = createVehicle [_type,[-5000,-5000,50],[],50,'CAN_COLLIDE'];
	_vehicle setDir _direction;
	if (_surfaceNormal) then {
		_vehicle setVectorUp (surfaceNormal _position);
	};
	_vehicle lockCargo TRUE;
	_vehicle setPosASL _position;
} else {
	if (local _vehicle) then {
		_vehicle lockCargo TRUE;
	} else {
		['lockCargo',_vehicle,TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	};
};
if (isDedicated) then {
	{
		_vehicle addEventHandler _x;
	} forEach [
		[
			'Engine',
			{
				params ['_vehicle',''];
				if (
					(_vehicle getVariable ['QS_logistics_trailer',FALSE]) ||
					{(_vehicle getVariable ['QS_uav_disabled',FALSE])}
				) then {
					deleteVehicleCrew _vehicle;
				};
			}
		],
		[
			'GetIn',
			{
				params ['_vehicle','','_unit'];
				if (
					(_vehicle getVariable ['QS_logistics_trailer',FALSE]) ||
					{(_vehicle getVariable ['QS_uav_disabled',FALSE])}
				) then {
					_unit moveOut _vehicle;
				};
			}
		],
		[
			'Deleted',
			{
				params ['_vehicle'];
				if ((attachedObjects _vehicle) isNotEqualTo []) then {
					{
						[0,_x] call QS_fnc_eventAttach;
						if (!isPlayer _x) then {
							_x setDamage [1,FALSE];
							deleteVehicle _x;
						};
					} forEach (attachedObjects _vehicle);
				};
			}
		],
		[
			'Killed',
			{
				params ['_vehicle'];
				if ((attachedObjects _vehicle) isNotEqualTo []) then {
					{
						[0,_x] call QS_fnc_eventAttach;
						if (!isPlayer _x) then {
							_x setDamage [1,FALSE];
							deleteVehicle _x;
						};
					} forEach (attachedObjects _vehicle);
				};
			}
		]	
	];
};
{
	_vehicle setVariable _x;
} forEach [
	['QS_ST_customDN',localize 'STR_QS_Text_445',TRUE],
	['QS_ST_showDisplayName',TRUE,TRUE],
	['QS_logistics_trailer',TRUE,TRUE],
	['QS_uav_protected',TRUE,TRUE],
	['QS_uav_disabled',TRUE,TRUE]
];
_vehicle;