/*/
File: fn_createMinefield.sqf
Author: 

	Quiksilver

Last Modified:

	4/09/2017 A3 1.76 by Quiksilver

Description:

	Create a minefield
	
	_objects = [(getPosATL QS_radioTower),5,35,25,[],true,false] call QS_fnc_createMinefield;
____________________________________________________________________________/*/

params ['_centerPos','_innerRadius','_outerRadius','_quantity','_types','_isMarked','_isBarriers'];
private _all = [];
private _mines = [];
private _barriers = [];
private _signs = [];
private _barrierTypes = [
	['Land_Sign_MinesTall_Greek_F','Land_Sign_MinesDanger_Greek_F'],
	['Land_Sign_MinesTall_English_F','Land_Sign_MinesDanger_English_F']
] select (worldName isEqualTo 'Tanoa');
private _minePositions = [];
private _maxAttempts = _quantity * 10;
private _attempts = 0;
private _mine = objNull;
private _position = [0,0,0];
private _radius = _outerRadius - _innerRadius;
if (_types isEqualTo []) then {
	_types = ['minefield_types_2'] call QS_data_listOther;
};
while {((count _mines) < _quantity)} do {
	_position = _centerPos getPos [(_innerRadius + (random _outerRadius)),(random 360)];
	if (!surfaceIsWater _position) then {
		_mine = createMine [(selectRandomWeighted _types),_position,[],1];
		_mines pushBack _mine;
		//_mine enableDynamicSimulation TRUE;
		_mine setVectorUp (surfaceNormal (getPosWorld _mine));
		{
			_x revealMine _mine;
		} forEach [EAST,RESISTANCE];
	};
	if (_attempts > _maxAttempts) exitWith {};
	_attempts = _attempts + 1;
};
if (_isMarked) then {
	private _sign = objNull;
	private _dir = random 360;
	private _info = [];
	private _pos = [0,0,0];
	private _configClass = '';
	private _randomType = '';
	for '_x' from 0 to 7 step 1 do {
		_pos = _centerPos getPos [(_outerRadius + 5),_dir];
		_randomType = selectRandom _barrierTypes;
		_info = QS_hashmap_simpleObjectInfo getOrDefault [_randomType,[]];
		if (_info isEqualTo []) then {
			_configClass = configFile >> 'CfgVehicles' >> _randomType;
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
			QS_hashmap_simpleObjectInfo set [_randomType,_info];
		};
		_pos set [2,_info # 1];
		_pos = ATLToASL _pos;
		_sign = createSimpleObject [_info # 0,_pos];
		_sign setDir ((_centerPos getDir _pos) - 180);
		if ((random 1) > 0.666) then {
			_sign setVectorUp (surfaceNormal _pos);
		} else {
			_sign setVectorUp [0,0,0];
		};
		_dir = _dir + 45;
		0 = _signs pushBack _sign;
	};
};
_all = _mines + _signs + _barriers;
_all;