/*/
File: fn_isNearFieldHospital.sqf
Author: 

	Quiksilver

Last Modified:

	25/11/2017 A3 1.78 by Quiksilver

Description:

	Is near field hospital
____________________________________________________________________________/*/

params ['_type'];
private _c = FALSE;
if (_type isEqualTo 0) exitWith {
	_unit = param [1,objNull];
	if (alive _unit) then {
		if ((missionNamespace getVariable ['QS_positions_fieldHospitals',[]]) isNotEqualTo []) then {
			_fieldHospitals = missionNamespace getVariable ['QS_positions_fieldHospitals',[]];
			{
				if (_x isEqualType []) then {
					if ((_unit distance2D (_x # 1)) < (_x # 2)) exitWith {
						_c = TRUE;
					};
				};
			} forEach _fieldHospitals;
		};
	};
	_c;
};
if (_type isEqualTo 1) exitWith {
	//comment 'Get nearest field hospital position';

	_c;
};
_c;