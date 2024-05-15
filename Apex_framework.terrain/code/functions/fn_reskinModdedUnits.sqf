/*/
File: fn_reskinModdedUnits.sqf
Author:
	
	Quiksilver
	
Last Modified:

	18/12/2023 A3 2.14 by Quiksilver
	
Description:

	Very Basic procedure to reskin vanilla units to modded counterparts
	
Usage:

	(Using RHS mod as an example)

		[
			'rhs_msv_marksman',							// STRING or ARRAY of strings. opfor default class.
			'rhsusf_usmc_marpat_wd_rifleman',			// STRING or ARRAY of strings. blufor default class
			'rhs_msv_marksman',							// STRING or ARRAY of strings. indfor default class
			'c_man_1'									// STRING or ARRAY of strings. civilian default class
		] spawn QS_fnc_reskinModdedUnits;
	
Notes:

	- You can use an array of classnames for each faction instead, for basic randomization
	- All spawned units will get reskinned with the above default classes, based on faction side
______________________________________________________/*/

if (_this isEqualTo []) exitWith {diag_log '* reskinModdedUnits invalid params *';};
if (!canSuspend) exitWith { 
	_this spawn QS_fnc_reskinModdedUnits; 
	diag_log '* reskinModdedUnits is rebooting in scheduled environment *';
};
scriptName 'QS Basic Reskin';
params [
	['_east','',['',[]]],
	['_west','',['',[]]],
	['_resistance','',['',[]]],
	['_civilian','',['',[]]],
	['_excludeTypes',['O_UAV_AI','B_UAV_AI','I_UAV_AI','C_UAV_AI_F']],
	['_sleepInterval',0.5]
];
_true = true;
_false = false;
_factionEast = [EAST];
_factionWest = [WEST];
_factionResistance = [RESISTANCE];
_factionCivilian = [CIVILIAN];

// Validate east
private _reskinEast = FALSE;
if (_east isEqualType []) then {
	if (_east isNotEqualTo []) then {
		_reskinEast = TRUE;
	};
} else {
	if (_east isNotEqualTo '') then {
		_reskinEast = TRUE;
	};
};
// Validate west
private _reskinWest = FALSE;
if (_west isEqualType []) then {
	if (_west isNotEqualTo []) then {
		_reskinWest = TRUE;
	};
} else {
	if (_west isNotEqualTo '') then {
		_reskinWest = TRUE;
	};
};
// Validate resistance
private _reskinInd = FALSE;
if (_resistance isEqualType []) then {
	if (_resistance isNotEqualTo []) then {
		_reskinInd = TRUE;
	};
} else {
	if (_resistance isNotEqualTo '') then {
		_reskinInd = TRUE;
	};
};
// Validate civ
private _reskinCiv = FALSE;
if (_civilian isEqualType []) then {
	if (_civilian isNotEqualTo []) then {
		_reskinCiv = TRUE;
	};
} else {
	if (_civilian isNotEqualTo '') then {
		_reskinCiv = TRUE;
	};
};
for '_z' from 0 to 1 step 0 do {
	{
		sleep _sleepInterval;
		if (
			(!(_x getvariable ['QS_reskinned',_false])) &&
			{(!isPlayer _x)} &&
			{(!isNull (group _x))} &&
			{(!unitIsUAV _x)} &&
			{(!((typeOf _x) in _excludeTypes))}
		) then {
			_x setvariable ['QS_reskinned',_true];
			// Opfor
			if (_reskinEast) then {
				if ((side (group _x)) in _factionEast) then {
					if (_east isEqualType []) then {
						_x setUnitLoadout (selectRandom _east);
						_x selectWeapon (primaryWeapon _x);
					} else {
						_x setUnitLoadout _east;
						_x selectWeapon (primaryWeapon _x);
					};
				};
			};
			// Blufor
			if (_reskinWest) then {
				if ((side (group _x)) in _factionWest) then {
					if (_west isEqualType []) then {
						_x setUnitLoadout (selectRandom _west);
						_x selectWeapon (primaryWeapon _x);
					} else {
						_x setUnitLoadout _west;
						_x selectWeapon (primaryWeapon _x);
					};
				};
			};
			// Indfor
			if (_reskinInd) then {
				if ((side (group _x)) in _factionResistance) then {
					if (_resistance isEqualType []) then {
						_x setUnitLoadout (selectRandom _resistance);
						_x selectWeapon (primaryWeapon _x);
					} else {
						_x setUnitLoadout _resistance;
						_x selectWeapon (primaryWeapon _x);
					};
				};
			};
			// Civ
			if (_reskinCiv) then {
				if ((side (group _x)) in _factionCivilian) then {
					if (_civilian isEqualType []) then {
						_x setUnitLoadout (selectRandom _civilian);
						_x selectWeapon (primaryWeapon _x);
					} else {
						_x setUnitLoadout _civilian;
						_x selectWeapon (primaryWeapon _x);
					};
				};
			};
		};
	} foreach allunits;
	sleep _sleepInterval;
};