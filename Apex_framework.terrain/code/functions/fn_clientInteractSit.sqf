/*/
File: fn_clientInteractSit.sqf
Author:

	Quiksilver
	
Last Modified:

	16/02/2023 A3 2.12 by Quiksilver
	
Description:

	Sit Down / Stand Up
_____________________________________/*/

params ['','','','_type'];
_chairTypes = ['chair_types_1'] call QS_data_listVehicles;
_chairModels = ['chair_models_1'] call QS_data_listVehicles;
_sittingAnimations = ['sitting_animations_1'] call QS_data_listOther;
_player = QS_player;
if (_type isEqualTo 0) then {
	if (!isNull (attachedTo _player)) then {
		[0,(attachedTo _player)] call QS_fnc_eventAttach;
	};
	_posInFront = _player modelToWorldWorld [0,0.5,0];
	_player setPosWorld _posInFront;
	if ((stance _player) isNotEqualTo 'STAND') then {
		['switchMove',_player,[(_player getVariable ['QS_seated_oldAnimState',''])]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	};
	if !(_player isNil 'QS_interact_actionStand') then {
		_player removeAction (_player getVariable 'QS_interact_actionStand');
		_player setVariable ['QS_interact_actionStand',nil,FALSE];
	};
	_player setVariable ['QS_seated_oldAnimState',nil,FALSE];
};
if (_type isEqualTo 1) then {
	getCursorObjectParams params ['_object','',''];
	if (
		((_player distance2D _object) > 2.5) ||
		{
			(
				(!((toLowerANSI (typeOf _object)) in _chairTypes)) && 
				{(!((toLowerANSI ((getModelInfo _object) # 0)) in _chairModels))}
			)
		} ||
		{((attachedObjects _object) isNotEqualTo [])} ||
		{(!isNull (attachedTo _object))} ||
		{((stance _player) isNotEqualTo 'STAND')}
	) exitWith {};
	if ((((getPosATL _object) nearEntities ['CAManBase',0.75]) select {(_x isNotEqualTo _player)}) isNotEqualTo []) exitWith {
		50 cutText [localize 'STR_QS_Text_145','PLAIN DOWN'];
	};
	if ((toLowerANSI (animationState _player)) in _sittingAnimations) exitWith {
		50 cutText [localize 'STR_QS_Text_146','PLAIN DOWN'];
	};
	if (local _object) then {
		_object setVectorUp [0,0,1];
	} else {
		[36.5,_object] remoteExecCall ['QS_fnc_remoteExec',_object,FALSE];
	};
	_sittingAnimation = selectRandom _sittingAnimations;
	if (simulationEnabled _object) then {
		[39,_object,FALSE,profileName,(getPlayerUID player)] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
	};
	_player setVariable ['QS_seated_oldAnimState',(animationState _player),FALSE];
	['switchMove',_player,[_sittingAnimation]] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	private _attachY = -0.1;
	if (((toLowerANSI (typeOf _object)) in ['land_armchair_01_f']) || {((toLowerANSI ((getModelInfo _object) # 0)) in ['armchair_01_f.p3d'])}) then {
		_attachY = 0;
	};
	if (_player isEqualTo player) then {
		[1,_player,[_object,[0,_attachY,0]]] call QS_fnc_eventAttach;
	};
	if (_player isEqualTo player) then {
		player setVariable [
			'QS_interact_actionStand',
			(player addAction [localize 'STR_QS_Interact_066',(missionNamespace getVariable 'QS_fnc_clientInteractSit'),0,49,FALSE,TRUE,'GetOut','TRUE',-1,FALSE]),
			FALSE
		];
		player setUserActionText [(player getVariable 'QS_interact_actionStand'),((player actionParams (player getVariable 'QS_interact_actionStand')) # 0),(format ["<t size='3'>%1</t>",((player actionParams (player getVariable 'QS_interact_actionStand')) # 0)])];
		[_object] spawn {
			params ['_object'];
			scriptName 'Seated thread';
			[0,player] call QS_fnc_eventAttach;
			private _sitDirectionOffset = 180;
			if (((toLowerANSI (typeOf _object)) in ['land_armchair_01_f']) || {((toLowerANSI ((getModelInfo _object) # 0)) in ['armchair_01_f.p3d'])}) then {
				_sitDirectionOffset = 0;
			};
			player setDir ((getDir _object) - _sitDirectionOffset);
			uiSleep 0.05;
			if (((toLowerANSI (typeOf _object)) in ['land_rattanchair_01_f','land_armchair_01_f']) || {((toLowerANSI ((getModelInfo _object) # 0)) in ['rattanchair_01_f.p3d','armchair_01_f.p3d'])}) then {
				private _playerPos = (getPosWorld player) vectorAdd [0,0,-1];
				player setPosWorld _playerPos;
			};
			uiSleep 0.05;
			_animationState = animationState player;
			for '_x' from 0 to 1 step 0 do {
				if ((animationState player) isNotEqualTo _animationState) exitWith {player setVariable ['QS_seated_oldAnimState',nil,FALSE];};
				if ((player distance2D _object) > 1) exitWith {
					if ((animationState player) isEqualTo _animationState) then {
						[nil,nil,nil,0] call (missionNamespace getVariable 'QS_fnc_clientInteractSit');
					};
				};
				if (((vectorUp _object) # 2) < 0.5) exitWith {
					if ((animationState player) isEqualTo _animationState) then {
						[nil,nil,nil,0] call (missionNamespace getVariable 'QS_fnc_clientInteractSit');
					};
				};
				if (!alive _object) exitWith {
					if ((animationState player) isEqualTo _animationState) then {
						[nil,nil,nil,0] call (missionNamespace getVariable 'QS_fnc_clientInteractSit');
					};
				};
				if (!alive player) exitWith {player setVariable ['QS_seated_oldAnimState',nil,FALSE];};
				uiSleep 0.05;
			};
			if !(player isNil 'QS_interact_actionStand') then {
				player removeAction (player getVariable 'QS_interact_actionStand');
				player setVariable ['QS_interact_actionStand',nil,FALSE];
			};
			if !(player isNil 'QS_seated_oldAnimState') then {
				player setVariable ['QS_seated_oldAnimState',nil,FALSE];
			};
		};
	};
};