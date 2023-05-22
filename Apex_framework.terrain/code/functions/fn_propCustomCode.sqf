/*/
File: fn_propCustomCode.sqf
Author:
	
	Quiksilver
	
Last Modified:

	01/05/2023 A3 2.12 by Quiksilver
	
Description:

	-
__________________________________________/*/

params ['_entity',['_class','']];
if (_class isEqualTo '') then {
	_class = toLowerANSI (typeOf _entity);
} else {
	_class = toLowerANSI _class;
};
{
	_entity setVariable _x;
} forEach [
	['QS_logistics_immovable',TRUE,TRUE],
	['QS_logistics',FALSE,TRUE]
];
if (_class isKindOf 'StaticWeapon') then {
	_entity enableWeaponDisassembly FALSE;
	_entity enableRopeAttach FALSE;
	_entity enableVehicleCargo FALSE;
};
if (_class isKindOf 'FlagPole_F') then {
	_entity setFlagTexture (missionNamespace getVariable ['QS_missionConfig_textures_defaultFlag','a3\data_f\flags\flag_nato_co.paa']);
};
if (_class isKindOf 'sign_arrow_yellow_f') then {
	if ([_entity,30] call QS_fnc_canFlattenTerrain) then {
		_width = 5;
			_fnc_flattenTerrain = {
				params ['_start','_a','_b','_h'];
				getTerrainInfo params ['', '', '_cellsize',''];
				_step = _cellsize / 2;
				private _newPositions = [];
				private _oldPositions = [];
				_aa = -_a;
				_bb = -_b;
				for '_xStep' from _aa to _a step _step do {
					for '_yStep' from _bb to _b step _step do {
						private _newHeight = _start vectorAdd [_xStep, _yStep, 0];
						_newHeight set [2,_h];
						if ((getTerrainHeight _newHeight) isNotEqualTo _h) then {
							_oldPositions pushBack (getTerrainHeight _newHeight);
							_newPositions pushBack _newHeight;
						};
					}; 
				}; 
				[_oldPositions,_newPositions]
			};
			private _desiredTerrainHeight = (getTerrainHeight (getPosWorld _entity)) - 0;
			private _positionsAndHeights = [getPosWorld _entity,_width,_width,_desiredTerrainHeight] call _fnc_flattenTerrain;
			QS_system_terrainMod pushBack _positionsAndHeights;
			diag_log (format [localize 'STR_QS_DiagLogs_139',count QS_system_terrainMod,_positionsAndHeights # 1]);
			setTerrainHeight [_positionsAndHeights # 1,TRUE];
			_entity spawn {
				_this hideObjectGlobal TRUE;
				sleep 0.5;
				deleteVehicle _this;
			};
		} else {
		_entity spawn {
			_this hideObjectGlobal TRUE;
			sleep 0.5;
			deleteVehicle _this;
		};
	};
};
if (_class isKindOf 'Lamps_base_F') then {
	if (([_entity] call QS_fnc_getObjectVolume) < 2.1) then {
		_entity spawn {
			sleep 1;
			{
				_this setVariable _x;
			} forEach [
				['QS_logistics_immovable',FALSE,TRUE],
				['QS_logistics',TRUE,TRUE]
			];
		};
	};
};