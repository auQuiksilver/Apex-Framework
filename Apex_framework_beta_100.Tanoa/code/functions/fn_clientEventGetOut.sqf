/*
File: fn_clientEventGetOut.sqf
Author:

	Quiksilver
	
Last modified:

	23/10/2016 ArmA 3 1.64 by Quiksilver
	
Description:

	-
__________________________________________________*/

params ['_vehicle','_position','_unit','_turret'];
private ['_driver','_loadedInField','_loadedAtBase','_loadedAtMission','_val'];
if (_position in ['cargo','gunner','commander']) then {
	if (!(isNull (driver _vehicle))) then {
		_driver = driver _vehicle;
		if (alive _driver) then {
			if (isPlayer _driver) then {
				/*/if ((((getPosATL _vehicle) select 2) <= 25) || {(((getPosATL _vehicle) select 2) > 150) && ((backpack _unit) isEqualTo 'B_Parachute')})  then {/*/
					_val = 0;
					if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 500) then {
						_loadedAtMission = _driver getVariable 'QS_IA_PP_loadedAtMission';
						if (_unit in _loadedAtMission) then {
							_val = 1;
							_loadedAtMission deleteAt (_loadedAtMission find _unit);
							_driver setVariable ['QS_IA_PP_loadedAtMission',_loadedAtMission,TRUE];
							if (!isNil {_driver getVariable 'QS_PP_difficultyEnabledRTD'}) then {
								if ((_driver getVariable 'QS_PP_difficultyEnabledRTD') select 0) then {
									_val = _val * 1.5;
								};
							};
							_driver setVariable ['QS_IA_PP',((_driver getVariable 'QS_IA_PP') + _val),TRUE];
							0 = QS_leaderboards_session_queue pushBack ['TRANSPORT',(getPlayerUID _driver),(name _driver),_val];
						} else {
							_loadedAtBase = _driver getVariable 'QS_IA_PP_loadedAtBase';
							if (_unit in _loadedAtBase) then {
								_loadedAtBase deleteAt (_loadedAtBase find _unit);
								_driver setVariable ['QS_IA_PP_loadedAtBase',_loadedAtBase,TRUE];
							} else {
								_loadedInField = _driver getVariable 'QS_IA_PP_loadedInField';
								if (_unit in _loadedInField) then {
									_val = 0.5;
									if (!isNil {_driver getVariable 'QS_PP_difficultyEnabledRTD'}) then {
										if ((_driver getVariable 'QS_PP_difficultyEnabledRTD') select 0) then {
											_val = _val * 1.5;
										};
									};
									_loadedInField deleteAt (_loadedInField find _unit);
									_driver setVariable ['QS_IA_PP_loadedInField',_loadedInField,TRUE];
									_driver setVariable ['QS_IA_PP',((_driver getVariable 'QS_IA_PP') + _val),TRUE];
									0 = QS_leaderboards_session_queue pushBack ['TRANSPORT',(getPlayerUID _driver),(name _driver),_val];
								};
							};
						};
					} else {
						if (((_vehicle distance2D (markerPos 'QS_marker_aoMarker')) < 2000) || {((_vehicle distance2D (markerPos 'QS_marker_sideMarker')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_priorityMarker')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_aoMarker_2')) < 2000)} || {((_vehicle distance2D (markerPos 'QS_marker_hqMarker')) < 1000)} || {((_vehicle distance2D (missionNamespace getVariable 'QS_evacPosition_1')) < 1500)}) then {
							_loadedAtBase = _driver getVariable 'QS_IA_PP_loadedAtBase';
							if (_unit in _loadedAtBase) then {
								_val = 1;
								if (!isNil {_driver getVariable 'QS_PP_difficultyEnabledRTD'}) then {
									if ((_driver getVariable 'QS_PP_difficultyEnabledRTD') select 0) then {
										_val = _val * 1.5;
									};
								};
								_loadedAtBase deleteAt (_loadedAtBase find _unit);
								_driver setVariable ['QS_IA_PP_loadedAtBase',_loadedAtBase,TRUE];
								_driver setVariable ['QS_IA_PP',((_driver getVariable 'QS_IA_PP') + _val),TRUE];
								0 = QS_leaderboards_session_queue pushBack ['TRANSPORT',(getPlayerUID _driver),(name _driver),_val];
							} else {
								_loadedInField = _driver getVariable 'QS_IA_PP_loadedInField';
								if (_unit in _loadedInField) then {
									_val = 0.5;
									if (!isNil {_driver getVariable 'QS_PP_difficultyEnabledRTD'}) then {
										if ((_driver getVariable 'QS_PP_difficultyEnabledRTD') select 0) then {
											_val = _val * 1.5;
										};
									};
									_loadedInField deleteAt (_loadedInField find _unit);
									_driver setVariable ['QS_IA_PP_loadedInField',_loadedInField,TRUE];
									_driver setVariable ['QS_IA_PP',((_driver getVariable 'QS_IA_PP') + _val),TRUE];
									0 = QS_leaderboards_session_queue pushBack ['TRANSPORT',(getPlayerUID _driver),(name _driver),_val];
								} else {
									_loadedAtMission = _driver getVariable 'QS_IA_PP_loadedAtMission';/*/NOTE/*/
									if (_unit in _loadedAtMission) then {
										_loadedAtMission deleteAt (_loadedAtMission find _unit);
										_driver setVariable ['QS_IA_PP_loadedAtMission',_loadedAtMission,TRUE];
									};
								};
							};
						} else {
							_loadedInField = _driver getVariable 'QS_IA_PP_loadedInField';
							if (_unit in _loadedInField) then {
								_loadedInField deleteAt (_loadedInField find _unit);
								_driver setVariable ['QS_IA_PP_loadedInField',_loadedInField,TRUE];
							} else {
								_loadedAtBase = _driver getVariable 'QS_IA_PP_loadedAtBase';/*/NOTE/*/
								if (_unit in _loadedAtBase) then {
									_loadedAtBase deleteAt (_loadedAtBase find _unit);
									_driver setVariable ['QS_IA_PP_loadedAtBase',_loadedAtBase,TRUE];
								} else {
									_loadedAtMission = _driver getVariable 'QS_IA_PP_loadedAtMission';/*/NOTE/*/
									if (_unit in _loadedAtMission) then {
										_loadedAtMission deleteAt (_loadedAtMission find _unit);
										_driver setVariable ['QS_IA_PP_loadedAtMission',_loadedAtMission,TRUE];
									};
								};
							};
						};
					};
				/*/};/*/
			};
		};
	};
};