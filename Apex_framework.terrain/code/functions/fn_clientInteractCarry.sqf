/*
File: fn_clientInteractCarry.sqf
Author:

	Quiksilver
	
Last Modified:

	29/10/2023 A3 2.14 by Quiksilver
	
Description:

	Carry an entity
_________________________________________*/

private _t = cursorTarget;
if (!isNull (objectParent _t)) exitWith {};
if (
	(!(_t isKindOf 'CAManBase')) && 
	(!([0,_t,objNull] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')))
) exitWith {};
if (_t getVariable ['QS_interaction_disabled',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_087','PLAIN',0.3];
};
if (_t getVariable ['QS_unit_needsStabilise',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Text_088','PLAIN',0.3];
};
if (_t getVariable ['QS_logistics_immovable',FALSE]) exitWith {50 cutText [localize 'STR_QS_Text_335','PLAIN DOWN',0.25];};
if (
	(_t isKindOf 'StaticWeapon') && 
	(!(unitIsUav _t)) && 
	(((crew _t) findIf {(alive _x)}) isNotEqualTo -1)
) exitWith {};
if ([_t,0] call QS_fnc_logisticsMovementDisallowed) exitWith {
	50 cutText [localize 'STR_QS_Text_402','PLAIN',0.3];
};
if (_t isKindOf 'CAManBase') then {
	//if ((currentWeapon player) isNotEqualTo '') then {
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
			if ((lifeState _unit) isNotEqualTo 'INCAPACITATED') then {_c = TRUE;};
			if (!((lifeState player) in ['HEALTHY','INJURED'])) then {_c = TRUE;};
			if ((_unit isNotEqualTo cursorObject) && (_unit isNotEqualTo cursorTarget)) then {_c = TRUE;};
			if (!isNull (objectParent player)) then {_c = TRUE;};
			if (!isNull (objectParent _unit)) then {_c = TRUE;};
			_c;
		};
		_onCompleted = {
			params ['_unit'];
			[7.2,_unit,'ainjpfalmstpsnonwnondf_carried_dead',player,'acinpercmstpsnonwnondnon'] remoteExec ['QS_fnc_remoteExec',0,FALSE];
			player forceWalk TRUE;
			[1,_unit,[player,[0.1,-0.1,-1.2],'leftshoulder',TRUE]] call QS_fnc_eventAttach;
			50 cutText [(format [localize 'STR_QS_Text_089',(name _unit)]),'PLAIN DOWN',0.3];
		};
		_onFailed = {
			FALSE
		};
		[
			localize 'STR_QS_Menu_167',
			3,
			0,
			[[_t],{FALSE}],
			[[_t,(position _t)],_onCancelled],
			[[_t],_onCompleted],
			[[],{FALSE}]
		] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
	//} else {
	//	50 cutText [localize 'STR_QS_Text_090','PLAIN DOWN',0.4];
	//};
} else {
	//comment 'Crate carrying';
	// Static Weapon object volume band-aid fix
	if (
		(_t isKindOf 'StaticWeapon') &&
		{(([_t] call QS_fnc_getObjectVolume) > 3)} &&					// Note: ???
		{((_t getVariable ['QS_logistics_objvol',-1]) isEqualTo -1)}
	) then {
		_t setVariable ['QS_logistics_objvol',3,TRUE];
	};
	if (
		([0,_t,objNull] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) &&
		{([4,_t,(vehicle player)] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams'))} &&
		{(!((getPlayerUID player) in QS_blacklist_logistics))}
	) then {
		if ((stance player) isEqualTo 'STAND') then {
			if ((currentWeapon player) isNotEqualTo '') then {
				player setVariable ['QS_RD_holsteredWeapon',(currentWeapon player),FALSE];
				player action ['SwitchWeapon',player,player,100];
				uiSleep 0.1;
			};
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
				if ((_entity isNotEqualTo cursorObject) && (_entity isNotEqualTo cursorTarget)) then {_c = TRUE;};
				if (!isNull (objectParent player)) then {_c = TRUE;};
				if (!isNull (objectParent _entity)) then {_c = TRUE;};
				if ((_entity isKindOf 'StaticWeapon') && (!(unitIsUav _entity)) && (((crew _entity) findIf {(alive _x)}) isNotEqualTo -1)) then {_c = TRUE;};
				if ((stance player) isNotEqualTo 'STAND') then {_c = TRUE;};
				if ((currentWeapon player) isNotEqualTo '') then {_c = TRUE;};
				_c;
			};
			_onCompleted = {
				params ['_entity'];
				if (!local _entity) then {
					[66,TRUE,_entity,clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
				[QS_player,_entity,FALSE,TRUE] call QS_fnc_unloadCargoPlacementMode;
			};
			_onFailed = {
				FALSE
			};
			[
				localize 'STR_QS_Menu_167',
				2,
				0,
				[[_t],{FALSE}],
				[[_t,(position _t)],_onCancelled],
				[[_t],_onCompleted],
				[[],{FALSE}]
			] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
		} else {
			50 cutText [localize 'STR_QS_Text_093','PLAIN',0.3];
		};
	} else {
		50 cutText [localize 'STR_QS_Text_094','PLAIN',0.3];
		if ((getPlayerUID player) in QS_blacklist_logistics) then {
			50 cutText [localize 'STR_QS_Text_388','PLAIN',0.3];
		};
	};
};