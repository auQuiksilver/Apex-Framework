/*
File: fn_clientAnimateCarry.sqf
Author:
	
	Quiksilver
	
Last Modified:

	5/10/2017 A3 1.76 by Quiksilver

Description:

	-
__________________________________________________________*/

_t = _this select 0;
if (!isNull _t) then {
	if (_t isKindOf 'CAManBase') then {
		_onProgress = {
			FALSE
		};
		_onCancelled = {
			params ['_unit','_position'];
			private _c = FALSE;
			if (!alive player) then {_c = TRUE;};
			if (!alive _unit) then {_c = TRUE;};
			if ((player distance2D _position) > 4) then {_c = TRUE;};
			if (!isNull (attachedTo _unit)) then {_c = TRUE};
			if (!((lifeState _unit) isEqualTo 'INCAPACITATED')) then {_c = TRUE;};
			if (!((lifeState player) in ['HEALTHY','INJURED'])) then {_c = TRUE;};
			if ((!(_unit isEqualTo cursorObject)) && (!(_unit isEqualTo cursorTarget))) then {_c = TRUE;};
			if (!isNull (objectParent player)) then {_c = TRUE;};
			if (!isNull (objectParent _unit)) then {_c = TRUE;};
			_c;
		};
		_onCompleted = {
			params ['_unit'];
			['switchMove',player,'AcinPercMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			['switchMove',_unit,'AinjPfalMstpSnonWnonDf_carried_dead'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			player forceWalk TRUE;
			_unit attachTo [player,[0.1,-0.1,-1.2],'leftshoulder'];
			50 cutText [(format ['Carrying %1',(name _unit)]),'PLAIN DOWN',0.3];
		};
		_onFailed = {
			FALSE
		};
		[
			'Picking up',
			3,
			0,
			[[_t],{FALSE}],
			[[_t,(position _t)],_onCancelled],
			[[_t],_onCompleted],
			[[],{FALSE}]
		] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
	} else {
		comment 'Crate carrying';
		if ((currentWeapon player) isEqualTo '') then {
			_onProgress = {
				FALSE
			};
			_onCancelled = {
				params ['_entity','_position'];
				private _c = FALSE;
				if (!alive player) then {_c = TRUE;};
				if (!alive _entity) then {_c = TRUE;};
				if ((player distance2D _position) > 4) then {_c = TRUE;};
				if (!isNull (attachedTo _entity)) then {_c = TRUE};
				if (!((lifeState player) in ['HEALTHY','INJURED'])) then {_c = TRUE;};
				if ((!(_entity isEqualTo cursorObject)) && (!(_entity isEqualTo cursorTarget))) then {_c = TRUE;};
				if (!isNull (objectParent player)) then {_c = TRUE;};
				if (!isNull (objectParent _entity)) then {_c = TRUE;};
				_c;
			};
			_onCompleted = {
				params ['_entity'];
				player forceWalk TRUE;
				_entity attachTo [player,[0,0.5,1.1]];
				50 cutText [(format ['Carrying a(n) %1',(getText (configFile >> 'CfgVehicles' >> (typeOf _entity) >> 'displayName'))]),'PLAIN DOWN',0.3];
			};
			_onFailed = {
				FALSE
			};
			[
				'Picking up',
				3,
				0,
				[[_t],{FALSE}],
				[[_t,(position _t)],_onCancelled],
				[[_t],_onCompleted],
				[[],{FALSE}]
			] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
		} else {
			50 cutText ['Holster your weapon. Press [4]','PLAIN',0.3];
		};
	};
};