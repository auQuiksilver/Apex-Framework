/*/
File: fn_incapacitated.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Unit Incapacitated
______________________________________________/*/

params ['_unit','_selectionName','_damage','_source','_projectile','_hitPartIndex','_instigator','_hitPoint','_directHit'];
if (isPlayer _unit) then {
	if (dialog) then {
		closeDialog 2;
	};
	setCurrentChannel 5;
};
if (
	((lifeState _unit) isEqualTo 'INCAPACITATED') ||
	{(!alive _unit)}
) exitWith {};
_unit setVariable ['QS_client_downedPosition',getPosASL _unit,FALSE];
private _objectParent = objectParent _unit;
if (!isNull _objectParent) then {
	if (
		((['StaticWeapon','Quadbike_01_base_F','Kart_01_Base_F'] findIf { _objectParent isKindOf _x }) isNotEqualTo -1) ||
		{((['LSV_01_base_F','LSV_02_base_F','Offroad_01_base_F','Offroad_02_base_F'] findIf { (_objectParent isKindOf _x) && (_unit isEqualTo (gunner _objectParent)) }) isNotEqualTo -1)}
	) then {
		_unit moveOut _objectParent;
		unassignVehicle _unit;
	} else {
		if (!alive _objectParent) then {
			_unit moveOut _objectParent;
			unassignVehicle _unit;
			_t = diag_tickTime + 3;
			waitUntil {((isNull (objectParent _unit)) || (diag_tickTime > _t))};
			uiSleep 0.01;
			private _vel = velocity _objectParent;
			_unit setDir (random 360);
			_unit setVelocity (_vel vectorAdd [
				((sin (_objectParent getDir _unit)) * (3 + random 12)),
				((cos (_objectParent getDir _unit)) * (3 + random 12)),
				1 + (random 10)
			]);
			uiSleep 0.25;
		} else {
			_unit setVariable ['QS_RD_loaded',TRUE,TRUE];
		};
	};
};
if (
	(_unit getUnitTrait 'QS_trait_pilot') || 
	{(_unit getUnitTrait 'QS_trait_fighterPilot')} || 
	{(((getTerrainHeightASL (getPosWorld _unit)) < -2) && (!isTouchingGround _unit))} || 
	{((_unit getVariable ['QS_unit_side',WEST]) in [EAST,RESISTANCE,CIVILIAN])}
) exitWith {
	_unit setDamage [1,TRUE];
	if (isPlayer _unit) then {
		['systemChat',(format ['%1 %2',profileName,localize 'STR_QS_Chat_113'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
};
if ((secondaryWeapon _unit) isNotEqualTo '') then {
	if ((currentWeapon _unit) isEqualTo (secondaryWeapon _unit)) then {
		_unit action ['SwitchWeapon',_unit,_unit,100];
	};
};
if (!isNull (attachedTo _unit)) then {
	[0,_unit] call QS_fnc_eventAttach;
};
if ((attachedObjects _unit) isNotEqualTo []) then {
	{
		if (!isNull _x) then {
			[0,_x] call QS_fnc_eventAttach;
			if (
				(_x isKindOf 'CAManBase') &&
				{(alive _x)} &&
				{((lifeState _x) isEqualTo 'INCAPACITATED')} &&
				{(['carr',(animationState _x),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}
			) then {
				['switchMove',_x,['acts_InjuredLyingRifle02']] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			};
			if (local _x) then {
				_x awake TRUE;
			} else {
				['awake',_x,TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			};
		};
	} forEach (attachedObjects _unit);
};
if (!(captive _unit)) then {
	_unit setCaptive TRUE;
};
_unit setUnconscious TRUE;
private _timeNow = time;
private _serverTime = serverTime;
private _tickTimeNow = diag_tickTime;
private _medicalTimerDelay = getMissionConfigValue ['ReviveBleedOutDelay',600];
private _medicalStartTime = _tickTimeNow;
private _medicalTimer = _medicalStartTime + _medicalTimerDelay;
{
	_unit setVariable _x;
} forEach [
	['QS_revive_timeDown',_serverTime,TRUE],
	['QS_revive_timeBleedout',(_serverTime + _medicalTimerDelay),TRUE],
	['QS_RD_draggable',TRUE,TRUE],
	['QS_revive_disable',FALSE,FALSE],
	['QS_respawn_disable',-1,FALSE],
	['QS_client_medevacRequested',FALSE,FALSE]
];
_unit setDamage [0.25,TRUE];
if (isForcedWalk _unit) then {
	_unit forceWalk FALSE;
};
if (!isPlayer _unit) exitWith {};
if ((lifeState _unit) isNotEqualTo 'INCAPACITATED') exitWith {
	['systemChat',(format ['%1 %2',profileName,localize 'STR_QS_Chat_114'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	_unit setDamage [1,TRUE];
};
showHUD [FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE];
disableSerialization;
scopeName 'QS_main_1';
_profileName = profileName;
private _text = '';
private _actOfGod = FALSE;
private _chance = [0.57,0.625] select (_unit getUnitTrait 'medic');
private _randomN = random 1;
private _actOfGod_delay = -1;
if (_randomN > 0.5) then {
	if (_randomN < _chance) then {
		_actOfGod = TRUE;
		_actOfGod_delay = _tickTimeNow + 35 + (random 35);
	};
};
_sounds = [
	'A_01','A_02','A_03','A_04','A_05','A_06','A_07','A_08',
	'B_01','B_02','B_03','B_04','B_05','B_06','B_07','B_08',
	'C_01','C_02','C_03','C_04','C_05'
];
_soundDelayFixed = 5;
_soundDelayRandom = 20;
_soundDelay = _tickTimeNow + _soundDelayFixed + (random _soundDelayRandom);
_pulsingFreq = QS_hashmap_configfile getOrDefaultCall [
	'cfgfirstaid_pulsationsoundinterval',
	{getNumber (configfile >> 'cfgfirstaid' >> 'pulsationSoundInterval')},
	TRUE
];
_sound = '';
_medevacBase = markerPos 'QS_marker_medevac_hq';
private _medevacRequested = FALSE;
private _revivedAtVehicle = FALSE;
private _incapacitatedText = format ['%1 %2',_profileName,localize 'STR_QS_Chat_115'];
if (!isNull _instigator) then {
	if (_instigator isEqualTo _unit) then {
		_incapacitatedText = format ['%1 %2',_profileName,localize 'STR_QS_Chat_115'];
	} else {
		if (
			(_instigator getUnitTrait 'QS_trait_sniper') || 
			((toLowerANSI (typeOf _instigator)) in (['enemy_sniper_types_1'] call QS_data_listUnits))
		) then {
			_nameKiller = name _instigator;
			private _sniperText = selectRandom [
				localize 'STR_QS_Chat_116',
				localize 'STR_QS_Chat_117',
				localize 'STR_QS_Chat_118',
				localize 'STR_QS_Chat_119'
			];
			_incapacitatedText = format [
				'%1 %2',
				_profileName,
				(format ['%1 ( %2 )',_sniperText,_nameKiller])
			];
		} else {
			if (isPlayer _instigator) then {
				if ((getPlayerUID _instigator) in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
					_incapacitatedText = format ['%1 %2.',_profileName,localize 'STR_QS_Chat_115'];
				} else {
					if ((side _instigator) in [EAST,RESISTANCE]) then {
						_incapacitatedText = format ['%1 %3 %2',_profileName,(name _instigator),localize 'STR_QS_Chat_120'];
					} else {
						_incapacitatedText = format ['%1 %3 %2 (%4)',_profileName,(name _instigator),localize 'STR_QS_Chat_120',localize 'STR_QS_Chat_121'];
					};
				};
			} else {
				_incapacitatedText = format ['%1 %2',_profileName,localize 'STR_QS_Chat_115'];
			};
		};
		if (_instigator isEqualTo (missionNamespace getVariable ['QS_csatCommander',objNull])) then {
			_options = [
				localize 'STR_QS_Chat_122',
				localize 'STR_QS_Chat_123',
				localize 'STR_QS_Chat_124',
				localize 'STR_QS_Chat_125',
				localize 'STR_QS_Chat_126'
			];
			_incapacitatedText = format [selectRandom _options,_profileName];
		};
	};
} else {
	_incapacitatedText = format ['%1 %2',_profileName,localize 'STR_QS_Chat_115'];
};
['systemChat',_incapacitatedText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
private _textReviveTickets = '';
private _remainingTickets = 0;
_timeNow = time;
_tickTimeNow = diag_tickTime;
_lifeState = lifeState _unit;
_incapacitatedState = incapacitatedState _unit;
private _vehicle = vehicle _unit;
_objectParent = objectParent _unit;
private _attachedTo = attachedTo _unit;
_medicalBoxTypes = ['Box_UAV_06_medical_base_F','UAV_06_medical_base_F'];
_medicalBoxRadius = 5;
private _nearMedicalBoxes = [];
private _medicalBox = objNull;
private _49Opened = FALSE;
private _d49 = displayNull;
private _QS_buttonCtrl = controlNull;
private _buttonRespawnFOB = controlNull;
private _QS_buttonMedevac = controlNull;
private _QS_buttonAction = '';
private _playerClassDName = ['GET_ROLE_DISPLAYNAME',(_unit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
_QS_ctrlCreateArray = ['RscStructuredText',12345];
_display = findDisplay 46;
private _ctrlIncapacitated = _display ctrlCreate _QS_ctrlCreateArray;
_ctrlIncapacitated ctrlSetPosition [((0.0075 * safezoneW) + safezoneX),((0.01 * safezoneH) + safezoneY),1,1];
private _string1 = actionKeysNames ['InGamePause',1];
private _text1 = parseText format ['<t size="1.5" align="left">%7<t/><br/><t size="1" align="left">%5 [%1] %6<br/>%4 (%2)<br/>%3</t>',(_string1 select [1,((count _string1) - 2)]),([(_medicalTimer - _tickTimeNow),'MM:SS'] call (missionNamespace getVariable 'BIS_fnc_secondsToString')),(call (missionNamespace getVariable 'QS_fnc_clientMFindHealer')),localize 'STR_QS_Text_270',localize 'STR_QS_Menu_092',localize 'STR_QS_Text_271',localize 'STR_QS_Text_272'];
_ctrlIncapacitated ctrlSetStructuredText _text1;
_ctrlIncapacitated ctrlCommit 0;
if (isNil 'bis_revive_ppColor') then {
	bis_revive_ppColor = ppEffectCreate ['ColorCorrections',1632];
};
if (isNil 'bis_revive_ppVig') then {
	bis_revive_ppVig = ppEffectCreate ['ColorCorrections',1633];
};
if (isNil 'bis_revive_ppBlur') then {
	bis_revive_ppBlur = ppEffectCreate ['DynamicBlur',525];
};
bis_revive_ppColor ppEffectAdjust [1,1,0.15,[0.3,0.3,0.3,0],[0.3,0.3,0.3,0.3],[1,1,1,1]];
bis_revive_ppVig ppEffectAdjust [1,1,0,[0.15,0,0,1],[1.0,0.5,0.5,1],[0.587,0.199,0.114,0],[1,1,0,0,0,0.2,1]];
bis_revive_ppBlur ppEffectAdjust [0];
{
	_x ppEffectCommit 3; 
	_x ppEffectEnable TRUE; 
	_x ppEffectForceInNVG TRUE;
} forEach [bis_revive_ppColor, bis_revive_ppVig, bis_revive_ppBlur];
private _forceRespawned = FALSE;
_unit setTargetAge 'UNKNOWN';
_unit setMimic 'hurt';
private _exit = FALSE;
private _initialAnimSet = FALSE;
private _initialAnimDelay = _tickTimeNow + 8;
private _chatShown = shownChat;
private _ambulanceDelay = _tickTimeNow + 5;
private _transportSoldier = 0;
_QS_productVersion = productVersion;
_QS_missionVersion = missionNamespace getVariable ['QS_system_devBuild_text',''];
_roleSelectionSystem = missionNamespace getVariable ['QS_RSS_enabled',TRUE];
_fn_findHealer = missionNamespace getVariable 'QS_fnc_clientMFindHealer';
_fn_secondsToString = missionNamespace getVariable 'QS_fnc_secondsToString';
_fn_isNearFieldHospital = missionNamespace getVariable 'QS_fnc_isNearFieldHospital';
_fn_inString = missionNamespace getVariable 'QS_fnc_inString';
for '_x' from 0 to 1 step 0 do {
	_timeNow = time;
	_serverTime = serverTime;
	_tickTimeNow = diag_tickTime;
	_lifeState = lifeState _unit;
	_incapacitatedState = incapacitatedState _unit;
	_vehicle = vehicle _unit;
	_objectParent = objectParent _unit;
	_attachedTo = attachedTo _unit;
	_string1 = actionKeysNames ['InGamePause',1];
	_text1 = parseText format ['<t size="1.5" align="left">INCAPACITATED<t/><br/><t size="1" align="left">Press [%1] to respawn<br/>Bleeding out (%2)<br/>%3</t>',(_string1 select [1,((count _string1) - 2)]),([(_medicalTimer - _tickTimeNow),'MM:SS'] call _fn_secondsToString),(call _fn_findHealer)];
	_ctrlIncapacitated ctrlSetStructuredText ([_text1,(parseText '')] select visibleMap);
	if (_tickTimeNow > _soundDelay) then {
		if (isNull _objectParent) then {
			if (isNull _attachedTo) then {
				playSound3D [(format ['A3\Missions_F_EPA\data\sounds\WoundedGuy%1.wss',(selectRandom _sounds)]),_unit,FALSE,(_unit modelToWorldWorld (_unit selectionPosition ['head','hitpoints'])),5,1,20];
			};
		};
		_soundDelay = _tickTimeNow + _soundDelayFixed + (random _soundDelayRandom);
	};
	if (!(_initialAnimSet)) then {
		if (_tickTimeNow > _initialAnimDelay) then {
			_initialAnimSet = TRUE;
			if (
				(isTouchingGround _vehicle) &&
				{(isNull _attachedTo)} &&
				{(isNull _objectParent)}
			) then {
				['switchMove',_unit,['acts_InjuredLyingRifle02']] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];
				_unit switchMove ['acts_InjuredLyingRifle02'];
			};
		};
	};
	if ((_unit getVariable ['QS_revive_respawnType','']) isNotEqualTo '') then {
		if ((_unit getVariable 'QS_revive_respawnType') isEqualTo 'FOB') then {
			// Removed
		};
		_forceRespawned = TRUE;
	};
	if (_lifeState in ['HEALTHY','INJURED']) then {
		_exit = TRUE;
	};
	if (_tickTimeNow >= _medicalTimer) then {
		['systemChat',(format ['%1 %2',_profileName,localize 'STR_QS_Chat_127'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		_forceRespawned = TRUE;
	} else {
		if (
			(alive _objectParent) &&
			{((_objectParent isKindOf 'LandVehicle') || {(_objectParent isKindOf 'Air')} || {(_objectParent isKindOf 'Ship')})} &&
			{(alive (effectiveCommander _objectParent))} &&
			{((_medicalTimer - _tickTimeNow) < 30)}
		) then {
			_medicalTimer = _medicalTimer + 60;
		};
		if (
			(alive _attachedTo) &&
			{((_attachedTo isKindOf 'LandVehicle') || {(_attachedTo isKindOf 'Air')} || {(_attachedTo isKindOf 'Ship')})} &&
			{(alive (effectiveCommander _attachedTo))} &&
			{((_medicalTimer - _tickTimeNow) < 30)}
		) then {
			_medicalTimer = _medicalTimer + 60;
		};
	};
	if (_tickTimeNow > _ambulanceDelay) then {
		if (((getPosASL _unit) # 2) < -1.5) then {
			['systemChat',(format ['%1 %2',_profileName,localize 'STR_QS_Chat_128'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			_forceRespawned = TRUE;
		};
	};
	if (_forceRespawned) exitWith {
		forceRespawn _unit;
	};
	
	if (
		(_tickTimeNow > _ambulanceDelay) &&
		{(((_unit distance2D _medevacBase) < 4) || {([0,_unit] call _fn_isNearFieldHospital)})} &&
		{(isNull _objectParent)} &&
		{(isNull _attachedTo)} &&
		{(_lifeState isEqualTo 'INCAPACITATED')}
	) then {
		if ([0,_unit] call _fn_isNearFieldHospital) then {
			if (_tickTimeNow > (_unit getVariable ['QS_client_revivedAtHospital',-1])) then {
				50 cutText [localize 'STR_QS_Text_211','PLAIN DOWN',0.5];
				_unit setVariable ['QS_client_revivedAtHospital',(_tickTimeNow + 900),FALSE];
				_unit setUnconscious FALSE;
				if (captive _unit) then {
					_unit setCaptive FALSE;
				};
			};
		} else {
			_unit setUnconscious FALSE;
			if (captive _unit) then {
				_unit setCaptive FALSE;
			};
			[34,['ST_MEDEVAC',['Medevac Complete',(format ['%1 medevac<br/>successfully completed!',profileName])]]] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
		};
	};
	if (_tickTimeNow > _ambulanceDelay) then {
		if (!(_unit getVariable ['QS_revive_disable',FALSE])) then {
			if (!(_revivedAtVehicle)) then {
				if (!isNull _objectParent) then {
					if ((['medical',(typeOf _vehicle),FALSE] call _fn_inString) || {(['medevac',(typeOf _vehicle),FALSE] call _fn_inString)}) then {
						if (_unit isNotEqualTo (driver _vehicle)) then {
							if (_vehicle isNil 'QS_medicalVehicle_reviveTickets') then {
								_revivedAtVehicle = TRUE;
								if (_lifeState isEqualTo 'INCAPACITATED') then {
									_unit setUnconscious FALSE;
								};
								if (captive _unit) then {
									_unit setCaptive FALSE;
								};
								if (_unit getVariable ['QS_RD_loaded',FALSE]) then {
									_unit setVariable ['QS_RD_loaded',FALSE,TRUE];
								};
								_transportSoldier = QS_hashmap_configfile getOrDefaultCall [
									format ['cfgvehicles_%1_transportsoldier',toLowerANSI (typeOf _vehicle)],
									{getNumber ((configOf _vehicle) >> 'transportSoldier')},
									TRUE
								];
								_remainingTickets = _transportSoldier - 1;
								_vehicle setVariable ['QS_medicalVehicle_reviveTickets',_remainingTickets,TRUE];
								_textReviveTickets = format ['%1 ( %2 ) - %4 - %3',(getText ((configOf _vehicle) >> 'displayName')),(mapGridPosition _vehicle),_remainingTickets,localize 'STR_QS_Chat_051'];
								['sideChat',[WEST,'BLU'],_textReviveTickets] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
							} else {
								if ((_vehicle getVariable 'QS_medicalVehicle_reviveTickets') isEqualType 0) then {
									if ((_vehicle getVariable 'QS_medicalVehicle_reviveTickets') > 0) then {
										_revivedAtVehicle = TRUE;
										if (_lifeState isEqualTo 'INCAPACITATED') then {
											_unit setUnconscious FALSE;
										};
										if (captive _unit) then {
											_unit setCaptive FALSE;
										};
										if (_unit getVariable ['QS_RD_loaded',FALSE]) then {
											_unit setVariable ['QS_RD_loaded',FALSE,TRUE];
										};
										_remainingTickets = (_vehicle getVariable 'QS_medicalVehicle_reviveTickets') - 1;
										_vehicle setVariable ['QS_medicalVehicle_reviveTickets',_remainingTickets,TRUE];
										_textReviveTickets = format ['%1 ( %2 ) - %4 - %3',(getText ((configOf _vehicle) >> 'displayName')),(mapGridPosition _vehicle),_remainingTickets,localize 'STR_QS_Chat_051'];
										['sideChat',[WEST,'BLU'],_textReviveTickets] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
									};
								};
							};
						};
					};
				} else {
					if (isNull _attachedTo) then {
						_nearMedicalBoxes = (_unit nearEntities [_medicalBoxTypes,_medicalBoxRadius]) select {((!(_x getVariable ['QS_medbox_disableRevive',FALSE])) && (alive _x) && (isNull (attachedTo _x)))};
						if (_nearMedicalBoxes isNotEqualTo []) then {
							_medicalBox = _nearMedicalBoxes # 0;
							if ((vectorMagnitude (velocity _medicalBox)) < 1) then {
								if ((!(unitIsUav _medicalBox)) || {((unitIsUav _medicalBox) && (isUavConnected _medicalBox))}) then {
									deleteVehicle _medicalBox;
									_text = format ['%1 %3 %2',_profileName,(_medicalBox getVariable ['QS_ST_customDN',(getText ((configOf _medicalBox) >> 'displayName'))]),localize 'STR_QS_Chat_129'];
									['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
									_revivedAtVehicle = TRUE;
									if (_lifeState isEqualTo 'INCAPACITATED') then {
										_unit setUnconscious FALSE;
									};
								};
							};
						};
					};
				};
			};
		};
	};
	
	
	if (
		(!(_unit getVariable ['QS_revive_disable',FALSE])) &&
		{(_actOfGod)} &&
		{(_tickTimeNow > _actOfGod_delay)}
	) then {
		_actOfGod = FALSE;
		if (player getVariable ['QS_animDone',TRUE]) then {
			if ((isNull _attachedTo) && (isNull _objectParent)) then {
				_deadVehicles = allDead - allDeadMen;
				if (
					((_deadVehicles inAreaArray [_unit,5,5,0,FALSE]) isEqualTo []) &&
					{(((getPosASL _unit) # 2) > -1)} &&
					{((_unit targets [TRUE,30]) isEqualTo [])}
				) then {
					_text = localize 'STR_QS_Text_212';
					50 cutText [_text,'PLAIN DOWN',0.5];
					if (_lifeState isEqualTo 'INCAPACITATED') then {
						_unit setUnconscious FALSE;
					};
				};
			};
		};
	};
	
	
	
	if (!(_unit getVariable ['QS_revive_disable',FALSE])) then {
		if (_actOfGod) then {
			if (_tickTimeNow > _actOfGod_delay) then {
				_actOfGod = FALSE;
				if (player getVariable ['QS_animDone',TRUE]) then {
					if ((isNull _attachedTo) && (isNull _objectParent)) then {
						_deadVehicles = allDead - allDeadMen;
						if ((_deadVehicles inAreaArray [_unit,5,5,0,FALSE]) isEqualTo []) then {
							if (!(((getPosASL _unit) # 2) < -1)) then {
								if ((_unit targets [TRUE,30]) isEqualTo []) then {
									_text = localize 'STR_QS_Text_212';
									50 cutText [_text,'PLAIN DOWN',0.5];
									if (_lifeState isEqualTo 'INCAPACITATED') then {
										_unit setUnconscious FALSE;
									};
								};
							};
						};
					};
				};
			};
		};
	};
	if (!isNull _objectParent) then {
		if (!alive _objectParent) then {
			_unit setUnconscious FALSE;
			uiSleep 0.1;
			moveOut _unit;
			unassignVehicle _unit;
			waitUntil {(isNull (objectParent _unit))};
			uiSleep 0.01;
			private _vel = velocity _objectParent;
			_unit setDir (random 360);
			_unit setVelocity [
				(_vel # 0) + ((sin (_objectParent getDir _unit)) * (3 + random 12)), 
				(_vel # 1) + ((cos (_objectParent getDir _unit)) * (3 + random 12)), 
				(((_vel # 2) + 1) + (random 9))
			];
			uiSleep 0.25;
			_unit setUnconscious TRUE;
		};
	};
	if (!(_49Opened)) then {
		_d49 = findDisplay 49;
		if (!isNull _d49) then {
			if (!(isStreamFriendlyUIEnabled)) then {
				if (shownChat) then {
					showChat FALSE;
				};
			};
			_49Opened = TRUE;
			{
				_QS_buttonCtrl = _d49 displayCtrl _x;
				if (!isNull _QS_buttonCtrl) then {
					_QS_buttonCtrl ctrlSetText (localize 'STR_QS_Menu_009');
					_QS_buttonCtrl ctrlSetTooltip (format ['%1 %2 %3 %4',localize 'STR_QS_Utility_011','&',localize 'STR_QS_Utility_012',localize 'STR_QS_Menu_009']);
					_QS_buttonAction = "[] call QS_fnc_clientMenu2";
					_QS_buttonCtrl buttonSetAction _QS_buttonAction;
					_QS_buttonCtrl ctrlCommit 0;
				};
			} forEach [16700,2];
			(_d49 displayCtrl 103) ctrlEnable FALSE;
			(_d49 displayCtrl 103) ctrlSetText (localize 'STR_QS_Menu_096');
			(_d49 displayCtrl 103) ctrlEnable (_tickTimeNow > (_unit getVariable ['QS_respawn_disable',-1]));
			(_d49 displayCtrl 103) ctrlSetTooltip (localize 'STR_QS_Menu_097');
			_QS_buttonCtrl = (_d49 displayCtrl 103);
			_QS_buttonAction = "player setVariable ['QS_revive_respawnType','BASE',FALSE];";
			_QS_buttonCtrl buttonSetAction _QS_buttonAction;
			(_d49 displayCtrl 103) ctrlCommit 0;
			_buttonRespawnFOB = _d49 displayCtrl 1010;
			_QS_buttonCtrl = _buttonRespawnFOB;
			_QS_buttonAction = "player setVariable ['QS_revive_respawnType','FOB',FALSE];";
			_QS_buttonCtrl buttonSetAction _QS_buttonAction;
			//_buttonRespawnFOB ctrlSetText (format ['%2 (%1)',(missionNamespace getVariable 'QS_module_fob_respawnTickets'),localize 'STR_QS_Menu_098']);
			//_buttonRespawnFOB ctrlSetTooltip (format ['%3 %1 (%2 %4).',(missionNamespace getVariable ['QS_module_fob_displayName','']),(missionNamespace getVariable ['QS_module_fob_respawnTickets',0]),localize 'STR_QS_Menu_098',localize 'STR_QS_Menu_099']);
			_buttonRespawnFOB ctrlEnable FALSE;
			/*/
			if (player getVariable ['QS_module_fob_client_respawnEnabled',TRUE]) then {
				if (missionNamespace getVariable 'QS_module_fob_respawnEnabled') then {
					if ((missionNamespace getVariable 'QS_module_fob_respawnTickets') > 0) then {
						if (_timeNow > (missionNamespace getVariable 'QS_module_fob_client_timeLastRespawn')) then {
							if (_tickTimeNow > (_unit getVariable ['QS_respawn_disable',-1])) then {
								(_d49 displayCtrl 1010) ctrlEnable TRUE;
							} else {
								(_d49 displayCtrl 1010) ctrlEnable FALSE;
							};
						} else {
							(_d49 displayCtrl 1010) ctrlEnable FALSE;
						};
					} else {
						(_d49 displayCtrl 1010) ctrlEnable FALSE;
					};
				} else {
					(_d49 displayCtrl 1010) ctrlEnable FALSE;
				};
			} else {
				(_d49 displayCtrl 1010) ctrlEnable FALSE;
			};
			(_d49 displayCtrl 1010) ctrlCommit 0;
			/*/
			//comment 'Configure / Request Medevac option';
			_QS_buttonMedevac = (_d49 displayCtrl 101);
			_QS_buttonMedevac ctrlEnable FALSE;
			_QS_buttonMedevac ctrlSetText (localize 'STR_QS_Menu_100');
			_QS_buttonMedevac ctrlSetTooltip (localize 'STR_QS_Menu_101');
			_QS_buttonMedevac ctrlRemoveAllEventHandlers 'OnButtonClick';
			_QS_buttonMedevac ctrlRemoveAllEventHandlers 'OnButtonDown';
			_QS_buttonAction = 'call (missionNamespace getVariable "QS_fnc_clientRequestMedevac")';
			_QS_buttonCtrl = _QS_buttonMedevac;
			_QS_buttonCtrl buttonSetAction _QS_buttonAction;
			_QS_buttonMedevac buttonSetAction _QS_buttonAction;
			_QS_buttonMedevac ctrlCommit 0;
			(_d49 displayCtrl 122) ctrlEnable TRUE;
			(_d49 displayCtrl 122) ctrlSetText (localize 'STR_QS_Menu_102');
			(_d49 displayCtrl 104) ctrlEnable FALSE;
			(_d49 displayCtrl 104) ctrlSetText ([localize 'STR_QS_Menu_010',localize 'STR_QS_Menu_011'] select _roleSelectionSystem);
			(_d49 displayCtrl 104) ctrlSetTooltip ([localize 'STR_QS_Menu_012',localize 'STR_QS_Menu_013'] select _roleSelectionSystem);
			(_d49 displayCtrl 523) ctrlSetText (format ['%1',_profileName]);
			(_d49 displayCtrl 109) ctrlSetText (format ['%1',_playerClassDName]);
		};
	} else {
		_d49 = findDisplay 49;
		if (isNull _d49) then {
			if (!(isStreamFriendlyUIEnabled)) then {
				if (!(shownChat)) then {
					showChat TRUE;
				};
			};
			_49Opened = FALSE;
		} else {
			//comment 'Manage button availability';
			/*/
			if (player getVariable ['QS_module_fob_client_respawnEnabled',TRUE]) then {
				if (missionNamespace getVariable 'QS_module_fob_respawnEnabled') then {
					if ((missionNamespace getVariable 'QS_module_fob_respawnTickets') > 0) then {
						if (_timeNow > (missionNamespace getVariable 'QS_module_fob_client_timeLastRespawn')) then {
							if (_tickTimeNow > (_unit getVariable ['QS_respawn_disable',-1])) then {
								(_d49 displayCtrl 1010) ctrlEnable TRUE;
							} else {
								(_d49 displayCtrl 1010) ctrlEnable FALSE;
							};
						} else {
							(_d49 displayCtrl 1010) ctrlEnable FALSE;
						};
					} else {
						(_d49 displayCtrl 1010) ctrlEnable FALSE;
					};
				} else {
					(_d49 displayCtrl 1010) ctrlEnable FALSE;
				};
			} else {
				(_d49 displayCtrl 1010) ctrlEnable FALSE;
			};
			(_d49 displayCtrl 1010) ctrlSetText (format ['%2 (%1)',(missionNamespace getVariable 'QS_module_fob_respawnTickets'),localize 'STR_QS_Menu_098']);
			(_d49 displayCtrl 1010) ctrlCommit 0;
			/*/
			(_d49 displayCtrl 1005) ctrlSetText (format ['%1 - A3 %2',_QS_missionVersion,(format ['%1.%2',(_QS_productVersion # 2),(_QS_productVersion # 3)])]);
			(_d49 displayCtrl 1005) ctrlCommit 0;
			//_QS_buttonMedevac ctrlEnable ((!(missionNamespace getVariable ['QS_dynTask_medevac_inProgress',TRUE])) && (_tickTimeNow > (_unit getVariable ['QS_client_lastMedevacRequest',-1])) && ((lifeState _unit) isEqualTo 'INCAPACITATED') && (isNull (objectParent _unit)) && (isNull (attachedTo _unit)));
			_QS_buttonMedevac ctrlEnable FALSE;		// Some players (not all) seem to be too dumb to read the warning about unable to respawn for 10 minutes, and they end up [alt]+[f4]
			if (_tickTimeNow > (_unit getVariable ['QS_respawn_disable',-1])) then {
				_QS_buttonMedevac ctrlSetText (localize 'STR_QS_Menu_100');
			} else {
				_QS_buttonMedevac ctrlSetText ([((_unit getVariable ['QS_respawn_disable',-1]) - _tickTimeNow),'MM:SS'] call _fn_secondsToString);
			};
			_QS_buttonMedevac ctrlSetTooltip ([localize 'STR_QS_Menu_103',localize 'STR_QS_Menu_104'] select ((missionNamespace getVariable ['QS_dynTask_medevac_inProgress',TRUE]) || {(_tickTimeNow < (_unit getVariable ['QS_client_lastMedevacRequest',-1]))}));
			_QS_buttonAction = 'call (missionNamespace getVariable "QS_fnc_clientRequestMedevac");';
			_QS_buttonCtrl = _QS_buttonMedevac;
			_QS_buttonCtrl buttonSetAction _QS_buttonAction;
			_QS_buttonMedevac ctrlCommit 0;
		};
	};
	if (visibleMap) then {
		if (ctrlShown _ctrlIncapacitated) then {
			_ctrlIncapacitated ctrlShow FALSE;
		};
	} else {
		if (!(ctrlShown _ctrlIncapacitated)) then {
			_ctrlIncapacitated ctrlShow TRUE;
		};	
	};
	if (!(_medevacRequested)) then {
		if (_unit getVariable ['QS_client_medevacRequested',FALSE]) then {
			_medevacRequested = TRUE;
			_medicalTimer = _unit getVariable ['QS_respawn_disable',-1];
		};
	};
	if (!alive _unit) then {_exit = TRUE;};
	if (_exit) exitWith {};
	uiSleep 0.035;
};
if (!isNull (findDisplay 49)) then {
	(findDisplay 49) closeDisplay 2;
};
ctrlDelete _ctrlIncapacitated;
bis_revive_ppColor ppEffectAdjust [1,1,0,[1,1,1,0],[0,0,0,1],[0,0,0,0]];
bis_revive_ppVig ppEffectAdjust [1,1,0,[1,1,1,0],[0,0,0,1],[0,0,0,0]];
bis_revive_ppBlur ppEffectAdjust [0];
{
	_x ppEffectCommit 1;
} forEach [bis_revive_ppColor, bis_revive_ppVig, bis_revive_ppBlur];
uiSleep 0.1;
{
	_x ppEffectEnable FALSE;
} forEach [bis_revive_ppColor, bis_revive_ppVig, bis_revive_ppBlur];
if (!isGameFocused) then {
	playSoundUI ['beep_target',0.25,1,FALSE];
};
_unit setDamage [0,TRUE];
_unit allowDamage TRUE;
if (captive _unit) then {
	_unit setCaptive FALSE;
};
_unit setBleedingRemaining 0;
_unit setMimic 'neutral';
{
	_unit setVariable _x;
} forEach [
	['QS_RD_draggable',FALSE,TRUE],
	['QS_revive_disable',FALSE,(player getVariable ['QS_revive_disable',FALSE])],
	['QS_respawn_disable',-1,FALSE],
	['QS_client_medevacRequested',FALSE,FALSE]
];
showHUD (missionNamespace getVariable [(format ['QS_allowedHUD_%1',(player getVariable ['QS_unit_side',WEST])]),WEST]);
[29,(missionNamespace getVariable 'QS_module_fob_side')] call (missionNamespace getVariable 'QS_fnc_remoteExec');
if ((lifeState _unit) in ['HEALTHY','INJURED']) then {
	if (isNull _objectParent) then {
		['switchMove',_unit,['AmovPpneMstpSnonWnonDnon']] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	};
};