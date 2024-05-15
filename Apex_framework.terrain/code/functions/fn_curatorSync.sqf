/*/
File: fn_curatorSync.sqf
Author: 

	Quiksilver

Last Modified:

	21/1/2024 A3 2.14 by Quiksilver

Description:

	Curator Sync
_______________________________________/*/

params ['_module','_curatorSelected'];
if (!isNull _module) then {
	if (_curatorSelected isEqualTo []) then {
		private _arrayToAdd = [];
		private _entity = objNull;
		{
			_entity = _x;
			if (
				(([
					'Man','WeaponHolder','GroundWeaponHolder','WeaponHolderSimulated','Air',
					'LandVehicle','Reammobox_F','Ship','StaticWeapon','CraterLong','Cargo_base_F'
				] findIf {_entity isKindOf _x}) isNotEqualTo -1) ||
				{((_entity isKindOf 'FlagCarrier') && (!(_entity isKindOf 'ShipFlag_US_F')) && (_entity getVariable ['QS_zeus',false]))}
			) then {
				if (
					(!(_entity getVariable ['QS_curator_disableEditability',FALSE])) &&
					(!(_entity getVariable ['QS_dead_prop',FALSE]))
				) then {
					_arrayToAdd pushBackUnique _entity;
				};
			} else {
				if !(_entity isNil 'QS_curator_spawnedObj') then {
					_arrayToAdd pushBackUnique _entity;
				};
			};
		} forEach (8 allObjects 8);  //(allMissionObjects 'All');
		{
			_module addCuratorEditableObjects _x;
			sleep 0.2;
		} forEach [
			[(allPlayers select {(!(_x getVariable ['QS_curator_disableEditability',FALSE]))}),FALSE],
			[(allUnits select {(!(_x getVariable ['QS_curator_disableEditability',FALSE]))}),TRUE],
			[(allDead select {(!(_x getVariable ['QS_dead_prop',FALSE]))}),TRUE],
			[_arrayToAdd,TRUE]
		];
	} else {
		_module removeCuratorEditableObjects [_curatorSelected,TRUE];
	};
};