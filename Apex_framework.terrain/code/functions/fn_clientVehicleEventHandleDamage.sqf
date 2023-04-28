/*
File: fn_clientVehicleEventHandleDamage.sqf
Author:
	
	Quiksilver
	
Last Modified:

	17/03/2023 A3 2.12 by Quiksilver

Description:

	Event Handle Damage
____________________________________________*/

if (!(local (_this # 0))) exitWith {};
params ['_vehicle','_selectionName','_damage','_source','_projectile','','_instigator','_hitPoint','_directHit'];
([_vehicle,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
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
	if (
		(
			((ropeAttachedObjects _vehicle) isNotEqualTo []) &&
			{(_source in (ropeAttachedObjects _vehicle))}
		) ||
		{(
			(!isNull (ropeAttachedTo _vehicle)) &&
			{(_source isEqualTo (ropeAttachedTo _vehicle))}
		)} ||
		{(
			(!isNull (getSlingLoad _vehicle)) &&
			{(_source isEqualTo (getSlingLoad _vehicle))}
		)}
	) then {
		_scale = 0.05;
	};
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
				['Heli_Transport_02_base_F',['engine_1_hit','engine_2_hit','engine_hit','main_rotor_hit']],
				['Heli_light_03_base_F',['engine_1_hit','engine_2_hit','engine_hit','main_rotor_hit']],
				['Heli_Transport_04_base_F',['engine_1_hit','engine_2_hit','engine_hit','main_rotor_hit']],
				['Heli_Attack_02_base_F',['engine_1_hit','engine_2_hit','engine_hit','main_rotor_hit']],
				['Heli_Light_02_base_F',['engine_1_hit','engine_2_hit','engine_hit','main_rotor_hit']],
				['Heli_Light_01_base_F',['engine_hit','main_rotor_hit']],
				['Heli_Transport_01_base_F',['engine_1_hit','engine_2_hit','engine_hit','main_rotor_hit']],
				['Heli_Transport_03_base_F',['engine_1_hit','engine_2_hit','engine_3_hit','engine_4_hit','engine_hit','main_rotor_1_hit','main_rotor_1_hit']],
				['Heli_Attack_01_base_F',['engine_1_hit','engine_2_hit','engine_hit','main_rotor_hit']]
			];
			_element = _data1 findIf {(_vehicle isKindOf (_x # 0))};
			if (_element isNotEqualTo -1) then {
				if (_selectionName in ((_data1 # _element) # 1)) then {
					_aircraft_crit = TRUE;
					_scale = [0.1,0.25] select ((random 1) > 0.5);
				};
			};
		};
		if (
			(_vehicle isKindOf 'LandVehicle') ||
			{(_vehicle isKindOf 'Ship')}
		) then {
			_scale = 0.75;
			if (
				(
					((_vehicle animationSourcePhase 'showslathull') isEqualTo 1) &&
					{(((missionNamespace getVariable ['QS_vehicle_incomingMissiles',[]]) findIf {(_projectile isEqualTo (_x # 0))}) isNotEqualTo -1)} &&
					{(['cage',_selectionName,FALSE] call QS_fnc_inString)}
				) ||
				{(_vehicle isKindOf 'APC_Tracked_01_base_F')}
			) then {
				if (diag_tickTime > (missionNamespace getVariable ['QS_critHit_timeout',-1])) then {
					missionNamespace setVariable ['QS_critHit_timeout',diag_tickTime + 3,FALSE];
					missionNamespace setVariable ['QS_vehicleHit_modified',((random 1) > 0.333),FALSE];
				};
				if (missionNamespace getVariable ['QS_vehicleHit_modified',FALSE]) then {
					_scale = 0.333;
				};
			};
		};
		if (_vehicle isKindOf 'Plane') then {
			_scale = 0.75;
			_data1 = [
				['VTOL_02_infantry_base_F',['hitrotor1','hitrotor2','hitrotor1','hitrotor2','hitrotor1','hitrotor2','hitengine','hitengine2']],
				['VTOL_01_base_F',['hitengine','hitengine2','hitlrotor','hitrrotor','hitlrotor','hitrrotor']]
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
if (
	(alive _instigator) &&
	{(isPlayer _instigator)} &&
	{(_inSafezone && _safezoneActive && (_safezoneLevel > 1))} &&
	{(_vehicle isKindOf 'Air')}
) then {
	([_instigator,'SAFE'] call QS_fnc_inZone) params ['_inSafezone2','_safezoneLevel2','_safezoneActive2'];
	if (!_inSafezone2 && (_safezoneLevel2 > 1)) then {
		if (_damage > 0.25) then {
			[player,_instigator,0.1,_instigator] call (missionNamespace getVariable 'QS_fnc_clientEventHit');
			_instigator setDamage [1,FALSE];
		};
	};
	if ((vehicle _instigator) isKindOf 'LandVehicle') then {
		_scale = 0.01;
	};
};
if (_scale > 0.05) then {
	if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
		_scale = 0.05;
	};
}; 
if (
	(_projectile isEqualTo 'FuelExplosion') &&
	{(_inSafezone && _safezoneActive)}
) exitWith {(((_damage - _oldDamage) * 0.05) + _oldDamage)};
if (_vehicle getVariable ['QS_logistics_wreck',FALSE]) then {
	_scale = 0;
	if ((crew _vehicle) isNotEqualTo []) then {
		{
			if (!unitIsUav _x) then {
				_x moveOut _vehicle;
			};
		} forEach (crew _vehicle);
	};
	if (!isNull (assignedGroup _vehicle)) then {
		if (diag_tickTime > (_vehicle getvariable ['QS_vehicle_delayGenericRX',-1])) then {
			_vehicle setvariable ['QS_vehicle_delayGenericRX',diag_ticktime + 5,FALSE];
			['leaveVehicle',assignedGroup _vehicle,_vehicle] remoteExec ['QS_fnc_remoteExecCmd',assignedGroup _vehicle,FALSE];
		};
	};
};
_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
if (_scale isEqualTo 0) exitWith {_damage};
if (
	(_vehicle isKindOf 'LandVehicle') && 
	(!(_vehicle isKindOf 'StaticWeapon'))
) then {
	if (!(_vehicle getVariable ['QS_logistics_wreck',FALSE])) then {
		_criticalHitpoints = ['hithull','hitbody','hitengine','#structural',''];
		if (
			(_hitPoint in _criticalHitpoints) ||
			{(_selectionName isEqualTo '')}
		) then {
			_damage = _damage min 0.89;
		};
		_fuelHitpoints = ['hitfuel'];
		if (_hitPoint in _fuelHitpoints) then {
			_damage = _damage min 0.5;
		};
		if ((damage _vehicle) >= 0.86) then {
			_applychance = (
				(_vehicle getVariable ['QS_logistics_applyWreckChance',FALSE]) ||
				(
					(
						(_vehicle isKindOf 'Car') ||
						(_vehicle isKindOf 'Tank')
					) &&
					(!(_vehicle isKindOf 'StaticWeapon'))
				)
			);
			if ([_vehicle,_applychance] call QS_fnc_canWreck) then {
				_vehicle setVariable ['QS_logistics_wreck',TRUE,FALSE];
				_scale = 0;
				50 cutText [localize 'STR_QS_Text_428','PLAIN',0.25,TRUE];
				_dn = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _vehicle)],
					{getText ((configOf _vehicle) >> 'displayName')},
					TRUE
				];
				[
					114,
					[
						_vehicle,
						0,
						TRUE,
						[TRUE,typeOf _vehicle,([_vehicle,typeOf _vehicle] call QS_fnc_getWreckType),(_vehicle getVariable ['QS_ST_customDN',_dn])],
						FALSE
					]
				] remoteExec ['QS_fnc_remoteExec',2];
				_damage = _damage min 0.89;
			};
		};
	};
};
if (_scale isEqualTo 0) exitWith {_damage};
if (_aircraft_crit) exitWith {
	if (_damage > 0.86) then {
		if (diag_tickTime > (missionNamespace getVariable ['QS_critHit_timeout',-1])) then {
			if (scriptDone (missionNamespace getVariable ['QS_critHit_gatekeeper',scriptNull])) then {
				QS_critHit_gatekeeper = 1 spawn {
					uiSleep _this;
					missionNamespace setVariable ['QS_critHit_timeout',diag_tickTime + 60,FALSE];
				};
			};
			if (scriptDone (missionNamespace getVariable ['QS_aircraft_critHit',scriptNull])) then {
				QS_aircraft_critHit_array = [[_selectionName,0.86]];
				QS_aircraft_critHit = [_vehicle,_source,_instigator] spawn {
					params ['_vehicle','_source','_instigator'];
					uiSleep 0.333;
					{
						_vehicle setHit [_x # 0,_x # 1,TRUE,_source,_instigator];
					} forEach QS_aircraft_critHit_array;
					QS_aircraft_critHit_array = [];
				};
			} else {
				QS_aircraft_critHit_array pushBack [_selectionName,0.89];
			};
			_vehicle setHit [(['hitfuel','fuel_hit'] select (_vehicle isKindOf 'Helicopter')),_damage,TRUE,_source,_instigator];
			_damage = _damage min 0.86;
		};
	};
	_damage;
};
_damage;