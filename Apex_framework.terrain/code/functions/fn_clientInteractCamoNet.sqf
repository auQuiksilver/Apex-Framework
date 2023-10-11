/*/
File: fn_clientInteractCamoNet.sqf
Author:

	Quiksilver
	
Last Modified:

	3/03/2018 A3 1.80 by Quiksilver
	
Description:

	Vehicle Camo Nets
_____________________________________________________________/*/

params ['_actionTarget','_actionCaller','_actionID','_actionArguments'];
_actionArguments params ['_vehicle','_newPhase','_animationSources'];
private _exitArmor = FALSE;
_armor_anims = ['showslathull','showslatturret'];
private _armor_vAnims = _vehicle getVariable ['QS_vehicle_slatarmorAnims',[]];
if (_armor_vAnims isEqualTo []) then {
	private _array = [];
	private _armorAnimationSources = (configOf _vehicle) >> 'animationSources';
	private _animationSource = configNull;
	private _i = 0;
	for '_i' from 0 to ((count _armorAnimationSources) - 1) step 1 do {
		_animationSource = _armorAnimationSources select _i;
		if (((toLowerANSI (configName _animationSource)) in _armor_anims) || {(['showslat',(configName _animationSource),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
			0 = _array pushBack (toLowerANSI (configName _animationSource));
		};
	};
	{
		if (_x isEqualType '') then {
			if (!((toLowerANSI _x) in _array)) then {
				if (((toLowerANSI _x) in _armor_anims) || {(['showslat',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
					_array pushBack (toLowerANSI _x);
				};
			};
		};
	} forEach (getArray ((configOf _vehicle) >> 'animationList'));
	_vehicle setVariable ['QS_vehicle_slatarmorAnims',_array,FALSE];
	_armor_vAnims = _array;
};
if (_armor_vAnims isNotEqualTo []) then {
	if ((_armor_vAnims findIf {((_vehicle animationSourcePhase _x) isEqualTo 1)}) isNotEqualTo -1) then {
		_exitArmor = TRUE;
	};
};
if (_exitArmor) exitWith {
	50 cutText [localize 'STR_QS_Text_082','PLAIN DOWN',0.5];
};
_onCancelled = {
	params ['_t','_position'];
	private _c = FALSE;
	if (!alive player) then {_c = TRUE;};
	if (player isNotEqualTo (vehicle player)) then {_c = TRUE;};
	if (!alive _t) then {_c = TRUE;};
	if (!((vehicle player) isKindOf 'CAManBase')) then {_c = TRUE;};
	if (!(_t in [cursorObject,cursorTarget])) then {_c = TRUE;};
	if (((getPosATL player) distance2D _position) > 5) then {_c = TRUE;};
	if (_c) then {
		missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
	};
	_c;
};
_onCompleted = {
	params ['_actionTarget','_actionCaller','_actionID','_actionArguments'];
	_actionArguments params ['_vehicle','_newPhase','_animationSources'];
	private _exitArmor = FALSE;
	_armor_anims = ['showslathull','showslatturret'];
	private _armor_vAnims = _vehicle getVariable ['QS_vehicle_slatarmorAnims',[]];
	if (_armor_vAnims isEqualTo []) then {
		private _array = [];
		private _armorAnimationSources = (configOf _vehicle) >> 'animationSources';
		private _animationSource = configNull;
		private _i = 0;
		for '_i' from 0 to ((count _armorAnimationSources) - 1) step 1 do {
			_animationSource = _armorAnimationSources select _i;
			if (((toLowerANSI (configName _animationSource)) in _armor_anims) || {(['showslat',(configName _animationSource),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
				0 = _array pushBack (toLowerANSI (configName _animationSource));
			};
		};
		{
			if (_x isEqualType '') then {
				if (!((toLowerANSI _x) in _array)) then {
					if (((toLowerANSI _x) in _armor_anims) || {(['showslat',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
						_array pushBack (toLowerANSI _x);
					};
				};
			};
		} forEach (getArray ((configOf _vehicle) >> 'animationList'));
		_vehicle setVariable ['QS_vehicle_slatarmorAnims',_array,FALSE];
		_armor_vAnims = _array;
	};
	if (_armor_vAnims isNotEqualTo []) then {
		if ((_armor_vAnims findIf {((_vehicle animationSourcePhase _x) isEqualTo 1)}) isNotEqualTo -1) then {
			_exitArmor = TRUE;
		};
	};
	if (_exitArmor) exitWith {
		50 cutText [localize 'STR_QS_Text_082','PLAIN DOWN',0.5];
	};
	{
		_vehicle animateSource [_x,_newPhase,TRUE];
	} forEach _animationSources;
	if (_newPhase isEqualTo 1) then {
		50 cutText [localize 'STR_QS_Text_083','PLAIN DOWN',0.333];
	} else {
		50 cutText [localize 'STR_QS_Text_084','PLAIN DOWN',0.333];
	};
	missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
};
missionNamespace setVariable ['QS_repairing_vehicle',TRUE,FALSE];
private _text = '';
if (_newPhase isEqualTo 1) then {
	_text = localize 'STR_QS_Menu_165';
} else {
	_text = localize 'STR_QS_Menu_166';
};
private _duration = 5;
[
	_text,
	_duration,
	0,
	[[_vehicle],{FALSE}],
	[[_vehicle,(getPosATL _vehicle)],_onCancelled],
	[_this,_onCompleted],
	[[],{FALSE}]
] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');