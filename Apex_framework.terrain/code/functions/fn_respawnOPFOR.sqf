/*/
File: fn_respawnOPFOR.sqf
Author: 
	
	Quiksilver
	
Last modified: 

	5/02/2018 A3 1.88 by Quiksilver

Description: 

	OPFOR respawn
________________________________________/*/

params [['_unit',player],['_pos',markerPos 'respawn_east']];
if ((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']) then {
	private _positionFound = FALSE;
	if ((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) isEqualTo 'CLASSIC') then {
		if (
			((toLowerANSI (markerColor 'QS_marker_hqMarker')) isEqualTo 'coloropfor') &&
			{(([(missionNamespace getVariable 'QS_hqPos'),300,[WEST],(allUnits + allUnitsUav),0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo [])}
		) then {
			private _hqBuildingPositions = [];
			private _hqBuildingPosition = [0,0,0];
			private _building = objNull;
			private _buildingPositions = [];
			{
				_building = _x;
				_buildingPositions = _building buildingPos -1;
				_buildingPositions = [_building,_buildingPositions] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
				if (_buildingPositions isNotEqualTo []) then {
					{
						_hqBuildingPosition = _x;
						0 = _hqBuildingPositions pushBack _hqBuildingPosition;
					} forEach _buildingPositions;
				};
			} forEach (nearestObjects [(missionNamespace getVariable 'QS_hqPos'),['House','Building'],50,TRUE]);
			if (_hqBuildingPositions isNotEqualTo []) then {
				_positionFound = TRUE;
				_hqBuildingPositions = _hqBuildingPositions apply {[(_x # 0),(_x # 1),((_x # 2) + 0.5)]};
				_spawnPosition = selectRandom _hqBuildingPositions;
				_unit switchMove ['amovppnemstpsraswrfldnon'];
				[_unit,_spawnPosition] spawn {
					preloadCamera (_this # 1);
					uiSleep 0.5;
					(_this # 0) setPos (_this # 1);
				};
			};
		};
	};
	if (!(_positionFound)) then {
		_unit switchMove ['amovppnemstpsraswrfldnon'];
		_worldName = worldName;
		private _fn_blacklist = {TRUE};
		if (_worldName isEqualTo 'Tanoa') then {
			_fn_blacklist = {
				private _c = TRUE;
				{
					if ((_this distance2D (_x # 0)) < (_x # 1)) exitWith {
						_c = FALSE;
					};
				} count [
					[[13415.7,5194.57,0.00172806],350],
					[[12897.9,5442.16,0.00107098],175],
					[[2257.59,1664.31,0.00162601],90],
					[[3681.47,9377.08,0.00176811],400],
					[[11440.4,14422,0.0013628],275]
				];
				_c;
			};
		};
		_maxDist = (missionNamespace getVariable ['QS_aoSize',600]) * 0.9;
		_base = markerPos 'QS_marker_base_marker';
		private _foundSpawnPos = FALSE;
		_enemySides = (_unit getVariable ['QS_unit_side',WEST]) call (missionNamespace getVariable 'QS_fnc_enemySides');
		_allPlayers = allPlayers select {((_x getVariable ['QS_unit_side',WEST]) in _enemySides)};
		private _spawnPosDefault = missionNamespace getVariable ['QS_aoPos',(markerPos 'respawn_east')];
		for '_x' from 0 to 999 step 0 do {
			_spawnPosDefault = [_pos,0,_maxDist,2,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
			if (_spawnPosDefault isNotEqualTo []) then {
				if ((_allPlayers inAreaArray [_spawnPosDefault,400,400,0,FALSE]) isEqualTo []) then {
					if ((_spawnPosDefault distance2D _base) > 1200) then {
						if (_spawnPosDefault call _fn_blacklist) then {
							if (!([_spawnPosDefault,_pos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
								_foundSpawnPos = TRUE;
							};
						};
					};
				};
			};
			if (_foundSpawnPos) exitWith {};
		};
		_unit switchMove ['amovppnemstpsraswrfldnon'];
		[_unit,_spawnPosDefault] spawn {
			preloadCamera (_this # 1);
			uiSleep 0.5;
			(_this # 0) setVehiclePosition [(_this # 1),[],10,'NONE'];
		};
	};
};