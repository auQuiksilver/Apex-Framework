/*/
File: fn_initPlayerServer.sqf
Author:

	Quiksilver
	
Last modified:

	7/10/2018 A3 1.84 by Quiksilver
	
Description:

	Init Player Server
__________________________________________________/*/

scriptName 'QS InitPlayerServer';
params ['_client','_jip','_cid','_uid','_profileName'];
if (!(missionNamespace getVariable ['QS_mission_init',FALSE])) then {
	waitUntil {
		uiSleep 0.1;
		(missionNamespace getVariable ['QS_mission_init',FALSE])
	};
};
_t = diag_tickTime + 15;
waitUntil {
	uiSleep 0.1;
	((!isNull _client) || {(diag_tickTime > _t)})
};
missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
if (!(allCurators isEqualTo [])) then {
	{
		if (!isNull (getAssignedCuratorUnit _x)) then {
			_x addCuratorEditableObjects [[_client],FALSE];
		};
	} count allCurators;
};
if (isNull _client) exitWith {};
_ii = ((missionNamespace getVariable 'QS_roboCop') findIf {((_x select 0) isEqualTo _uid)});
private _val = 0;
private _a = [_uid,_val];
if (_ii isEqualTo -1) then {
	_a = [_uid,_val];
	(missionNamespace getVariable 'QS_roboCop') pushBack _a;
} else {
	_a = (missionNamespace getVariable 'QS_roboCop') select _ii;
	_val = _a select 1;
	(missionNamespace getVariable 'QS_roboCop') set [_ii,_a];
};
if (_val > 5) exitWith {
	FALSE remoteExecCall ['disableUserInput',_cid,FALSE];
	uiSleep 0.1;
	([] call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand (format ['#exec kick %1',_cid]);
};
private _sLevel = 0;
if (_uid in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	_sLevel = 2;
};
if (_cid < 3) exitWith {
	diag_log format ['***** DEBUG ***** Invalid Client Owner: %1 *****',_cid];
};

/*/ EXTDB3 - Database - Client Registry could go here /*/

private _kicked = FALSE;
private _isCAS = FALSE;
if ((toLower (typeOf _client)) in ['b_fighter_pilot_f','b_soldier_uav_f','b_t_soldier_uav_f']) then {
	if ((missionNamespace getVariable ['QS_missionConfig_CAS',2]) in [1,3]) then {
		/*/
			EXTDB3 - Database - This is where you would check client if client is in CAS database
		/*/
		if ((toLower (typeOf _client)) in ['b_fighter_pilot_f']) then {
			if ((missionNamespace getVariable ['QS_missionConfig_CAS',2]) isEqualTo 0) then {
				_kicked = TRUE;
				FALSE remoteExecCall ['disableUserInput',_cid,FALSE];
				uiSleep 0.1;
				[[],{endMission 'QS_RD_end_8';}] remoteExec ['call',_cid,FALSE];
			} else {
				if (_uid in (['CAS'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {			/*/EXTDB3 - Database - Relevant line/*/
					_isCAS = TRUE;

					private _aircraftPool = 0;
					private _airIndex = (missionNamespace getVariable 'QS_CAS_jetAllowance') findIf {((_x select 0) isEqualTo _uid)};
					if (_airIndex isEqualTo -1) then {
						(missionNamespace getVariable 'QS_CAS_jetAllowance') pushBack [_uid,_aircraftPool];
					} else {
						_aircraftPool = ((missionNamespace getVariable 'QS_CAS_jetAllowance') select _airIndex) select 1;
					};
					if (_aircraftPool >= (missionNamespace getVariable ['QS_CAS_jetAllowance_value',3])) then {
						//comment 'No aircraft remaining in client aircraft pool';
						_kicked = TRUE;
						FALSE remoteExecCall ['disableUserInput',_cid,FALSE];
						uiSleep 0.1;
						[[],{endMission 'QS_RD_end_7';}] remoteExec ['call',_cid,FALSE];
					} else {
						//comment 'Good to go!';
						missionNamespace setVariable ['QS_fighterPilot',_client,TRUE];
					};
				} else {
					_kicked = TRUE;
					FALSE remoteExecCall ['disableUserInput',_cid,FALSE];
					uiSleep 0.1;
					[[],{endMission 'QS_RD_end_6';}] remoteExec ['call',_cid,FALSE];
				};
			};
		} else {
			//comment 'UAV Operator, let him through';
			_isCAS = TRUE;
		};
	} else {
		_isCAS = TRUE;
	};
};

// Register leaderboards stuff


_loginVal = 998;
_client setVariable ['QS_5551212',_loginVal,FALSE];
_client setVariable ['QS_ClientSupporterLevel',_sLevel,FALSE];
if (!(_kicked)) then {
	[
		[[_uid,_cid,_val,_jip],_sLevel,_loginVal,_isCAS],
		{
			missionNamespace setVariable ['QS_atClientMisc',(_this select 0),FALSE];
			player setVariable ['QS_ClientSupporterLevel',(_this select 1),FALSE];
			player setVariable ['QS_5551212',(_this select 2),FALSE];
			if ((_this select 3) isEqualType TRUE) then {
				if (player getUnitTrait 'uavhacker') then {
					player setUnitTrait ['QS_trait_cas',(_this select 3),TRUE];
				} else {
					player setUnitTrait ['QS_trait_fighterPilot',(_this select 3),TRUE];
				};
			} else {
				if (player getUnitTrait 'uavhacker') then {
					player setUnitTrait ['QS_trait_cas',FALSE,TRUE];
				} else {
					player setUnitTrait ['QS_trait_fighterPilot',FALSE,TRUE];
				};
			};
			0 spawn (missionNamespace getVariable 'QS_fnc_initPlayerLocal');
		}
	] remoteExec ['call',_cid,FALSE];
};