/*/
File: fn_clientEventHandleDamage.sqf
Author: 

	Quiksilver
	
Last modified:

	6/10/2017 A3 1.76 by Quiksilver
	
Description:

	-
___________________________________________________________________/*/

params ['_unit','_selectionName','_damage','_source','_projectile','_hitPartIndex','_instigator','_hitPoint'];
if ((!local _unit) ||{(!alive _unit)}) exitWith {};
if ((!((lifeState _unit) in ['HEALTHY','INJURED'])) || {(!isDamageAllowed _unit)}) exitWith {(([(_unit getHit _selectionName),(damage _unit)] select (_selectionName isEqualTo '')) min 0.89)};
private _scale = 0.75;
_oldDamage = [(_unit getHit _selectionName),(damage _unit)] select (_selectionName isEqualTo '');
if (isNull (objectParent _unit)) then {
	if (_source isEqualType objNull) then {
		if (!isNull _source) then {
			if ((isPlayer _source) || {(isPlayer _instigator)}) then {
				if (!(_unit in [_source,_instigator])) then {
					_scale = [0.05,0] select (_selectionName isEqualTo '?');
				};
			} else {
				if (!(_selectionName isEqualTo '?')) then {
					_scale = 0.333;
					if (_selectionName in ['face_hub','neck','head','pelvis','spine1','spine2','spine3','body','']) then {
						if ((random 1) > ([0.5,0.25] select (((((player getVariable 'QS_client_soundControllers') select 1) select 8) select 1) isEqualTo 1))) then {
							_randomSelection = ['arms','hands','legs'] selectRandomWeighted [0.5,0.25,0.25];
							_unit setHit [_randomSelection,(((_unit getHit _randomSelection) + (((_damage - _oldDamage) * _scale) + _oldDamage)) min 0.89),TRUE];
							_scale = 0;
						};
					};
				} else {
					_scale = 0;
				};
			};
		};
	} else {
		if (!isNull _instigator) then {
			if (isPlayer _instigator) then {
				_scale = 0;
			};
		};
	};
} else {
	if ((vehicle _unit) isKindOf 'Air') then {
		if (alive (vehicle _unit)) then {
			if (!(_selectionName isEqualTo '?')) then {
				_scale = 0.25;
			};
			if (_unit isEqualTo (driver (vehicle _unit))) then {
				if (_instigator isEqualType objNull) then {
					if (!isNull _instigator) then {
						if (isPlayer _instigator) then {
							if (!(_instigator isEqualTo _unit)) then {
								_scale = 0;
							};
						};
					};
				};
			};
		};
	};
};
if (isNull _source) then {
	_source = missionNamespace getVariable ['QS_revive_lastSource',objNull];
} else {
	missionNamespace setVariable ['QS_revive_lastSource',_source,FALSE];
};
if (isNull _instigator) then {
	_instigator = missionNamespace getVariable ['QS_revive_lastInstigator',objNull];
} else {
	missionNamespace setVariable ['QS_revive_lastInstigator',_instigator,FALSE];
};
_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
if ((_damage > 0.89) && (_selectionName in ['','head','body']))  then {
	if (scriptDone (missionNamespace getVariable 'QS_script_incapacitated')) then {
		if (isDamageAllowed _unit) then {
			_unit allowDamage FALSE;
		};
		missionNamespace setVariable ['QS_script_incapacitated',(_this spawn (missionNamespace getVariable 'QS_fnc_incapacitated')),FALSE];
	};
	_damage = 0.89;
};
(_damage min 0.89);