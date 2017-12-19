/*
File: fn_clientEventGetIn.sqf
Author:

	Quiksilver
	
Last modified:

	1/2/2016 ArmA 1.54 by Quiksilver
	
Description:

	
__________________________________________________*/

params ['_vehicle','_position','_unit','_turret'];
private ['_driver','_newArray'];
if (_position in ['cargo','gunner','commander']) then {
	if (!(isNull (driver _vehicle))) then {
		_driver = driver _vehicle;
		if (alive _driver) then {
			if (isPlayer _driver) then {
				/*/if (isPlayer _unit) then {/*/
					if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 300) then {
						_newArray = (_driver getVariable 'QS_IA_PP_loadedAtBase') + [_unit];
						_driver setVariable ['QS_IA_PP_loadedAtBase',_newArray,TRUE];
					} else {
						if (((_vehicle distance2D (markerPos 'QS_marker_aoMarker')) < 2000) || {((_vehicle distance2D (markerPos 'QS_marker_sideMarker')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_priorityMarker')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_aoMarker_2')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_hqMarker')) < 2000)} || {((_vehicle distance2D (missionNamespace getVariable 'QS_evacPosition_1')) < 1500)} || {((_vehicle distance2D (missionNamespace getVariable 'QS_evacPosition_2')) < 1000)}) then {
							_newArray = (_driver getVariable 'QS_IA_PP_loadedAtMission') + [_unit];
							_driver setVariable ['QS_IA_PP_loadedAtMission',_newArray,TRUE];
						} else {
							_newArray = (_driver getVariable 'QS_IA_PP_loadedInField') + [_unit];
							_driver setVariable ['QS_IA_PP_loadedInField',_newArray,TRUE];									
						};
					};
				/*/};/*/
			};
		};
	};
};
if (_position isEqualTo 'driver') then {
	if (!isPlayer _unit) then {
		if (!(['pilot',(typeOf _unit),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
			moveOut _unit;
		};
	};
};