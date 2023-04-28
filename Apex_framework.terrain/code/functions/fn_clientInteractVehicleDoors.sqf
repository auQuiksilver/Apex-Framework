/*
File: fn_clientInteractVehicleDoors.sqf
Author:

	Quiksilver
	
Last Modified:

	30/12/2022 A3 2.10
	
Description:

	-
_____________________________________________________________*/

(_this # 3) params [
	'_vehicle',
	'_value'
];
_vt = toLowerANSI (typeOf _vehicle);
_animateDoor = ['veh_doors_1'] call QS_data_listVehicles;
_animate = ['veh_doors_2'] call QS_data_listVehicles;
if (_vt in _animateDoor) exitWith {
	if (_vt in (['veh_doors_3'] call QS_data_listVehicles)) then {
		if ((_vehicle doorPhase 'door_R') isEqualTo 0) then {
			_vehicle animateDoor ['door_R',1];
			_vehicle animateDoor ['door_L',1];
		} else {
			if ((_vehicle doorPhase 'door_R') isEqualTo 1) then {
				_vehicle animateDoor ['door_R',0];
				_vehicle animateDoor ['door_L',0];
			};
		};
	} else {
		if (_vt in (['veh_doors_4'] call QS_data_listVehicles)) then {
			if ((_vehicle doorPhase 'Door_R_source') isEqualTo 0) then {
				_vehicle animateDoor ['Door_R_source',1];
				_vehicle animateDoor ['Door_L_source',1];
			} else {
				if ((_vehicle doorPhase 'Door_R_source') isEqualTo 1) then {
					_vehicle animateDoor ['Door_R_source',0];
					_vehicle animateDoor ['Door_L_source',0];
				};
			};		
		} else {
			if (_vt in (['veh_doors_5'] call QS_data_listVehicles)) then {
				if ((_vehicle doorPhase 'Door_Back_R') isEqualTo 0) then {
					{
						_vehicle animateDoor _x;
					} forEach [
						['Door_Back_R',1],
						['Door_Back_L',1]
					];
				} else {
					if ((_vehicle doorPhase 'Door_Back_R') isEqualTo 1) then {
						{
							_vehicle animateDoor _x;
						} forEach [
							['Door_Back_R',0],
							['Door_Back_L',0]
						];
					};
				};
			} else {
				if (_vt in (['veh_doors_6'] call QS_data_listVehicles)) then {
					if ((_vehicle doorPhase 'Door_1_source') isEqualTo 0) then {
						{
							_vehicle animateDoor _x;
						} forEach [
							['Door_1_source',1],
							['Door_2_source',1],
							['Door_3_source',1]
						];
					} else {
						if ((_vehicle doorPhase 'Door_1_source') isEqualTo 1) then {
							{
								_vehicle animateDoor _x;
							} forEach [
								['Door_1_source',0],
								['Door_2_source',0],
								['Door_3_source',0]
							];
						};
					};
				} else {
					if (_vt in (['veh_doors_7'] call QS_data_listVehicles)) then {
						if ((_vehicle doorPhase 'Door_3_source') isEqualTo 0) then {
							{
								_vehicle animateDoor _x;
							} forEach [
								['Door_3_source',1],
								['Door_4_source',1]
							];
						} else {
							if ((_vehicle doorPhase 'Door_3_source') isEqualTo 1) then {
								{
									_vehicle animateDoor _x;
								} forEach [
									['Door_3_source',0],
									['Door_4_source',0]
								];
							};
						};
					};
				};
			};
		};
	};
};
if (_vt in _animate) exitWith {
	if ((_vehicle animationSourcePhase 'Doors') isEqualTo 0) then {
		_vehicle animateSource ['Doors',1,1];
		_vehicle animateSource ['Doors',1,1];
	} else {
		if ((_vehicle animationSourcePhase 'Doors') isEqualTo 1) then {
			_vehicle animateSource ['Doors',0,1];
			_vehicle animateSource ['Doors',0,1];
		};
	};
};