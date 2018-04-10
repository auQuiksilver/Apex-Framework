/*
File: fn_clientMSpectate.sqf
Author:

	Quiksilver
	
Last modified:

	15/05/2016 A3 1.58 by Quiksilver

Description:

	Spectate wounded - Some of code inspired by RscSpectator (by Karel Moricky [BIS])
_________________________________________________________________________________________*/

private ['_groupMembers','_spectatedUnitID','_deltaSpectatedUnitID','_buttonSpectate','_buttonCameraMode','_nextUnitID','_nextUnit','_nameNextUnit','_typeNextUnit'];

/*/======================================= CONFIG/*/

disableSerialization;

_deltaSpectatedUnitID = _this select 0;
_groupMembers = units (group player);
_buttonSpectate = ((uiNamespace getVariable 'QS_revive_dialog') displayCtrl 1601);
_buttonCameraMode = ((uiNamespace getVariable 'QS_revive_dialog') displayCtrl 1602);

/*/======================================= FIND NEXT GROUP MEMBER/*/

if ((count _groupMembers) > 1) then {
	_spectatedUnitID = _groupMembers find (missionNamespace getVariable 'QS_client_spectatedUnit');
	_spectatedUnitID = _spectatedUnitID + _deltaSpectatedUnitID;
	_spectatedUnitID = ((count _groupMembers) + _spectatedUnitID) % (count _groupMembers);
	missionNamespace setVariable ['QS_client_spectatedUnit',(_groupMembers select _spectatedUnitID),FALSE];
	if (player isEqualTo (missionNamespace getVariable 'QS_client_spectatedUnit')) then {
		_buttonCameraMode ctrlEnable TRUE;
		[1] call (missionNamespace getVariable 'QS_fnc_clientMCameraMode');
		50 cutText ['','PLAIN DOWN'];
	} else {
		_buttonCameraMode ctrlEnable FALSE;
		player cameraEffect ['TERMINATE','BACK'];
		if (!isNull (missionNamespace getVariable 'QS_woundedCam')) then {
			camDestroy (missionNamespace getVariable 'QS_woundedCam');
			missionNamespace setVariable ['QS_woundedCam',objNull,FALSE];
		};
		private _timeNow = time + 3;
		waitUntil {
			(preloadCamera (getPos (missionNamespace getVariable 'QS_client_spectatedUnit'))) ||
			(time > _timeNow)
		};
		50 cutText [(format ['Spectating %1',(name (missionNamespace getVariable 'QS_client_spectatedUnit'))]),'PLAIN DOWN'];
		(vehicle (missionNamespace getVariable 'QS_client_spectatedUnit')) switchCamera 'Internal';
	};
	('RscSpectator_fade' call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutText ['','BLACK IN'];
	[_buttonSpectate] spawn {
		private ['_buttonSpectate'];
		disableSerialization;
		_buttonSpectate = _this select 0;
		_buttonSpectate ctrlEnable FALSE;
		uiSleep 1;
		_buttonSpectate ctrlEnable TRUE;
	};
	_nextUnitID = _groupMembers find (missionNamespace getVariable 'QS_client_spectatedUnit');
	_nextUnitID = _nextUnitID + _deltaSpectatedUnitID;
	_nextUnitID = ((count _groupMembers) + _nextUnitID) % (count _groupMembers);
	_nextUnit = _groupMembers select _nextUnitID;
	_nameNextUnit = name _nextUnit;
	_typeNextUnit = getText (configFile >> 'CfgVehicles' >> (typeOf _nextUnit) >> 'displayName');
	
	if (player != _nextUnit) then {
		_buttonSpectate ctrlSetText format ['Spectate %1',_nameNextUnit];
	} else {
		_buttonSpectate ctrlSetText 'Spectate yourself';
	};
};
if (!(player getVariable 'QS_medical_spectating')) then {
	player setVariable ['QS_medical_spectating',TRUE];
	0 spawn {
		while {(player getVariable 'QS_medical_spectating')} do {
			if (cameraView isEqualTo 'External') then {
				(vehicle (missionNamespace getVariable 'QS_client_spectatedUnit')) switchCamera 'Internal';
			};
			uiSleep 0.01;
			if (player isEqualTo (missionNamespace getVariable 'QS_client_spectatedUnit')) exitWith {
				player setVariable ['QS_medical_spectating',FALSE];
			};
			if ((!(player isEqualTo player)) || {(!alive player)} || {(!(player getVariable 'QS_revive_incapacitated'))}) exitWith {
				player setVariable ['QS_medical_spectating',FALSE];
			};
			uiSleep 0.25;
		};
	};
};