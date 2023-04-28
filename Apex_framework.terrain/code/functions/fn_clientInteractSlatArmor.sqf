/*/
File: fn_clientInteractSlatArmor.sqf
Author:

	Quiksilver
	
Last Modified:

	14/04/2018 A3 1.82 by Quiksilver
	
Description:

	-
_____________________________________________________________/*/

params ['_actionTarget','_actionCaller','_actionID','_actionArguments'];
_actionArguments params ['_vehicle','_newPhase','_animationSources'];
if ((!(player getUnitTrait 'engineer')) && (!(player getUnitTrait 'QS_trait_crewman'))) exitWith {
	50 cutText [localize 'STR_QS_Text_147','PLAIN DOWN',0.5];
};
if (isEngineOn _vehicle) exitWith {
	50 cutText [localize 'STR_QS_Text_148','PLAIN DOWN',0.5];
};
if ((damage _vehicle) isNotEqualTo 0) exitWith {
	50 cutText [localize 'STR_QS_Text_149','PLAIN DOWN',0.5];
};
private _exitCamo = FALSE;
_camonetArmor_anims = ['camonet_anims_1'] call QS_data_listOther;
private _camonetArmor_vAnims = _vehicle getVariable ['QS_vehicle_camonetAnims',[]];
if (_camonetArmor_vAnims isEqualTo []) then {
	private _array = [];
	private _camonetAnimationSources = (configOf _vehicle) >> 'animationSources';
	private _animationSource = configNull;
	private _i = 0;
	for '_i' from 0 to ((count _camonetAnimationSources) - 1) step 1 do {
		_animationSource = _camonetAnimationSources select _i;
		if (((toLowerANSI (configName _animationSource)) in _camonetArmor_anims) || {(['showcamo',(configName _animationSource),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
			0 = _array pushBack (toLowerANSI (configName _animationSource));
		};
	};
	{
		if (_x isEqualType '') then {
			if (!((toLowerANSI _x) in _array)) then {
				if (((toLowerANSI _x) in _camonetArmor_anims) || {(['showcamo',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
					_array pushBack (toLowerANSI _x);
				};
			};
		};
	} forEach (getArray ((configOf _vehicle) >> 'animationList'));
	_vehicle setVariable ['QS_vehicle_camonetAnims',_array,FALSE];
	_camonetArmor_vAnims = _array;
};
if (_camonetArmor_vAnims isNotEqualTo []) then {
	if ((_camonetArmor_vAnims findIf {((_vehicle animationSourcePhase _x) isEqualTo 1)}) isNotEqualTo -1) then {
		_exitCamo = TRUE;
	};
};
if (_exitCamo) exitWith {
	50 cutText [localize 'STR_QS_Text_150','PLAIN DOWN',0.5];
};
_onCancelled = {
	params ['_v','_position'];
	private _c = FALSE;
	if (!alive player) then {_c = TRUE;};
	if ((_v distance2D _position) > 3) then {_c = TRUE;};
	if ((vehicle player) isNotEqualTo _v) then {_c = TRUE;};
	if (!(isNull (attachedTo _v))) then {_c = TRUE;};
	if (!(isNull (isVehicleCargo _v))) then {_c = TRUE;};
	if (isEngineOn _v) then {_c = TRUE;};
	if (!alive _v) then {_c = TRUE;};
	if (_c) then {
		missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
	};
	_c;
};
_onCompleted = {
	params ['_actionTarget','_actionCaller','_actionID','_actionArguments'];
	_actionArguments params ['_vehicle','_newPhase','_animationSources'];
	private _exitCamo = FALSE;
	_camonetArmor_anims = ['camonet_anims_1'] call QS_data_listOther;
	private _camonetArmor_vAnims = _vehicle getVariable ['QS_vehicle_camonetAnims',[]];
	if (_camonetArmor_vAnims isEqualTo []) then {
		private _array = [];
		private _camonetAnimationSources = (configOf _vehicle) >> 'animationSources';
		private _animationSource = configNull;
		private _i = 0;
		for '_i' from 0 to ((count _camonetAnimationSources) - 1) step 1 do {
			_animationSource = _camonetAnimationSources select _i;
			if (((toLowerANSI (configName _animationSource)) in _camonetArmor_anims) || {(['showcamo',(configName _animationSource),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
				0 = _array pushBack (toLowerANSI (configName _animationSource));
			};
		};
		{
			if (_x isEqualType '') then {
				if (!((toLowerANSI _x) in _array)) then {
					if (((toLowerANSI _x) in _camonetArmor_anims) || {(['showcamo',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
						_array pushBack (toLowerANSI _x);
					};
				};
			};
		} forEach (getArray ((configOf _vehicle) >> 'animationList'));
		_vehicle setVariable ['QS_vehicle_camonetAnims',_array,FALSE];
		_camonetArmor_vAnims = _array;
	};
	if (_camonetArmor_vAnims isNotEqualTo []) then {
		if ((_camonetArmor_vAnims findIf {((_vehicle animationSourcePhase _x) isEqualTo 1)}) isNotEqualTo -1) then {
			_exitCamo = TRUE;
		};
	};
	if (_exitCamo) exitWith {
		50 cutText [localize 'STR_QS_Text_150','PLAIN DOWN',0.5];
	};
	{
		_vehicle animateSource [_x,_newPhase,TRUE];
	} forEach _animationSources;
	playSound3D [
		'A3\Sounds_F\sfx\ui\vehicles\vehicle_repair.wss',
		_vehicle,
		FALSE,
		(getPosASL _vehicle),
		2,
		1,
		25
	];
	if (_newPhase isEqualTo 1) then {
		_mass = _vehicle getVariable ['QS_vehicle_massArmor',-1];
		if (_mass isEqualTo -1) then {
			_vehicle setVariable ['QS_vehicle_massArmor',[(getMass _vehicle),((getMass _vehicle) * 1.375)],TRUE];
		};
		if (local _vehicle) then {
			_vehicle setMass ((_vehicle getVariable 'QS_vehicle_massArmor') # 1);
		} else {
			['setMass',_vehicle,((_vehicle getVariable 'QS_vehicle_massArmor') # 1)] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
		};
		if (vehicleCargoEnabled _vehicle) then {
			if (local _vehicle) then {
				_vehicle enableVehicleCargo FALSE;
			} else {
				['enableVehicleCargo',_vehicle,FALSE] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
			};
		};
		50 cutText [localize 'STR_QS_Text_151','PLAIN DOWN',0.333];
	} else {
		if ((_vehicle getVariable ['QS_vehicle_massArmor',-1]) isNotEqualTo -1) then {
			if (local _vehicle) then {
				_vehicle setMass ((_vehicle getVariable 'QS_vehicle_massArmor') # 0);
			} else {
				['setMass',_vehicle,((_vehicle getVariable 'QS_vehicle_massArmor') # 0)] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
			};
			if (!(vehicleCargoEnabled _vehicle)) then {
				if (local _vehicle) then {
					_vehicle enableVehicleCargo TRUE;
				} else {
					['enableVehicleCargo',_vehicle,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
				};
			};
		};
		50 cutText [localize 'STR_QS_Text_152','PLAIN DOWN',0.333];
	};
	missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
};
missionNamespace setVariable ['QS_repairing_vehicle',TRUE,FALSE];
private _text = '';
if (_newPhase isEqualTo 1) then {
	_text = localize 'STR_QS_Menu_170';
} else {
	_text = localize 'STR_QS_Menu_171';
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