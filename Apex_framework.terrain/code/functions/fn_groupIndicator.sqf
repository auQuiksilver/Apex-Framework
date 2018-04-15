/*/
File: fn_groupIndicator.sqf
Script Name: QuackTac Fireteam HUD
Author:

	Quiksilver
	
Last modified:

	21/03/2018 A3 1.82 by Quiksilver
	
Description:

	Squad Radar
__________________________________________________/*/

if ((_this select 0) isEqualType controlNull) exitWith {
	_player = player;
	if (
		(!isNull (objectParent _player)) ||
		{(visibleCompass)} ||
		{(visibleMap)} ||
		{(!alive _player)} ||
		{(captive _player)} ||
		{(!(((uavControl (getConnectedUav _player)) select 1) isEqualTo ''))} ||
		{(!(cameraOn isEqualTo (vehicle _player)))} ||
		{((count (units _player)) < 2)} ||
		{(!isNull curatorCamera)}
	) exitWith {
		if (!((ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1002)) isEqualTo '')) then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1002) ctrlSetText '';
		};
		if (!((ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003)) isEqualTo '')) then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetText '';
		};
	};
	_map = param [0];
	_grp = group _player;
	_000 = positionCameraToWorld [0,0,0];
	_001 = positionCameraToWorld [0,0,1];
	_viewVector = ((_001 select 0) - (_000 select 0)) atan2 ((_001 select 1) - (_000 select 1));
	_viewVector2 = -_viewVector;
	_lc2 = [68,65];
	_toDrawLines = [];
	if (!((toLower (ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1002))) isEqualTo 'media\images\icons\squadback.paa')) then {
		((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1002) ctrlSetText 'media\images\icons\squadback.paa';
	};
	if ('ItemCompass' in (assignedItems _player)) then {
		if (!((toLower (ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003))) isEqualTo 'media\images\icons\squadradarcompassbackgroundtexture_ca.paa')) then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetText 'media\images\icons\SquadRadarCompassBackgroundTexture_ca.paa';
		};
		if (!((ctrlAngle ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003)) isEqualTo [_viewVector2,0.5,0.5])) then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetAngle [_viewVector2,0.5,0.5];
		};
	} else {
		if (!((toLower (ctrlText ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003))) isEqualTo 'media\images\icons\squadradarbackgroundtexture_ca.paa')) then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetText 'media\images\icons\squadradarbackgroundtexture_ca.paa';
		};
		if (!((ctrlAngle ((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003)) isEqualTo [0,0.5,0.5])) then {
			((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1003) ctrlSetAngle [0,0.5,0.5];
		};
	};
	_groupedUnits = missionNamespace getVariable ['QS_client_groupIndicator_units',[]];
	if (!(_groupedUnits isEqualTo [])) then {
		private _unit = objNull;
		private _unitVehicle = objNull;
		private _unitType = '';
		private _grpLeader = objNull;
		private _distToLeader = 0;
		private _posLeader = [0,0,0];
		private _pos = [0,0,0];
		private _icon = '';
		private _teamID = 0;
		private _colorTeam = [0,0,0,0];
		{
			_unit = _x;
			if (alive _unit) then {
				_unitVehicle = vehicle _unit;
				_grpLeader = leader _grp;
				_pos = _lc2 getPos [
					((_player distance2D _unitVehicle) / 15),
					((_player getDir _unitVehicle) - _viewVector)
				];
				if (_unit isEqualTo _player) then {
					if (_player isEqualTo _grpLeader) then {
						if (!((groupSelectedUnits _player) isEqualTo [])) then {
							private _selectedUnit = objNull;
							private _posSelectedUnit = [0,0,0];
							private _distToSelectedUnit = 0;
							{
								_selectedUnit = _x;
								_distToSelectedUnit = _player distance2D _selectedUnit;
								if (_distToSelectedUnit < 46) then {
									if (_distToSelectedUnit > 2) then {
										_posSelectedUnit = _lc2 getPos [(_distToSelectedUnit / 15),((_player getDir _selectedUnit) - _viewVector)];
										0 = _toDrawLines pushBack [_pos,_posSelectedUnit,[0,1,1,0.5]];
									};
								};
							} count (groupSelectedUnits _player);
						};
					} else {
						_distToLeader = _player distance2D _grpLeader;
						if (_distToLeader < 46) then {
							if (_distToLeader > 2) then {
								_posLeader = _lc2 getPos [(_distToLeader / 15),((_player getDir _grpLeader) - _viewVector)];
								0 = _toDrawLines pushBack [_pos,_posLeader,[0,1,1,0.5]];
							};
						};
					};
				};
				_teamID = 0;
				if (!isNil {assignedTeam _unit}) then {
					_teamID = (['MAIN','RED','GREEN','BLUE','YELLOW'] find (assignedTeam _unit)) max 0;
				};
				_colorTeam = [[1,1,1,1],[1,0,0,1],[0,1,0.5,1],[0,0.5,1,1],[1,1,0,1]] select _teamID;
				if (isNull (objectParent _unit)) then {
					if (!(_unit isEqualTo _grpLeader)) then {
						if (!((((units _grp) - [_unit]) findIf {((_unit distance2D _x) < 3)}) isEqualTo -1)) then {
							_colorTeam = [1,0.68,0.64,1];
						};
					};
				};
				if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
					_colorTeam = [1,0.41,0,1];
				};
				if ((isPlayer _unit) && (!((getPlayerChannel _unit) isEqualTo -1))) then {
					_icon = 'a3\ui_f\data\igui\rscingameui\rscdisplayvoicechat\microphone_ca.paa';
				} else {
					_unitType = typeOf _unitVehicle;
					_icon = missionNamespace getVariable [format ['QS_ST_iconType#%1',_unitType],''];
					if (_icon isEqualTo '') then {
						if (_unitVehicle isKindOf 'CAManBase') then {
							if (_unit getUnitTrait 'QS_trait_HQ') then {
								_icon = 'a3\ui_f\data\map\vehicleicons\iconManCommander_ca.paa';
								_icon = getText (configFile >> 'CfgVehicles' >> _unitType >> 'icon');
							} else {
								if (_unit getUnitTrait 'medic') then {
									_unitType = 'B_medic_F';
									_icon = getText (configFile >> 'CfgVehicles' >> _unitType >> 'icon');
								} else {
									if (_unit getUnitTrait 'engineer') then {
										_unitType = 'B_engineer_F';
										_icon = getText (configFile >> 'CfgVehicles' >> _unitType >> 'icon');
									} else {
										if (_unit getUnitTrait 'explosiveSpecialist') then {
											_unitType = 'B_soldier_exp_F';
											_icon = getText (configFile >> 'CfgVehicles' >> _unitType >> 'icon');
										} else {
											_icon = getText (configFile >> 'CfgVehicles' >> _unitType >> 'icon');
										};
									};
								};
							};
						} else {
							_icon = getText (configFile >> 'CfgVehicles' >> _unitType >> 'icon');
						};
						missionNamespace setVariable [format ['QS_ST_iconType#%1',_unitType],_icon,FALSE];
					};
				};
				if (alive _unit) then {
					if (_unit isEqualTo (effectiveCommander _unitVehicle)) then {
						_map drawIcon [_icon,_colorTeam,_pos,15,15,((getDirVisual _unit) - _viewVector),'',1,0,'RobotoCondensed','right'];
					};
				};
			};
		} count _groupedUnits;
	};
	if (!(_toDrawLines isEqualTo [])) then {
		{
			_map drawLine _x;
		} count _toDrawLines;
	};
};
if ((_this select 0) isEqualTo 'Init') then {
	disableSerialization;
	if (!isNil {player getVariable 'QS_HUD_3'}) exitWith {};
	16000 cutRsc ['QS_RD_dialog_hud','PLAIN'];
	_map = (uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1001;
	_map ctrlMapAnimAdd [0,0.1,[-100,-100,0]];
	ctrlMapAnimCommit _map;
	_size = ((_map ctrlMapScreenToWorld [0,0]) select 1) - ((_map ctrlMapScreenToWorld [0,1]) select 1);
	_sizeUI = ((ctrlPosition _map select 2) * 3/4) max ((ctrlPosition _map) select 3);
	_sizeCoef = _size / 1000;
	_sizeUI = ((ctrlPosition _map) select 2) min (((ctrlPosition _map) select 3) * 3/4);
	if ('st_sthud' in activatedAddons) then {
		0 spawn {
			_timeout = diag_tickTime + 10;
			waitUntil {
				((!(missionNamespace getVariable ['ST_STHud_ShownUI',-1] isEqualTo -1)) || (diag_tickTime > _timeout))
			};
			missionNamespace setVariable ['ST_STHud_ShownUI',0,FALSE];
		};
	};
	player setVariable ['QS_HUD_3',(_map ctrlAddEventHandler ['Draw',{_this call (missionNamespace getVariable 'QS_fnc_groupIndicator')}]),FALSE];
	_map ctrlMapAnimAdd [0,0.00074 / (_sizeUI * _sizeCoef),[68,65]];
	ctrlMapAnimCommit _map;
	((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1002) ctrlSetPosition (ctrlPosition((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1001));
	((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1002) ctrlCommit 0;
	((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1003) ctrlSetPosition (ctrlPosition((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1001));
	((uiNamespace getVariable 'QS_RD_client_dialog_hud') displayctrl 1003) ctrlCommit 0;
};
if ((_this select 0) isEqualTo 'Exit') then {
	disableSerialization;
	_map = (uiNamespace getVariable 'QS_RD_client_dialog_hud') displayCtrl 1001;
	_map ctrlRemoveEventHandler ['Draw',(player getVariable 'QS_HUD_3')];
	player setVariable ['QS_HUD_3',nil,FALSE];
	16000 cutText ['','PLAIN'];
};