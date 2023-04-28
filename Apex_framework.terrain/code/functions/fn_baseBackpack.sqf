/*/
File: fn_baseBackpack.sqf
Author:

	Quiksilver (Alias of BIS_fnc_basicBackpack by Jiri Wainar)
	
Last Modified:

	15/04/2018 A3 1.82 by Quiksilver
	
Description:

	Return class of given backpack without a bakened-in equipment (an empty backpack).
	
Notes:

	To Do: Optimise this
________________________________________________/*/

params [
	['_input','',['']]
];
private _output = '';
if (_input isEqualTo '') exitWith {/*/call _fn_debug;/*/''};
_fn_hasCargo = {
	private _hasCargo = FALSE;
	private _cargo = [];
	{
		_cargo = _x call (missionNamespace getVariable 'BIS_fnc_getCfgSubClasses');
		if (_cargo isNotEqualTo []) exitWith {
			_hasCargo = TRUE;
		};
	} forEach [
		(configfile >> 'CfgVehicles' >> _this >> 'TransportItems'),
		(configfile >> 'CfgVehicles' >> _this >> 'TransportMagazines'),
		(configfile >> 'CfgVehicles' >> _this >> 'TransportWeapons')
	];
	_hasCargo;
};
if (!(_input call _fn_hasCargo)) exitWith {_input};
_parents = [configfile >> 'CfgVehicles' >> _input,TRUE] call (missionNamespace getVariable 'BIS_fnc_returnParents');
private _hasCargo = FALSE;
private _scope = -1;
{
	_hasCargo = _x call _fn_hasCargo;
	_scope = getNumber (configfile >> 'CfgVehicles' >> _x >> 'scope');
	if ((!(_hasCargo)) && (_scope isEqualTo 2)) exitWith {
		_output = _x;
	};
} forEach _parents;
_output;