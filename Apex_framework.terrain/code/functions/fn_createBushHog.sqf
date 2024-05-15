/*/
File: fn_createBushHog.sqf
Author:

	Quiksilver
	
Last modified:

	28/04/2023 A3 2.12 by Quiksilver
	
Description:

	Bush Hog
__________________________________________/*/

params ['_vehicle'];
if (!(_vehicle isKindOf 'B_APC_Wheeled_01_cannon_F')) exitWith {FALSE};
if (!(local _vehicle)) exitWith {};
_vehicle animateSource ['HideTurret',1];
_vehicle animateSource ['ShowSlatHull',1];
_vehicle enableVehicleCargo FALSE;
_vehicle lockTurret [[0],TRUE];
_vehicle lockTurret [[0,0],TRUE];
private _obj = objNull;
private _attachedArray = [];
{
	_obj = createVehicle [_x # 0,[0,0,0]];
	_obj allowDamage FALSE;
	[1,_obj,[_vehicle,_x # 1]] call QS_fnc_eventAttach;
	_obj setDir (_x # 2);
	if (_obj isKindOf 'StaticWeapon') then {
		_obj setVariable ['QS_curator_disableEditability',TRUE,TRUE];
		_obj setVariable ['QS_interaction_disabled',TRUE,TRUE];
		_obj enableWeaponDisassembly FALSE;
		_obj setVariable ['QS_ST_customDN','',TRUE];
		if (_obj isKindOf 'AT_01_base_F') then {
			for '_i' from 0 to 15 step 1 do {
				_obj addMagazineTurret ['1Rnd_GAT_missiles',[0]];
			};
			for '_i' from 0 to 19 step 1 do {
				_obj addMagazineTurret ['1Rnd_GAA_missiles',[0]];
			};
		} else {
			_obj setTurretLimits [[0],-56,+56,-10,90];
			_obj addWeaponTurret ['LMG_coax',[0]];
			for '_i' from 0 to 5 step 1 do {
				_obj addMagazineTurret ['1000Rnd_762x51_Belt_T_Yellow',[0]];
			};
		};
		_obj addEventHandler [
			'GetOut',
			{
				params ["_vehicle", "_role", "_unit", "_turret"];
				_parent = attachedTo _vehicle;
				if (alive _parent) then {
					if ((_parent emptyPositions 'Cargo') > 0) then {
						_unit setVariable ['QS_moveToTurret_cooldown',diag_tickTime + 3];
						[
							[_vehicle,_unit,_parent],
							{
								params ['_vehicle','_unit','_parent'];
								waitUntil {
									_unit moveOut _vehicle;
									(!(_unit in _vehicle))
								};
								_vehicle removeAllEventHandlers 'IncomingMissile';
								_unit assignAsCargo _parent;
								_unit moveInCargo _parent;
							}
						] remoteExec ['spawn',_unit,FALSE];
					};
				};
			}
		];
		_obj addEventHandler [
			'IncomingMissile',
			{
				params ["_target","_ammo","_vehicle","_instigator","_missile"];
				[_target,FALSE] remoteExec ['allowDamage',_vehicle];
				[_missile,objNull] remoteExec ['setMissileTarget',_vehicle];
			}
		];
	};
	_attachedArray pushBack _obj;
} forEach [
	['Land_SandbagBarricade_01_half_F',[1.6,-0.8,0.5],90],
	['Land_SandbagBarricade_01_half_F',[1.6,-3.25,0.5],90],
	['Land_SandbagBarricade_01_F',[0,0.75,1.1],0],
	['Land_SandbagBarricade_01_F',[0,-4.75,1.1],0],
	['Land_SandbagBarricade_01_F',[-1.6,-3.25,1.1],270],
	['Land_SandbagBarricade_01_F',[-1.6,-1,1.1],270],
	['Land_WoodenShelter_01_F',[0,-2,1.5],270],
	['B_HMG_01_high_F',[0,-1,1.6],90],
	['B_HMG_01_high_F',[0,-3.5,1.6],90],
	['B_static_AT_F',[0,-2,1.3],90]
];
{
	_vehicle setVariable _x;
} forEach [
	['QS_attachedObjects',_attachedArray,FALSE],
	['QS_ST_customDN',localize 'STR_QS_Text_462',TRUE],
	['QS_ST_showDisplayName',TRUE,TRUE],
	['QS_disableRespawnAction',TRUE,TRUE]
];
{
	_x moveOut _vehicle;
} forEach (crew _vehicle);
{
	_vehicle addEventHandler _x;
} forEach [
	[
		'GetIn',
		{
			params ["_vehicle", "_role", "_unit", "_turret"];
			if (_role isEqualTo 'cargo') then {
				if (diag_ticktime < (_unit getVariable ['QS_moveToTurret_cooldown',-1])) exitWith {};
				_attachedTurrets = (attachedObjects _vehicle) select { ((_x isKindOf 'StaticWeapon') && ((_x emptyPositions 'Gunner') > 0)) };
				if (_attachedTurrets isNotEqualTo []) then {
					_attachedTurret = selectRandom _attachedTurrets;
					[
						[_vehicle,_unit,_attachedTurret],
						{
							params ['_vehicle','_unit','_attachedTurret'];
							waitUntil {
								_unit moveOut _vehicle;
								(!(_unit in _vehicle))
							};
							_unit assignAsGunner _attachedTurret;
							_unit moveInGunner _attachedTurret;
							_attachedTurret enableWeaponDisassembly FALSE;
							_attachedTurret allowDamage FALSE;
							_attachedTurret removeAllEventHandlers 'IncomingMissile';
							_attachedTurret addEventHandler [
								'IncomingMissile',
								{
									params ["_target","_ammo","_vehicle","_instigator","_missile"];
									if (!local _target) exitWith {};
									if (isDedicated) then {
										[_missile,objNull] remoteExec ['setMissileTarget',_vehicle];
									};
									_missile spawn {
										sleep (1 + (random 1));
										_this setDamage [1,TRUE];
										triggerAmmo _this;
									};
								}
							];
						}
					] remoteExec ['spawn',_unit,FALSE];
				};
			};
			if (_role isEqualTo 'driver') then {
				[
					[_vehicle],
					{
						params ['_vehicle'];
						QS_INCMISS_EH = _vehicle addEventHandler [
							'IncomingMissile',
							{
								params ["_target","_ammo","_vehicle","_instigator","_missile"];
								if (!local _target) exitWith {};
								if (isDedicated) then {
									[_missile,objNull] remoteExec ['setMissileTarget',_vehicle];
								};
								_missile spawn {
									sleep (1 + (random 1));
									_this setDamage [1,TRUE];
									triggerAmmo _this;
								};
							}
						];
						_vehicle addEventHandler [
							'GetOut',
							{
								params ["_vehicle", "_role", "_unit", "_turret"];
								if (_unit isEqualTo player) then {
									_vehicle removeEventHandler [_thisEvent,_thisEventHandler];
									_vehicle removeEventHandler ['IncomingMissile',QS_INCMISS_EH];
								};
							}
						];
					}
				] remoteExec ['call',_unit,FALSE];
			};
		}
	],
	[
		'IncomingMissile',
		{
			params ["_target","_ammo","_vehicle","_instigator","_missile"];
			if (isDedicated) then {
				[_missile,objNull] remoteExec ['setMissileTarget',_vehicle];
			};
		}
	],
	[
		'Local',
		{
			params ['_vehicle'];
			_attached = attachedObjects _vehicle;
			if (isDedicated) then {
				{
					[_x,FALSE] remoteExec ['allowDamage',_vehicle];
				} forEach _attached;
			};
		}
	],
	[
		'Deleted',
		{
			params ['_vehicle'];
			{
				[0,_x] call QS_fnc_eventAttach;
				deleteVehicle _x;
			} count (attachedObjects _vehicle);
		}
	],
	[
		'Killed',
		{
			params ['_killed'];
			deleteVehicle ((_killed getVariable ['QS_attachedObjects',[]]) + (attachedObjects _killed));
		}
	]
];