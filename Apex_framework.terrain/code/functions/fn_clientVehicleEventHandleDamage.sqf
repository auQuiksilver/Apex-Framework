/*
File: fn_clientVehicleEventHandleDamage.sqf
Author:
	
	Quiksilver
	
Last Modified:

	19/06/2017 A3 1.70 by Quiksilver

Description:

	Event Handle Damage				
__________________________________________________________*/

if ((!(local (_this select 0))) || {(!alive (_this select 0))}) exitWith {};
params ['_vehicle','_selectionName','_damage','_source','_projectile','_hitPartIndex','_instigator','_hitPoint'];
private _scale = 1;
_oldDamage = [(_vehicle getHit _selectionName),(damage _vehicle)] select (_selectionName isEqualTo '');
if (!(_selectionName isEqualTo '?')) then {
	if (!isNull _instigator) then {
		if ((isPlayer _instigator) || {(isPlayer (effectiveCommander _instigator))}) then {
			if (!(_vehicle in [_source,_instigator])) then {
				if ((side (group _instigator)) in [playerSide,sideEnemy]) then {
					_scale = 0.05;
				};
			};
		} else {
			if (_vehicle isKindOf 'Helicopter') then {
				_scale = 0.5;
			};
		};
	};
	if (!isNull _source) then {
		if ((isPlayer _source) || {(isPlayer (effectiveCommander _source))}) then {
			if (!(_vehicle in [_source,_instigator])) then {
				if ((side (group _instigator)) in [playerSide,sideEnemy]) then {
					_scale = 0.05;
				};
			};
		} else {
			if (_vehicle isKindOf 'Helicopter') then {
				_scale = 0.5;
			};
		};
	} else {
		if (_projectile isEqualTo '') then {
			_scale = 0.5;
			if ((_selectionName select [0,5]) isEqualTo 'wheel') then {
				if (!(_vehicle isEqualTo (missionNamespace getVariable ['QS_sideMission_vehicle',objNull]))) then {
					_scale = 0.05;
				};
			};
		};
	};
	if (!isNull _instigator) then {
		if (alive _instigator) then {
			if (isPlayer _instigator) then {
				if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 300) then {
					if (_vehicle isKindOf 'Air') then {
						if (((vehicle _instigator) distance2D (markerPos 'QS_marker_base_marker')) > 400) then {
							if (_damage > 0.25) then {
								[player,_instigator,0.1] call (missionNamespace getVariable 'QS_fnc_clientEventHit');
								_instigator setDamage [1,FALSE];
							};
						};
						if ((vehicle _instigator) isKindOf 'LandVehicle') then {
							_scale = 0;
						};
					};
				};
			};
		};
	};
} else {
	_scale = 0;
};
_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
_damage;