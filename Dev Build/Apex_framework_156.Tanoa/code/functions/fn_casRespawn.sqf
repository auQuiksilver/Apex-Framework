/*/
File: fn_casRespawn.sqf
Author: 

	Quiksilver
	
Last modified:

	2/09/2022 A3 2.10 by Quiksilver

Description: 

	Respawn CAS
___________________________________________________________________________/*/

if (!(alive (missionNamespace getVariable 'QS_fighterPilot'))) exitWith {};
_casJetObj = missionNamespace getVariable ['QS_casJet',objNull];
if (
	(!(canMove _casJetObj)) && 
	{((fuel _casJetObj) isEqualTo 0)} && 
	{(((getPosATL _casJetObj) # 2) < 10)} && 
	{((crew _casJetObj) isEqualTo [])} 
) then {
	_casJetObj setDamage [1,FALSE];
};
if (alive _casJetObj) exitWith {};
_missionConfig_CAS = missionNamespace getVariable ['QS_missionConfig_CAS',2];
if (_missionConfig_CAS isEqualTo 0) exitWith {};
private _exit = FALSE;
private _pool = [];
private _isCarrier = FALSE;
private _pos = [0,0,0];
private _dir = 0;
private _typeOverride = '';
private _aircraftPool = 0;
private _jetsDLC = missionNamespace getVariable ['QS_cas_JetsDLCEnabled',TRUE];
if (_missionConfig_CAS isEqualTo 1) then {
	_pool = [
		'O_Plane_CAS_02_dynamicLoadout_F',1,
		'O_Plane_Fighter_02_F',([0,1] select _jetsDLC),
		'B_Plane_Fighter_01_F',([0,2] select _jetsDLC),
		'B_Plane_CAS_01_dynamicLoadout_F',2,
		'I_Plane_Fighter_04_F',([0,1] select _jetsDLC)
	];
};
if (_missionConfig_CAS isEqualTo 2) then {
	_pool = [
		'O_Plane_CAS_02_dynamicLoadout_F',1,
		'O_Plane_Fighter_02_F',([0,1] select _jetsDLC),
		'B_Plane_Fighter_01_F',([0,2] select _jetsDLC),
		'B_Plane_CAS_01_dynamicLoadout_F',2,
		'I_Plane_Fighter_04_F',([0,1] select _jetsDLC)
	];
};
if (_missionConfig_CAS isEqualTo 3) then {
	private _pilot = missionNamespace getVariable ['QS_fighterPilot',objNull];
	_uid = getPlayerUID _pilot;
	if (_uid isEqualTo '') exitWith {_exit = TRUE;};
	private _airIndex = ((missionNamespace getVariable 'QS_CAS_jetAllowance') findIf {((_x # 0) isEqualTo _uid)});
	if (_airIndex isEqualTo -1) exitWith {_exit = TRUE;};
	diag_log format ['***** CAS RESPAWN ***** SPAWNING JET FOR %1 * %2 *****',(name _pilot),((missionNamespace getVariable 'QS_CAS_jetAllowance') # _airIndex)];
	private _aircraftPool = ((missionNamespace getVariable 'QS_CAS_jetAllowance') # _airIndex) # 1;
	if (_aircraftPool >= (missionNamespace getVariable ['QS_CAS_jetAllowance_value',3])) exitWith {
		if (isPlayer _pilot) then {
			if (_pilot getUnitTrait 'QS_trait_fighterPilot') then {
				['HANDLE',['HANDLE_REQUEST_ROLE','',(_pilot getVariable ['QS_unit_side',WEST]),'rifleman',_pilot]] call (missionNamespace getVariable 'QS_fnc_roles');
				_pilot spawn {
					moveOut _this;
					uiSleep 0.5;
					remoteExec ['QS_fnc_clientEventRespawn',_this,FALSE];
				};
			};
		};
		_exit = TRUE;
	};
	if (!(missionNamespace getVariable ['QS_casJet_destroyedAtBase',FALSE])) then {
		_aircraftPool = _aircraftPool + 1;
	};	
	if ((missionNamespace getVariable ['QS_casJet_destroyedAtBase_type','']) isNotEqualTo '') then {
		_typeOverride = missionNamespace getVariable ['QS_casJet_destroyedAtBase_type',''];
		missionNamespace setVariable ['QS_casJet_destroyedAtBase_type','',FALSE];
	};
	_pilot setVariable ['QS_client_casAllowance',_aircraftPool,[2,(owner _pilot)]];
	(missionNamespace getVariable 'QS_CAS_jetAllowance') set [_airIndex,[_uid,_aircraftPool]];
	missionNamespace setVariable ['QS_CAS_jetAllowance_current',_aircraftPool,FALSE];
	missionNamespace setVariable ['QS_casJet_destroyedAtBase',FALSE,FALSE];
	['sideChat',[WEST,'AirBase'],(format ['%3 ( %1 / %2 ) ...',_aircraftPool,(missionNamespace getVariable ['QS_CAS_jetAllowance_value',3]),localize 'STR_QS_Chat_025'])] remoteExec ['QS_fnc_remoteExecCmd',_pilot,FALSE];
	private ['_newCasType','_dir','_obstructions','_obstructionArray'];
	//comment 'Now lets decide what will spawn';
	private [
		'_playerPilot','_pilotTransportRank','_pilotLeaderboards','_pilotLeaderboardIndex','_pilotScore','_countLeaderboard',
		'_pool0','_pool1','_pool2','_pool3','_pool4'
	];
	_playerPilot = missionNamespace getVariable ['QS_fighterPilot',objNull];
	if (isNull _playerPilot) exitWith {
		_exit = TRUE;
	};
	if (!isPlayer _playerPilot) exitWith {
		_exit = TRUE;
	};
	_pool0 = [
		'O_Plane_CAS_02_dynamicLoadout_F',0,
		'O_Plane_Fighter_02_F',([0,0] select _jetsDLC),
		'O_Plane_Fighter_02_Stealth_F',([0,0] select _jetsDLC),
		'B_Plane_Fighter_01_F',([0,0] select _jetsDLC),
		'B_Plane_Fighter_01_Stealth_F',([0,0] select _jetsDLC),
		'B_Plane_CAS_01_dynamicLoadout_F',0,
		'I_Plane_Fighter_03_dynamicLoadout_F',1,
		'I_Plane_Fighter_04_F',([0,0] select _jetsDLC),
		'i_c_plane_civil_01_f',0
	];
	_pool1 = [
		'O_Plane_CAS_02_dynamicLoadout_F',1,
		'O_Plane_Fighter_02_F',([0,1] select _jetsDLC),
		'O_Plane_Fighter_02_Stealth_F',([0,1] select _jetsDLC),
		'B_Plane_Fighter_01_F',([0,1] select _jetsDLC),
		'B_Plane_Fighter_01_Stealth_F',([0,1] select _jetsDLC),
		'B_Plane_CAS_01_dynamicLoadout_F',1,
		'I_Plane_Fighter_03_dynamicLoadout_F',5,
		'I_Plane_Fighter_04_F',([0,5] select _jetsDLC),
		'i_c_plane_civil_01_f',0
	];
	_pool2 = [
		'O_Plane_CAS_02_dynamicLoadout_F',1,
		'O_Plane_Fighter_02_F',([0,1] select _jetsDLC),
		'O_Plane_Fighter_02_Stealth_F',([0,1] select _jetsDLC),
		'B_Plane_Fighter_01_F',([0,1] select _jetsDLC),
		'B_Plane_Fighter_01_Stealth_F',([0,1] select _jetsDLC),
		'B_Plane_CAS_01_dynamicLoadout_F',1,
		'I_Plane_Fighter_03_dynamicLoadout_F',1,
		'I_Plane_Fighter_04_F',([0,1] select _jetsDLC),
		'i_c_plane_civil_01_f',0
	];
	_pool3 = [
		'O_Plane_CAS_02_dynamicLoadout_F',3,
		'O_Plane_Fighter_02_F',([0,3] select _jetsDLC),
		'O_Plane_Fighter_02_Stealth_F',([0,1] select _jetsDLC),
		'B_Plane_Fighter_01_F',([0,3] select _jetsDLC),
		'B_Plane_Fighter_01_Stealth_F',([0,1] select _jetsDLC),
		'B_Plane_CAS_01_dynamicLoadout_F',3,
		'I_Plane_Fighter_03_dynamicLoadout_F',0,
		'I_Plane_Fighter_04_F',([0,2] select _jetsDLC),
		'i_c_plane_civil_01_f',0
	];
	_pool4 = [
		'O_Plane_CAS_02_dynamicLoadout_F',5,
		'O_Plane_Fighter_02_F',([0,5] select _jetsDLC),
		'O_Plane_Fighter_02_Stealth_F',([0,1] select _jetsDLC),
		'B_Plane_Fighter_01_F',([0,5] select _jetsDLC),
		'B_Plane_Fighter_01_Stealth_F',([0,1] select _jetsDLC),
		'B_Plane_CAS_01_dynamicLoadout_F',5,
		'I_Plane_Fighter_03_dynamicLoadout_F',0,
		'I_Plane_Fighter_04_F',([0,1] select _jetsDLC),
		'i_c_plane_civil_01_f',0
	];
	private _pilotLeaderboards = QS_leaderboards2 toArray FALSE;
	_pilotLeaderboards append (QS_leaderboards3 toArray FALSE);
	_pilotLeaderboards = _pilotLeaderboards apply {
		[
			(_x # 1) # 1,			// getting transport pilot list
			(_x # 0),
			(_x # 1) # 0
		]
	};
	_pilotLeaderboards = _pilotLeaderboards select {((_x # 0) >= 10)};
	_pilotLeaderboards sort FALSE;
	_countLeaderboard = count _pilotLeaderboards;
	_pilotLeaderboardIndex = (_pilotLeaderboards findIf {((_x # 1) isEqualTo _uid)});
	if (_pilotLeaderboardIndex isNotEqualTo -1) then {
		_pilotTransportRank = _pilotLeaderboardIndex + 1;
		_pilotScore = (_pilotLeaderboards # _pilotLeaderboardIndex) # 0;
		_pilotRankCoef = 1 - (_pilotTransportRank / _countLeaderboard);
		if (_pilotScore >= 10) then {
			if (_pilotRankCoef > 0.5) then {
				if (_pilotRankCoef > 0.75) then {
					if (_pilotRankCoef > 0.9) then {
						_pool = _pool4;
					} else {
						_pool = _pool3;
					};
				} else {
					_pool = _pool2;
				};
			} else {
				_pool = _pool1;
			};
		} else {
			_pool = _pool0;
		};
	} else {
		_pool = _pool0;
	};
};
if (_exit) exitWith {};
_newCasType = selectRandomWeighted _pool;
if (_typeOverride isNotEqualTo '') then {
	_newCasType = _typeOverride;
};
if ((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0) then {
	if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
		if (worldName isEqualTo 'Altis') then {
			_pos = [14453.5,16278.9,0.1];
			_dir = 210.788;
		};
		if (worldName isEqualTo 'Tanoa') then {
			_pos = [6848.31,7267.26,0.1];
			_dir = 37.3149;
		};
		if (worldName isEqualTo 'Malden') then {
			_pos = [8068.67,10002.2,0.395561];
			_dir = 358.366;
		};
		if (worldName isEqualTo 'Enoch') then {
			_pos = [4321.49,10505,0.3];
			_dir = 314.899;		
		};
		if (worldName isEqualTo 'Stratis') then {
			_pos = [1913.38,5955.01,0.1];
			_dir = 237.56;
		};
	} else {
		_pos = markerPos ['QS_marker_casJet_spawn',TRUE];
		_dir = markerDir 'QS_marker_casJet_spawn';
	};
	[_pos,15,20,50] call (missionNamespace getVariable 'QS_fnc_clearPosition');
} else {
	_newCasType = 'B_Plane_Fighter_01_F';
	_isCarrier = TRUE;
	_pos = ((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-30.228,82.3711,25.7758]);
	_dir = ((getDir (missionNamespace getVariable 'QS_carrierObject')) - -90.623);
};
[_pos,_dir,_newCasType,_isCarrier] spawn {
	params ['_pos','_dir','_newCasType','_isCarrier'];
	uiSleep 0.01;
	missionNamespace setVariable ['QS_casJet',(createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _newCasType,_newCasType],[-500,-500,100],[],0,'CAN_COLLIDE']),TRUE];
	private _casJet = missionNamespace getVariable 'QS_casJet';
	_casJet setDir _dir;
	if (_isCarrier) then {
		_casJet animateSource ['wing_fold_r',1,TRUE];
		_casJet animateSource ['wing_fold_l',1,TRUE];
		_casJet setPosWorld _pos;
		_casJet setVelocity [0,0,0];
	} else {
		_casJet setPos _pos;
	};
	_casJet setVariable ['QS_casJet_ownerUID',(getPlayerUID (missionNamespace getVariable 'QS_fighterPilot')),FALSE];
	_casJet disableTIEquipment TRUE;
	_casJet flyInHeight 500;
	_casJet flyInHeightASL [500,500,500];
	_casJet lock 0;
	_casJet setVehicleReportRemoteTargets FALSE;
	_casJet setVehicleReceiveRemoteTargets (!(missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]));
	_casJet setVehicleReportOwnPosition (!(missionNamespace getVariable ['QS_virtualSectors_sub_1_active',FALSE]));
	[_casJet,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
	_casJet addEventHandler [
		'Killed',
		{
			params ['_jet'];
			_text = [localize 'STR_QS_Chat_026',localize 'STR_QS_Chat_027'] select (((getPosATL _jet) # 2) > 20);
			[[WEST,'AirBase'],_text] remoteExec ['sideChat',-2,FALSE];
			([_jet,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
			if (_inSafezone && _safezoneActive) then {
				missionNamespace setVariable ['QS_casJet_destroyedAtBase',TRUE,FALSE];
				missionNamespace setVariable ['QS_casJet_destroyedAtBase_type',(typeOf _jet),FALSE];
			} else {
				if ((missionNamespace getVariable ['QS_missionConfig_CAS',2]) isEqualTo 3) then {
					if ((missionNamespace getVariable ['QS_CAS_jetAllowance_current',0]) >= (missionNamespace getVariable ['QS_CAS_jetAllowance_value',3])) then {
						missionNamespace setVariable ['QS_CAS_jetAllowance_gameover',TRUE,FALSE];
					};
				};
			};
			(missionNamespace getVariable 'QS_garbageCollector') pushBack [_jet,'NOW_DISCREET',0];
		}
	];
	_casJet addEventHandler [
		'Deleted',
		{
			params ['_entity'];
		}
	];
	_casJet allowDamage FALSE;
	_casJet enableRopeAttach FALSE;
	_casJet enableVehicleCargo FALSE;
	_casJet addEventHandler [
		'GetIn',
		{
			(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
			if (!simulationEnabled (_this # 0)) then {
				(_this # 0) enableSimulationGlobal TRUE;
			};
			(_this # 0) allowDamage TRUE;
		}
	];
	['setFeatureType',_casJet,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_casJet];
	if ((toLowerANSI (typeOf _casJet)) in ['c_plane_civil_01_racing_f','c_plane_civil_01_f','i_c_plane_civil_01_f']) then {
		[_casJet] call (missionNamespace getVariable 'QS_fnc_Q51');
	};
	if (_casJet isKindOf 'I_Plane_Fighter_03_dynamicLoadout_F') then {
		_casJet removeWeapon 'missiles_SCALPEL';
	};
	if (_casJet isKindOf 'B_Plane_CAS_01_dynamicLoadout_F') then {
		_casJet removeWeapon 'Missile_AGM_02_Plane_CAS_01_F';
	};
	if (_casJet isKindOf 'O_Plane_CAS_02_dynamicLoadout_F') then {
		_casJet removeWeapon 'Missile_AGM_01_Plane_CAS_02_F';
	};
	if ((toLowerANSI _newCasType) in ['o_plane_fighter_02_f','o_plane_fighter_02_stealth_f']) then {
		{
			_casJet setObjectTextureGlobal _x;
		} forEach [
			[0,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_01_Blue_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_02_Blue_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_02\data\Fighter_02_fuselage_01_Blue_co.paa"],
			[3,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_02_co.paa"],
			[4,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_00_co.paa"],
			[5,"a3\air_f_jets\plane_fighter_02\data\Numbers\Fighter_02_number_01_co.paa"]
		];
	};
	if ((toLowerANSI _newCasType) in ['i_plane_fighter_04_f']) then {
		{
			_casJet setObjectTextureGlobal _x;
		} forEach [
			[0,"a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_01_co.paa"],
			[1,"a3\air_f_jets\plane_fighter_04\data\Fighter_04_fuselage_02_co.paa"],
			[2,"a3\air_f_jets\plane_fighter_04\data\fighter_04_misc_01_co.paa"],
			[3,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_04_ca.paa"],
			[4,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_04_ca.paa"],
			[5,"a3\air_f_jets\plane_fighter_04\data\Numbers\Fighter_04_number_08_ca.paa"]
		];	
	};
};