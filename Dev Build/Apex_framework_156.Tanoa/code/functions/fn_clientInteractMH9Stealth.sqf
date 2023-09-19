/*/
File: fn_clientInteractMH9Stealth.sqf
Author:

	Quiksilver
	
Last modified:

	27/03/2023 A3 2.12 by Quiksilver
	
Description:
	
	MH-9 Stealth Mode
_________________________________________________________/*/

params ['_mode','_vehicle','_ui'];
if (_mode isEqualTo 'CONDITION') exitWith {
	if (!(_vehicle isKindOf 'Heli_Light_01_unarmed_base_F')) exitWith {player removeAction QS_hummingbird_benchAction;FALSE};
	if (!alive player) exitWith {player removeAction QS_hummingbird_benchAction;FALSE};
	(
		(alive _vehicle) &&
		{(_vehicle isKindOf 'Heli_Light_01_unarmed_base_F')} &&
		{((_vehicle animationSourcePhase 'BenchL_Up') in [0,1])} && 
		{((_vehicle animationSourcePhase 'AddBenches') isEqualTo 1)}
	)
};
if (_mode isEqualTo 'CONDITION2') exitWith {
	(
		(alive _vehicle) &&
		{(_vehicle isKindOf 'Heli_Light_01_unarmed_base_F')} &&
		{((_vehicle animationSourcePhase 'BenchL_Up') in [0,1])} && 
		{((_vehicle animationSourcePhase 'AddBenches') isEqualTo 1)}
	)
};
if (_mode isEqualTo 'INTERACT') exitWith {
	if 	(
		(alive _vehicle) &&
		{(local _vehicle)} &&
		{(_vehicle isKindOf 'Heli_Light_01_unarmed_base_F')} &&
		{((_vehicle animationSourcePhase 'BenchL_Up') in [0,1])} && 
		{((_vehicle animationSourcePhase 'AddBenches') isEqualTo 1)}
	) then {
		_benchSeats = [2,3,4,5];
		private _allowToggle = TRUE;
		private _benchCrew = (fullCrew [_vehicle,'turret',TRUE]) select { (((_x # 2) in _benchSeats) && (!isNull (_x # 0))) };
		_benchCrewDead = _benchCrew select {!alive (_x # 0)};
		if (_benchCrewDead isNotEqualTo []) then {
			{
				(_x # 0) moveOut _vehicle;
			} forEach _benchCrewDead;
		};
		_benchCrew = _benchCrew select {alive (_x # 0)};
		if (_benchCrew isNotEqualTo []) then {
			50 cutText [localize 'STR_QS_Text_347','PLAIN',0.333];
			_allowToggle = FALSE;
		};
		if (_allowToggle) then {
			if (!_ui) then {
				private _text = '';
				{
					_text = _text + (format ['<br/><t align="left">[%1]</t><br/>',_x trim ['"',0]]);
				} forEach (actionKeysNamesArray 'launchCM');
				[_text,TRUE,TRUE,localize 'STR_QS_Hints_168',TRUE] call QS_fnc_hint;
			};
			_up = (_vehicle animationSourcePhase 'BenchL_Up') isEqualTo 1;
			if (_up) then {
				50 cutText [localize 'STR_QS_Text_345','PLAIN DOWN',0.1];
				_vehicle animateSource ['BenchL_Up',0];
				_vehicle animateSource ['BenchR_Up',0];
				{
					_vehicle lockCargo [_x,FALSE];
				} forEach _benchSeats;
				['lockCargo',_vehicle,[_benchSeats,FALSE]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			} else {
				50 cutText [localize 'STR_QS_Text_346','PLAIN DOWN',0.1];
				if (diag_tickTime > (uiNamespace getVariable ['QS_stealth_toggle_cooldown',-1])) then {
					uiNamespace setVariable ['QS_stealth_toggle_cooldown',diag_tickTime + 15];
					if ((missionNamespace getVariable ['QS_vehicle_incomingMissiles',[]]) isNotEqualTo []) then {
						_passiveStealthCoef = [_vehicle] call QS_fnc_vehicleGetPassiveStealth;
						{
							if ((random 1) < _passiveStealthCoef) then {
								if (
									(!isNull (_x # 0)) &&
									(!isNull (_x # 1))
								) then {
									['setMissileTarget',(_x # 0),objNull] remoteExec ['QS_fnc_remoteExecCmd',(_x # 1),FALSE];
								};
							};
						} forEach (missionNamespace getVariable ['QS_vehicle_incomingMissiles',[]]);
					};
				};
				if (isCollisionLightOn _vehicle) then {
					_vehicle setCollisionLight FALSE;
				};
				if (isLightOn _vehicle) then {
					_vehicle setPilotLight FALSE;
				};
				if (!isNull (getSlingLoad _vehicle)) then {
					_vehicle setSlingLoad objNull;
				};
				_vehicle animateSource ['BenchL_Up',1];
				_vehicle animateSource ['BenchR_Up',1];
				{
					_vehicle lockCargo [_x,TRUE];
				} forEach _benchSeats;
				['lockCargo',_vehicle,[_benchSeats,TRUE]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				[_vehicle,_benchSeats] spawn {
					params ['_vehicle','_benchSeats'];
					uiSleep 3;
					{
						if ((_vehicle getCargoIndex _x) in _benchSeats) then {
							_x moveOut _vehicle;
						};
					} forEach (crew _vehicle);
				};
			};
		};
	} else {
		50 cutText [localize 'STR_QS_Text_335','PLAIN',0.333];
	};
};
if (_mode isEqualTo 'CONDITION_STEALTH') exitWith {
	((_vehicle animationSourcePhase 'BenchL_Up') isEqualTo 1)
};