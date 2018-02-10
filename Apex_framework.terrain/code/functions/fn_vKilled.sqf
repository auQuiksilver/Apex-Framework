/*
File: fn_atVKilled.sqf
Author:

	Quiksilver
	
Last modified:

	1/01/2016 ArmA 3 1.54 by Quiksilver
	
Description:

	-
__________________________________________________*/
params ['_killed','_killer'];
private [
	'_killedPos','_killerPos','_i','_cid','_uid','_val','_a','_clientArray','_n','_vTypeName','_kTypeName','_vKiller','_isGunner','_driver','_delta',
	'_oldVal','_newVal'
];
if (!isNull _killer) then {
	_vKiller = vehicle _killer;
	if (isPlayer _killer) then {
		if (!((vehicle _killer) isEqualTo _killed)) then {
			if ((_killed distance (markerPos 'QS_marker_base_marker')) < 600) then {
				_vTypeName = getText (configFile >> 'CfgVehicles' >> (typeOf _killed) >> 'displayName');
				_kTypeName = getText (configFile >> 'CfgVehicles' >> (typeOf _killer) >> 'displayName');
				_isGunner = FALSE;
				if ((_vKiller distance _killed) > 15) then {
					_isGunner = TRUE;
				};
				if (!(_vKiller isKindOf 'Man')) then {
					{
						if (isPlayer _x) then {
							if (_isGunner) then {
								if (_x in [(gunner _vKiller),(commander _vKiller),(_vKiller turretUnit [0]),(_vKiller turretUnit [1])]) then {
									_n = name _x;
									_uid = getPlayerUID _x;
									_cid = owner _x;
									_val = 1;
									_i = [QS_roboCop,_uid,0] call (missionNamespace getVariable 'ZEN_fnc_arrayGetNestedIndex');
									if (_i isEqualTo -1) then {
										_a = [_uid,_val];
										0 = QS_roboCop pushBack _a;
										[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];		
									} else {
										_clientArray = QS_roboCop select _i;
										_clientVal = _clientArray select 1;
										_val = _val + _clientVal;
										_a = [_uid,_val];
										QS_roboCop set [_i,_a];
										[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
									};
								};
							} else {
								_n = name _x;
								_uid = getPlayerUID _x;
								_cid = owner _x;
								_val = 1;
								_i = [QS_roboCop,_uid,0] call (missionNamespace getVariable 'ZEN_fnc_arrayGetNestedIndex');
								if (_i isEqualTo -1) then {
									_a = [_uid,_val];
									0 = QS_roboCop pushBack _a;
									[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
								} else {
									_clientArray = QS_roboCop select _i;
									_clientVal = _clientArray select 1;
									_val = _val + _clientVal;
									_a = [_uid,_val];
									QS_roboCop set [_i,_a];
									[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
								};
							};
						};
						_killedPos = getPosWorld _killed;
						_killerPos = getPosWorld _killer;
						diag_log format ['************************ ADMIN - %1 - A %2 was destroyed by %3 - Killer - %4 - %5 - Killed - %6 - %7 ************************',time,_vTypeName,_n,_kTypeName,_killerPos,_vTypeName,_killedPos];
					} count (crew _vKiller);
				} else {
					_n = name _killer;
					_uid = getPlayerUID _killer;
					_cid = owner _killer;
					_val = 1;
					_i = [QS_roboCop,_uid,0] call (missionNamespace getVariable 'ZEN_fnc_arrayGetNestedIndex');
					if (_i isEqualTo -1) then {
						_a = [_uid,_val];
						0 = QS_roboCop pushBack _a;
						[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
					} else {
						_clientArray = QS_roboCop select _i;
						_clientVal = _clientArray select 1;
						_val = _val + _clientVal;
						_a = [_uid,_val];
						QS_roboCop set [_i,_a];
						[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
					};
					diag_log format ['************************ ADMIN - %1 - A %2 was destroyed by %3 - Killer - %4 - %5 - Killed - %6 - %7 ************************',time,_vTypeName,_n,_kTypeName,_killerPos,_vTypeName,_killedPos];
				};
			};
		};
	};
};
if (_killed isKindOf 'Helicopter') then {
	if (!isNull (driver _killed)) then {
		_driver = driver _killed;
		if ((count (crew _killed)) > 1) then {
			if (!isNil {_driver getVariable 'QS_IA_PP'}) then {
				_delta = 0;
				for '_x' from 0 to ((count (crew _killed)) - 2) step 1 do {
					_delta = _delta + 1;
				};
				_oldVal = _driver getVariable 'QS_IA_PP';
				_newVal = _oldVal - _delta;
				if (_newVal < -1) then {
					_newVal = -1;
				};
				_driver setVariable ['QS_IA_PP',_newVal,TRUE];
				0 = QS_leaderboards_session_queue pushBack ['TRANSPORT',(getPlayerUID _driver),-_delta];
			};
		};
	};
};
if ((typeOf _killed) in [
	"B_T_VTOL_01_armed_blue_F","B_T_VTOL_01_armed_F","B_T_VTOL_01_armed_olive_F",
	"B_T_VTOL_01_infantry_blue_F","B_T_VTOL_01_infantry_F","B_T_VTOL_01_infantry_olive_F",
	"B_T_VTOL_01_vehicle_blue_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_vehicle_olive_F"
]) then {
	0 = QS_garbageCollector pushBack [_killed,'DELAYED_FORCED',(time + 30)];
};