/*/
File: fn_clientDamageModifier.sqf
Author: 

	Quiksilver
	
Last modified:

	13/10/2018 A3 1.84 by Quiksilver
	
Description:

	Player Damage Modification
___________________________________________________________________/*/

params ['_unit','','_damage','_source','','_hitPartIndex','_instigator',''];
private _return = 0.88;
if (isNull (objectParent _unit)) then {
	if (_source isEqualType objNull) then {
		if (!isNull _source) then {
			if ((isPlayer _source) || {(isPlayer _instigator)}) then {
				if (!(_unit in [_source,_instigator])) then {
					if ((side (group _instigator)) in [(_unit getVariable ['QS_unit_side',WEST]),sideEnemy]) then {
						_return = 0.05;
					};
				};
			} else {
				if ((call (missionNamespace getVariable ['QS_missionConfig_reducedDamage',{1}])) isEqualTo 1) then {
					_return = 0.333;
					if (_hitPartIndex in [-1,0,1,2,3,4,5,6,7,11]) then {
						if ((random 1) > ([0.5,0.25] select (((((_unit getVariable 'QS_client_soundControllers') # 1) # 8) # 1) isEqualTo 1))) then {
							_randomSelection = selectRandomWeighted [8,0.5,9,0.25,10,0.25];
							_hitValue = (_unit getHitIndex _randomSelection) max ((_unit getHitIndex _randomSelection) + _damage);
							_unit setHitIndex [_randomSelection,_hitValue,TRUE];
							_return = 0.05;
						};
					};
				};
			};
		};
	} else {
		if (!isNull _instigator) then {
			if (isPlayer _instigator) then {
				if ((side (group _instigator)) in [(_unit getVariable ['QS_unit_side',WEST]),sideEnemy]) then {
					_return = 0.05;
				};
			};
		};
	};
} else {
	if ((objectParent _unit) isKindOf 'Air') then {
		if (alive (objectParent _unit)) then {
			if ((call (missionNamespace getVariable ['QS_missionConfig_reducedDamage',{1}])) isEqualTo 1) then {
				_return = 0.333;
			};
			if (_unit isEqualTo (driver (objectParent _unit))) then {
				if (_instigator isEqualType objNull) then {
					if (!isNull _instigator) then {
						if (isPlayer _instigator) then {
							if (!(_unit in [_source,_instigator])) then {
								if ((side (group _instigator)) in [(_unit getVariable ['QS_unit_side',WEST]),sideEnemy]) then {
									_return = 0;
								};
							};
						};
					};
				};
			};
		};
	} else {
		if ((objectParent _unit) isKindOf 'Car') then {
			if ((objectParent _unit) getVariable ['QS_vehicle_civArmored',FALSE]) then {
				// Simulating an armored civilian vehicle
			};
		};
	};
};
_return;