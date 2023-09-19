/*/
File: fn_clientEventGetIn.sqf
Author:

	Quiksilver
	
Last modified:

	30/12/2022 A3 2.10 by Quiksilver
	
Description:

	-
__________________________________________________/*/

params ['_vehicle','_position','_unit',''];
if (_position in ['cargo','gunner','commander']) then {
	_driver = driver _vehicle;
	if (
		(alive _driver) &&
		{(isPlayer _driver)} &&
		{(_driver getUnitTrait 'QS_trait_pilot')}
	) then {
		([_vehicle,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
		if (_inSafezone && _safezoneActive) then {
			_driver setVariable ['QS_IA_PP_loadedAtBase',((_driver getVariable ['QS_IA_PP_loadedAtBase',[]]) + [_unit]),(!isDedicated)];
		} else {
			if (((_vehicle distance2D (markerPos 'QS_marker_aoMarker')) < 2000) || {((_vehicle distance2D (markerPos 'QS_marker_sideMarker')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_priorityMarker')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_aoMarker_2')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_hqMarker')) < 2000)} || {((_vehicle distance2D (missionNamespace getVariable 'QS_evacPosition_1')) < 1500)} || {((_vehicle distance2D (missionNamespace getVariable 'QS_evacPosition_2')) < 1000)}) then {
				_driver setVariable ['QS_IA_PP_loadedAtMission',((_driver getVariable ['QS_IA_PP_loadedAtMission',[]]) + [_unit]),(!isDedicated)];
			} else {
				_driver setVariable ['QS_IA_PP_loadedInField',((_driver getVariable ['QS_IA_PP_loadedInField',[]]) + [_unit]),(!isDedicated)];
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