/*
File: fn_clientMCameraMode.sqf
Author:

	Quiksilver
	
Last modified:

	30/12/2015 ArmA 1.54 by Quiksilver

Description:

	Wounded camera
_________________________________________________________________________________________*/

private ['_t','_c','_dt','_g','_gn','_position'];

/*/======================================= CONFIG/*/

disableSerialization; 
_t = _this select 0;
_c = _this select 1;

/*/======================================= DESTROY THE CAMERA/*/

if (_t isEqualTo 0) exitWith {
	QS_woundedCam cameraEffect ['TERMINATE','BACK'];
	camDestroy QS_woundedCam;
	camUseNVG FALSE;
	missionNamespace setVariable ['QS_woundedCam',objNull,FALSE];
	missionNamespace setVariable ['QS_camUseNVG',nil,FALSE];
	missionNamespace setVariable ['client_spectatedUnit',objNull,FALSE];
	player switchCamera 'INTERNAL';
};

/*/======================================= CREATE THE CAMERA/*/

if (_t isEqualTo 1) exitWith {
	missionNamespace setVariable ['QS_woundedCam',objNull,FALSE];
	_position = [(4 + (random 3)),(4 + (random 3)),(3 + (random 3))];
	QS_woundedCam = 'CAMERA' camCreate (position player);
	QS_woundedCam attachTo [(vehicle player),_position];
	QS_woundedCam camSetTarget (vehicle player);
	QS_woundedCam cameraEffect ['INTERNAL','BACK'];
	/*/QS_woundedCam camSetRelPos [(4 + (random 3)),(4 + (random 3)),(3 + (random 3))];/*/
	QS_woundedCam camSetFOV 1;
	QS_woundedCam camSetFocus [50,0];
	QS_woundedCam camCommit 0;
	/*/showCinemaBorder TRUE;/*/
	/*/showHUD FALSE;/*/
	if (sunOrMoon < 0.1) then {
		camUseNVG TRUE;
		missionNamespace setVariable ['QS_camUseNVG',TRUE,FALSE];
	} else {
		camUseNVG FALSE;
		missionNamespace setVariable ['QS_camUseNVG',FALSE,FALSE];
	};
	_position;
};

/*/======================================= ADJUST THE CAMERA (NVG)/*/

if (_t isEqualTo 2) exitWith {
	0 spawn {
		disableSerialization;
		private _buttonCameraMode = ((uiNamespace getVariable 'QS_revive_dialog') displayCtrl 1602);
		_buttonCameraMode ctrlEnable FALSE;
		if (missionNamespace getVariable 'QS_camUseNVG') then {
			missionNamespace setVariable ['QS_camUseNVG',FALSE,FALSE];
			camUseNVG FALSE;
		} else {
			missionNamespace setVariable ['QS_camUseNVG',TRUE,FALSE];
			camUseNVG TRUE;
			playSound ['RscDisplayCurator_visionMode',FALSE];
		};
		uiSleep 1.5;
		_buttonCameraMode ctrlEnable TRUE;
	};
};