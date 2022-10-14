/*/
File: fn_deltaVD.sqf
Author:

	Quiksilver
	
Last Modified:

	1/10/2022 A3 2.10 by Quiksilver
	
Description:

	Change View Distance
_______________________________________________/*/

scriptName 'QS - Client - Delta VD';
params ['_viewDistanceData','_objectViewDistanceData','_shadowDistanceData',''];
_viewDistanceData params [['_currentVD',-1],['_targetVD',-1],['_incrementVD',10]];
_objectViewDistanceData params [['_currentOD',-1],['_targetOD',-1],['_incrementOD',10]];
_shadowDistanceData params [['_currentSH',-1],['_targetSH',-1],['_incrementSH',1]];
_rampShadow = _currentSH isNotEqualTo _targetSH;
_rampObject = _currentOD isNotEqualTo _targetOD;
_rampView = _currentVD isNotEqualTo _targetVD;
_increment_shadow = (_targetSH - _currentSH) / 100;
private _helper_shadow = _currentSH;
_increment_object = (_targetOD - _currentOD) / 100;
private _helper_object = _currentOD;
_increment_view = (_targetVD - _currentVD) / 100;
private _helper_view = _currentVD;
uiSleep 0.1;
for '_x' from 0 to 99 step 1 do {
	if (_rampShadow) then {
		_helper_shadow = _currentSH + (_increment_shadow * (_x + 1));
		setShadowDistance _helper_shadow;
	};
	if (_rampObject) then {
		_helper_object = _currentOD + (_increment_object * (_x + 1));
		setObjectViewDistance _helper_object;
	};
	if (_rampView) then {
		_helper_view = _currentVD + (_increment_view * (_x + 1));
		setViewDistance _helper_view;
	};
	uiSleep 0.025;
};
if (_rampShadow) then {
	setShadowDistance _targetSH;
};
if (_rampObject) then {
	setObjectViewDistance _targetOD;
};
if (_rampView) then {
	setViewDistance _targetVD;
};