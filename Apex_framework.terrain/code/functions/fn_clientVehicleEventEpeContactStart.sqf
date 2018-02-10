/*
File: fn_clientVehicleEventEpeContactStart.sqf
Author:
	
	Quiksilver
	
Last Modified:

	3/02/2017 A3 1.66 by Quiksilver

Description:

	Event Epe Contact Start

	This may trigger the Hit event second, so it will get blocked by the Hit event anti-spam variable
__________________________________________________________*/
if (!local (_this select 0)) exitWith {};
params ['_vehicle','_vehicle2','_selection1','_selection2','_force'];
if (_vehicle isKindOf 'Air') then {
	if (!(_vehicle2 isKindOf 'Air')) then {
		if ((_vehicle distance (markerPos 'QS_marker_base_marker')) < 750) then {
			if (_force >= 1000) then {
				[player,_vehicle2,0.1,(driver _vehicle2),'EPECONTACTSTART'] call (missionNamespace getVariable 'QS_fnc_clientEventHit');
			};
		};
	};
};