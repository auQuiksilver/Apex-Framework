/*
File: fn_clientProgressVisualization.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/12/2022 A3 2.10 by Quiksilver

Description:

	Procedure Visualization
	
Notes:

	['Text',10,0,_onProgress,_onCancelled,_onCompleted,_onFailed,_moveToCorner] spawn QS_fnc_clientProgressVisualization;
__________________________________________________________*/

if (
	(!canSuspend) ||
	(uiNamespace getVariable ['QS_client_progressVisualization_active',FALSE])
) exitWith {};
{
	uiNamespace setVariable _x;
} forEach [
	['QS_client_progressVisualization_active',TRUE],
	['QS_client_progressVisualization_script',_thisScript]
];
params [
	['_text','Text'],
	['_duration',10],
	['_initialProgress',0],
	['_onProgress',[[],{FALSE}]],
	['_onCancelled',[[],{FALSE}]],
	['_onCompleted',[[],{FALSE}]],
	['_onFailed',[[],{FALSE}]],
	['_moveToCorner',TRUE],
	['_newMode',0],
	['_newParams',['']],
	['_newDisplay',displayNull]
];
uiNamespace setVariable ['QS_ui_progress_mode',_newMode];
_onProgress params [['_argumentsProgress',[]],'_expressionProgress'];
_onCancelled params [['_argumentsCancelled',[]],'_expressionCancelled'];
_onCompleted params [['_argumentsCompleted',[]],'_expressionCompleted'];
_onFailed params [['_argumentsFailed',[]],'_expressionFailed'];
disableSerialization;
_display = findDisplay 46;
private _QS_controls = [];
private _QS_ctrlCreateArray = [];
private _QS_ctrl_0 = controlNull;
private _QS_ctrl_1 = controlNull;
private _QS_ctrl_2 = controlNull;
if (_newMode isEqualTo 0) then {
	_QS_color_profile = [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862]),(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])];
	_QS_ctrlCreateArray = ['RscText',5001];
	_QS_ctrl_0 = _display ctrlCreate _QS_ctrlCreateArray;
	_QS_ctrl_0 ctrlSetText _text;
	_QS_ctrl_0 ctrlSetFont 'RobotoCondensed';
	_QS_ctrl_0 ctrlSetBackgroundColor [0,0,0,0.5];
	
	_QS_ctrl_0 ctrlSetPosition [
		0.5 - pixelW * pixelGrid * 12.5,
		(-10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
		(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
		(0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
	];
	_QS_controls pushBack _QS_ctrl_0;
	_QS_ctrlCreateArray = ['RscBackground',5002];
	_QS_ctrl_1 = _display ctrlCreate _QS_ctrlCreateArray;
	_QS_ctrl_1 ctrlSetText '';
	_QS_ctrl_1 ctrlSetBackgroundColor [0,0,0,0.5];
	_QS_ctrl_1 ctrlSetPosition [
		0.5 - pixelW * pixelGrid * 12.5,
		(-9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
		(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
		(0.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
	];
	_QS_controls pushBack _QS_ctrl_1;
	_QS_ctrlCreateArray = ['RscProgress',5003];
	_QS_ctrl_2 = _display ctrlCreate _QS_ctrlCreateArray;
	_QS_ctrl_2 ctrlSetText '';
	_QS_ctrl_2 ctrlSetTextColor _QS_color_profile;
	_QS_ctrl_2 ctrlSetPosition [
		0.5 - pixelW * pixelGrid * 12.5,
		(-9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
		(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
		(0.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
	];
	_QS_controls pushBack _QS_ctrl_2;
	{
		_x ctrlCommit 0;
	} forEach _QS_controls;
};
if ((_newMode isEqualTo 0) && {(_moveToCorner)}) then {
	_QS_ctrl_0 ctrlSetPosition [
		(10 * (((safezoneW / safezoneH) min 1.2) / 40) + (profilenamespace getvariable ["IGUI_GRID_MISSION_X",(safezoneX + safezoneW - 21 * (((safezoneW / safezoneH) min 1.2) / 40))])),
		(3.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
		(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
		(0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
	];
	_QS_ctrl_1 ctrlSetPosition [
		(10 * (((safezoneW / safezoneH) min 1.2) / 40) + (profilenamespace getvariable ["IGUI_GRID_MISSION_X",(safezoneX + safezoneW - 21 * (((safezoneW / safezoneH) min 1.2) / 40))])),
		(4.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
		(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
		(0.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
	];
	_QS_ctrl_2 ctrlSetPosition [
		(10 * (((safezoneW / safezoneH) min 1.2) / 40) + (profilenamespace getvariable ["IGUI_GRID_MISSION_X",(safezoneX + safezoneW - 21 * (((safezoneW / safezoneH) min 1.2) / 40))])),
		(4.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
		(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
		(0.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
	];
	{
		_x ctrlCommit 0.5;
	} forEach _QS_controls;
};
// Mode 1
if (_newMode isEqualTo 1) exitWith {
	_newDisplay = if (isNull _newDisplay) then {findDisplay 46};
	{
		uiNamespace setVariable _x;
	} forEach [
		['QS_client_progressVisualization_active',TRUE],
		['QS_ui_progress1_activated',TRUE],
		['QS_ui_progress1_display',_newDisplay],
		['QS_ui_progress1_startTime',diag_tickTime],
		['QS_ui_progress1_totalTime',_duration],
		['QS_ui_progress1_progress',_initialProgress],
		['QS_ui_progress1_openProgressImg',format ['a3\ui_f\data\igui\cfg\HoldActions\progress2\progress_%1_ca.paa',0]],
		['QS_ui_progress1_icon',(_newParams # 0)],
		['QS_ui_progress1_iconCtrl',controlNull],
		['QS_ui_progress1_progressCtrl',controlNull],
		['QS_ui_progress1_alphaChangeTime',0.25],
		['QS_ui_progress1_alphaIn',diag_tickTime + (uiNamespace getVariable ['QS_ui_context_alphaChangeTime',-1])],
		['QS_ui_progress1_alphaMax',0.75]
	];
	uiNamespace setVariable [
		'QS_ui_progress1_deltaTime',
		(
			(uiNamespace getVariable ['QS_ui_progress1_startTime',-1]) + 
			(uiNamespace getVariable ['QS_ui_progress1_totalTime',-1])
		)
	];
	uiNamespace setVariable ['QS_ui_progress1_progressCtrl',_newDisplay ctrlCreate ['RscPictureKeepAspect',69420]];
	_posX = 0.5 - pixelW * pixelGrid * 6;
	_posY = 0.7 - pixelH * pixelGrid * 3;
	_posW = pixelW * pixelGrid * 12;
	_posH = pixelH * pixelGrid * 6;
	// Icon
	_posWMod = -0.03 + _posW;
	_posHMod = -0.03 + _posH;
	_posXMod = 0.015 + _posX;
	_posYMod = 0.015 + _posY;
	// Text
	_posXtext = 0.5 - pixelW * pixelGrid * 12;
	_posYtext = 0.8 - pixelH * pixelGrid * 3;
	_posWtext = pixelW * pixelGrid * 24;
	_posHtext = pixelH * pixelGrid * 6;
	(uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]) ctrlSetPosition [
		_posX,
		_posY,
		_posW,
		_posH
	];
	private _color = ctrlTextColor (uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]);
	_color set [3,0];
	(uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]) ctrlSetTextColor _color;
	(uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]) ctrlSetText (uiNamespace getVariable ['QS_ui_progress1_openProgressImg','']);
	(uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]) ctrlCommit 0;
	if ((uiNamespace getVariable ['QS_ui_progress1_icon','']) isNotEqualTo '') then {
		uiNamespace setVariable ['QS_ui_progress1_iconCtrl',_newDisplay ctrlCreate ['RscPictureKeepAspect',69421]];
		(uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]) ctrlSetPosition [
			_posXMod,
			_posYMod,
			_posWMod,
			_posHMod
		];
		_color = ctrlTextColor (uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]);
		_color set [3,0];
		(uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]) ctrlSetTextColor _color;
		(uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]) ctrlSetText (uiNamespace getVariable ['QS_ui_progress1_icon','']);
		(uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]) ctrlCommit 0;
	};
	private _textShown = _text isNotEqualTo '';
	private _ctrlText = (uiNamespace getVariable "BIS_dynamicText") displayCtrl 9999;
	private _ctrlTextColor = [1,1,1,0];
	if (_textShown) then {
		("BIS_layerTitlecard" call BIS_fnc_rscLayer) cutRsc ["RscDynamicText", "PLAIN"];
		_ctrlText = (uiNamespace getVariable "BIS_dynamicText") displayCtrl 9999;
		_ctrlText ctrlSetPosition [
			_posXtext,
			_posYtext,
			_posWtext,
			_posHtext
		];
		_ctrlText ctrlSetTextColor _ctrlTextColor;
		_ctrlText ctrlSetStructuredText (parseText _text);
		_ctrlText ctrlSetShadow 2;
		_ctrlText ctrlShow TRUE;
		_ctrlText ctrlCommit 0;
	};
	private _currentTime = diag_tickTime;
	private _callProgress = _expressionProgress isNotEqualTo {FALSE};
	private _progress = _initialProgress;
	private _totalTime = uiNamespace getVariable ['QS_ui_progress1_totalTime',-1];
	private _openTime = uiNamespace getVariable ['QS_ui_progress1_deltaTime',-1];
	private _remainingTime = -1;
	private _completion = -1;
	private _alphaTotalTime = -1;
	private _alphaOpenTime = -1;
	private _alpha = 0;
	for '_i' from 0 to 1 step 0 do {
		uiSleep diag_deltaTime;
		_currentTime = diag_tickTime;
		
		if (isNull _newDisplay) exitWith {};
		
		if (_argumentsCancelled call _expressionCancelled) exitWith {
			//comment 'Cancelled';
		};
		if (_argumentsFailed call _expressionFailed) exitWith {
			//comment 'Failed';		
		};
		if (_progress >= 1) exitWith {
			_argumentsCompleted call _expressionCompleted;
			//comment 'Completed';
		};
		if (_callProgress) then {
			[_progress,_argumentsProgress] call _expressionProgress;
		};
		_totalTime = uiNamespace getVariable ['QS_ui_progress1_totalTime',-1];
		_openTime = uiNamespace getVariable ['QS_ui_progress1_deltaTime',-1];
		_remainingTime = _openTime - _currentTime;
		_progress = (_totalTime - _remainingTime) / _totalTime;
		_progress = parseNumber (_progress toFixed 2);
		uiNamespace setVariable ['QS_ui_progress1_progress',_progress];
		uiNamespace setVariable ['QS_ui_progress1_openProgressImg',format ['a3\ui_f\data\igui\cfg\HoldActions\progress2\progress_%1_ca.paa',round (_progress * 24)]];
		_alphaTotalTime = uiNamespace getVariable ['QS_ui_progress1_alphaChangeTime',-1];
		_alphaOpenTime = uiNamespace getVariable ['QS_ui_progress1_alphaIn',-1];
		_remainingTime = _alphaOpenTime - _currentTime;
		_alpha = (_alphaTotalTime - _remainingTime) / _alphaTotalTime;
		_alpha = 0 max (parseNumber (_alpha toFixed 2)) min (uiNamespace getVariable ['QS_ui_progress1_alphaMax',0]);
		if (!isNull (uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull])) then {
			_color = ctrlTextColor (uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]);
			_color set [3,_alpha];
			(uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]) ctrlSetTextColor _color;
			(uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]) ctrlSetText (uiNamespace getVariable ['QS_ui_progress1_openProgressImg','']);
			(uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]) ctrlCommit 0;
		};
		if (!isNull (uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull])) then {
			_color = ctrlTextColor (uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]);
			_color set [3,_alpha];
			(uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]) ctrlSetTextColor _color;
			(uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]) ctrlCommit 0;
		};
		if (_textShown) then {
			_color = ctrlTextColor _ctrlText;
			_color set [3,_alpha];
			_ctrlText ctrlSetTextColor _color;
			_ctrlText ctrlCommit 0;
		};
	};
	//Delete
	private _alphaTotalTime = 0.1;
	private _alphaDelta = _alpha * _alphaTotalTime;
	private _timeout = diag_tickTime + (_alphaTotalTime * 10);
	while {_alpha > 0} do {
		if (diag_tickTime > _timeout) exitWith {}; // Failsafe
		uiSleep diag_deltaTime;
		_alpha = _alpha - _alphaDelta;
		if (!isNull (uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull])) then {
			_color = ctrlTextColor (uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]);
			_color set [3,_alpha];
			(uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]) ctrlSetTextColor _color;
			(uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]) ctrlCommit 0;
		};
		if (!isNull (uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull])) then {
			_color = ctrlTextColor (uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]);
			_color set [3,_alpha];
			(uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]) ctrlSetTextColor _color;
			(uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]) ctrlCommit 0;
		};
		if (_textShown) then {
			_color = ctrlTextColor _ctrlText;
			_color set [3,_alpha];
			_ctrlText ctrlSetTextColor _color;
			_ctrlText ctrlCommit 0;
		};
		if (_alpha <= 0) exitWith {};
	};
	if (!isNull (uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull])) then {
		ctrlDelete (uiNamespace getVariable ['QS_ui_progress1_progressCtrl',controlNull]);
	};
	if (!isNull (uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull])) then {
		ctrlDelete (uiNamespace getVariable ['QS_ui_progress1_iconCtrl',controlNull]);
	};
	if (_textShown) then {
		_ctrlText ctrlShow FALSE;
		_ctrlText ctrlCommit 0;
	};
	{
		uiNamespace setVariable _x;
	} forEach [
		['QS_client_progressVisualization_text',''],
		['QS_client_progressVisualization_initialProgress',0],
		['QS_client_progressVisualization_progress',0],
		['QS_client_progressVisualization_active',FALSE],
		['QS_client_progressVisualization_script',scriptNull]
	];
};
// Mode 0
private _timeStart = diag_tickTime;
_timeComplete = _timeStart + _duration;
_timeDiff = (_timeComplete - _timeStart) + 0.01;
private _progress = _initialProgress;
uiNamespace setVariable ['QS_client_progressVisualization_text',_text];
uiNamespace setVariable ['QS_client_progressVisualization_initialProgress',_progress];
_QS_ctrl_2 progressSetPosition _progress;
scopeName 'main';
for '_x' from 0 to 1 step 0 do {
	if (_argumentsCancelled call _expressionCancelled) then {
		breakTo 'main';
		//comment 'Cancelled';
	};
	if (_argumentsFailed call _expressionFailed) then {
		breakTo 'main';
		//comment 'Failed';		
	};
	if (_progress >= 1) then {
		_argumentsCompleted call _expressionCompleted;
		uiSleep 0.25;
		breakTo 'main';
		//comment 'Completed';
	};
	_progress = 0 max (_initialProgress + ((diag_tickTime - _timeStart) / _timeDiff)) min 1;
	if (_expressionProgress isNotEqualTo {FALSE}) then {
		[_progress,_argumentsProgress] call _expressionProgress;
	};
	if ((uiNamespace getVariable ['QS_client_progressVisualization_text',_text]) isNotEqualTo _text) then {
		_text = uiNamespace getVariable ['QS_client_progressVisualization_text',_text];
		_QS_ctrl_0 ctrlSetText _text;
	};
	_QS_ctrl_2 progressSetPosition _progress;
	uiNamespace setVariable ['QS_client_progressVisualization_progress',_progress];
	uiSleep 0.01;
};
{
	ctrlDelete _x;
} forEach _QS_controls;
{
	uiNamespace setVariable _x;
} forEach [
	['QS_client_progressVisualization_text',''],
	['QS_client_progressVisualization_initialProgress',0],
	['QS_client_progressVisualization_progress',0],
	['QS_client_progressVisualization_active',FALSE],
	['QS_client_progressVisualization_script',scriptNull],
	['QS_ui_progress1_activated',FALSE]
];