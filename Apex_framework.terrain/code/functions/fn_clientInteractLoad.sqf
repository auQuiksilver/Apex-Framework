/*/
File: fn_clientInteractLoad.sqf
Author:

	Quiksilver
	
Last Modified:

	27/05/2023 A3 2.12 by Quiksilver
	
Description:

	-
	
Notes:

	This function should be obsoleted but it still works,
	so we dont want to do anything about it yet
_____________________________________________________________/*/

params [
	['_addaction0',nil],
	['_addaction1',nil],
	['_addaction2',nil],
	['_addaction3',nil],
	['_t',cursorTarget],
	['_obj',objNull]
];
private _result = FALSE;
if ((['LandVehicle','Ship','Air'] findIf { _t isKindOf _x }) isEqualTo -1) exitWith {_result};
_dn = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _t)],
	{getText ((configOf _t) >> 'displayName')},
	TRUE
];
_attachedObjects = (attachedObjects player) select {!isObjectHidden _x};
private _isViV = FALSE;
private _capacity = [];
if (_attachedObjects isNotEqualTo []) then {
	{
		_obj = _x;
		if (_obj isKindOf 'CAManBase') then {
			if (_obj getVariable 'QS_RD_carried') then {
				_obj setVariable ['QS_RD_carried',FALSE,TRUE];
			};
			[0,_obj] call QS_fnc_eventAttach;
			player setVariable ['QS_RD_interacting',FALSE,TRUE];
			_obj setVariable ['QS_RD_interacting',FALSE,TRUE];
		} else {
			_isViV = [_t,_obj] call (missionNamespace getVariable 'QS_fnc_isValidCargoV');
			if (
				(([1,_obj,_t] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) || (_isViV)) &&
				(!lockedInventory _t)
			) then {
				missionNamespace setVariable ['QS_targetBoundingBox_placementModeCancel',TRUE,FALSE];
				playSound3D [
					'A3\Sounds_F\sfx\ui\vehicles\vehicle_rearm.wss',
					_t,
					FALSE,
					(getPosASL _t),
					1,
					1,
					15
				];
				_obj setVariable ['QS_logistics',TRUE,TRUE];
				player playActionNow 'released';
				if (_obj getVariable ['QS_logistics_virtual',FALSE]) then {
					['SET_CLIENT',_t,_obj] call QS_fnc_virtualVehicleCargo;
				} else {
					[0,_obj] call QS_fnc_eventAttach;		// Is this wise?
					if (_isViV) then {
						_t setVehicleCargo _obj;
					} else {
						[71,_obj,TRUE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						[1,_obj,[_t,[0,0,-100]]] call QS_fnc_eventAttach;
					};
				};
				_result = TRUE;
				_dn1 = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _obj)],
					{getText ((configOf _obj) >> 'displayName')},
					TRUE
				];
				if (isClass ((configOf _t) >> 'VehicleTransport' >> 'Carrier')) then {
					50 cutText [
						(format [
							'%1 %3 %2',
							(_obj getVariable ['QS_ST_customDN',_dn1]),
							_dn,
							localize 'STR_QS_Text_114'
						]),
						'PLAIN DOWN',
						0.4
					];
				} else {
					_capacity = [3,_obj,_t] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams');
					_capacity params ['_currentCargoVolume','_cargoMaxCapacity','_currentCargoMass','_cargoMaxMass'];
					_text = format [
						'<t align="center">%6: %1 / %2<t/><br/><t align="center">%5: %3 / %4<t/>',
						round _currentCargoMass,
						round _cargoMaxMass,
						parseNumber (_currentCargoVolume toFixed 2),
						round _cargoMaxCapacity,
						localize 'STR_QS_Utility_031',
						localize 'STR_QS_Utility_032'
					];
					50 cutText [_text,'PLAIN DOWN',0.666, TRUE, TRUE];
				};
			};
		};
	} forEach _attachedObjects;
};
if (_obj isKindOf 'CAManBase') then {
	if ((unitIsUav _t) && (([_t,1] call (missionNamespace getVariable 'QS_fnc_clientInteractUGV')) > 0)) then {
		if ([_t,2,_obj] call (missionNamespace getVariable 'QS_fnc_clientInteractUGV')) then {
			if (!isPlayer _obj) then {
				_obj setVariable ['QS_RD_escorted',FALSE,TRUE];
				_obj setVariable ['QS_RD_loaded',TRUE,TRUE];
			};
			['switchMove',_obj,(['AinjPpneMstpSnonWnonDnon','acts_InjuredLyingRifle02'] select (isPlayer _obj))] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			player playAction 'released';
			50 cutText [(format ['%1 %3 %2',(name _obj),_dn,localize 'STR_QS_Text_114']),'PLAIN DOWN',0.3];
		} else {
			50 cutText [localize 'STR_QS_Text_116','PLAIN DOWN',0.3];
		};
	} else {
		if (!isPlayer _obj) then {
			_obj setVariable ['QS_RD_escorted',FALSE,TRUE];
			if (!((lifeState _obj) isEqualTo 'INCAPACITATED')) then {
				_obj setVariable ['QS_RD_loaded',TRUE,TRUE];
			};
		};
		[0,_obj] call QS_fnc_eventAttach;
		if (local _obj) then {
			[_obj,_t] call (missionNamespace getVariable 'QS_fnc_moveInCargoMedical');
		} else {
			[3,_obj,_t] remoteExec ['QS_fnc_remoteExec',_obj,FALSE];
		};
		50 cutText [(format ['%1 %3 %2',(name _obj),_dn,localize 'STR_QS_Text_114']),'PLAIN DOWN',0.3];
	};
	['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
};
if (isForcedWalk player) then {
	player forceWalk FALSE;
};
_result;