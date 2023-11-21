/*/
File: fn_serverObjectsMapper.sqf
Author:

	Quiksilver
	
Last Modified:

	5/10/2018 A3 1.84 by Quiksilver
	
Description:

	Objects Mapper
_____________________________________________________/*/

params [
	['_pos',[0,0,0]],
	['_azi',0],
	['_data',[]],
	['_useRecycler',FALSE]
];
private _newObjs = [];
_pos params ['_posX','_posY'];
_dynSim = dynamicSimulationSystemEnabled;
private _array = [];
private _newObj = nil;
private _rotMatrix = [];
private _newRelPos = [];
private _newPos = [];
private _z = 0;
private _configClass = '';
private _model = '';
private _newPosZ = 0;
private _info = [];
{
	_array = _x;
	_array params [
		['_type',''],
		['_relPos',[0,0,0]],
		['_azimuth',-1],
		['_orientation',[]],
		['_allowDamage',FALSE],
		['_simulation',FALSE],
		['_isSimpleObject',FALSE],
		['_code',{}]
	];
	_newObj = nil;
	_rotMatrix = [
		[(cos _azi),(sin _azi)],
		[-(sin _azi),(cos _azi)]
	];
	_newRelPos = [_rotMatrix,_relPos] call (missionNamespace getVariable 'QS_fnc_commonMultiplyMatrix');
	if ((count _relPos) > 2) then {
		_z = _relPos # 2;
	} else {
		_z = 0;
	};
	_newPos = [(_posX + (_newRelPos # 0)),(_posY + (_newRelPos # 1)),_z];
	if (surfaceIsWater _newPos) then {
		if ((getTerrainHeightASL _newPos) < 0) then {
			_newPos set [2,(_z + (getTerrainHeightASL _newPos))];
		};
	};
	if (_isSimpleObject) then {
		_info = QS_hashmap_simpleObjectInfo getOrDefault [_type,[]];
		if (_info isEqualTo []) then {
			_configClass = configFile >> 'CfgVehicles' >> _type;
			_model = getText (_configClass >> 'model');
			if ((_model select [0,1]) isEqualTo '\') then {
				_model = _model select [1];
			};
			if ((_model select [((count _model) - 4),4]) isNotEqualTo '.p3d') then {
				_model = _model + '.p3d';
			};
			_info = [
				_model,
				(getNumber (_configClass >> 'SimpleObject' >> 'verticalOffset')),
				(toLowerANSI (getText (_configClass >> 'vehicleClass')))
			];
			QS_hashmap_simpleObjectInfo set [_type,_info];
		};
		_newPosZ = _newPos # 2;
		_newPos set [2,((_info # 1) + _newPosZ)];
		_newPos = ATLToASL _newPos;
		if (_useRecycler) then {
			_newObj = [2,1,_info # 0] call (missionNamespace getVariable 'QS_fnc_serverObjectsRecycler');
			if (isNull _newObj) then {
				_newObj = createSimpleObject [_info # 0,_newPos];
			} else {
				missionNamespace setVariable ['QS_analytics_entities_recycled',((missionNamespace getVariable ['QS_analytics_entities_recycled',0]) + 1),FALSE];
				_newObj setPosWorld _newPos;
			};
		} else {
			_newObj = createSimpleObject [_info # 0,_newPos];
		};
		_newObj setDir (_azi + _azimuth);
		if ((_info # 2) in ['fortifications','ruins','car','armored','air','ship','support']) then {
			_newObj setVectorUp (surfaceNormal _newPos);
		};
	} else {
		if (_useRecycler) then {
			_newObj = [2,0,_type] call (missionNamespace getVariable 'QS_fnc_serverObjectsRecycler');
			if (isNull _newObj) then {
				_newObj = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _type,_type],[(random -1000),(random -1000),(1000 + (random 1000))],[],0,'CAN_COLLIDE'];
			} else {
				missionNamespace setVariable ['QS_analytics_entities_recycled',((missionNamespace getVariable ['QS_analytics_entities_recycled',0]) + 1),FALSE];
			};
		} else {
			_newObj = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _type,_type],[(random -1000),(random -1000),(1000 + (random 1000))],[],0,'CAN_COLLIDE'];
		};
		_newObj setDir (_azi + _azimuth);
		_newObj setPos _newPos;
		[_newObj,_newPos,_azi,_azimuth] spawn {
			params ['_newObj','_newPos','_azi','_azimuth'];
			sleep 0.1;
			_newObj setDir (_azi + _azimuth);
			_newObj setPos _newPos;
			if ((_newObj isKindOf 'House') || {((_newObj buildingPos -1) isNotEqualTo [])}) then {
				_newObj setVectorUp [0,0,1];
			};
		};
		if (_orientation isNotEqualTo []) then {
			([_newObj] + _orientation) call (missionNamespace getVariable 'BIS_fnc_setPitchBank');
		};
		_newObj allowDamage _allowDamage;
		_newObj enableSimulationGlobal _simulation;
		if (_simulation) then {
			if (_dynSim) then {
				if (!(_newObj isKindOf 'LandVehicle')) then {
					//_newObj enableDynamicSimulation TRUE;
				};
			};
		};
	};
	if (_code isNotEqualTo {}) then {
		_newObj = [_newObj] call _code;
	};
	if (_newObj isEqualType objNull) then {
		0 = _newObjs pushBack _newObj;
	} else {
		if (_newObj isEqualType []) then {
			{
				0 = _newObjs pushBack _x;
			} forEach _newObj;
		};
	};
} forEach _data;
_newObjs;