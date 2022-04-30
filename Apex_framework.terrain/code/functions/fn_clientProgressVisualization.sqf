/*
File: fn_clientProgressVisualization.sqf
Author:
	
	Quiksilver
	
Last Modified:

	2/03/2018 A3 1.80 by Quiksilver

Description:

	Procedure Visualization
__________________________________________________________*/

if (!canSuspend) exitWith {};
if (uiNamespace getVariable ['QS_client_progressVisualization_active',FALSE]) exitWith {};
{
	uiNamespace setVariable _x;
} forEach [
	['QS_client_progressVisualization_active',TRUE],
	['QS_client_progressVisualization_script',_thisScript]
];
params [
	'_text',
	'_duration',
	'_initialProgress',
	'_onProgress',
	'_onCancelled',
	'_onCompleted',
	'_onFailed',
	['_moveToCorner',TRUE]
];
_onProgress params ['_argumentsProgress','_expressionProgress'];
_onCancelled params ['_argumentsCancelled','_expressionCancelled'];
_onCompleted params ['_argumentsCompleted','_expressionCompleted'];
_onFailed params ['_argumentsFailed','_expressionFailed'];
disableSerialization;
_display = findDisplay 46;
_QS_controls = [];
private _QS_ctrlCreateArray = [];
_QS_color_profile = [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862]),(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])];
_QS_ctrlCreateArray = ['RscText',5001];
_QS_ctrl_0 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_0 ctrlSetText _text;
_QS_ctrl_0 ctrlSetFont 'RobotoCondensed';
_QS_ctrl_0 ctrlSetBackgroundColor [0,0,0,0.5];
/*/
_QS_ctrl_0 ctrlSetPosition [
	0.5,
	0.5,
	(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
	(0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
];
/*/
_QS_ctrl_0 ctrlSetPosition [
	0.5,
	(-10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
	(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
	(0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
];
_QS_controls pushBack _QS_ctrl_0;
_QS_ctrlCreateArray = ['RscBackground',5002];
_QS_ctrl_1 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_1 ctrlSetText '';
_QS_ctrl_1 ctrlSetBackgroundColor [0,0,0,0.5];
/*/
_QS_ctrl_1 ctrlSetPosition [
	(10 * (((safezoneW / safezoneH) min 1.2) / 40) + (profilenamespace getvariable ["IGUI_GRID_MISSION_X",(safezoneX + safezoneW - 21 * (((safezoneW / safezoneH) min 1.2) / 40))])),
	(4.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
	(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
	(0.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
];
/*/
_QS_ctrl_1 ctrlSetPosition [
	0.5,
	(-9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
	(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
	(0.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
];
_QS_controls pushBack _QS_ctrl_1;
_QS_ctrlCreateArray = ['RscProgress',5003];
_QS_ctrl_2 = _display ctrlCreate _QS_ctrlCreateArray;
_QS_ctrl_2 ctrlSetText '';
_QS_ctrl_2 ctrlSetTextColor _QS_color_profile;
/*/
_QS_ctrl_2 ctrlSetPosition [
	(10 * (((safezoneW / safezoneH) min 1.2) / 40) + (profilenamespace getvariable ["IGUI_GRID_MISSION_X",(safezoneX + safezoneW - 21 * (((safezoneW / safezoneH) min 1.2) / 40))])),
	(4.7 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
	(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
	(0.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
];
/*/
_QS_ctrl_2 ctrlSetPosition [
	0.5,
	(-9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (profilenamespace getvariable ["IGUI_GRID_MISSION_Y",(safezoneY + safezoneH - 10.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])),
	(10 * (((safezoneW / safezoneH) min 1.2) / 40)),
	(0.3 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))
];
_QS_controls pushBack _QS_ctrl_2;
{
	_x ctrlCommit 0;
} forEach _QS_controls;
if (_moveToCorner) then {
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
	['QS_client_progressVisualization_script',scriptNull]
];