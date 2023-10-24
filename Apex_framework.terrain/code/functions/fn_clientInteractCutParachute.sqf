/*
File: fn_clientInteractCutParachute.sqf
Author:

	Quiksilver
	
Last Modified:

	24/12/2022 A3 2.10 by Quiksilver
	
Description:

	Cut Parachute Interaction
________________________________________________*/

_objectParent = objectParent player;
if (!(_objectParent isKindOf 'Air')) then {
	// Cut vehicle chute
	_attached = attachedTo _objectParent;
	if (!isNull _attached) then {
		if ((toLowerANSI (typeOf _attached)) in qs_core_classnames_vehicleparachutes) then {
			[0,_objectParent] call QS_fnc_eventAttach;
			_attached spawn {sleep 1;deleteVehicle _this;};
			50 cutText [localize 'STR_QS_Text_313','PLAIN',0.333];
		};
	};
} else {
	// Cut para chute
	player moveOut _objectParent;
	_objectParent spawn {sleep 1;deleteVehicle _this;};
	50 cutText [localize 'STR_QS_Text_313','PLAIN',0.333];
};
uiNamespace setVariable ['QS_client_openParachuteCooldown',diag_tickTime + 5];