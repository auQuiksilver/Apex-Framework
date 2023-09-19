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
		(['uxo_field_types_1'] call QS_data_listOther)
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
		_mineTypesWeighted = ['uxo_field_types_1'] call QS_data_listOther;
	};
	private _mine = objNull;
	for '_x' from 0 to (_quantity - 1) step 1 do {
		_mine = createMine [(selectRandomWeighted _mineTypesWeighted),_spawnPos,[],_aoSize];
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