/*/
File: fn_clientInteractSensorTarget.sqf
Author:

	Quiksilver
	
Last Modified:

	7/9/2018 A3 1.84 by Quiksilver
	
Description:

	Remote Sensors / Datalink Interaction
_____________________________________________________________/*/

_cursorObject = cursorObject;
if (isNull _cursorObject) exitWith {};
if (!alive _cursorObject) exitWith {
	50 cutText [localize 'STR_QS_Text_138','PLAIN DOWN',0.25];
};
if ((!(_cursorObject isKindOf 'LandVehicle')) && (!(_cursorObject isKindOf 'Air')) && (!(_cursorObject isKindOf 'Ship')) && (!(_cursorObject isKindOf 'StaticWeapon'))) exitWith {
	50 cutText [localize 'STR_QS_Text_139','PLAIN DOWN',0.25];
};
if (((crew _cursorObject) findIf {(alive _x)}) isEqualTo -1) exitWith {
	50 cutText [localize 'STR_QS_Text_140','PLAIN DOWN',0.25];
};
if (_cursorObject isSensorTargetConfirmed (player getVariable ['QS_unit_side',WEST])) exitWith {
	50 cutText [localize 'STR_QS_Text_141','PLAIN DOWN',0.45];
};
if (_cursorObject in ([(listRemoteTargets (player getVariable ['QS_unit_side',WEST])),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets'))) exitWith {
	50 cutText [localize 'STR_QS_Text_142','PLAIN DOWN',0.45];
};
if (_cursorObject getVariable ['QS_remoteTarget_reported',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_142','PLAIN DOWN',0.45];
};
if (_cursorObject getVariable ['QS_reportTarget_disable',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_143','PLAIN DOWN',0.45];
};
if (uiNamespace getVariable ['QS_client_progressVisualization_active',FALSE]) exitWith {};
_onCancelled = {
	params ['_cursorObject'];
	private _c = FALSE;
	if (!alive player) then {
		_c = TRUE;
	};
	if (!((lifeState player) in ['HEALTHY','INJURED'])) then {
		_c = TRUE;
	};
	if (cursorObject isNotEqualTo _cursorObject) then {
		_c = TRUE;
	};
	if (!alive _cursorObject) then {
		_c = TRUE;
	};
	if (_cursorObject in ([(listRemoteTargets (player getVariable ['QS_unit_side',WEST])),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets'))) then {
		_c = TRUE;
	};
	_c;
};
_onCompleted = {
	params ['_cursorObject'];
	if (player getUnitTrait 'QS_trait_JTAC') then {
		if (alive (player getVariable ['QS_client_jtac_sensorTarget',objNull])) then {
			['confirmSensorTarget',(player getVariable ['QS_client_jtac_sensorTarget',objNull]),[(player getVariable ['QS_unit_side',WEST]),TRUE]] remoteExec ['QS_fnc_remoteExecCmd',(player getVariable ['QS_unit_side',WEST]),FALSE];
			(player getVariable 'QS_client_jtac_sensorTarget') confirmSensorTarget [(player getVariable ['QS_unit_side',WEST]),FALSE];
			['reportRemoteTarget',(player getVariable ['QS_unit_side',WEST]),[(player getVariable 'QS_client_jtac_sensorTarget'),360]] remoteExec ['QS_fnc_remoteExecCmd',(player getVariable ['QS_unit_side',WEST]),FALSE];
			(player getVariable ['QS_unit_side',WEST]) reportRemoteTarget [(player getVariable 'QS_client_jtac_sensorTarget'),360];
		};
		if ((!(_cursorObject in ([(listRemoteTargets (player getVariable ['QS_unit_side',WEST])),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets')))) && (!(_cursorObject getVariable ['QS_remoteTarget_reported',FALSE]))) then {
			['confirmSensorTarget',_cursorObject,[(player getVariable ['QS_unit_side',WEST]),TRUE]] remoteExec ['QS_fnc_remoteExecCmd',(player getVariable ['QS_unit_side',WEST]),FALSE];
			_cursorObject confirmSensorTarget [(player getVariable ['QS_unit_side',WEST]),TRUE];
			_cursorObject setVariable ['QS_remoteTarget_reported',TRUE,TRUE];
			['reportRemoteTarget',(player getVariable ['QS_unit_side',WEST]),[_cursorObject,360]] remoteExec ['QS_fnc_remoteExecCmd',(player getVariable ['QS_unit_side',WEST]),FALSE];
			(player getVariable ['QS_unit_side',WEST]) reportRemoteTarget [_cursorObject,360];
			player setVariable ['QS_client_jtac_sensorTarget',_cursorObject,FALSE];
			50 cutText [localize 'STR_QS_Text_144','PLAIN DOWN',0.3];
			playSound 'beep_target';
			_displayName = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cursorObject)],
				{getText ((configOf _cursorObject) >> 'displayName')},
				TRUE
			];
			['sideChat',[WEST,'BLU'],(format ['%1 %4 %2 %5 %3 %6',profileName,_displayName,(mapGridPosition _cursorObject),localize 'STR_QS_Chat_036',localize 'STR_QS_Hints_060',localize 'STR_QS_Chat_037'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			[77,'FIRE_SUPPORT',[_cursorObject,profileName],FALSE] remoteExec ['QS_fnc_remoteExec',2];
		} else {
			50 cutText [localize 'STR_QS_Text_142','PLAIN DOWN',0.3];
		};
	} else {
		if ((!(_cursorObject in ([(listRemoteTargets (player getVariable ['QS_unit_side',WEST])),0] call (missionNamespace getVariable 'QS_fnc_listRemoteTargets')))) && (!(_cursorObject getVariable ['QS_remoteTarget_reported',FALSE]))) then {
			['reportRemoteTarget',(player getVariable ['QS_unit_side',WEST]),[_cursorObject,180]] remoteExec ['QS_fnc_remoteExecCmd',(player getVariable ['QS_unit_side',WEST]),FALSE];
			(player getVariable ['QS_unit_side',WEST]) reportRemoteTarget [_cursorObject,180];
			_cursorObject setVariable ['QS_remoteTarget_reported',TRUE,TRUE];
			50 cutText [localize 'STR_QS_Text_144','PLAIN DOWN',0.3];
			playSound 'beep_target';
		} else {
			50 cutText [localize 'STR_QS_Text_142','PLAIN DOWN',0.3];
		};	
	};
};
private _time = [6,3] select (player getUnitTrait 'QS_trait_JTAC');
_time = _time + ([2,3] select ((_cursorObject animationSourcePhase 'showcamonethull') isEqualTo 1));
playSound 'clickSoft';
[
	localize 'STR_QS_Menu_169',
	_time,
	0,
	[[],{FALSE}],
	[[_cursorObject],_onCancelled],
	[[_cursorObject],_onCompleted],
	[[],{FALSE}]
] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');