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
_boxArray = [
	'Box_East_Ammo_F',
	'Box_East_Wps_F',
	'O_CargoNet_01_ammo_F',
	'Box_East_AmmoOrd_F',
	'Box_East_Grenades_F',
	'Box_East_WpsLaunch_F',
	'Box_East_WpsSpecial_F',
	'O_supplyCrate_F',
	'Box_East_Support_F',
	'Box_East_AmmoVeh_F',
	'Box_NATO_Ammo_F',
	'Box_IND_Ammo_F'
] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
if (worldName isEqualTo 'Tanoa') then {
	_boxArray = [
		"Box_T_East_Ammo_F",
		"Box_Syndicate_Ammo_F",
		"Box_T_East_Wps_F",
		"Box_T_NATO_Wps_F",
		"Box_Syndicate_Wps_F",
		"Box_IED_Exp_F",
		"Box_Syndicate_WpsLaunch_F",
		"Box_T_East_WpsSpecial_F",
		"Box_T_NATO_WpsSpecial_F",
		"Box_GEN_Equip_F"
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
if (worldName isEqualTo 'Enoch') then {
	_boxArray = [
		'Box_East_Ammo_F',
		'Box_East_Wps_F',
		'i_e_cargonet_01_ammo_f',
		'Box_East_AmmoOrd_F',
		'Box_East_Grenades_F',
		'Box_East_WpsLaunch_F',
		'Box_East_WpsSpecial_F',
		'O_supplyCrate_F',
		'Box_East_Support_F',
		'Box_East_AmmoVeh_F',
		'Box_NATO_Ammo_F',
		'Box_IND_Ammo_F'
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
for '_x' from 0 to (2 + (round(random 2))) do {
	_boxSelect = selectRandom _boxArray;
	_spawnPos = _pos findEmptyPosition [0,40,_boxSelect];
	if (_spawnPos isNotEqualTo []) then {
		_box = createVehicle [_boxSelect,[(_spawnPos # 0),(_spawnPos # 1),((_spawnPos # 2)+0.5)],[],0,'NONE'];
		_box setDir (random 360);
		if ((random 1) > 0.666) then {
			[_box,0,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
		};
		if (!((toLowerANSI _boxSelect) in ['o_supplycrate_f','o_cargonet_01_ammo_f','box_east_ammoveh_f','i_e_cargonet_01_ammo_f'])) then {
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