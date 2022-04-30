/*/
File: fn_clientInteractLoad.sqf
Author:

	Quiksilver
	
Last Modified:

	11/10/2017 A3 1.76 by Quiksilver
	
Description:

	-
_____________________________________________________________/*/

private _t = cursorTarget;
if ((!(_t isKindOf 'LandVehicle')) && (!(_t isKindOf 'Air')) && (!(_t isKindOf 'Ship'))) exitWith {};
_dn = getText (configFile >> 'CfgVehicles' >> (typeOf _t) >> 'displayName');
_attachedObjects = attachedObjects player;
private _isViV = FALSE;
private _obj = objNull;
private _capacity = [];
if (!(_attachedObjects isEqualTo [])) then {
	{
		_obj = _x;
		if (_obj isKindOf 'Man') then {
			if (_obj getVariable 'QS_RD_carried') then {
				for '_x' from 0 to 2 step 1 do {
					_obj setVariable ['QS_RD_carried',FALSE,TRUE];
				};
			};
			detach _obj;
			for '_x' from 0 to 2 step 1 do {
				player setVariable ['QS_RD_interacting',FALSE,TRUE];
				_obj setVariable ['QS_RD_interacting',FALSE,TRUE];
			};
		} else {
			_isViV = [_t,_obj] call (missionNamespace getVariable 'QS_fnc_isValidCargoV');
			if (([1,_obj,_t] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) || (_isViV)) then {
				for '_x' from 0 to 1 step 1 do {
					_obj setVariable ['QS_cargoObject',TRUE,TRUE];
				};
				player playAction 'released';
				detach _obj;
				if (_isViV) then {
					_t setVehicleCargo _obj;
				} else {
					0 = [71,_obj,TRUE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					_obj attachTo [_t,[0,0,-100]];
				};
				playSound3D [
					'A3\Sounds_F\sfx\ui\vehicles\vehicle_rearm.wss',
					_t,
					FALSE,
					(getPosASL _t),
					1,
					1,
					15
				];
				if (isClass (configFile >> 'CfgVehicles' >> (typeOf _t) >> 'VehicleTransport' >> 'Carrier')) then {
					50 cutText [
						(format [
							'%1 loaded into %2',
							(_obj getVariable ['QS_ST_customDN',(getText (configFile >> 'CfgVehicles' >> (typeOf _obj) >> 'displayName'))]),
							_dn
						]),
						'PLAIN DOWN',
						0.4
					];
				} else {
					_capacity = [3,_obj,_t] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams');
					50 cutText [
						(format [
							'%1 loaded into %2<br/><br/><t color="%5">Cargo capacity: %3 / %4</t>',
							(_obj getVariable ['QS_ST_customDN',(getText (configFile >> 'CfgVehicles' >> (typeOf _obj) >> 'displayName'))]),
							_dn,
							(_capacity select 0),
							(_capacity select 1),
							(["#ffffff","#ff0000"] select ((_capacity select 0) isEqualTo (_capacity select 1)))
						]),
						'PLAIN DOWN',
						([0.4,0.8] select ((_capacity select 0) isEqualTo (_capacity select 1))),
						FALSE,
						TRUE
					];
				};
			};
		};
	} forEach _attachedObjects;
};
if (_obj isKindOf 'Man') then {
	if ((unitIsUav _t) && (([_t,1] call (missionNamespace getVariable 'QS_fnc_clientInteractUGV')) > 0)) then {
		if ([_t,2,_obj] call (missionNamespace getVariable 'QS_fnc_clientInteractUGV')) then {
			for '_x' from 0 to 1 step 1 do {
				if (!isPlayer _obj) then {
					_obj setVariable ['QS_RD_escorted',FALSE,TRUE];
					_obj setVariable ['QS_RD_loaded',TRUE,TRUE];
				};
				_t setVariable ['QS_RD_activeCargo',TRUE,TRUE];
			};
			['switchMove',_obj,(['AinjPpneMstpSnonWnonDnon','acts_InjuredLyingRifle02'] select (isPlayer _obj))] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			player playAction 'released';
			50 cutText [(format ['%1 loaded into %2',(name _obj),_dn]),'PLAIN DOWN',0.3];
		} else {
			50 cutText ['Load failed','PLAIN DOWN',0.3];
		};
	} else {
		for '_x' from 0 to 1 step 1 do {
			if (!isPlayer _obj) then {
				_obj setVariable ['QS_RD_escorted',FALSE,TRUE];
				_obj setVariable ['QS_RD_loaded',TRUE,TRUE];
			};
			_t setVariable ['QS_RD_activeCargo',TRUE,TRUE];
		};
		detach _obj;
		if (local _obj) then {
			[_obj,_t] call (missionNamespace getVariable 'QS_fnc_moveInCargoMedical');
		} else {
			[3,_obj,_t] remoteExec ['QS_fnc_remoteExec',_obj,FALSE];
		};
		50 cutText [(format ['%1 loaded into %2',(name _obj),_dn]),'PLAIN DOWN',0.3];
	};
	['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
};
if (isForcedWalk player) then {
	player forceWalk FALSE;
};
TRUE;