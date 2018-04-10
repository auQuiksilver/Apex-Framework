/*
File: fn_clientInteractRappel.sqf
Author:

	Quiksilver
	
Last Modified:

	12/12/2016 A3 1.66
	
Description:

	Rappel Interactions
_____________________________________________________________*/

_type = _this select 3;
if (_type isEqualTo 1) then {
	[player,(vehicle player)] call (missionNamespace getVariable 'AR_Rappel_From_Heli_Action');
} else {
	if (_type isEqualTo 2) then {
		0 spawn {
			{
				if (!isPlayer _x) then {
					if ((vehicle _x) isEqualTo (vehicle player)) then {
						sleep 1;
						[_x,(vehicle _x)] call (missionNamespace getVariable 'AR_Rappel_From_Heli_Action');
					};
				};
			} forEach (units (group player));
		};
	} else {
		if (_type isEqualTo 3) then {
			[player] call (missionNamespace getVariable 'AR_Rappel_Detach_Action');
		} else {
			if (_type isEqualTo 4) then {
				_vehicle = vehicle player;
				if (isNil {_vehicle getVariable 'QS_rappellSafety'}) then {
					for '_x' from 0 to 1 step 1 do {
						_vehicle setVariable ['QS_rappellSafety',TRUE,TRUE];
					};
					50 cutText ['Fastrope disabled','PLAIN DOWN',1];
				} else {
					for '_x' from 0 to 1 step 1 do {
						_vehicle setVariable ['QS_rappellSafety',nil,TRUE];
					};
					50 cutText ['Fastrope enabled','PLAIN DOWN',1];
				};
			};
		};
	};
};