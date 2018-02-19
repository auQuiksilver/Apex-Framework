/*/
File: fn_incapacitated.sqf
Author:

	Quiksilver
	
Last modified:

	18/12/2017 A3 1.80 by Quiksilver
	
Description:

	Unit Incapacitated
_______________________________________________________________________________/*/
params ['_unit','_selectionName','_damage','_source','_projectile','_hitPartIndex','_instigator','_hitPoint'];
private [
	'_objectParent','_timeNow','_actOfGod','_iAmMedic','_chance','_randomN','_medicalTimerDelay','_medicalStartTime',
	'_revivedAtVehicle','_vehicle','_textReviveTickets','_tickTimeNow','_attachedTo','_actOfGod_delay',
	'_49Opened','_d49','_QS_buttonCtrl','_playerClassDName','_incapacitatedText','_remainingTickets','_buttonRespawnFOB',
	'_QS_buttonAction','_QS_buttonMedevac'
];
if (isPlayer _unit) then {
	if (dialog) then {
		closeDialog 0;
	};
	setCurrentChannel 5;
};
if (
	((lifeState _unit) isEqualTo 'INCAPACITATED') ||
	{(!alive _unit)}
) exitWith {};
if (!isNull (objectParent _unit)) then {
	_objectParent = objectParent _unit;
	if (
		(_objectParent isKindOf 'StaticWeapon') ||
		{(_objectParent isKindOf 'Quadbike_01_base_F')} ||
		{(_objectParent isKindOf 'Kart_01_Base_F')}
	) then {
		moveOut _unit;
		unassignVehicle _unit;
	} else {
		if (!alive _objectParent) then {
			moveOut _unit;
			unassignVehicle _unit;
			waitUntil {(isNull (objectParent _unit))};
			uiSleep 0.01;
			private _vel = velocity _objectParent;
			_unit setDir (random 360);
			_unit setVelocity [
				(_vel select 0) + ((sin (_objectParent getDir _unit)) * (3 + random 12)),
				(_vel select 1) + ((cos (_objectParent getDir _unit)) * (3 + random 12)),
				(((_vel select 2) + 1) + (random 10))
			];
			uiSleep 0.25;
		} else {
			if ((_unit isEqualTo (driver _objectParent)) || {((_objectParent isKindOf 'Air') && (_unit in [(_objectParent turretUnit [-1]),(_objectParent turretUnit [0]),(_objectParent turretUnit [1])]))}) then {
				moveOut _unit;
				unassignVehicle _unit;
			} else {
				_unit setVariable ['QS_RD_loaded',TRUE,TRUE];
				_objectParent setVariable ['QS_RD_activeCargo',TRUE,TRUE];
			};
		};
	};
};
if ((_unit getUnitTrait 'QS_trait_pilot') || {(_unit getUnitTrait 'QS_trait_fighterPilot')} || {((getTerrainHeightASL (getPosWorld _unit)) < -2)}) exitWith {
	comment 'If pilot or over water, set dead';
	_unit setDamage [1,TRUE];
	if (isPlayer _unit) then {
		['systemChat',(format ['%1 was killed',profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
};
if (!((secondaryWeapon _unit) isEqualTo '')) then {
	if ((currentWeapon _unit) isEqualTo (secondaryWeapon _unit)) then {
		_unit action ['SwitchWeapon',_unit,_unit,100];
	};
};
if (!isNull (attachedTo _unit)) then {
	detach _unit;
};
if (!((attachedObjects _unit) isEqualTo [])) then {
	{
		detach _x;
	} count (attachedObjects _unit);
};
if (!(captive _unit)) then {
	_unit setCaptive TRUE;
};
comment 'Set unconscious';
_unit setUnconscious TRUE;
comment 'Set interaction variables';
{
	_unit setVariable _x;
} forEach [
	['QS_RD_draggable',TRUE,TRUE],
	['QS_RD_carryable',TRUE,TRUE],
	['QS_RD_loadable',TRUE,TRUE],
	['QS_incapacitated_processMoveOutRequest',FALSE,FALSE],
	['QS_revive_disable',FALSE,FALSE],
	['QS_respawn_disable',-1,FALSE],
	['QS_client_medevacRequested',FALSE,FALSE]
];
_unit setDamage [0.25,TRUE];
if (isForcedWalk _unit) then {
	_unit forceWalk FALSE;
};
comment 'AI Exit';
if (!isPlayer _unit) exitWith {};
showHUD [FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE];
disableSerialization;
scopeName 'QS_main_1';
_profileName = profileName;
_timeNow = time;
_tickTimeNow = diag_tickTime;
_actOfGod = FALSE;
if (_unit getUnitTrait 'medic') then {
	_iAmMedic = TRUE;
	_chance = 0.57;
} else {
	_chance = 0.625;
	_iAmMedic = FALSE;
};
_randomN = random 1;
if (_randomN > 0.5) then {
	if (_randomN < _chance) then {
		_actOfGod = TRUE;
		_actOfGod_delay = _tickTimeNow + 25 + (random 25);
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
_sound = '';
_medevacBase = markerPos 'QS_marker_medevac_hq';
_medicalTimerDelay = 10 * 60;
_medicalStartTime = _tickTimeNow;
private _medicalTimer = _medicalStartTime + _medicalTimerDelay;
private _medevacRequested = FALSE;
_revivedAtVehicle = FALSE;
_incapacitatedText = format ['%1 was incapacitated',_profileName];
if (!isNull _instigator) then {
	if (_instigator isEqualTo _unit) then {
		_incapacitatedText = format ['%1 was incapacitated',_profileName];
	} else {
		if ((toLower (typeOf _instigator)) in ['o_sniper_f','o_ghillie_ard_f','o_ghillie_lsh_f','o_ghillie_sard_f','o_t_sniper_f','o_t_ghillie_tna_f']) then {
			_nameKiller = name _instigator;
			_incapacitatedText = format ['%1 %2',_profileName,(selectRandom [(format ['was rekt by an enemy sniper ( %1 )',_nameKiller]),(format ['was incapacitated by an enemy sniper ( %1 )',_nameKiller]),(format ['got sniped ( %1 )',_nameKiller]),(format ['was blown away by an enemy sniper ( %1 )',_nameKiller])])];
		} else {
			if (isPlayer _instigator) then {
				if ((getPlayerUID _instigator) in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
					_incapacitatedText = format ['%1 was incapacitated.',_profileName];
				} else {
					if ((side _instigator) in [EAST,RESISTANCE]) then {
						_incapacitatedText = format ['%1 was incapacitated by %2',_profileName,(name _instigator)];
					} else {
						_incapacitatedText = format ['%1 was incapacitated by %2 (Friendly fire)',_profileName,(name _instigator)];
					};
				};
			} else {
				_incapacitatedText = format ['%1 was incapacitated',_profileName];
			};
		};
	};
} else {
	_incapacitatedText = format ['%1 was incapacitated',_profileName];
};
['systemChat',_incapacitatedText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
_timeNow = time;
_tickTimeNow = diag_tickTime;
_lifeState = lifeState _unit;
_incapacitatedState = incapacitatedState _unit;
_vehicle = vehicle _unit;
_objectParent = objectParent _unit;
_attachedTo = attachedTo _unit;
_49Opened = FALSE;
_d49 = displayNull;
_QS_buttonCtrl = controlNull;
_playerClassDName = getText (configFile >> 'CfgVehicles' >> (typeOf _unit) >> 'displayName');
_QS_ctrlCreateArray = ['RscStructuredText',12345];
_display = findDisplay 46;
private _ctrlIncapacitated = _display ctrlCreate _QS_ctrlCreateArray;
_ctrlIncapacitated ctrlSetPosition [((0.0075 * safezoneW) + safezoneX),((0.01 * safezoneH) + safezoneY),1,1];
private _string1 = actionKeysNames ['InGamePause',1];
private _text1 = parseText format ['<t size="1.5" align="left">INCAPACITATED<t/><br/><t size="1" align="left">Press [%1] to respawn<br/>Bleeding out (%2)<br/>%3</t>',(_string1 select [1,((count _string1) - 2)]),([(_medicalTimer - _tickTimeNow),'MM:SS'] call (missionNamespace getVariable 'BIS_fnc_secondsToString')),([] call (missionNamespace getVariable 'QS_fnc_clientMFindHealer'))];
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
//private _clientFOBRespawnEnabled = missionNamespace getVariable 'QS_module_fob_client_respawnEnabled';
_unit setMimic 'hurt';
private _exit = FALSE;
if (!((lifeState _unit) isEqualTo 'INCAPACITATED')) exitWith {
	_unit setDamage [1,TRUE];
};
private _initialAnimSet = FALSE;
private _initialAnimDelay = _tickTimeNow + 8;
private _chatShown = shownChat;
comment 'Block shooting';
_QS_action_cockblock = _unit addAction ['   ',{},nil,-99,FALSE,TRUE,'DefaultAction','TRUE',5,TRUE,''];
comment 'Functions preload';
_fn_findHealer = missionNamespace getVariable 'QS_fnc_clientMFindHealer';
_fn_secondsToString = missionNamespace getVariable 'BIS_fnc_secondsToString';
_fn_isNearFieldHospital = missionNamespace getVariable 'QS_fnc_isNearFieldHospital';
_fn_inString = missionNamespace getVariable 'QS_fnc_inString';
comment 'Loop';
for '_x' from 0 to 1 step 0 do {
	comment 'Update useful info';
	_timeNow = time;
	_tickTimeNow = diag_tickTime;
	_lifeState = lifeState _unit;
	_incapacitatedState = incapacitatedState _unit;
	_vehicle = vehicle _unit;
	_objectParent = objectParent _unit;
	_attachedTo = attachedTo _unit;
	comment 'Display';
	_string1 = actionKeysNames ['InGamePause',1];
	_text1 = parseText format ['<t size="1.5" align="left">INCAPACITATED<t/><br/><t size="1" align="left">Press [%1] to respawn<br/>Bleeding out (%2)<br/>%3</t>',(_string1 select [1,((count _string1) - 2)]),([(_medicalTimer - _tickTimeNow),'MM:SS'] call _fn_secondsToString),(call _fn_findHealer)];
	_ctrlIncapacitated ctrlSetStructuredText ([_text1,(parseText '')] select visibleMap);
	comment 'Agony sound simulation';
	if (_tickTimeNow > _soundDelay) then {
		if (isNull _objectParent) then {
			if (isNull _attachedTo) then {
				_sound = format ['A3\Missions_F_EPA\data\sounds\WoundedGuy%1.wss',(selectRandom _sounds)];
				//_posASL = getPosASL _unit;
				_headPos = _unit modelToWorldWorld (_unit selectionPosition ['head','hitpoints']);
				//playSound3D [_sound,_unit,FALSE,[(_headPos select 0),(_headPos select 1),(_posASL select 2)],5,1,20];
				playSound3D [_sound,_unit,FALSE,_headPos,5,1,20];
			};
		};
		_soundDelay = _tickTimeNow + _soundDelayFixed + (random _soundDelayRandom);
	};
	comment 'Initial anim delay';
	if (!(_initialAnimSet)) then {
		if (_tickTimeNow > _initialAnimDelay) then {
			_initialAnimSet = TRUE;
			if (isTouchingGround _vehicle) then {
				if (isNull _attachedTo) then {
					if (isNull _objectParent) then {
						['switchMove',_unit,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						_unit switchMove 'acts_InjuredLyingRifle02';
						_unit setDir ((getDir _unit) + 180);
					};
				};
			};
		};
	};
	comment 'Respawned';
	if (!((_unit getVariable ['QS_revive_respawnType','']) isEqualTo '')) then {
		if ((_unit getVariable 'QS_revive_respawnType') isEqualTo 'FOB') then {
			missionNamespace setVariable [
				'QS_module_fob_respawnTickets',
				((missionNamespace getVariable 'QS_module_fob_respawnTickets') - 1),
				TRUE
			];
		};
		_forceRespawned = TRUE;
	};
	comment 'Revived';
	if (_lifeState in ['HEALTHY','INJURED']) then {
		if (!(_unit getVariable 'QS_incapacitated_processMoveOutRequest')) then {
			_exit = TRUE;
		};
	};
	comment 'Bled out';
	if (_tickTimeNow >= _medicalTimer) then {
		['systemChat',(format ['%1 bled out',_profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		_forceRespawned = TRUE;
	} else {
		if (!isNull _objectParent) then {
			if (alive _objectParent) then {
				if ((_objectParent isKindOf 'LandVehicle') || {(_objectParent isKindOf 'Air')} || {(_objectParent isKindOf 'Ship')}) then {
					if (!isNull (effectiveCommander _objectParent)) then {
						if (alive (effectiveCommander _objectParent)) then {
							if ((_medicalTimer - _tickTimeNow) < 30) then {
								_medicalTimer = _medicalTimer + 60;
							};
						};
					};
				};
			};
		};
		if (!isNull _attachedTo) then {
			if (alive _attachedTo) then {
				if ((_attachedTo isKindOf 'LandVehicle') || {(_attachedTo isKindOf 'Air')} || {(_attachedTo isKindOf 'Ship')}) then {
					if (!isNull (effectiveCommander _attachedTo)) then {
						if (alive (effectiveCommander _attachedTo)) then {
							if ((_medicalTimer - _tickTimeNow) < 30) then {
								_medicalTimer = _medicalTimer + 60;
							};
						};
					};
				};
			};
		};
	};
	comment 'Underwater';
	if (((getPosASL _unit) select 2) < -1.5) then {
		['systemChat',(format ['%1 drowned',_profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		_forceRespawned = TRUE;
	};
	if (_forceRespawned) exitWith {
		forceRespawn _unit;
	};
	comment 'Is at medevac HQ';
	if (((_unit distance2D _medevacBase) < 4) || {([0,_unit] call _fn_isNearFieldHospital)}) then {
		if (isNull _objectParent) then {
			if (isNull _attachedTo) then {
				if (_lifeState isEqualTo 'INCAPACITATED') then {
					if ([0,_unit] call _fn_isNearFieldHospital) then {
						if (_tickTimeNow > (_unit getVariable ['QS_client_revivedAtHospital',-1])) then {
							50 cutText ['Revived at field hospital','PLAIN DOWN',0.5];
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
			};
		};
	};
	comment 'Is in medical vehicle';
	if (!(_unit getVariable ['QS_revive_disable',FALSE])) then {
		if (!(_revivedAtVehicle)) then {
			if (!isNull _objectParent) then {
				if ((['medical',(typeOf _vehicle),FALSE] call _fn_inString) || {(['medevac',(typeOf _vehicle),FALSE] call _fn_inString)}) then {
					if (isNil {_vehicle getVariable 'QS_medicalVehicle_reviveTickets'}) then {
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
						_remainingTickets = (getNumber (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'transportSoldier')) - 1;
						_vehicle setVariable ['QS_medicalVehicle_reviveTickets',_remainingTickets,TRUE];
						_textReviveTickets = format ['%1 ( %2 ) - Revive Tickets Remaining - %3',(getText (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'displayName')),(mapGridPosition _vehicle),_remainingTickets];
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
								_textReviveTickets = format ['%1 ( %2 ) - Revive Tickets Remaining - %3',(getText (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'displayName')),(mapGridPosition _vehicle),_remainingTickets];
								['sideChat',[WEST,'BLU'],_textReviveTickets] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
							};
						};
					};
				};
			};
		};
	};
	comment 'Act of god';
	if (!(_unit getVariable ['QS_revive_disable',FALSE])) then {
		if (_actOfGod) then {
			if (_tickTimeNow > _actOfGod_delay) then {
				_actOfGod = FALSE;
				if (player getVariable ['QS_animDone',TRUE]) then {
					if ((isNull _attachedTo) && (isNull _objectParent)) then {
						_deadVehicles = allDead - allDeadMen;
						if (({((_x distance _unit) < 5)} count _deadVehicles) isEqualTo 0) then {
							if (!(((getPosASL _unit) select 2) < -1)) then {
								_text = 'Revived by an act of the gods. Praise the gods!';
								50 cutText [_text,'PLAIN DOWN',0.5];
								if (_lifeState isEqualTo 'INCAPACITATED') then {
									_unit setUnconscious FALSE;
									if (captive _unit) then {
										_unit setCaptive FALSE;
									};
								};
							};
						};
					};
				};
			};
		};
	};
	comment 'Move out handling';
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
				(_vel select 0) + ((sin (_objectParent getDir _unit)) * (3 + random 12)), 
				(_vel select 1) + ((cos (_objectParent getDir _unit)) * (3 + random 12)), 
				(((_vel select 2) + 1) + (random 9))
			];
			uiSleep 0.25;
			_unit setUnconscious TRUE;
		} else {
			if ((_unit isEqualTo (driver _objectParent)) || {((_objectParent isKindOf 'Air') && (_unit in [(_objectParent turretUnit [-1]),(_objectParent turretUnit [0]),(_objectParent turretUnit [1])]))}) then {
				_unit setVariable ['QS_incapacitated_processMoveOutRequest',TRUE,FALSE];
			} else {
				if (_unit getVariable ['QS_incapacitated_processMoveOutRequest',FALSE]) then {
					_unit setVariable ['QS_incapacitated_processMoveOutRequest',FALSE,TRUE];
					_unit setUnconscious FALSE;
					uiSleep 0.1;
					moveOut _unit;
					unassignVehicle _unit;
					uiSleep 0.1;
					_unit setVehiclePosition [(_objectParent modelToWorld (_objectParent selectionPosition ['pos cargo','memory'])),[],0,'CAN_COLLIDE'];
					uiSleep 0.01;
					_unit setVehiclePosition [(_objectParent getRelPos [((_unit distance _objectParent) + 0.5),(_objectParent getRelDir _unit)]),[],0,'CAN_COLLIDE'];
					uiSleep 0.01;
					['switchMove',_unit,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					_unit switchMove 'acts_InjuredLyingRifle02';
					uiSleep 0.1;
					_unit setUnconscious TRUE;
				};
			};
		};
	};
	comment 'Pause Menu handling';
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
					_QS_buttonCtrl ctrlSetText 'Player Menu';
					_QS_buttonCtrl ctrlSetTooltip 'Invade & Annex player menu';
					_QS_buttonAction = "[] call QS_fnc_clientMenu2";
					_QS_buttonCtrl buttonSetAction _QS_buttonAction;
					_QS_buttonCtrl ctrlCommit 0;
				};
			} forEach [16700,2];
			(_d49 displayCtrl 103) ctrlEnable FALSE;
			(_d49 displayCtrl 103) ctrlSetText 'Respawn at Base';
			(_d49 displayCtrl 103) ctrlEnable (_tickTimeNow > (_unit getVariable ['QS_respawn_disable',-1]));
			(_d49 displayCtrl 103) ctrlSetTooltip 'Respawn at the main base.';
			_QS_buttonCtrl = (_d49 displayCtrl 103);
			_QS_buttonAction = "player setVariable ['QS_revive_respawnType','BASE',FALSE];";
			_QS_buttonCtrl buttonSetAction _QS_buttonAction;
			(_d49 displayCtrl 103) ctrlCommit 0;
			_buttonRespawnFOB = _d49 displayCtrl 1010;
			_QS_buttonCtrl = _buttonRespawnFOB;
			_QS_buttonAction = "player setVariable ['QS_revive_respawnType','FOB',FALSE];";
			_QS_buttonCtrl buttonSetAction _QS_buttonAction;
			_buttonRespawnFOB ctrlSetText (format ['Respawn at FOB (%1)',(missionNamespace getVariable 'QS_module_fob_respawnTickets')]);
			_buttonRespawnFOB ctrlSetTooltip (format ['Respawn at FOB %1 (%2 tickets remaining).',(missionNamespace getVariable ['QS_module_fob_displayName','']),(missionNamespace getVariable ['QS_module_fob_respawnTickets',0])]);
			_buttonRespawnFOB ctrlEnable FALSE;
			//if (_clientFOBRespawnEnabled) then {
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
			//} else {
			//	(_d49 displayCtrl 1010) ctrlEnable FALSE;
			//};
			(_d49 displayCtrl 1010) ctrlCommit 0;
			comment 'Configure / Request Medevac option';
			_QS_buttonMedevac = (_d49 displayCtrl 101);
			_QS_buttonMedevac ctrlEnable FALSE;
			_QS_buttonMedevac ctrlSetText 'Request Medevac';
			_QS_buttonMedevac ctrlSetTooltip 'Disables Revive/Respawn and creates a Medevac mission for others to attempt.';
			_QS_buttonMedevac ctrlRemoveAllEventHandlers 'OnButtonClick';
			_QS_buttonMedevac ctrlRemoveAllEventHandlers 'OnButtonDown';
			_QS_buttonAction = 'call (missionNamespace getVariable "QS_fnc_clientRequestMedevac")';
			_QS_buttonCtrl = _QS_buttonMedevac;
			_QS_buttonCtrl buttonSetAction _QS_buttonAction;
			_QS_buttonMedevac buttonSetAction _QS_buttonAction;
			_QS_buttonMedevac ctrlCommit 0;
			(_d49 displayCtrl 122) ctrlEnable TRUE;
			(_d49 displayCtrl 122) ctrlSetText 'Field Manual';
			(_d49 displayCtrl 104) ctrlEnable FALSE;
			(_d49 displayCtrl 104) ctrlSetText 'Abort';
			(_d49 displayCtrl 104) ctrlSetTooltip 'Abort to role assignment (Respawn to enable).';
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
			comment 'Manage button availability';
			//if (_clientFOBRespawnEnabled) then {
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
			//} else {
			//	(_d49 displayCtrl 1010) ctrlEnable FALSE;
			//};
			(_d49 displayCtrl 1010) ctrlSetText (format ['Respawn at FOB (%1)',(missionNamespace getVariable 'QS_module_fob_respawnTickets')]);
			(_d49 displayCtrl 1010) ctrlCommit 0;
			_QS_buttonMedevac ctrlEnable ((!(missionNamespace getVariable ['QS_dynTask_medevac_inProgress',TRUE])) && (_tickTimeNow > (_unit getVariable ['QS_client_lastMedevacRequest',-1])) && ((lifeState _unit) isEqualTo 'INCAPACITATED') && (isNull (objectParent _unit)) && (isNull (attachedTo _unit)));
			if (_tickTimeNow > (_unit getVariable ['QS_respawn_disable',-1])) then {
				_QS_buttonMedevac ctrlSetText 'Request Medevac';
			} else {
				_QS_buttonMedevac ctrlSetText ([((_unit getVariable ['QS_respawn_disable',-1]) - _tickTimeNow),'MM:SS'] call (missionNamespace getVariable 'BIS_fnc_secondsToString'));
			};
			_QS_buttonMedevac ctrlSetTooltip (['Disables Revive/Respawn and creates a Medevac mission for others to attempt.','Medevac unavailable at this time.'] select ((missionNamespace getVariable ['QS_dynTask_medevac_inProgress',TRUE]) || {(_tickTimeNow < (_unit getVariable ['QS_client_lastMedevacRequest',-1]))}));
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

	if (_exit) exitWith {};
	uiSleep 0.035;
};
_unit removeAction _QS_action_cockblock;
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
	['QS_RD_carryable',FALSE,TRUE],
	['QS_RD_loadable',FALSE,TRUE],
	['QS_incapacitated_processMoveOutRequest',FALSE,FALSE],
	['QS_revive_disable',FALSE,TRUE],
	['QS_respawn_disable',-1,FALSE],
	['QS_client_medevacRequested',FALSE,FALSE]
];
showHUD (missionNamespace getVariable [(format ['QS_allowedHUD_%1',playerSide]),WEST]);
[29,(missionNamespace getVariable 'QS_module_fob_side')] call (missionNamespace getVariable 'QS_fnc_remoteExec');
if ((lifeState _unit) in ['HEALTHY','INJURED']) then {
	if (isNull _objectParent) then {
		['switchMove',_unit,'AmovPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	};
};