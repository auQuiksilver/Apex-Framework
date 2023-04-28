/*
File: fn_clientInteractRappel.sqf
Author:

	Quiksilver
	
Last Modified:

	12/12/2016 A3 1.66
	
Description:

	Rappel Interactions
_____________________________________________________________*/

_type = _this # 3;
if (_type isEqualTo 1) then {
	[QS_player,(vehicle QS_player)] call (missionNamespace getVariable 'AR_Rappel_From_Heli_Action');
} else {
	if (_type isEqualTo 2) then {
		0 spawn {
			{
				if (!isPlayer _x) then {
					if ((vehicle _x) isEqualTo (vehicle QS_player)) then {
						sleep 1;
						[_x,(vehicle _x)] call (missionNamespace getVariable 'AR_Rappel_From_Heli_Action');
					};
				};
			} forEach (units (group QS_player));
		};
	} else {
		if (_type isEqualTo 3) then {
			[QS_player] call (missionNamespace getVariable 'AR_Rappel_Detach_Action');
		} else {
			if (_type isEqualTo 4) then {
				_vehicle = vehicle QS_player;
				if (!(_vehicle getVariable ['QS_rappellSafety',FALSE])) then {
					_vehicle setVariable ['QS_rappellSafety',TRUE,TRUE];
					50 cutText [localize 'STR_QS_Text_041','PLAIN DOWN',1];
				} else {
					_vehicle setVariable ['QS_rappellSafety',FALSE,TRUE];
					50 cutText [localize 'STR_QS_Text_042','PLAIN DOWN',1];
				};
			};
		};
	};
};