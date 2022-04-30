/*
File: fn_vHandleDamage.sqf
Author:

	Quiksilver
	
Last Modified:

	27/04/2016 A3 1.58 by Quiksilver
	
Description:

	Vehicle Damage Handler
___________________________________________________*/

params ['_vehicle','_selection','_damage','_source','_ammo','_hitPartIndex'];
if (!(_selection isEqualTo '?')) then {
	if (_selection isEqualTo '') then { 
		_oldDamage = damage _vehicle; 
	} else { 
		_oldDamage = _vehicle getHit _selection;
	};
	if (!isNil '_oldDamage') then {
		if ((isNull _source) && (_ammo isEqualTo '')) exitWith {
			_scale = 0.5;
			if ((_selection select [0,5]) == 'wheel') then {
				_scale = 0.1;
			};
			_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
		};
	};
};
_damage;