/*/
File: fn_clientInteractCarrierLaunch.sqf
Author:

	Quiksilver
	
Last modified:

	10/04/2018 A3 1.82 by Quiksilver
	
Description:
	
	Carrier Launch handling
___________________________________________________/*/

_cameraOn = cameraOn;
_cameraOnPos = getPosWorld _cameraOn;
private _isUAV = unitIsUav _cameraOn;
private _launcherData = [];
private _launcherPolygon = [];
private _deflectorSelection = '';
private _carrierObjectSegmentType = '';
private _launchPosData = [];
private _launchPos = [];
private _launchDir = -1;
private _carrierParts = [];
private _carrierPart = objNull;
if (!(_cameraOn getVariable ['QS_carrier_launch',FALSE])) then {
	{
		_launcherData = _x;
		_launcherPolygon = _launcherData select 0;
		_launcherPolygon = _launcherPolygon apply { ((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld _x) };
		if (_cameraOnPos inPolygon _launcherPolygon) exitWith {
			if (_isUAV) then {
				_launchPosData = _launcherData select 5;
			} else {
				_launchPosData = _launcherData select 4;
			};
			_carrierObjectSegmentType = _launcherData select 1;
			_deflectorSelection = _launcherData select 2;
			_launchPos = (missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld (_launchPosData select 1);
			_launchDir = ((getDir (missionNamespace getVariable 'QS_carrierObject')) - (_launchPosData select 2));
		};
	} forEach (call (missionNamespace getVariable 'QS_data_carrierLaunch'));
	if (!(_launchPos isEqualTo [])) then {
		_carrierParts = nearestObjects [_launchPos,[_carrierObjectSegmentType],100,TRUE];
		if (!(_carrierParts isEqualTo [])) then {
			_carrierPart = _carrierParts select 0;
			_carrierPart animateSource [_deflectorSelection,10,7.5];
			playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_Flaps_Up.wss',objNull,FALSE,(_carrierPart modelToWorldWorld (_carrierPart selectionPosition _deflectorSelection)),25,1,75];
			_cameraOn setVariable ['QS_vehicle_carrierAnimData',[_carrierPart,[_deflectorSelection,0,7.5]],TRUE];
			[83,1,_cameraOn] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
		_cameraOn setVelocity [0,0,0];
		_cameraOn allowDamage FALSE;
		_cameraOn setPosWorld _launchPos;
		_cameraOn setDir _launchDir;
		_cameraOn setVelocity [0,0,0];
		_cameraOn allowDamage TRUE;
		[_cameraOn,(missionNamespace getVariable 'QS_carrierObject'),TRUE] call (missionNamespace getVariable 'BIS_fnc_attachToRelative');
		if (!(_cameraOn getVariable ['QS_carrier_launch',FALSE])) then {
			_cameraOn setVariable ['QS_carrier_launch',TRUE,TRUE];
		} else {
			_cameraOn setVariable ['QS_carrier_launch',FALSE,TRUE];
		};
		_launchCancel = {
			params ['_actionTarget','_actionCaller','_actionID','_actionArguments'];
			_actionArguments params ['_cameraOn'];
			if (!isEngineOn _cameraOn) exitWith {
				50 cutText ['Engine must be ON to launch','PLAIN',0.5];
			};
			if (_cameraOn getVariable ['QS_carrier_launch',FALSE]) then {
				_cameraOn setAirplaneThrottle 0;
				detach _cameraOn;
				_cameraOn setPosWorld (getPosWorld _cameraOn);
				_cameraOn setVectorUp [0,0,1];
				_cameraOn setVariable ['QS_carrier_launch',FALSE,TRUE];
				_carrierAnimData = _cameraOn getVariable ['QS_vehicle_carrierAnimData',[]];
				if (!(_carrierAnimData isEqualTo [])) then {
					(_carrierAnimData select 0) animateSource (_carrierAnimData select 1);
					playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_Flaps_Down.wss',objNull,FALSE,((_carrierAnimData select 0) modelToWorldWorld ((_carrierAnimData select 0) selectionPosition ((_carrierAnimData select 1) select 0))),25,1,75];
				};
				[83,0,_cameraOn] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				50 cutText ['Launch Cancelled','PLAIN DOWN',0.75];
			};
			_cameraOn removeAction _actionID;
			missionNamespace setVariable ['QS_client_action_carrierLaunchCancel',[],FALSE];
		};
		_launchCancelAction = _cameraOn addAction ['Cancel',_launchCancel,[_cameraOn],0,FALSE,TRUE,'','TRUE',-1,FALSE,''];
		_cameraOn setUserActionText [_launchCancelAction,((_cameraOn actionParams _launchCancelAction) select 0),(format ["<t size='3'>%1</t>",((_cameraOn actionParams _launchCancelAction) select 0)])];
		missionNamespace setVariable ['QS_client_action_carrierLaunchCancel',[_cameraOn,_launchCancelAction],FALSE];
	};
} else {
	detach _cameraOn;
	_cameraOn setAirplaneThrottle 1;
	[_cameraOn,(getDir _cameraOn)] call (missionNamespace getVariable 'BIS_fnc_AircraftCatapultLaunch');
	_cameraOn setVariable ['QS_carrier_launch',FALSE,TRUE];
	_cameraOn spawn {
		uiSleep 5;
		if (diag_tickTime > (uiNamespace getVariable ['QS_fighterPilot_lastMsg',(diag_tickTime - 1)])) then {
			uiNamespace setVariable ['QS_fighterPilot_lastMsg',(diag_tickTime + 300)];
			[63,[4,['CAS_1',['','Close Air Support online!']]]] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
			['sideChat',[WEST,'AirBase'],(format ['Close Air Support (%1) is available. Pilot: %2',(getText (configFile >> 'CfgVehicles' >> (typeOf _this) >> 'displayName')),profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
		_carrierAnimData = _this getVariable ['QS_vehicle_carrierAnimData',[]];
		if (!(_carrierAnimData isEqualTo [])) then {
			(_carrierAnimData select 0) animateSource (_carrierAnimData select 1);
			playSound3D ['A3\Sounds_F_Jets\vehicles\air\Shared\FX_Plane_Jet_Flaps_Down.wss',objNull,FALSE,((_carrierAnimData select 0) modelToWorldWorld ((_carrierAnimData select 0) selectionPosition ((_carrierAnimData select 1) select 0))),25,1,75];
		};
		[83,0,_this] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
	if (!((missionNamespace getVariable 'QS_client_action_carrierLaunchCancel') isEqualTo [])) then {
		(missionNamespace getVariable 'QS_client_action_carrierLaunchCancel') params [
			'_actionVehicle',
			'_actionAction'
		];
		if (!isNull _actionVehicle) then {
			_actionVehicle removeAction _actionAction;
		};
		missionNamespace setVariable ['QS_client_action_carrierLaunchCancel',[],FALSE];
	};
};