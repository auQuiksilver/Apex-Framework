/*
File: fn_clientMWounded.sqf
Author:

	Quiksilver
	
Last modified:

	24/03/2017 A3 1.68 by Quiksilver
	
Description:

	Client Wounded system
	
Note:

	OBSOLETE, superceded by QS_fnc_incapacitated
_______________________________________________________________________________*/

scopeName 'main_1';
private [
	'_v','_pos','_cw','_timerActive','_allowRespawnButtons','_dialog','_deathTimer','_waitTimer','_nearestMedic','_nm',
	'_buttonWait','_buttonSpectate','_buttonCameraMode','_buttonBlank','_buttonRespawnBASE','_buttonRespawnFOB','_bleedoutCheck',
	'_medicCheck','_medicalTimer','_spectateVar','_ui','_actOfGod','_healer','_text','_actOfGod_delay','_position','_v1','_sounds',
	'_soundDelayFixed','_soundDelayRandom','_soundDelay','_sound','_deadVehicles','_headPos','_QS_revive_injuredAnims','_medevacBase',
	'_ppCheckDelay','_medicalStartTime','_blood','_bright','_intense','_blur','_medicalTimerDelay','_timeNow','_QS_Revive_blockEscape',
	'_revivedAtVehicle','_remainingTickets','_textReviveTickets','_iAmPilot','_buttonRespawnFOBText','_iAmMedic','_chance','_randomN','_lifeState','_incapacitatedState'
];

disableSerialization;

/*/============================================= SET VARIABLES/*/

{
	player setVariable _x;
} forEach [
	['QS_revive_incapacitated',TRUE,TRUE],
	['QS_revive_waitButton',TRUE,FALSE],
	['QS_revive_waitTime',-1,FALSE],
	['QS_RD_draggable',TRUE,TRUE],
	['QS_RD_loadable',TRUE,TRUE],
	['QS_medical_spectating',FALSE],
	['QS_revive_respawnType','',FALSE]
];

/*/============================================= SET WOUNDED STATE/*/

