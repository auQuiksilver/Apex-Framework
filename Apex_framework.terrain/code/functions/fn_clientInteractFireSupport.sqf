/*
File: fn_clientInteractFireSupport.sqf
Author:

	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	
_____________________________________________*/

_player = QS_player;
if (
	((binocular QS_player) isNotEqualTo '') &&
	{((currentWeapon QS_player) isEqualTo (binocular QS_player))} &&
	{(
		(isNull (objectParent QS_player)) ||
		{(isTurnedOut QS_player)}
	)} &&
	{(isNull curatorCamera)} &&
	{((QS_player getSlotItemName 611) isNotEqualTo '')} &&
	{((QS_player isEqualTo (leader (group QS_player))) || ((toLowerANSI (backpack QS_player)) in qs_core_classnames_radiobags))} &&
	{((missionNamespace getVariable ['QS_missionConfig_fireSupport',1]) > 0)}
) then {
	_conditionCancel = {
		_player = QS_player;
		_range = [600,1200] select (_player getUnitTrait 'QS_trait_jtac');
		_eyePos = eyePos _player;
		_weaponDir = _player weaponDirection (currentWeapon _player);
		_frontPos = _eyePos vectorAdd (_weaponDir vectorMultiply _range);
		_intersections = lineIntersectsSurfaces [
			_eyePos,
			_frontPos,
			_player
		];
		_inSafezone = FALSE;
		_safezoneLevel = 0;
		_safezoneActive = FALSE;
		if (_intersections isNotEqualTo []) then {
			_intersection = _intersections # 0;
			_posASL = _intersection # 0;
			if ((_posASL # 2) < 0) then {
				_posASL set [2,0];
			};
			_result = [_posASL,'SAFE'] call QS_fnc_inZone;
			_inSafezone = _result # 0;
			_safezoneLevel = _result # 1;
			_safezoneActive = _result # 2;
		};
		if (diag_tickTime < (uiNamespace getVariable ['QS_fireSupport_cooldown',-1])) exitWith {
			50 cutText [format [localize 'STR_QS_Menu_225',([ceil (((uiNamespace getVariable ['QS_fireSupport_cooldown',-1]) - (round diag_tickTime)) max 0),"MM:SS"] call BIS_fnc_secondsToString)],'PLAIN DOWN',0.333];
			TRUE
		};
		if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) exitWith {
			50 cutText [localize 'STR_QS_Menu_222','PLAIN DOWN',0.3];
			TRUE
		};
		(
			(!(uiNamespace getVariable ['QS_ui_action_spacebar',FALSE])) ||
			((currentWeapon _player) isNotEqualTo (binocular _player)) ||
			(!((lifeState _player) in ['HEALTHY','INJURED'])) ||
			(dialog) ||
			(_intersections isEqualTo [])
		)
	};
	_onCompleted = {
		_range = [600,1200] select (player getUnitTrait 'QS_trait_jtac');
		_eyePos = eyePos player;
		_weaponDir = player weaponDirection (currentWeapon player);
		_frontPos = _eyePos vectorAdd (_weaponDir vectorMultiply _range);
		_intersections = lineIntersectsSurfaces [
			_eyePos,
			_frontPos,
			player
		];
		if (_intersections isNotEqualTo []) then {
			_intersection = _intersections # 0;
			_posASL = _intersection # 0;
			if ((_posASL # 2) < 0) then {
				_posASL set [2,0];
			};
			missionNamespace setVariable ['QS_client_fireSupport_target',_posASL,FALSE];
			player setVariable ['QS_client_fireSupport_target',_posASL,FALSE];
			createDialog 'QS_RD_client_dialog_menu_fireSupport';
		};
	};
	[
		localize 'STR_QS_Menu_213',
		[4,2] select (player getUnitTrait 'QS_trait_jtac'),
		0,
		[[],{FALSE}],
		[[],_conditionCancel],
		[[],_onCompleted],
		[[],{FALSE}],
		FALSE,
		1,
		['\a3\ui_f\data\igui\cfg\cursors\attack_ca.paa']
	] spawn QS_fnc_clientProgressVisualization;
};