/*/
File: fn_aoHQCache.sqf
Author: 

	Quiksilver

Last Modified:

	25/04/2017 A3 1.68 by Quiksilver

Description:

	Supply cache at enemy HQ
	
[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
____________________________________________________________________________/*/

private ['_pos','_boxArray','_box','_boxSelect','_spawnedBoxArray','_magazineCargo','_index'];
_pos = _this # 0;
_spawnedBoxArray = [];
_boxArray = (['hq_cache_list_1'] call QS_data_listVehicles) call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
if (worldName isEqualTo 'Tanoa') then {
	_boxArray = (['hq_cache_list_2'] call QS_data_listVehicles) call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
if (worldName isEqualTo 'Enoch') then {
	_boxArray = (['hq_cache_list_3'] call QS_data_listVehicles) call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
private _undraggableHQBoxes = ['hq_cache_draggable_1'] call QS_data_listVehicles;
for '_x' from 0 to (2 + (round(random 2))) do {
	_boxSelect = selectRandom _boxArray;
	_spawnPos = _pos findEmptyPosition [0,40,_boxSelect];
	if (_spawnPos isNotEqualTo []) then {
		_box = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _boxSelect,_boxSelect],(_spawnPos vectorAdd [0,0,0.5]),[],0,'NONE'];
		_box setDir (random 360);
		if ((random 1) > 0.666) then {
			[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
		};
		if (!((toLowerANSI _boxSelect) in _undraggableHQBoxes)) then {
			_box setVariable ['QS_RD_draggable',TRUE,TRUE];
		};
		0 = _spawnedBoxArray pushBack _box;
		//comment 'Clear smoke grenades as anti-troll measure.';
		_magazineCargo = getMagazineCargo _box;
		clearMagazineCargoGlobal _box;
		_index = 0;
		for '_x' from 0 to ((count (_magazineCargo # 0)) - 1) step 1 do {
			if (!(['SmokeShell',((_magazineCargo # 0) # _index),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
				_box addMagazineCargoGlobal [((_magazineCargo # 0) # _index),((_magazineCargo # 1) # _index)];
			};
			_index = _index + 1;
		};
		_box addEventHandler [
			'Killed',
			{
				missionNamespace setVariable [
					'QS_analytics_entities_killed',
					((missionNamespace getVariable 'QS_analytics_entities_killed') + 1),
					FALSE
				];
				deleteVehicle (_this # 0);
			}
		];
		_box addEventHandler [
			'Deleted',
			{
			
			}
		];
	};
};
_spawnedBoxArray;