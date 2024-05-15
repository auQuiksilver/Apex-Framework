/*/
File: fn_clientEventGetOut.sqf
Author:

	Quiksilver
	
Last modified:

	10/10/2018 A3 1.84 by Quiksilver
	
Description:

	-
__________________________________________________/*/

params ['_vehicle','_position','_unit','','_isEject'];
if (_position in ['cargo','gunner','commander']) then {
	_driver = driver _vehicle;
	if (alive _driver) then {
		if (isPlayer _driver) then {
			private _val = 0;
			([_vehicle,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
			if (_inSafezone && _safezoneActive) then {
				private _loadedAtMission = _driver getVariable ['QS_IA_PP_loadedAtMission',[]];
				if (_unit in _loadedAtMission) then {
					_val = 1;
					_driver setVariable ['QS_IA_PP_loadedAtMission',(_loadedAtMission select {((alive _x) && (_x isNotEqualTo _unit))}),(!isDedicated)];
					if !(_driver isNil 'QS_PP_difficultyEnabledRTD') then {
						if ((_driver getVariable 'QS_PP_difficultyEnabledRTD') # 0) then {
							_val = _val * 1.5;
						};
					};
					0 = (missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TRANSPORT',(getPlayerUID _driver),(name _driver),_val];
				} else {
					private _loadedAtBase = _driver getVariable ['QS_IA_PP_loadedAtBase',[]];
					if (_unit in _loadedAtBase) then {
						_driver setVariable ['QS_IA_PP_loadedAtBase',(_loadedAtBase select {((alive _x) && (_x isNotEqualTo _unit))}),(!isDedicated)];
					} else {
						private _loadedInField = _driver getVariable ['QS_IA_PP_loadedInField',[]];
						if (_unit in _loadedInField) then {
							_val = 0.5;
							if !(_driver isNil 'QS_PP_difficultyEnabledRTD') then {
								if ((_driver getVariable 'QS_PP_difficultyEnabledRTD') # 0) then {
									_val = _val * 1.5;
								};
							};
							_driver setVariable ['QS_IA_PP_loadedInField',(_loadedInField select {((alive _x) && (_x isNotEqualTo _unit))}),(!isDedicated)];
							0 = (missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TRANSPORT',(getPlayerUID _driver),(name _driver),_val];
						};
					};
				};
			} else {
				if (((_vehicle distance2D (markerPos 'QS_marker_aoMarker')) < 2000) || {((_vehicle distance2D (markerPos 'QS_marker_sideMarker')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_priorityMarker')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_aoMarker_2')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_hqMarker')) < 1000)} || {((_vehicle distance2D (missionNamespace getVariable 'QS_evacPosition_1')) < 1500)}) then {
					private _loadedAtBase = _driver getVariable ['QS_IA_PP_loadedAtBase',[]];
					if (_unit in _loadedAtBase) then {
						_val = 1;
						if !(_driver isNil 'QS_PP_difficultyEnabledRTD') then {
							if ((_driver getVariable 'QS_PP_difficultyEnabledRTD') # 0) then {
								_val = _val * 1.5;
							};
						};
						_driver setVariable ['QS_IA_PP_loadedAtBase',(_loadedAtBase select {((alive _x) && (_x isNotEqualTo _unit))}),(!isDedicated)];
						0 = (missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TRANSPORT',(getPlayerUID _driver),(name _driver),_val];
					} else {
						private _loadedInField = _driver getVariable ['QS_IA_PP_loadedInField',[]];
						if (_unit in _loadedInField) then {
							_val = 0.5;
							if !(_driver isNil 'QS_PP_difficultyEnabledRTD') then {
								if ((_driver getVariable 'QS_PP_difficultyEnabledRTD') # 0) then {
									_val = _val * 1.5;
								};
							};
							_driver setVariable ['QS_IA_PP_loadedInField',(_loadedInField select {((alive _x) && (_x isNotEqualTo _unit))}),(!isDedicated)];
							0 = (missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TRANSPORT',(getPlayerUID _driver),(name _driver),_val];
						} else {
							private _loadedAtMission = _driver getVariable ['QS_IA_PP_loadedAtMission',[]];
							if (_unit in _loadedAtMission) then {
								_driver setVariable ['QS_IA_PP_loadedAtMission',(_loadedAtMission select {((alive _x) && (_x isNotEqualTo _unit))}),(!isDedicated)];
							};
						};
					};
				} else {
					private _loadedInField = _driver getVariable ['QS_IA_PP_loadedInField',[]];
					if (_unit in _loadedInField) then {
						_driver setVariable ['QS_IA_PP_loadedInField',(_loadedInField select {((alive _x) && (_x isNotEqualTo _unit))}),(!isDedicated)];
					} else {
						private _loadedAtBase = _driver getVariable ['QS_IA_PP_loadedAtBase',[]];
						if (_unit in _loadedAtBase) then {
							_driver setVariable ['QS_IA_PP_loadedAtBase',(_loadedAtBase select {((alive _x) && (_x isNotEqualTo _unit))}),(!isDedicated)];
						} else {
							private _loadedAtMission = _driver getVariable ['QS_IA_PP_loadedAtMission',[]];
							if (_unit in _loadedAtMission) then {
								_driver setVariable ['QS_IA_PP_loadedAtMission',(_loadedAtMission select {((alive _x) && (_x isNotEqualTo _unit))}),(!isDedicated)];
							};
						};
					};
				};
			};
		};
	};
};