/*
File: fn_clientRespawnPosition.sqf
Author:
	
	Quiksilver
	
Last Modified:

	28/03/2023 A3 2.12 by Quiksilver

Description:

	Respawn positioning for players
__________________________________________________________*/

params ['_type'];
if (_type isEqualTo -2) exitWith {
	_data = ['GET_HOME_DATA'] call QS_fnc_deployment;
	if (_data isEqualTo []) exitWith {
		[-1] call QS_fnc_clientRespawnPosition;
	};
	['SELECT',_data] call QS_fnc_deployment;
};
if (_type isEqualTo -1) exitWith {
	_data = ['GET_DEFAULT_DATA'] call QS_fnc_deployment;
	['SELECT',_data] call QS_fnc_deployment;
};
if (_type isEqualTo 1) exitWith {
	params ['','_newUnit'];
	// EAST respawn
	if ((_newUnit getVariable ['QS_unit_side',WEST]) isEqualTo EAST) exitWith {
		if ((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isNotEqualTo 0) then {
			if ((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']) then {
				setPlayerRespawnTime 15;
				['SET_DEFAULT_LOADOUT',(_newUnit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
				[_newUnit,(missionNamespace getVariable 'QS_aoPos')] call (missionNamespace getVariable 'QS_fnc_respawnOPFOR');
			} else {
				0 spawn {
					preloadCamera (markerPos ['respawn_east',TRUE]);
					uiSleep 0.25;
					player setVehiclePosition [(markerPos ['respawn_east',TRUE]),[],7,'NONE'];
				};
			};
		};
		0 spawn {uiSleep 1;createDialog 'QS_client_dialog_menu_roles';};
	};
	// RESISTANCE respawn
	if ((_newUnit getVariable ['QS_unit_side',WEST]) isEqualTo RESISTANCE) exitWith {
		if ((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isNotEqualTo 0) then {
			if ((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']) then {
				setPlayerRespawnTime 15;
				['SET_DEFAULT_LOADOUT',(_newUnit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
				[_newUnit,(missionNamespace getVariable 'QS_aoPos')] call (missionNamespace getVariable 'QS_fnc_respawnOPFOR');
			} else {
				0 spawn {
					preloadCamera (markerPos ['respawn_resistance',TRUE]);
					uiSleep 0.25;
					player setVehiclePosition [(markerPos ['respawn_resistance',TRUE]),[],7,'NONE'];
				};
			};
		};
		0 spawn {uiSleep 1;createDialog 'QS_client_dialog_menu_roles';};
	};
	// CIVILIAN respawn
	if ((_newUnit getVariable ['QS_unit_side',WEST]) isEqualTo CIVILIAN) exitWith {
		if ((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isNotEqualTo 0) then {
			0 spawn {
				preloadCamera (markerPos ['respawn_civilian',TRUE]);
				uiSleep 0.25;
				player setVehiclePosition [(markerPos ['respawn_civilian',TRUE]),[],7,'NONE'];
			};
			setPlayerRespawnTime 15;
		};
		0 spawn {uiSleep 1;createDialog 'QS_client_dialog_menu_roles';};
	};
};