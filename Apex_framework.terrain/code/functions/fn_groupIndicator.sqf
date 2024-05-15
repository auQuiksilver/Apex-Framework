/*/
File: fn_groupIndicator.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Squad Radar
__________________________________________________/*/

if ((_this # 0) isEqualType controlNull) exitWith {
	_player = QS_player;
	if (
		(!isNull (objectParent _player)) ||
		{(!isGameFocused)} ||
		{(visibleCompass)} ||
		{(visibleMap)} ||
		{(!alive _player)} ||
		{(captive _player)} ||
		{(!isNull (remoteControlled _player))} ||
		{(cameraOn isNotEqualTo (vehicle _player))} ||
		{((count (units _player)) < 2)} ||
		{(!isNull curatorCamera)}
	) exitWith {
		if ((ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1002)) isNotEqualTo '') then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1002) ctrlSetText '';
		};
		if ((ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003)) isNotEqualTo '') then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetText '';
		};
	};
	_map = param [0];
	_grp = group _player;
	_000 = positionCameraToWorld [0,0,0];
	_001 = positionCameraToWorld [0,0,1];
	_viewVector = ((_001 # 0) - (_000 # 0)) atan2 ((_001 # 1) - (_000 # 1));
	_viewVector2 = -_viewVector;
	_lc2 = [68,65];
	_toDrawLines = [];
	if ((toLowerANSI (ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1002))) isNotEqualTo 'media\images\icons\squadback.paa') then {
		((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1002) ctrlSetText 'media\images\icons\squadback.paa';
	};
	if (
		((QS_player getSlotItemName 609) isNotEqualTo '') &&
		(!(missionNamespace getVariable ['QS_module_gpsJammer_inArea',FALSE]))
	) then {
		if ((toLowerANSI (ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003))) isNotEqualTo 'media\images\icons\squadradarcompassbackgroundtexture_ca.paa') then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetText 'media\images\icons\SquadRadarCompassBackgroundTexture_ca.paa';
		};
		if ((ctrlAngle ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003)) isNotEqualTo [_viewVector2,0.5,0.5]) then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetAngle [_viewVector2,0.5,0.5];
		};
	} else {
		if ((toLowerANSI (ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003))) isNotEqualTo 'media\images\icons\squadradarbackgroundtexture_ca.paa') then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetText 'media\images\icons\squadradarbackgroundtexture_ca.paa';
		};
		if ((ctrlAngle ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003)) isNotEqualTo [0,0.5,0.5]) then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetAngle [0,0.5,0.5];
		};
	};
	_areaUnits = missionNamespace getVariable ['QS_client_groupIndicator_units',[]];
	if (_areaUnits isNotEqualTo []) then {
		private _unit = objNull;
		private _unitVehicle = objNull;
		private _unitType = '';
		private _grpLeader = objNull;
		private _distToLeader = 0;
		private _posLeader = [0,0,0];
		private _pos = [0,0,0];
		private _icon = '';
		private _colorTeam = [0,0,0,0];
		{
			_unit = _x;
			_unitVehicle = vehicle _unit;
			_pos = _lc2 getPos [
				((_player distance2D _unitVehicle) / 15),
				((_player getDirVisual _unitVehicle) - _viewVector)
			];
			if (_unit in (units _grp)) then {
				_grpLeader = leader _grp;
				if (_unit isEqualTo _player) then {
					if (_player isEqualTo _grpLeader) then {
						if ((groupSelectedUnits _player) isNotEqualTo []) then {
							private _selectedUnit = objNull;
							private _posSelectedUnit = [0,0,0];
							private _distToSelectedUnit = 0;
							{
								_selectedUnit = _x;
								_distToSelectedUnit = _player distance2D _selectedUnit;
								if ((_distToSelectedUnit < 46) && (_distToSelectedUnit > 2)) then {
									_posSelectedUnit = _lc2 getPos [(_distToSelectedUnit / 15),((_player getDirVisual _selectedUnit) - _viewVector)];
									0 = _toDrawLines pushBack [_pos,_posSelectedUnit,[0,1,1,0.5]];
								};
							} count (groupSelectedUnits _player);
						};
					} else {
						_distToLeader = _player distance2D _grpLeader;
						if ((_distToLeader < 46) && (_distToLeader > 2)) then {
							_posLeader = _lc2 getPos [(_distToLeader / 15),((_player getDirVisual _grpLeader) - _viewVector)];
							0 = _toDrawLines pushBack [_pos,_posLeader,[0,1,1,0.5]];
						};
					};
				};
				_colorTeam = [[1,1,1,1],[1,1,1,1],[1,0,0,1],[0,1,0.5,1],[0,0.5,1,1],[1,1,0,1]] # ((['','MAIN','RED','GREEN','BLUE','YELLOW'] find (assignedTeam _unit)) max 1);
				if (
					(isNull (objectParent _unit)) &&
					{(_unit isNotEqualTo _grpLeader)} &&
					{((((units _grp) - [_unit]) findIf {((_unit distance2D _x) < 3)}) isNotEqualTo -1)}
				) then {
					_colorTeam = [1,0.68,0.64,1];
				};
				if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
					_colorTeam = [1,(([0.41,(0.41 * ((((_unit getVariable ['QS_revive_downtime',serverTime]) + 600) - serverTime) / 600))] select (isPlayer _unit)) max 0),0,1];
				};
				if (!((lifeState _unit) in ['HEALTHY','INJURED','INCAPACITATED'])) then {
					_colorTeam set [3,0.25];
				};
				if ((isPlayer _unit) && ((getPlayerChannel _unit) isNotEqualTo -1)) then {
					_unit setRandomLip TRUE;
					_icon = 'a3\ui_f\data\igui\rscingameui\rscdisplayvoicechat\microphone_ca.paa';
				} else {
					_unit setRandomLip FALSE;
					_unitType = typeOf _unitVehicle;
					if ((isPlayer _unit) && {(_unitType isKindOf 'CAManBase')}) then {
						_icon = _unit getVariable ['QS_unit_role_icon',-1];
						if (_icon isEqualTo -1) then {
							_icon = ['GET_ROLE_ICONMAP',(_unit getVariable ['QS_unit_role','rifleman']),_unit] call (missionNamespace getVariable 'QS_fnc_roles');
						};
					} else {
						_icon = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_icon',toLowerANSI _unitType],
							{getText ((configOf _unitVehicle) >> 'icon')},
							TRUE
						];
					};
				};
				if (_unit isEqualTo (effectiveCommander _unitVehicle)) then {
					_map drawIcon [_icon,_colorTeam,_pos,15,15,((getDirVisual _unit) - _viewVector)];
				};
			} else {
				if ((_player distance2D _unit) < 46) then {
					_map drawIcon ['a3\ui_f\data\igui\RscCustomInfo\Sensors\Targets\EnemyMan_ca.paa',[1,1,1,([0.25,1] select ((lifeState _unit) in ['HEALTHY','INJURED','INCAPACITATED']))],_pos,10,10,0];
				};
			};
		} count _areaUnits;
	};
	if (_toDrawLines isNotEqualTo []) then {
		{
			_map drawLine _x;
		} count _toDrawLines;
	};
};
if ((_this # 0) isEqualTo 'Init') exitWith {
	disableSerialization;
	if !(player isNil 'QS_HUD_3') exitWith {};
	16000 cutRsc ['QS_RD_dialog_hud','PLAIN'];
	_map = (uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1001;
	_map ctrlMapAnimAdd [0,0.1,[-100,-100,0]];
	ctrlMapAnimCommit _map;
	_size = ((_map ctrlMapScreenToWorld [0,0]) # 1) - ((_map ctrlMapScreenToWorld [0,1]) # 1);
	_sizeUI = (((ctrlPosition _map) # 2) * 3/4) max ((ctrlPosition _map) # 3);
	_sizeCoef = _size / 1000;
	_sizeUI = ((ctrlPosition _map) # 2) min (((ctrlPosition _map) # 3) * 3/4);
	if ('st_sthud' in activatedAddons) then {
		0 spawn {
			_timeout = diag_tickTime + 10;
			waitUntil {
				uiSleep 0.1;
				((missionNamespace getVariable ['ST_STHud_ShownUI',-1] isNotEqualTo -1) || {(diag_tickTime > _timeout)})
			};
			missionNamespace setVariable ['ST_STHud_ShownUI',0,FALSE];
		};
	};
	player setVariable ['QS_HUD_3',(_map ctrlAddEventHandler ['Draw',{call (missionNamespace getVariable 'QS_fnc_groupIndicator')}]),FALSE];
	_map ctrlMapAnimAdd [0,0.00074 / (_sizeUI * _sizeCoef),[68,65]];
	ctrlMapAnimCommit _map;
	private _radarPos = ctrlPosition ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1001);
	if ((profileNamespace getVariable ['QS_hud_radar_pos',[]]) isNotEqualTo []) then {
		_radarPos = profileNamespace getVariable ['QS_hud_radar_pos',[]];
	};
	((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1002) ctrlSetPosition _radarPos;
	((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1002) ctrlCommit 0;
	((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1003) ctrlSetPosition _radarPos;
	((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1003) ctrlCommit 0;
};
if ((_this # 0) isEqualTo 'Exit') exitWith {
	disableSerialization;
	_map = (uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1001;
	_map ctrlRemoveEventHandler ['Draw',(player getVariable 'QS_HUD_3')];
	player setVariable ['QS_HUD_3',nil,FALSE];
	16000 cutText ['','PLAIN'];
};
if ((_this # 0) isEqualTo 'Update_Pos') exitWith {
	// WIP
};