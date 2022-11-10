/*
File: fn_clientRespawnPosition.sqf
Author:
	
	Quiksilver
	
Last Modified:

	29/10/2022 A3 2.10 by Quiksilver

Description:

	Respawn positioning for players
__________________________________________________________*/

params ['_type'];
if (_type isEqualTo 0) exitWith {
	private _position = AGLToASL (markerPos 'QS_marker_base_marker');
	private _timeNow = time;
	if (
		(missionNamespace getVariable ['QS_missionConfig_zeusRespawnFlag',FALSE]) &&
		(!((missionNamespace getVariable ['QS_mission_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']))
	) then {
		_position = markerPos ['respawn_west',TRUE];
		waitUntil {
			uiSleep 0.01;
			((preloadCamera _position) || (time > (_timeNow + 3)))
		};
		player setPosWorld _position;
	} else {
		if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
			if (worldName isEqualTo 'Altis') then {
				_position = _position vectorAdd [10 - (random 20),10 - (random 20),0];
			};
			if (worldName isEqualTo 'Tanoa') then {
				_position = _position vectorAdd [6 - (random 12),6 - (random 12),0];
			};
			if (worldName isEqualTo 'Malden') then {
				_position = selectRandom (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingPos -1);
				_position = AGLToASL _position;
				player setDir (_position getDir (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingExit 0));
			};
			if (worldName isEqualTo 'Enoch') then {
				_position = _position vectorAdd [6 - (random 12),6 - (random 12),0];
			};
			if (worldName isEqualTo 'Stratis') then {
				_position = _position vectorAdd [6 - (random 12),6 - (random 12),0];
			};
		};
		if (!(simulationEnabled player)) then {
			player enableSimulation TRUE;
		};
		waitUntil {
			uiSleep 0.01;
			((preloadCamera _position) || (time > (_timeNow + 3)))
		};
		player setPosWorld _position;
	};
	if ((damage player) > 0) then {
		player setDamage [0,FALSE];
	};
	// Send players to alternate positions if needed
	call (missionNamespace getVariable 'QS_fnc_respawnPilot');
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
	// WEST respawn
	setPlayerRespawnTime 5;
	['SET_SAVED_LOADOUT',(_newUnit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
	[2,-1] spawn (missionNamespace getVariable 'QS_fnc_clientRadio');
	[29,(missionNamespace getVariable 'QS_module_fob_side')] call (missionNamespace getVariable 'QS_fnc_remoteExec');
	if (
		(missionNamespace getVariable ['QS_missionConfig_zeusRespawnFlag',FALSE]) &&
		((missionNamespace getVariable ['QS_mission_aoType','CLASSIC']) in ['NONE','ZEUS'])
	) then {
		// GAMEMODE IS "NONE" or "ZEUS" or other
		player switchMove '';
		0 spawn {
			preloadCamera (markerPos ['respawn_west',TRUE]);
			uiSleep 0.25;
			player setVehiclePosition [(markerPos ['respawn_west',TRUE]),[],7,'NONE'];
			call (missionNamespace getVariable 'QS_fnc_respawnPilot');
		};
	} else {
		private _position = AGLToASL (markerPos ['QS_marker_base_marker',TRUE]);
		if ((player getVariable 'QS_revive_respawnType') in ['BASE','']) then {
			if (
				((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isNotEqualTo 2) && 
				((missionNamespace getVariable ['QS_missionConfig_destroyerRespawn',0]) isNotEqualTo 1)
			) then {
				if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
					if (worldName isEqualTo 'Altis') then {
						_position = _position vectorAdd [12 - (random 24),12 - (random 24),0];
					};
					if (worldName isEqualTo 'Tanoa') then {
						_position = _position vectorAdd [6 - (random 12),6 - (random 12),0];
					};
					if (worldName isEqualTo 'Malden') then {
						_position = selectRandom (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingPos -1);
						_position = AGLToASL _position;
						player setDir (_position getDir (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingExit 0));
					};
					if (worldName isEqualTo 'Enoch') then {
						_position = _position vectorAdd [12 - (random 24),12 - (random 24),0];
					};
					if (worldName isEqualTo 'Stratis') then {
						_position = _position vectorAdd [6 - (random 12),6 - (random 12),0];
					};
				};
				preloadCamera _position;
				player setPosWorld _position;
			};
			player switchMove '';
			{
				player setVariable _x;
			} forEach [
				['QS_client_inBaseArea',TRUE,FALSE]
			];
			call (missionNamespace getVariable 'QS_fnc_respawnPilot');
		} else {
			if ((player getVariable 'QS_revive_respawnType') isEqualTo 'FOB') then {
				player switchMove '';
				_position = selectRandom ([(missionNamespace getVariable 'QS_module_fob_HQ'),(((missionNamespace getVariable 'QS_module_fob_HQ') buildingPos -1) select {(_x isNotEqualTo [0,0,0])})] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions'));
				preloadCamera _position;
				_position spawn {
					uiSleep 0.1;
					player setPos _this;
					player setDir (player getDir (missionNamespace getVariable 'QS_module_fob_HQ'));
					50 cutText [format [localize 'STR_QS_Text_048',(missionNamespace getVariable 'QS_module_fob_displayName')],'PLAIN DOWN'];
				};
				player setVariable ['QS_client_inFOBArea',TRUE,FALSE];
				missionNamespace setVariable ['QS_module_fob_client_timeLastRespawn',(time + 180),FALSE];
			};
		};
	};
};