/*
File: fn_clientInteractUnflipVehicle.sqf
Author:

	Quiksilver

Last modified:

	16/11/2017 A3 1.76 by Quiksilver
	
Description:

	Unflip a vehicle
___________________________________________________*/

private ['_pos','_t','_engineer','_engies','_quads','_canUnflip'];
_canUnflip = TRUE;
_t = cursorTarget;
_pos = getPosATL _t;
_engineer = ['Man'];
_engies = _pos nearEntities [_engineer,10];
_v = vehicle player;
if ((!(unitIsUav _t)) && (({(alive _x)} count (crew _t)) > 0)) exitWith {
	_canUnflip = FALSE;
	50 cutText ['Crew in vehicle, unflip failed!','PLAIN DOWN',0.5];
};
if (((count _engies) < 2) && {(!((toLower (typeOf _v)) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']))}) then {
	if ((getMass _t) >= 10000) exitWith {
		_canUnflip = FALSE;
		50 cutText ['Need another person nearby to unflip this vehicle, or use a(n) CRV-6e Bobcat APC','PLAIN DOWN',1];
	};
};
if (!alive _t) exitWith {};
if (!(_canUnflip)) exitWith {};
50 cutText ['Unflipping','PLAIN DOWN',0.25];
[_t,_v] spawn {
	player allowDamage FALSE;
	params ['_t','_v'];
	private ['_pos','_t','_safePos'];
	_t = _this select 0;
	_v = _this select 1;
	if ((_t isKindOf 'LandVehicle') || {(_t isKindOf 'Reammobox_F')}) then {
		if (_v isKindOf 'Man') then {
			player playAction 'PutDown';
			uiSleep 1;
		};
		_pos = getPosATL _t;
		_dir = getDir _t;
		_safePos = _pos findEmptyPosition [0,20,(typeOf _t)];
		_t setPos [(random -1000),(random -1000),(10 + (random -1000))];
		if (!(_safePos isEqualTo [])) then {
			_t setPosATL [(_safePos select 0),(_safePos select 1),((_safePos select 2)+3)]; 
			sleep 0.1;
			if (local _t) then {
				_t setVectorUp (surfaceNormal (getPosATL _t));
			} else {
				[36,_t] remoteExecCall ['QS_fnc_remoteExec',_t,FALSE];
			};
			sleep 0.1;
			_t setPosATL [(_safePos select 0),(_safePos select 1),((_safePos select 2)+3)];
			sleep 0.1;
		} else {
			_safePos = [_pos,0,30,(sizeOf (typeOf _t)),0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
			_t setPosATL [(_safePos select 0),(_safePos select 1),((_safePos select 2)+3)]; 
			sleep 0.1;
			if (local _t) then {
				_t setVectorUp (surfaceNormal (getPosATL _t));
			} else {
				[36,_t] remoteExecCall ['QS_fnc_remoteExec',_t,FALSE];
			};
			sleep 0.1;
			_t setPosATL [(_safePos select 0),(_safePos select 1),((_safePos select 2)+3)];
			sleep 0.1;
		};
	};
	if (isNull (objectParent player)) then {
		player setDir (player getDir _t);
	};
	player allowDamage TRUE;
};