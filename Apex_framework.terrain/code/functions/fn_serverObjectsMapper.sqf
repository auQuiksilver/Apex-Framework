/*/
File: fn_serverObjectsMapper.sqf
Author:

	Quiksilver
	
Last Modified:

	19/10/2017 A3 1.76 by Quiksilver
	
Description:

	Objects Mapper
__________________________________________________________________________/*/

params [
	['_pos',[0,0,0]],
	['_azi',0],
	['_data',[]],
	['_useRecycler',FALSE]
];
private ['_newObjs','_newObj','_rotMatrix','_newRelPos','_newPos','_z','_configClass','_model','_dir','_newPosZ','_dynSim','_array'];
_newObjs = [];
_pos params ['_posX','_posY'];
_dynSim = dynamicSimulationSystemEnabled;
_array = [];
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
	_rotMatrix = [
		[(cos _azi),(sin _azi)],
		[-(sin _azi),(cos _azi)]
	];
	_newRelPos = [_rotMatrix,_relPos] call (missionNamespace getVariable 'QS_fnc_commonMultiplyMatrix');
	if ((count _relPos) > 2) then {
		_z = _relPos select 2;
	} else {
		_z = 0;
	};
	_newPos = [(_posX + (_newRelPos select 0)),(_posY + (_newRelPos select 1)),_z];
	if (surfaceIsWater _newPos) then {
		if ((getTerrainHeightASL _newPos) < 0) then {
			_newPos set [2,(_z + (getTerrainHeightASL _newPos))];
		};
	};
	if (_isSimpleObject) then {
		_configClass = configFile >> 'CfgVehicles' >> _type;
		_model = getText (_configClass >> 'model');
		if ((_model select [0,1]) isEqualTo '\') then {
			_model = _model select [1];
		};
		if (!((_model select [((count _model) - 4),4]) isEqualTo '.p3d')) then {
			_model = _model + '.p3d';
		};
		_newPosZ = _newPos select 2;
		_newPos set [2,((getNumber (_configClass >> 'SimpleObject' >> 'verticalOffset')) + _newPosZ)];
		_newPos = ATLToASL _newPos;
		if (_useRecycler) then {
			_newObj = [2,1,_model] call (missionNamespace getVariable 'QS_fnc_serverObjectsRecycler');
			if (isNull _newObj) then {
				_newObj = createSimpleObject [_model,_newPos];
			} else {
				_newObj setPosWorld _newPos;
			};
		} else {
			_newObj = createSimpleObject [_model,_newPos];
		};
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_dir = _azi + _azimuth;
		_newObj setDir _dir;
		if ((toLower (getText (_configClass >> 'vehicleClass'))) in ['fortifications','ruins','car','armored','air','ship','support']) then {
			_newObj setVectorUp (surfaceNormal _newPos);
		};
	} else {
	
		if (_useRecycler) then {
			_newObj = [2,0,_type] call (missionNamespace getVariable 'QS_fnc_serverObjectsRecycler');
			if (isNull _newObj) then {
				_newObj = createVehicle [_type,[(random -1000),(random -1000),(1000 + (random 1000))],[],0,'CAN_COLLIDE'];
			};
		} else {
			_newObj = createVehicle [_type,[(random -1000),(random -1000),(1000 + (random 1000))],[],0,'CAN_COLLIDE'];
		};
		missionNamespace setVariable [
			'QS_analytics_entities_created',
			((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
			FALSE
		];
		_newObj setDir (_azi + _azimuth);
		_newObj setPos _newPos;
		[_newObj,_newPos,_azi,_azimuth] spawn {
			params ['_newObj','_newPos','_azi','_azimuth'];
			sleep 0.1;
			_newObj setDir (_azi + _azimuth);
			_newObj setPos _newPos;
			if (_newObj isKindOf 'House') then {
				_newObj setVectorUp [0,0,1];
			};
		};
		if (!(_orientation isEqualTo [])) then {
			([_newObj] + _orientation) call (missionNamespace getVariable 'BIS_fnc_setPitchBank');
		};
		_newObj allowDamage _allowDamage;
		_newObj enableSimulationGlobal _simulation;
		if (_simulation) then {
			if (_dynSim) then {
				if (!(_newObj isKindOf 'LandVehicle')) then {
					/*/_newObj enableDynamicSimulation TRUE;/*/ /*/this is too soon/*/
				};
			};
		};
	};
	if (!(_code isEqualTo {})) then {
		_newObj = [_newObj] call _code;
	};
	0 = _newObjs pushBack _newObj;
} count _data;
_newObjs;