/*/
File: fn_clientDamageModifier.sqf
Author: 

	Quiksilver
	
Last modified:

	18/12/2017 A3 1.80 by Quiksilver
	
Description:

	Player Damage Modification
___________________________________________________________________/*/

params ['_unit','_selectionName','_damage','_source','_projectile','_hitPartIndex','_instigator','_hitPoint'];
private _return = 0.8;
if (isNull (objectParent _unit)) then {
	if (_source isEqualType objNull) then {
		if (!isNull _source) then {
			if ((isPlayer _source) || {(isPlayer _instigator)}) then {
				if (!(_unit in [_source,_instigator])) then {
					_return = 0.05;
				};
			} else {
				_return = 0.333;
				if (_hitPartIndex in [-1,0,1,2,3,4,5,6,7,11]) then {
					if ((random 1) > ([0.5,0.25] select (((((player getVariable 'QS_client_soundControllers') select 1) select 8) select 1) isEqualTo 1))) then {
						_randomSelection = selectRandomWeighted [8,0.5,9,0.25,10,0.25];
						_hitValue = (_unit getHitIndex _randomSelection) max ((_unit getHitIndex _randomSelection) + _damage);
						_unit setHitIndex [_randomSelection,_hitValue,TRUE];
						_return = 0.05;
					};
				};
			};
		};
	} else {
		if (!isNull _instigator) then {
			if (isPlayer _instigator) then {
				_return = 0.05;
			};
		};
	};
} else {
	if ((vehicle _unit) isKindOf 'Air') then {
		if (alive (vehicle _unit)) then {
			_return = 0.25;
			if (_unit isEqualTo (driver (vehicle _unit))) then {
				if (_instigator isEqualType objNull) then {
					if (!isNull _instigator) then {
						if (isPlayer _instigator) then {
							if (!(_instigator isEqualTo _unit)) then {
								_return = 0;
							};
						};
					};
				};
			};
		};
	};
};
_return;