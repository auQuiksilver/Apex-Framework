/*
File: fn_clientVehicleEventHandleDamage.sqf
Author:
	
	Quiksilver
	
Last Modified:

	30/04/2022 A3 2.08 by Quiksilver

Description:

	Event Handle Damage
__________________________________________________________*/

if (!(local (_this # 0))) exitWith {};
params ['_vehicle','_selectionName','_damage','_source','_projectile','_hitPartIndex','_instigator','_hitPoint'];
private _scale = 1;
private _aircraft_crit = FALSE;
_oldDamage = [(_vehicle getHit _selectionName),(damage _vehicle)] select (_selectionName isEqualTo '');
if (!isNull _instigator) then {
	if ((isPlayer _instigator) || {(isPlayer (effectiveCommander _instigator))}) then {
		if (!(_vehicle in [_source,_instigator])) then {
			if ((side (group _instigator)) in [(player getVariable ['QS_unit_side',WEST]),sideEnemy]) then {
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
			if ((side (group _instigator)) in [(player getVariable ['QS_unit_side',WEST]),sideEnemy]) then {
				_scale = 0.05;
			};
		};
	} else {
		if (_vehicle isKindOf 'Helicopter') then {
			_scale = 0.333;
			_data1 = [
				["Heli_Transport_02_base_F",["engine_1_hit","engine_2_hit","engine_hit","main_rotor_hit"]],
				["Heli_light_03_base_F",["engine_1_hit","engine_2_hit","engine_hit","main_rotor_hit"]],
				["Heli_Transport_04_base_F",["engine_1_hit","engine_2_hit","engine_hit","main_rotor_hit"]],
				["Heli_Attack_02_base_F",["engine_1_hit","engine_2_hit","engine_hit","main_rotor_hit"]],
				["Heli_Light_02_base_F",["engine_1_hit","engine_2_hit","engine_hit","main_rotor_hit"]],
				["Heli_Light_01_base_F",["engine_hit","main_rotor_hit"]],
				["Heli_Transport_01_base_F",["engine_1_hit","engine_2_hit","engine_hit","main_rotor_hit"]],
				["Heli_Transport_03_base_F",["engine_1_hit","engine_2_hit","engine_3_hit","engine_4_hit","engine_hit","main_rotor_1_hit","main_rotor_1_hit"]],
				["Heli_Attack_01_base_F",["engine_1_hit","engine_2_hit","engine_hit","main_rotor_hit"]]
			];
			_element = _data1 findIf {(_vehicle isKindOf (_x # 0))};
			if (_element isNotEqualTo -1) then {
				if (_selectionName in ((_data1 # _element) # 1)) then {
					_aircraft_crit = TRUE;
					_scale = [0.1,0.25] select ((random 1) > 0.5);
				};
			};
		};
		if (_vehicle isKindOf 'Tank') then {
			_scale = 0.75;
		};
		if ((_vehicle isKindOf 'Car') || {(_vehicle isKindOf 'Ship')}) then {
			_scale = 0.75;
		};
		if (_vehicle isKindOf 'Plane') then {
			_data1 = [
				["VTOL_02_infantry_base_F",["hitrotor1","hitrotor2","hitrotor1","hitrotor2","hitrotor1","hitrotor2","hitengine","hitengine2"]],
				["VTOL_01_base_F",["hitengine","hitengine2","hitlrotor","hitrrotor","hitlrotor","hitrrotor"]]
			];
			_element = _data1 findIf {(_vehicle isKindOf (_x # 0))};
			if (_element isNotEqualTo -1) then {
				if (_selectionName in ((_data1 # _element) # 1)) then {
					_scale = [0.25,0.333] select ((random 1) > 0.5);
				};
			};
		};
	};
} else {
	if (_projectile isEqualTo '') then {
		_scale = 0.5;
		if ((_selectionName select [0,5]) isEqualTo 'wheel') then {
			if (_vehicle isNotEqualTo (missionNamespace getVariable ['QS_sideMission_vehicle',objNull])) then {
				_scale = 0.05;
			};
		};
	};
};
if (!isNull _instigator) then {
	if (alive _instigator) then {
		if (isPlayer _instigator) then {
			if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 500) then {
				if (_vehicle isKindOf 'Air') then {
					if (((vehicle _instigator) distance2D (markerPos 'QS_marker_base_marker')) > 500) then {
						if (_damage > 0.25) then {
							[player,_instigator,0.1,_instigator] call (missionNamespace getVariable 'QS_fnc_clientEventHit');
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
if (
	(_projectile isEqualTo 'FuelExplosion') &&
	{((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 500)}
) exitWith {0};
_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
if (_aircraft_crit) then {
	if (_damage >= 0.9) then {
		if (diag_tickTime > (missionNamespace getVariable ['QS_critHit_timeout',-1])) then {
			if (scriptDone (missionNamespace getVariable ['QS_critHit_gatekeeper',scriptNull])) then {
				QS_critHit_gatekeeper = 0 spawn {
					uiSleep 1;
					missionNamespace setVariable ['QS_critHit_timeout',diag_tickTime + 60,FALSE];
				};
			};
			if (scriptDone (missionNamespace getVariable ['QS_aircraft_critHit',scriptNull])) then {
				QS_aircraft_critHit_array = [[_selectionName,0.89]];
				QS_aircraft_critHit = [_vehicle] spawn {
					params ['_vehicle'];
					uiSleep 0.333;
					{
						_vehicle setHit [_x # 0,_x # 1];
					} forEach QS_aircraft_critHit_array;
					QS_aircraft_critHit_array = [];
				};
			} else {
				QS_aircraft_critHit_array pushBack [_selectionName,0.89];
			};
			_vehicle setHit [(['hitfuel','fuel_hit'] select (_vehicle isKindOf 'Helicopter')),_damage];
			_damage = 0.89;
		};
	};
};
_damage;