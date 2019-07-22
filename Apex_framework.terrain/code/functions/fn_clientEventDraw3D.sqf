/*/
File: fn_clientEventDraw3D.sqf
Author:

	Quiksilver
	
Last modified:

	11/07/2019 A3 1.94 by Quiksilver
	
Description:

	Draw 3D Event
_________________________________________________/*/

_time = diag_tickTime;
if (_time >= (uiNamespace getVariable ['QS_dynamicGroups_update',0])) then {
	_display = uiNamespace getVariable ['BIS_dynamicGroups_display',displayNull];
	if (!isNull _display) then {
		['Update',[FALSE]] call (uiNamespace getVariable ['RscDisplayDynamicGroups_script',{}]);
	};
	uiNamespace setVariable ['QS_dynamicGroups_update',(_time + ([0.5,2] select (isNull _display)))];
};
_player = player;
if ((!((lifeState _player) in ['HEALTHY','INJURED'])) || {(!isNull (findDisplay 49))} || {(!isNull curatorCamera)}) exitWith {};
_cameraOn = cameraOn;
if ((!(_cameraOn in [_player,(vehicle _player)])) && (!(unitIsUav _cameraOn))) exitWith {};
private _alpha = 0;
private _unit = objNull;
private _distance = 0;
private _unitName = '';
private _unitType = '';
private _rgba = [0,0,0,0];
private _array = [];
_font = 'RobotoCondensedBold';
if (isNull (objectParent _player)) then {
	if ((getPlayerChannel _player) isEqualTo 4) then {
		setCurrentChannel 5;
	};
	if ('ItemRadio' in (assignedItems _player)) then {
		if (!((getPlayerChannel _player) in [-1,5,4])) then {
			if (!(uiNamespace getVariable ['QS_UI_radio_shown',FALSE])) then {
				uiNamespace setVariable ['QS_UI_radio_shown',TRUE];
				'QS_ui_radio_layer' cutRsc ['QS_radio','PLAIN'];
				if ((uiNamespace getVariable ['QS_ui_timeLastRadioIn',_time]) < (_time - 3)) then {
					uiNamespace setVariable ['QS_ui_timeLastRadioIn',_time];
					playSound (selectRandom ['QS_radio_in_0','QS_radio_in_1','QS_radio_in_2']);
				};
			};
		} else {
			if (uiNamespace getVariable ['QS_UI_radio_shown',FALSE]) then {
				uiNamespace setVariable ['QS_UI_radio_shown',FALSE];
				'QS_ui_radio_layer' cutText ['','PLAIN'];
				if ((uiNamespace getVariable ['QS_ui_timeLastRadioOut',_time]) < (_time - 3)) then {
					uiNamespace setVariable ['QS_ui_timeLastRadioOut',_time];
					playSound (selectRandom ['QS_radio_out_0','QS_radio_out_1','QS_radio_out_2']);
				};
			};
		};
	} else {
		if (uiNamespace getVariable ['QS_UI_radio_shown',FALSE]) then {
			uiNamespace setVariable ['QS_UI_radio_shown',FALSE];
			'QS_ui_radio_layer' cutText ['','PLAIN'];
			if ((uiNamespace getVariable ['QS_ui_timeLastRadioOut',_time]) < (_time - 3)) then {
				uiNamespace setVariable ['QS_ui_timeLastRadioOut',_time];
				playSound (selectRandom ['QS_radio_out_0','QS_radio_out_1','QS_radio_out_2']);
			};
		};
		if (!((getPlayerChannel _player) in [-1,5,4])) then {
			setCurrentChannel 5;
		};
	};
} else {
	if (uiNamespace getVariable ['QS_UI_radio_shown',FALSE]) then {
		uiNamespace setVariable ['QS_UI_radio_shown',FALSE];
		'QS_ui_radio_layer' cutText ['','PLAIN'];
		if ((uiNamespace getVariable ['QS_ui_timeLastRadioOut',_time]) < (_time - 3)) then {
			uiNamespace setVariable ['QS_ui_timeLastRadioOut',_time];
			playSound (selectRandom ['QS_radio_out_0','QS_radio_out_1','QS_radio_out_2']);
		};
	};
};
if (visibleMap) exitWith {};
if (_player getUnitTrait 'medic') then {
	private _sTime = serverTime;
	private _vehicle = objNull;
	if (!((missionNamespace getVariable ['QS_client_medicIcons_units',[]]) isEqualTo [])) then {
		_pulse = ([2,25] call (missionNamespace getVariable 'QS_fnc_pulsate')) max 0.1;
		{
			_unit = _x;
			if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
				_distance = _player distance2D _unit;
				if (_distance > 2) then {
					_icon = 'a3\ui_f\data\igui\cfg\revive\overlayIcons\r100_ca.paa';
					_alpha = (1 - (((_distance / 500)) % 1)) min _pulse;
					_rgba = [1,(([0.41,(0.41 * ((((_unit getVariable ['QS_revive_downtime',_sTime]) + 600) - _sTime) / 600))] select (isPlayer _unit)) max 0),0,_alpha];
					if (!(((_unit nearEntities ['CAManBase',2]) select {(!(_x isEqualTo _unit)) && (_x getUnitTrait 'medic') && ((lifeState _x) in ['HEALTHY','INJURED'])}) isEqualTo [])) then {
						_icon = 'a3\ui_f\data\igui\cfg\revive\overlayIcons\u100_ca.paa';
						_rgba = [0.25,0.5,1,_alpha];
					};
					_vehicle = vehicle _unit;
					if (_alpha > 0) then {
						drawIcon3D [
							_icon,
							_rgba,
							(if (_vehicle isKindOf 'CAManBase') then {(_unit modelToWorldVisual (_unit selectionPosition 'Spine3'))} else {(_vehicle modelToWorldVisual [0,0,0])}),
							0.666,
							0.666,
							0,
							(if (_vehicle isKindOf 'CAManBase') then {(format ['%1 (%2m)',(name _unit),(ceil _distance)])} else {''}),
							1,
							0.03,
							_font,
							'center',
							TRUE
						];
					};
				};
			};
		} count (missionNamespace getVariable ['QS_client_medicIcons_units',[]]);
	};
} else {
	if ((_player getUnitTrait 'engineer') || {(_player getUnitTrait 'explosivespecialist')}) then {
		if ('MineDetectorDisplay' in ((infoPanel 'left') + (infoPanel 'right'))) then {
			_v = vehicle _player;
			_vt = typeOf _v;
			if (('MineDetector' in (items _player)) || {((toLower _vt) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f'])}) then {
				_drawDist = 17.5;
				if ((toLower _vt) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']) then {
					_drawDist = 35;
				};
				{
					if ((_x distance2D _player) < _drawDist) then {
						_minePos = getPosATLVisual _x;
						_scale = 1 - ((((_cameraOn distance2D _x) / (_drawDist + 0.1))) % 1);
						if (_scale > 0) then {
							drawIcon3D [
								'a3\ui_f\data\map\VehicleIcons\iconexplosivegp_ca.paa',
								[1,0,0,_scale],
								[(_minePos # 0),(_minePos # 1),((_minePos # 2) + 1)],
								1,
								1,
								0
							];
						};
					};
				} count (detectedMines (_player getVariable ['QS_unit_side',WEST]));
			};
		};
	};
};
if (!isStreamFriendlyUIEnabled) then {
	if (!shownChat) then {
		showChat TRUE;
	};
	if (!isNull _cameraOn) then {
		if ('ItemGPS' in (assignedItems _player)) then {
			{
				if ((_player isEqualTo (leader (group _player))) && (_x in (groupSelectedUnits _player))) then {
					private _teamID = 0;
					if (!isNil {assignedTeam _x}) then {
						_teamID = (['MAIN','RED','GREEN','BLUE','YELLOW'] find (assignedTeam _x)) max 0;
					};
					drawIcon3D [
						'a3\ui_f\data\igui\cfg\cursors\select_ca.paa',
						([([0,125,255,([1,0.75] select ((getPlayerChannel _x) isEqualTo -1))]),[1,0,0,([1,0.75] select ((getPlayerChannel _x) isEqualTo -1))],[0,1,0.5,([1,0.75] select ((getPlayerChannel _x) isEqualTo -1))],[0,0.5,1,([1,0.75] select ((getPlayerChannel _x) isEqualTo -1))],[1,1,0,([1,0.75] select ((getPlayerChannel _x) isEqualTo -1))]] select _teamID),
						(if (isNull (objectParent _x)) then {(_x modelToWorldVisual (_x selectionPosition 'Spine3'))} else {((objectParent _x) modelToWorldVisual [0,0,0])}),
						0.7,
						0.7,
						0,
						(['',(format ['%1',((((units _player) find _x) + 1) max 1)])] select (isNull (objectParent _x))),
						1,
						0.03,
						_font,
						'center',
						FALSE
					];
				} else {
					drawIcon3D [
						'a3\ui_f\data\igui\cfg\cursors\select_ca.paa',
						[0,125,255,([1,0.5] select ((getPlayerChannel _x) isEqualTo -1))],
						(if (isNull (objectParent _x)) then {(_x modelToWorldVisual (_x selectionPosition 'Spine3'))} else {((objectParent _x) modelToWorldVisual [0,0,0])}),
						0.5,
						0.5,
						0,
						'',
						0,
						0,
						_font,
						'center',
						FALSE
					];
				};
				if (_x isEqualTo (leader _player)) then {
					drawIcon3D [
						'a3\ui_f\data\igui\cfg\cursors\leader_ca.paa',
						[0,125,255,([1,0.5] select ((getPlayerChannel _x) isEqualTo -1))],
						(if (isNull (objectParent _x)) then {(_x modelToWorldVisual (_x selectionPosition 'Spine3'))} else {((objectParent _x) modelToWorldVisual [0,0,0])}),
						0.5,
						0.5,
						0,
						'',
						1,
						0,
						_font,
						'center',
						TRUE
					];
				};
			} count ((units _player) - [_player]);
		};
		if (freeLook) then {
			{
				_unit = _x;
				if ((side (group _unit)) isEqualTo (player getVariable ['QS_unit_side',WEST])) then {
					if (!(_unit getVariable ['QS_hidden',FALSE])) then {
						if (!(_unit isEqualTo _player)) then {
							if (((vectorMagnitude (velocity _unit)) * 3.6) <= 24) then {
								_icon = '';
								if (_unit in [cursorObject,cursorTarget]) then {
									if (isPlayer _unit) then {
										if (!isNil {_unit getVariable 'QS_ST_customDN'}) then {
											_unitType = _unit getVariable ['QS_ST_customDN',''];
										} else {
											_unitType = ['GET_ROLE_DISPLAYNAME',(_unit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
										};
									} else {
										if (!isNil {_unit getVariable 'QS_ST_customDN'}) then {
											_unitType = _unit getVariable ['QS_ST_customDN',''];
										} else {
											_unitType = missionNamespace getVariable [(format ['QS_ST_iconType#%1',_unitType]),''];
											if (_unitType isEqualTo '') then {
												_unitType = getText (configFile >> 'CfgVehicles' >> (typeOf _unit) >> 'displayName');
												missionNamespace setVariable [(format ['QS_ST_iconType#%1',_unitType]),_unitType,FALSE];
											};
										};
									};
									_unitName = (name _unit) + (format [' (%1)',_unitType]);
								} else {
									_unitName = (name _unit);
								};
								if (_player getUnitTrait 'medic') then {
									_unitName = format ['%1 (%2)',_unitName,(lifeState _unit)];
								};
								_distance = _cameraOn distance2D _unit;
								_alpha = 1 - (((_distance / 31)) % 1);
								if (_alpha > 0) then {
									drawIcon3D [
										_icon,
										[0.75,0.75,0.75,_alpha],
										(_unit modelToWorldVisual ((_unit selectionPosition 'head') vectorAdd [0,0,0.5])),
										1,
										1,
										0,
										_unitName,
										2,
										0.025,
										_font,
										'right',
										FALSE
									];
								};
							};
						};
					};
				};
			} count ((getPosATL _cameraOn) nearEntities ['CAManBase',30]);
		} else {
			_unit = cursorTarget;
			if (isNull _unit) then {
				_unit = cursorObject;
			} else {
				if (!(_unit isKindOf 'CAManBase')) then {
					_unit = cursorObject;
				};
			};
			if (!isNull _unit) then {
				if ((_unit isKindOf 'CAManBase') || {((effectiveCommander _unit) isKindOf 'CAManBase')}) then {
					if ((side (group _unit)) isEqualTo (player getVariable ['QS_unit_side',WEST])) then {
						if (!(_unit isEqualTo _player)) then {
							if (!(_unit getVariable ['QS_hidden',FALSE])) then {
								_icon = '';
								if ((_cameraOn distance2D _unit) >= 30) then {
									if ((_cameraOn distance2D _unit) >= 300) then {
										_unitName = '(Friendly)';
									} else {
										if (isPlayer _unit) then {
											_unitName = (name _unit) + ' (Friendly)';
										} else {
											_unitName = '[AI] (Friendly)';
										};
									};
								} else {
									if (isPlayer _unit) then {
										if (!isNil {_unit getVariable 'QS_ST_customDN'}) then {
											_unitType = _unit getVariable ['QS_ST_customDN',''];
										} else {
											_unitType = ['GET_ROLE_DISPLAYNAME',(_unit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
										};								
										_unitName = (name _unit) + (format [' (%1)',_unitType]);
									} else {
										if (!isNil {_unit getVariable 'QS_ST_customDN'}) then {
											_unitType = _unit getVariable ['QS_ST_customDN',''];
										} else {
											_unitType = missionNamespace getVariable [(format ['QS_ST_iconType#%1',_unitType]),''];
											if (_unitType isEqualTo '') then {
												_unitType = getText (configFile >> 'CfgVehicles' >> (typeOf _unit) >> 'displayName');
												missionNamespace setVariable [(format ['QS_ST_iconType#%1',_unitType]),_unitType,FALSE];
											};
										};
										_unitName = '[AI]' + (format [' (%1)',_unitType]);
									};
								};
								drawIcon3D [
									_icon,
									[0,125,255,1],
									(_unit modelToWorldVisual ((_unit selectionPosition (['pilot','head'] select (_unit isKindOf 'CAManBase'))) vectorAdd [0,0,0.5])),
									1,
									1,
									0,
									_unitName,
									2,
									0.03,
									_font,
									'right',
									FALSE
								];
							};
						};
					};
				};
			};
		};
	};
} else {
	if (shownChat) then {
		showChat FALSE;
	};
};
if (!((missionNamespace getVariable ['QS_draw3D_projectiles',[]]) isEqualTo [])) then {
	private _scale = 1;
	_array = missionNamespace getVariable ['QS_draw3D_projectiles',[]];
	_deg = ((ceil _time) - _time) * 720;
	{
		if (_x isEqualType objNull) then {
			if (!isNull _x) then {
				if ((_cameraOn distance2D _x) < 999) then {
					_scale = 1 - ((((_cameraOn distance2D _x) / 1000)) % 1);
					if (_scale > 0) then {
						drawIcon3D [
							'a3\ui_f\data\igui\cfg\cursors\explosive_ca.paa',
							[1,0,0,_scale],
							(getPosVisual _x),
							_scale,
							_scale,
							_deg
						];
					};
				};
			};
		};
	} count _array;
};
if (!((missionNamespace getVariable ['QS_client_customDraw3D',[]]) isEqualTo [])) then {
	_array = missionNamespace getVariable ['QS_client_customDraw3D',[]];
	{
		if (_x isEqualType []) then {
			drawIcon3D _x;
		};
	} count _array;
};
if (_player getVariable ['QS_client_inBaseArea',FALSE]) then {
	if (!((missionNamespace getVariable ['QS_client_baseIcons',[]]) isEqualTo [])) then {
		{
			_array = _x;
			if (_array isEqualType []) then {
				if ((_cameraOn distance2D (_array # 2)) < 29.5) then {
					_rgba = _array # 1;
					_rgba set [3,(1 - ((((_cameraOn distance2D (_array # 2)) / 30)) % 1))];
					_array set [1,_rgba];
					drawIcon3D _array;
				};
			};
		} count (missionNamespace getVariable ['QS_client_baseIcons',[]]);
	};
} else {
	if (_player getVariable ['QS_client_inFOBArea',FALSE]) then {
		if (!((missionNamespace getVariable ['QS_client_fobIcons',[]]) isEqualTo [])) then {
			{
				_array = _x;
				if (_array isEqualType []) then {
					if ((_cameraOn distance2D (_array # 2)) < 29.5) then {
						_rgba = _array # 1;
						_rgba set [3,(1 - ((((_cameraOn distance2D (_array # 2)) / 30)) % 1))];
						_array set [1,_rgba];
						drawIcon3D _array;
					};
				};
			} count (missionNamespace getVariable ['QS_client_fobIcons',[]]);
		};
	} else {
		if (_player getVariable ['QS_client_inCarrierArea',FALSE]) then {
			if (!((missionNamespace getVariable ['QS_client_carrierIcons',[]]) isEqualTo [])) then {
				{
					_array = _x;
					if (_array isEqualType []) then {
						if ((_cameraOn distance2D (_array # 2)) < 29.5) then {
							_rgba = _array # 1;
							_rgba set [3,(1 - ((((_cameraOn distance2D (_array # 2)) / 30)) % 1))];
							_array set [1,_rgba];
							drawIcon3D _array;
						};
					};
				} count (missionNamespace getVariable ['QS_client_carrierIcons',[]]);
			};
		};
	};
};