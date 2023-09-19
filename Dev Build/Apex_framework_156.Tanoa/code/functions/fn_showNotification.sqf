/*
File: fn_showNotification.sqf
Author:

	Quiksilver
	
Last modified:

	19/07/2016 A3 1.62 by Quiksilver
	
Description:

	Notification System
__________________________________________________________________________*/

if (time < 1) exitwith {};
private [
	'_template','_args','_cfgDefault','_cfgTemplate','_cfgTitle','_cfgIconPicture','_cfgIconText','_cfgDescription','_cfgColor',
	'_cfgDuration','_cfgPriority','_cfgDifficulty','_cfgSound','_cfgSoundClose','_cfgSoundRadio','_title','_iconPicture','_iconText',
	'_description','_color','_duration','_priority','_difficulty','_sound','_soundClose','_soundRadio','_iconSize','_data','_difficultyEnabled',
	'_queue','_queuePriority','_process','_processDone'
];
_template = _this param [0,'Default',['']];
_args = _this param [1,[],[[]]];
_cfgTemplate = [_template] call (missionNamespace getVariable 'QS_data_notifications');
_cfgTemplate params [
	'_color',
	'_colorIconPicture',
	'_colorIconText',
	'_description',
	'_difficulty',
	'_duration',
	'_iconPicture',
	'_iconText',
	'_iconSize',
	'_priority',
	'_sound',
	'_soundClose',
	'_soundRadio',
	'_title'
];
_data = [_title,_iconPicture,_iconText,_description,_color,_colorIconPicture,_colorIconText,_duration,_priority,_args,_sound,_soundClose,_soundRadio,_iconSize];
_queue = missionNamespace getVariable ['BIS_fnc_showNotification_queue',[]];
_queue resize (_priority max (count _queue));
if (isNil {_queue # _priority}) then {
	_queue set [_priority,[]];
};
_queuePriority = _queue # _priority;
_queuePriority pushBack _data;
missionNamespace setVariable ['BIS_fnc_showNotification_queue',_queue,FALSE];
['BIS_fnc_showNotification_counter',+1] call (missionNamespace getVariable 'BIS_fnc_counter');
_process = missionNamespace getVariable ['BIS_fnc_showNotification_process',TRUE];
_processDone = if (_process isEqualType TRUE) then [{TRUE},{(scriptDone _process)}];
if (_processDone) then {
	_process = [] spawn (missionNamespace getVariable 'QS_fnc_showNotification_process');
	missionNamespace setVariable ['BIS_fnc_showNotification_process',_process,FALSE];
};
TRUE;