/*/
File: fn_aoMinefield.sqf
Author:

	Quiksilver
	
Last modified:

	12/09/2022 A3 2.10 by Quiksilver
	
Description:

	Spawn a radial minefield with some razorwire around it
___________________________________________/*/

private ['_centralPos','_objectsArray','_mineTypes','_mine','_mineType','_distance','_distance2','_barriers','_angle','_signPos','_pos','_minePos'];
_centralPos = getPosATL (missionNamespace getVariable 'QS_radioTower');
_objectsArray = [];
_mineTypes = ['minefield_types_1'] call QS_data_listOther;
if (worldName isEqualTo 'Tanoa') then {
	_distance = 23;
	_distance2 = 25;
	_barriers = 15;
	_angle = 30;
} else {
	_distance = 40;
	_distance2 = 38;
	_barriers = 23;
	_angle = 15;
};

for '_x' from 0 to (round (29 + (random 19))) step 1 do {
	_mineType = selectRandom _mineTypes;
	_minePos = _centralPos getPos [(_distance2 * (sqrt (random 1))),(random 360)];
    _mine = createMine [_mineType,_minePos,[],0];
	//_mine enableDynamicSimulation TRUE;
	_mine setVectorUp (surfaceNormal (getPosWorld _mine));
	{
		_x revealMine _mine;
	} forEach [EAST,RESISTANCE];
	if (surfaceIsWater (getPosWorld _mine)) then {
		deleteVehicle _mine;
	} else {
		0 = _objectsArray pushBack _mine;
	};
};
if (missionNamespace getVariable ['QS_radiotower_useFence',FALSE]) then {
	_dir = 180;
	private _info = QS_hashmap_simpleObjectInfo getOrDefault ['Land_Razorwire_F',[]];
	if (_info isEqualTo []) then {
		_configClass = configFile >> 'CfgVehicles' >> 'Land_Razorwire_F';
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
		QS_hashmap_simpleObjectInfo set ['Land_Razorwire_F',_info];
	};
	for '_c' from 0 to _barriers step 1 do {
		_pos = _centralPos getPos [_distance,_dir];
		_pos set [2,_info # 1];
		_pos = ATLToASL _pos;
		_sign = createSimpleObject [_info # 0,_pos];
		_sign setDir _dir;
		_sign setVectorUp (surfaceNormal _pos);
		_dir = _dir + _angle;
		0 = _objectsArray pushBack _sign;
	};
};
_objectsArray;