_iAmPilot = ['pilot',(typeOf player),FALSE] call (missionNamespace getVariable 'QS_fnc_inString');
_iAmMedic = ['medic',(typeOf player),FALSE] call (missionNamespace getVariable 'QS_fnc_inString');
disableUserInput TRUE;
player allowDamage FALSE;
player setDamage 0.25;
player setBleedingRemaining 120;
player enableStamina ((player getVariable 'QS_stamina') select 0);
player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
if (!isNull (attachedTo player)) then {
	detach player;
};
if (!(captive player)) then {
	player setCaptive TRUE;
};
missionNamespace setVariable ['QS_client_spectatedUnit',player,FALSE];
showHUD [FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE];
_actOfGod = FALSE;
if (_iAmMedic) then {
	_chance = 0.57;
} else {
	_chance = 0.625;
};
_randomN = random 1;
if (_randomN > 0.5) then {
	if (_randomN < _chance) then {
		_actOfGod = TRUE;
		_actOfGod_delay = time + 25 + (random 25);
	};
};
uiSleep 0.125;
/*/QS_revive_killedVehiclePosition/*/
/*/if ((isNil {player getVariable 'QS_revive_killedVehiclePosition'}) || {((player getVariable 'QS_revive_killedVehiclePosition') isEqualTo [])} || {(alive ((player getVariable 'QS_revive_killedVehiclePosition') select 0))}) then {/*/
	_QS_revive_injuredAnims = [
		'acts_injuredlyingrifle01','acts_injuredlyingrifle02','ainjppnemstpsnonwrfldnon','ainjppnemstpsnonwnondnon','ainjpfalmstpsnonwrfldnon_carried_down',
		'unconscious','amovppnemstpsnonwnondnon','ainjpfalmstpsnonwnondnon_carried_down','unconsciousrevivedefault','unconsciousrevivedefault','unconsciousrevivedefault_a',
		'unconsciousrevivedefault_b','unconsciousrevivedefault_base','unconsciousrevivedefault_c'
	];
	['switchMove',player,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	player switchMove 'acts_InjuredLyingRifle02';
	waitUntil {
		uiSleep 0.05;
		player switchMove 'acts_InjuredLyingRifle02';
		((toLower (animationState player)) in _QS_revive_injuredAnims)
	};

	/*/============================================= SET PLAYER TO CORRECT POS/*/

	player setDir ((missionNamespace getVariable 'QS_client_killedState') select 2);
	deleteVehicle ((missionNamespace getVariable 'QS_client_killedState') select 0);
	uiSleep 0.01;
	player setPosWorld ((missionNamespace getVariable 'QS_client_killedState') select 1);
	{
		if (!isNull _x) then {
			if (local _x) exitWith {
				deleteVehicle _x;
				breakTo 'main_1';
			};
		};
	} count (nearestObjects [player,['WeaponHolderSimulated'],3,TRUE]);
/*/} else {/*/
/*
	_killedVehiclePosition = player getVariable 'QS_revive_killedVehiclePosition';
	_vKilled = _killedVehiclePosition select 0;
	_vPosition = _killedVehiclePosition select 1;
	_vIndex = _killedVehiclePosition select 2;
	if (!isNull _vKilled) then {
		if (alive _vKilled) then {
			if (_vPosition isEqualTo 'driver') then {
				player moveInDriver _vKilled;
			};
			if (_vPosition isEqualTo 'commander') then {
				player moveInCommander _vKilled;
			};
			if (_vPosition isEqualTo 'gunner') then {
				player moveInGunner _vKilled;
			};
			if (_vPosition isEqualTo 'Turret') then {
				player moveInTurret [_vKilled,_vIndex];
			};
			if (_vPosition isEqualTo 'cargo') then {
				player moveInCargo [_vKilled,_vIndex];
			};
		};
	};
	if (!isNull ((missionNamespace getVariable 'QS_client_killedState') select 0)) then {
		deleteVehicle ((missionNamespace getVariable 'QS_client_killedState') select 0);
	};
};
*/

/*/===================================== SET UP OUR CAMERA FOR OUR WOUNDED WARRIORS/*/

_position = [1,objNull] call (missionNamespace getVariable 'QS_fnc_clientMCameraMode');

/*/===================================== CREATE WOUNDED DIALOG/*/

createDialog 'QS_RD_client_dialog_menu_wounded';
_ui = uiNamespace getVariable 'QS_revive_dialog';
waitUntil {
	(!isNull (findDisplay 8000))
};
_QS_Revive_blockEscape = (findDisplay 8000) displayAddEventHandler [
	'KeyDown',
	'
		if ((_this select 1) in (actionKeys "IngamePause")) exitWith {
			if (isNull (findDisplay 8000)) then {
				createDialog "QS_RD_client_dialog_menu_wounded";
			};
			TRUE
		};
	'
];
_deathTimer = (_ui displayCtrl 1001);
_nearestMedic = (_ui displayCtrl 1002);
_buttonWait = (_ui displayCtrl 1600); 
_buttonWait ctrlEnable (!(_iAmPilot));
_buttonSpectate = (_ui displayCtrl 1601); 

if (count (units (group player)) > 1) then {
	_spectateVar = TRUE;
	_buttonSpectate ctrlEnable TRUE;
} else {
	_spectateVar = FALSE;
	_buttonSpectate ctrlEnable FALSE;
};
_buttonCameraMode = (_ui displayCtrl 1602);
_buttonCameraMode ctrlEnable TRUE;
_buttonBlank = (_ui displayCtrl 1603);
_buttonBlank ctrlEnable FALSE;
_buttonRespawnBASE = (_ui displayCtrl 1604);
_buttonRespawnBASE ctrlEnable TRUE;
_buttonRespawnFOB = (_ui displayCtrl 1605);
if (missionNamespace getVariable 'QS_module_fob_client_respawnEnabled') then {
	if (missionNamespace getVariable 'QS_module_fob_respawnEnabled') then {
		if (!(_iAmPilot)) then {
			if ((missionNamespace getVariable 'QS_module_fob_respawnTickets') > 0) then {
				if (player getVariable 'QS_revive_waitButton') then {
					if (time > (missionNamespace getVariable 'QS_module_fob_client_timeLastRespawn')) then {
						_buttonRespawnFOB ctrlEnable TRUE;
					} else {
						if (ctrlEnabled _buttonRespawnFOB) then {
							_buttonRespawnFOB ctrlEnable FALSE;
						};
					};
				} else {
					if (ctrlEnabled _buttonRespawnFOB) then {
						_buttonRespawnFOB ctrlEnable FALSE;
					};
				};
			} else {
				if (ctrlEnabled _buttonRespawnFOB) then {
					_buttonRespawnFOB ctrlEnable FALSE;
				};
			};
		} else {
			if (ctrlEnabled _buttonRespawnFOB) then {
				_buttonRespawnFOB ctrlEnable FALSE;
			};
		};
	} else {
		if (ctrlEnabled _buttonRespawnFOB) then {
			_buttonRespawnFOB ctrlEnable FALSE;
		};
	};
} else {
	if (ctrlEnabled _buttonRespawnFOB) then {
		_buttonRespawnFOB ctrlEnable FALSE;
	};
};
_buttonRespawnFOB ctrlSetText 'FOB';
_buttonRespawnFOB ctrlSetToolTip (format ['Respawn at FOB (Tickets remaining: %1)',(missionNamespace getVariable 'QS_module_fob_respawnTickets')]);
/*/================================= SET BLEED TIMER/*/

_medicalTimerDelay = 10 * 60;
_medicalStartTime = time;
_medicalTimer = _medicalStartTime + _medicalTimerDelay;
50 cutText ['','BLACK IN',1];
if (userInputDisabled) then {
	disableUserInput FALSE;
};
_v1 = vehicle player;
_revivedAtVehicle = FALSE;
_remainingTickets = -1;
_textReviveTickets = '';

/*/================================== SOUNDS/*/

_sounds = [
	'A3\Missions_F_EPA\data\sounds\WoundedGuyA_01.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyA_02.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyA_03.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyA_04.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyA_05.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyA_06.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyA_07.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyA_08.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyB_01.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyB_02.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyB_03.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyB_04.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyB_05.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyB_06.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyB_07.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyB_08.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyC_01.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyC_02.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyC_03.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyC_04.wss',
	'A3\Missions_F_EPA\data\sounds\WoundedGuyC_05.wss'
];
_soundDelayFixed = 5;
_soundDelayRandom = 20;
_soundDelay = time + _soundDelayFixed + (random _soundDelayRandom);
_sound = '';

/*/===== Medevac Base/*/

_medevacBase = markerPos 'QS_marker_medevac_hq';

/*/=============================================== LOOP/*/

for '_x' from 0 to 1 step 0 do {

	_timeNow = time;
	_lifeState = lifeState player;
	_incapacitatedState = incapacitatedState player;

	/*/=============================== SOUND/*/

	if (_timeNow > _soundDelay) then {
		if (isNull (objectParent player)) then {
			if (isNull (attachedTo player)) then {
				_sound = selectRandom _sounds;
				_posASL = getPosASL player;
				_headPos = player modelToWorld (player selectionPosition ['head','hitpoints']);
				playSound3D [_sound,player,FALSE,[(_headPos select 0),(_headPos select 1),(_posASL select 2)],5,1,20];
			};
		};
		_soundDelay = _timeNow + _soundDelayFixed + (random _soundDelayRandom);
	};

	/*/=============================== CAMERA MODE/*/

	if (!((vehicle player) isEqualTo _v1)) then {
		_v1 = vehicle player;
		if (!isNull (missionNamespace getVariable 'QS_woundedCam')) then {
			(missionNamespace getVariable 'QS_woundedCam') attachTo [_v1,_position];
		} else {
			_position = [1,(missionNamespace getVariable 'QS_woundedCam')] call (missionNamespace getVariable 'QS_fnc_clientMCameraMode');
		};
	};

	/*/================================ FIND NEAREST MEDIC/*/

	_nearestMedic ctrlSetText ([] call (missionNamespace getVariable 'QS_fnc_clientMFindHealer'));
	
	/*/================================ BLEED-OUT TIMER/*/
	
	_deathTimer ctrlSetText format ['%1 (Bleeding out)',([(_medicalTimer - _timeNow),'MM:SS'] call (missionNamespace getVariable 'QS_fnc_secondsToString'))];
	
	/*/=============================== ENSURE DIALOG STAYS THE FUCK OPEN!/*/
	
	if (isNull (findDisplay 8000)) then {
		waitUntil {
			createDialog 'QS_RD_client_dialog_menu_wounded';
			(!isNull (findDisplay 8000))
		};
		_ui = uiNamespace getVariable 'QS_revive_dialog';
		_deathTimer = (_ui displayCtrl 1001);
		_nearestMedic = (_ui displayCtrl 1002);
		_buttonWait = (_ui displayCtrl 1600); 
		_buttonWait ctrlEnable ((!(_iAmPilot)) && (player getVariable 'QS_revive_waitButton'));
		_buttonSpectate = (_ui displayCtrl 1601);
		if (count (units (group player)) > 1) then {
			_spectateVar = TRUE;
			_buttonSpectate ctrlEnable TRUE;
		} else {
			_spectateVar = FALSE;
			_buttonSpectate ctrlEnable FALSE;
		};
		_buttonCameraMode = (_ui displayCtrl 1602);
		_buttonBlank = (_ui displayCtrl 1603);
		_buttonBlank ctrlEnable FALSE;
		_buttonRespawnBASE = (_ui displayCtrl 1604);
		_buttonRespawnBASE ctrlEnable (player getVariable 'QS_revive_waitButton');
		_buttonRespawnFOB = (_ui displayCtrl 1605);
		_buttonRespawnFOB ctrlEnable FALSE;
		
		if (missionNamespace getVariable 'QS_module_fob_client_respawnEnabled') then {
			if (missionNamespace getVariable 'QS_module_fob_respawnEnabled') then {
				if (!(_iAmPilot)) then {
					if ((missionNamespace getVariable 'QS_module_fob_respawnTickets') > 0) then {
						if (player getVariable 'QS_revive_waitButton') then {
							if (time > (missionNamespace getVariable 'QS_module_fob_client_timeLastRespawn')) then {
								_buttonRespawnFOB ctrlEnable TRUE;
							} else {
								if (ctrlEnabled _buttonRespawnFOB) then {
									_buttonRespawnFOB ctrlEnable FALSE;
								};
							};
						} else {
							if (ctrlEnabled _buttonRespawnFOB) then {
								_buttonRespawnFOB ctrlEnable FALSE;
							};
						};
					} else {
						if (ctrlEnabled _buttonRespawnFOB) then {
							_buttonRespawnFOB ctrlEnable FALSE;
						};
					};
				} else {
					if (ctrlEnabled _buttonRespawnFOB) then {
						_buttonRespawnFOB ctrlEnable FALSE;
					};
				};
			} else {
				if (ctrlEnabled _buttonRespawnFOB) then {
					_buttonRespawnFOB ctrlEnable FALSE;
				};
			};
		} else {
			if (ctrlEnabled _buttonRespawnFOB) then {
				_buttonRespawnFOB ctrlEnable FALSE;
			};
		};
	};
	
	/*/================================ IF BLEED-OUT/*/
	
	if (_timeNow > _medicalTimer) exitWith {
		if (!isNull (findDisplay 8000)) then {
			(findDisplay 8000) closeDisplay 0;
		};
		if (currentChannel > 5) then {
			setCurrentChannel 5;
		};
		forceRespawn player;
	};
	
	/*/================================ IF UNDERWATER/*/
	
	if (((getPosASL player) select 2) < -1.5) then {
		if (!isNull (findDisplay 8000)) then {
			(findDisplay 8000) closeDisplay 0;
		};
		if (currentChannel > 5) then {
			setCurrentChannel 5;
		};
		forceRespawn player;
	};
	
	/*/================================ IF AT BASE MEDEVAC STATION/*/
	
	if ((player distance _medevacBase) < 3) then {
		if (isNull (objectParent player)) then {
			if (isNull (attachedTo player)) then {
				if (_lifeState isEqualTo 'INCAPACITATED') then {
					player setUnconscious FALSE;
					if (captive player) then {
						player setCaptive FALSE;
					};
				};
				player setVariable ['QS_revive_incapacitated',FALSE,TRUE];
				[34,['TaskSucceeded',['',format ['%1 Medevac Successful!',profileName]]]] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
			};
		};
	};
	
	/*/================================ CHECK PLAYER STANCE (bug mitigation)/*/
	
	if ((stance player) isEqualTo 'STAND') then {
		if (isNull (attachedTo player)) then {
			['switchMove',player,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			player switchMove 'acts_InjuredLyingRifle02';
		};
	};
	
	/*/================================ IF IN MEDICAL VEHICLE and TICKETS REMAINING/*/
	
	if (!(_revivedAtVehicle)) then {
		if (!isNull (objectParent player)) then {
			if ((['medical',(typeOf _v1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['medevac',(typeOf _v1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
				if (isNil {_v1 getVariable 'QS_medicalVehicle_reviveTickets'}) then {
					_revivedAtVehicle = TRUE;
					if (_lifeState isEqualTo 'INCAPACITATED') then {
						player setUnconscious FALSE;
					};
					player setVariable ['QS_revive_incapacitated',FALSE,TRUE];
					_remainingTickets = (getNumber (configFile >> 'CfgVehicles' >> (typeOf _v1) >> 'transportSoldier')) - 1;
					_v1 setVariable ['QS_medicalVehicle_reviveTickets',_remainingTickets,TRUE];
					_textReviveTickets = format ['%1 ( %2 ) - Revive Tickets Remaining - %3',(getText (configFile >> 'CfgVehicles' >> (typeOf _v1) >> 'displayName')),(mapGridPosition _v1),_remainingTickets];
					['sideChat',[WEST,'BLU'],_textReviveTickets] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				} else {
					if ((_v1 getVariable 'QS_medicalVehicle_reviveTickets') isEqualType 0) then {
						if ((_v1 getVariable 'QS_medicalVehicle_reviveTickets') > 0) then {
							_revivedAtVehicle = TRUE;
							if (_lifeState isEqualTo 'INCAPACITATED') then {
								player setUnconscious FALSE;
							};
							player setVariable ['QS_revive_incapacitated',FALSE,TRUE];
							_remainingTickets = (_v1 getVariable 'QS_medicalVehicle_reviveTickets') - 1;
							_v1 setVariable ['QS_medicalVehicle_reviveTickets',_remainingTickets,TRUE];
							_textReviveTickets = format ['%1 ( %2 ) - Revive Tickets Remaining - %3',(getText (configFile >> 'CfgVehicles' >> (typeOf _v1) >> 'displayName')),(mapGridPosition _v1),_remainingTickets];
							['sideChat',[WEST,'BLU'],_textReviveTickets] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
					};
				};
			};
		};
	};

	/*/================================ IF REVIVED/*/
	
	if (((!(missionNamespace getVariable 'QS_medSys')) && (!(player getVariable 'QS_revive_incapacitated'))) || {((missionNamespace getVariable 'QS_medSys') && (!(_lifeState isEqualTo 'INCAPACITATED')))}) exitWith {
		if (alive player) then {
			if (!isNull (findDisplay 8000)) then {
				(findDisplay 8000) closeDisplay 0;
			};
			if (missionNamespace getVariable 'QS_medSys') then {
				if (player getVariable 'QS_revive_incapacitated') then {
					player setVariable ['QS_revive_incapacitated',FALSE,TRUE];
				};
			};
			player setDamage 0.09;
			player enableStamina ((player getVariable 'QS_stamina') select 0);
			player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
			if (captive player) then {
				player setCaptive FALSE;
			};
			player allowDamage TRUE;
			player setVariable ['QS_RD_draggable',FALSE,TRUE];
			player setVariable ['QS_RD_loadable',FALSE,TRUE];
			player setVariable ['QS_revive_healer',nil,TRUE];
			['switchMove',player,'AmovPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
		};
	};
	
	/*/================================ IF ACT OF GOD/*/
	
	if (_actOfGod) then {
		if (_timeNow > _actOfGod_delay) then {
			if (((!(missionNamespace getVariable 'QS_medSys')) && (player getVariable 'QS_revive_incapacitated')) || ((missionNamespace getVariable 'QS_medSys') && (_lifeState isEqualTo 'INCAPACITATED'))) then {
				_actOfGod = FALSE;
				if ((isNull (attachedTo player)) && (isNull (objectParent player))) then {
					_deadVehicles = allDead - allDeadMen;
					if ((_deadVehicles findIf {((_x distance player) < 5)}) isEqualTo -1) then {
						if (!(((getPosASL player) select 2) < -1)) then {
							if ((animationState player) in _QS_revive_injuredAnims) then {
								_text = 'Revived by an act of the gods. Praise the gods!';
								50 cutText [_text,'PLAIN DOWN',1];
								if (_lifeState isEqualTo 'INCAPACITATED') then {
									player setUnconscious FALSE;
									if (captive player) then {
										player setCaptive FALSE;
									};
								};
								player setVariable ['QS_revive_incapacitated',FALSE,TRUE];
							};
						};
					};
				};
			};
		};
	};
	
	/*/================================ IF RESPAWNED/*/
	
	if (!((player getVariable 'QS_revive_respawnType') isEqualTo '')) exitWith {
		if (!isNull (findDisplay 8000)) then {
			(findDisplay 8000) closeDisplay 0;
		};
		if (currentChannel > 5) then {
			setCurrentChannel 5;
		};
		forceRespawn player;
	};
	
	/*/================================ IF DEAD/*/
	
	if ((!alive player) || {(isNull player)}) exitWith {};
	
	/*/================================ BUTTON CONTROL/*/

	if (count (units (group player)) > 1) then {
		if (!(_spectateVar)) then {
			_buttonSpectate ctrlEnable TRUE;
		};
	} else {
		if (_spectateVar) then {
			_buttonSpectate ctrlEnable FALSE;
		};
	};
	_buttonRespawnBASE ctrlEnable (player getVariable 'QS_revive_waitButton');
	if (missionNamespace getVariable 'QS_module_fob_client_respawnEnabled') then {
		if (missionNamespace getVariable 'QS_module_fob_respawnEnabled') then {
			if (!(_iAmPilot)) then {
				if ((missionNamespace getVariable 'QS_module_fob_respawnTickets') > 0) then {
					if (player getVariable 'QS_revive_waitButton') then {
						if (time > (missionNamespace getVariable 'QS_module_fob_client_timeLastRespawn')) then {
							_buttonRespawnFOB ctrlEnable TRUE;
						} else {
							if (ctrlEnabled _buttonRespawnFOB) then {
								_buttonRespawnFOB ctrlEnable FALSE;
							};
						};
					} else {
						if (ctrlEnabled _buttonRespawnFOB) then {
							_buttonRespawnFOB ctrlEnable FALSE;
						};
					};
				} else {
					if (ctrlEnabled _buttonRespawnFOB) then {
						_buttonRespawnFOB ctrlEnable FALSE;
					};
				};
			} else {
				if (ctrlEnabled _buttonRespawnFOB) then {
					_buttonRespawnFOB ctrlEnable FALSE;
				};
			};
		} else {
			if (ctrlEnabled _buttonRespawnFOB) then {
				_buttonRespawnFOB ctrlEnable FALSE;
			};
		};
	} else {
		if (ctrlEnabled _buttonRespawnFOB) then {
			_buttonRespawnFOB ctrlEnable FALSE;
		};
	};
	_buttonRespawnFOB ctrlSetToolTip (format ['Respawn at FOB (Tickets remaining: %1)',(missionNamespace getVariable 'QS_module_fob_respawnTickets')]);
	_buttonRespawnFOB ctrlSetText (format ['FOB (%1)',(missionNamespace getVariable 'QS_module_fob_respawnTickets')]);
	if (!((player getVariable 'QS_revive_waitTime') isEqualto -1)) then {
		if (_timeNow > (player getVariable 'QS_revive_waitTime')) then {
			player setVariable ['QS_revive_waitButton',TRUE,FALSE];
		};
	};
	uiSleep 0.05;
};
(findDisplay 8000) displayRemoveEventHandler ['KeyDown',_QS_Revive_blockEscape];
player setBleedingRemaining 0;
[0,(missionNamespace getVariable 'QS_woundedCam')] call (missionNamespace getVariable 'QS_fnc_clientMCameraMode');	
showHUD (missionNamespace getVariable [(format ['QS_allowedHUD_%1',playerSide]),WEST]);
[29,(missionNamespace getVariable 'QS_module_fob_side')] call (missionNamespace getVariable 'QS_fnc_remoteExec');