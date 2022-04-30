/*/
File: fn_aoCreateUXOfield.sqf
Author: 

	Quiksilver

Last Modified:

	26/11/2017 A3 1.78 by Quiksilver

Description:

	-
____________________________________________________________________________/*/

params [
	['_aoPos',[0,0,0]],
	['_aoSize',300],
	['_quantity',10],
	[
		'_mineTypesWeighted',
		[
			'BombCluster_03_UXO1_F',0.1,
			'BombCluster_02_UXO1_F',0.1,
			'BombCluster_01_UXO1_F',0.1,
			'BombCluster_03_UXO4_F',0.1,
			'BombCluster_02_UXO4_F',0.1,
			'BombCluster_01_UXO4_F',0.1,
			'BombCluster_03_UXO2_F',0.3,
			'BombCluster_02_UXO2_F',0.3,
			'BombCluster_01_UXO2_F',0.3,
			'BombCluster_03_UXO3_F',0.1,
			'BombCluster_02_UXO3_F',0.1,
			'BombCluster_01_UXO3_F',0.1
		]
	]
];
_return = [];
//comment 'Find position';
private _spawnPos = [0,0,0];
if (surfaceIsWater _aoPos) then {
	for '_x' from 0 to 14 step 1 do {
		_spawnPos = ['RADIUS',_aoPos,_aoSize,'LAND',[1,0,-1,-1,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if (!([_spawnPos,50,6] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) exitWith {};
	};
	_spawnPos set [2,0];
} else {
	_spawnPos = _aoPos;
};
if ((_spawnPos distance2D _aoPos) < (_aoSize * 1.1)) then {
	if (_mineTypesWeighted isEqualTo []) then {
		_mineTypesWeighted = [
			'BombCluster_03_UXO1_F',0.1,
			'BombCluster_02_UXO1_F',0.1,
			'BombCluster_01_UXO1_F',0.1,
			'BombCluster_03_UXO4_F',0.1,
			'BombCluster_02_UXO4_F',0.1,
			'BombCluster_01_UXO4_F',0.1,
			'BombCluster_03_UXO2_F',0.3,
			'BombCluster_02_UXO2_F',0.3,
			'BombCluster_01_UXO2_F',0.3,
			'BombCluster_03_UXO3_F',0.1,
			'BombCluster_02_UXO3_F',0.1,
			'BombCluster_01_UXO3_F',0.1
		];
	};
	private _mine = objNull;
	for '_x' from 0 to (_quantity - 1) step 1 do {
		_mine = createMine [(selectRandomWeighted _mineTypesWeighted),_spawnPos,[],_aoSize];
		missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
		if (surfaceIsWater (getPosWorld _mine)) then {
			deleteVehicle _mine;
		} else {
			_return pushBack _mine;
		};
		//_mine enableDynamicSimulation TRUE;
		_mine setVectorUp (surfaceNormal (getPosWorld _mine));
		{
			_x revealMine _mine;
		} forEach [EAST,RESISTANCE];
	};
};
_return;