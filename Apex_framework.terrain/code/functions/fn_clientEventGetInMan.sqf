/*
File: fn_clientEventGetInMan.sqf
Author:

	Quiksilver
	
Last modified:

	01/05/2023 A3 2.12 by Quiksilver
	
Description:

	-
__________________________________________________*/

params ['_unit','_position','_vehicle','_turretPath'];
if (!simulationEnabled _vehicle) then {
	_vehicle enableSimulation TRUE;
};
if (_vehicle getVariable ['QS_logistics_wreck',FALSE]) then {
	_unit moveOut _vehicle;
};
if (local _vehicle) then {
	if (_vehicle isKindOf 'LandVehicle') then {
		[_vehicle,TRUE,TRUE] call QS_fnc_updateCenterOfMass;
	};
};
if (_unit getVariable ['QS_toggle_visibleLaser',FALSE]) then {
	_unit setVariable ['QS_toggle_visibleLaser',FALSE,TRUE];
};
localNamespace setVariable ['QS_service_cancelled',TRUE];
_vehicle allowCrewInImmobile [TRUE,TRUE];
_vehicleToken = getPlayerUID _unit;
if (
	(_vehicle isKindOf 'VTOL_Base_F') &&
	{(_position isEqualTo 'driver')}
) then {
	_vehicle spawn {
		private _vehicle = _this;
		for '_i' from 0 to 1 step 0 do {
			if ((vehicle player) isNotEqualTo _vehicle) exitWith {};
			doStop player;
			sleep 10;
		};
	};
};
if (_vehicle isKindOf 'Mortar_01_base_F') then {
	[_unit,_vehicle] spawn {
		params ['_unit','_vehicle'];
		sleep 1;
		if (_vehicle isEqualTo (objectParent _unit)) then {
			['switchMove',_unit,'mortar_gunner'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		};
	};
};
player setVariable ['QS_RD_crewIndicator_show',TRUE,FALSE];
// Reset cruise control
if (local _vehicle) then {
	if (_position isEqualTo 'driver') then {
		_profilePlateNumber = profileNamespace getVariable ['QS_apexFramework_plateNumber',''];
		if (
			(_profilePlateNumber isEqualType '') &&
			{(_profilePlateNumber isNotEqualTo '')} &&
			{((count _profilePlateNumber) <= 15)}
		) then {
			if ((getPlateNumber _vehicle) isNotEqualTo _profilePlateNumber) then {
				['setPlateNumber',_vehicle,_profilePlateNumber] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			};
		} else {
			if ((getPlateNumber _vehicle) isNotEqualTo (groupId (group _unit))) then {
				['setPlateNumber',_vehicle,(groupId (group _unit))] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			};
		};
	};
	_vehicle allowCrewInImmobile [TRUE,TRUE];
	if (
		(!((getCruiseControl _vehicle) # 1)) && 
		{(((getCruiseControl _vehicle) # 0) > 0)}
	) then {
		_vehicle setCruiseControl [0,FALSE];
	};
};
if (_vehicle isKindOf 'Air') then {
	_transportSoldier = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_transportsoldier',toLowerANSI (typeOf _vehicle)],
		{getNumber ((configOf _vehicle) >> 'transportSoldier')},
		TRUE
	];
	if (
		(_position isEqualTo 'driver') &&
		{(_transportSoldier isNotEqualTo 0)} &&
		{(player getUnitTrait 'QS_trait_pilot')}
	) then {
		player setVariable ['QS_pilot_vehicleInfo',[_vehicle,['driver']],TRUE];
	};
};
_simulation = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _vehicle)],
	{toLowerANSI (getText ((configOf _vehicle) >> 'simulation'))},
	TRUE
];
if (
	((ropeAttachedObjects _vehicle) isNotEqualTo []) &&
	{(((['MODE20',_vehicle] call QS_fnc_simplePull) findAny ['PULL']) isNotEqualTo -1)}
) then {
	['MODE17'] call QS_fnc_simplePull;
};
if (
	(isNull (ropeAttachedTo _vehicle)) &&
	{(!isNull (getTowParent _vehicle))}
) then {
	_vehicle setTowParent objNull;
};
_supportTypes = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_availableforsupporttypes',toLowerANSI (typeOf _vehicle)],
	{((getArray ((configOf _vehicle) >> 'availableForSupportTypes')) apply {toLowerANSI _x})},
	TRUE
];
[1,_vehicle] call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandlers');
if (player getUnitTrait 'QS_trait_fighterPilot') then {
	if (_vehicle isKindOf 'Air') then {
		if (_position in ['driver','gunner']) then {
			private _isCAS = FALSE;
			if (_supportTypes isNotEqualTo []) then {
				{
					if (['CAS',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) exitWith {
						_isCAS = TRUE;
					};
				} forEach _supportTypes;
			};
			if (_isCAS) then {
				if (isNil {uiNamespace getVariable 'QS_pilotROE_msg'}) then {
					uiNamespace setVariable ['QS_pilotROE_msg',TRUE];
					// This will broadcast CAS ROE to pilots on entry to CAS Jet
					
					0 spawn {
						uiSleep 5;
						(localize 'STR_QS_Hints_229') hintC [
							(localize 'STR_QS_Hints_230'),
							(localize 'STR_QS_Hints_231'),
							(localize 'STR_QS_Hints_232'),
							(localize 'STR_QS_Hints_233'),
							(localize 'STR_QS_Hints_234'),
							(localize 'STR_QS_Hints_235'),
							(localize 'STR_QS_Hints_236'),
							(localize 'STR_QS_Hints_237')
						];
					};
					
				};
			};
		};
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_artyEngine',1]) isEqualTo 1) then {
	if (
		(_vehicle isEqualTo (missionNamespace getVariable ['QS_arty',objNull])) ||
		(
			(_vehicle isKindOf 'StaticMortar') && 
			(_unit getUnitTrait 'QS_trait_gunner')
		)
	) then {
		enableEngineArtillery TRUE;
	};
};
if (_position isEqualTo 'gunner') then {
	private _isArty = FALSE;
	if (_supportTypes isNotEqualTo []) then {
		{
			if (['artillery',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) exitWith {
				_isArty = TRUE;
			};
		} forEach _supportTypes;
	};
	if (
		_isArty ||
		{(_vehicle isKindOf 'StaticMortar')}
	) then {
		if (diag_tickTime > (uiNamespace getVariable ['QS_fireSupport_lastMsg',(diag_tickTime - 1)])) then {
			uiNamespace setVariable ['QS_fireSupport_lastMsg',(diag_tickTime + 300)];
			[63,[4,['FIRESUPPORT_1',['',localize 'STR_QS_Notif_154']]]] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
			_dn = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _vehicle)],
				{getText ((configOf _vehicle) >> 'displayName')},
				TRUE
			];
			['sideChat',[WEST,'AirBase'],(format [localize 'STR_QS_Chat_165',_dn,profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
};
if (_position isEqualTo 'driver') then {
	if (_vehicle isKindOf 'Offroad_01_Base_F') then {
		if (uiNamespace getVariable ['QS_uiaction_turbo',FALSE]) then {
			_texturedata = '';
			_selectionsTextures = [];
			{
				_selectionsTextures pushBack (parseNumber (_x # 1));
			} forEach [
				['#(argb,8,8,3)color(0,0,0,0.6)','754'],
				['#(argb,8,8,3)color(0,0,0,0.6)','65'],
				['#(argb,8,8,3)color(0,0,0,0.6)','840'],
				['#(argb,8,8,3)color(0,0,0,0.6)','1980'],
				['#(argb,8,8,3)color(0,0,0,0.6)','561'],
				['#(argb,8,8,3)color(0,0,0,0.6)','76']
			];
			reverse _selectionsTextures;
			{
				_texturedata = _texturedata + (format ['%1',_x]);
			} forEach _selectionsTextures;
			if (_vehicleToken isEqualTo _texturedata) then {
				_defaultTextures = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_texturecustom',toLowerANSI (typeOf _vehicle)],
					{(getArray ((configOf _vehicle) >> 'TextureSources' >> 'ParkRanger' >> 'textures'))},
					TRUE
				];
				{ 
					_vehicle setObjectTextureGlobal [_forEachIndex,_x]; 
				} forEach _defaultTextures;
				_vehicle animateDoor ['HideCover',1];
				_vehicle animateSource ['HideAntennas',1];
			};
		};
	};
};
if (
	(_vehicle isKindOf 'Heli_Light_01_unarmed_base_F') &&
	(_position isEqualTo 'driver')
) then {
	QS_hummingbird_benchAction = player addAction [localize 'STR_QS_Interact_128',{['INTERACT',cameraOn,FALSE] call QS_fnc_clientInteractMH9Stealth},nil,0,FALSE,TRUE,'','(["CONDITION",cameraOn] call QS_fnc_clientInteractMH9Stealth)'];
};
if (
	(_position isEqualTo 'driver') &&
	{(!(_vehicle in (assignedVehicles (group QS_player))))} &&
	{((assignedGroup _vehicle) isNotEqualTo (group QS_player))}
) then {
	['addVehicle',group QS_player,_vehicle] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
};