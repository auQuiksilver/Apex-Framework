/*/
File: fn_curatorSync.sqf
Author: 

	Quiksilver

Last Modified:

	28/03/2018 A3 1.82 by Quiksilver

Description:

	Curator Sync
_______________________________________/*/

params ['_module'];
if (!isNull _module) then {
	private _arrayToAdd = [];
	{
		if (
			(_x isKindOf 'CraterLong') || 
			{(_x isKindOf 'Man')} || 
			{(_x isKindOf 'WeaponHolder')} || 
			{(_x isKindOf 'GroundWeaponHolder')} || 
			{(_x isKindOf 'WeaponHolderSimulated')} ||
			{(_x isKindOf 'Air')} ||
			{(_x isKindOf 'LandVehicle')} ||
			{(_x isKindOf 'Reammobox_F')} ||
			{(_x isKindOf 'Ship')} ||
			{(_x isKindOf 'StaticWeapon')}
		) then {
			if (!(_x getVariable ['QS_curator_disableEditability',FALSE])) then {
				if (!(_x getVariable ['QS_dead_prop',FALSE])) then {
					0 = _arrayToAdd pushBackUnique _x;
				};
			};
		} else {
			if (!isNil {_x getVariable 'QS_curator_spawnedObj'}) then {
				0 = _arrayToAdd pushBackUnique _x;
			};
		};
	} count (allMissionObjects 'All');
	{
		_module addCuratorEditableObjects _x;
		sleep 0.2;
	} forEach [	
		[allPlayers,FALSE],
		[(allUnits select {(!(_x getVariable ['QS_curator_disableEditability',FALSE]))}),TRUE],
		[(allDead select {(!(_x getVariable ['QS_dead_prop',FALSE]))}),TRUE],
		[_arrayToAdd,TRUE]
	];
};