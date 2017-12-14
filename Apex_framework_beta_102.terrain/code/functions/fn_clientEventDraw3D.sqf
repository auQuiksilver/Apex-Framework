/*/
File: fn_clientEventDraw3D.sqf
Author:

	Quiksilver
	
Last modified:

	27/10/2017 A3 1.76 by Quiksilver
	
Description:

	Draw 3D Event
	
To do:

	Integrate 'groupSelectedUnits'
__________________________________________________________________________/*/

if ((!alive player) || {(!isNull (findDisplay 49))}) exitWith {};
_time = diag_tickTime;
if (_time >= (uiNamespace getVariable ['QS_dynamicGroups_update',0])) then {
	_display = uiNamespace getVariable ['BIS_dynamicGroups_display',displayNull];
	if (!isNull _display) then {
		['Update',[FALSE]] call (uiNamespace getVariable ['RscDisplayDynamicGroups_script',{}]);
	};
	uiNamespace setVariable ['QS_dynamicGroups_update',(_time + ([0.5,2] select (isNull _display)))];
};
_player = player;
_cameraOn = cameraOn;
if ((!(_cameraOn in [_player,(vehicle _player)])) && (!(unitIsUav _cameraOn))) exitWith {};
private ['_alpha','_unit','_distance','_unitName','_unitType','_objectParent','_rgba','_array'];
if (isNull (objectParent _player)) then {
	_playerChannel = getPlayerChannel _player;
	if (_playerChannel isEqualTo 4) then {
		setCurrentChannel 5;
	};
	if ('ItemRadio' in (assignedItems _player)) then {
		if (!(_playerChannel in [-1,5,4])) then {
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
		if (!(_playerChannel in [-1,5,4])) then {
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
	private ['_pdist','_color','_lifeState','_vehicle','_isMan'];
	{
		_unit = _x;
		_lifeState = lifeState _unit;
		if (_lifeState isEqualTo 'INCAPACITATED') then {
			_pdist = _player distance2D _unit;
			if (_pdist > 2) then {
				_icon = 'a3\ui_f\data\igui\cfg\revive\overlayIcons\r100_ca.paa';
				if (_lifeState in ['DEAD','DEAD-RESPAWN','DEAD-SWITCHING']) then {
					_icon = 'a3\ui_f\data\igui\cfg\revive\overlayIcons\f100_ca.paa';
				};
				_alpha = 1 - (((_pdist / 500)) % 1);
				_color = [1,0,0,_alpha];					
				if (!(((_unit nearEntities ['CAManBase',2]) select {(!(_x isEqualTo _unit)) && (_x getUnitTrait 'medic') && ((lifeState _x) in ['HEALTHY','INJURED'])}) isEqualTo [])) then {
					_icon = 'a3\ui_f\data\igui\cfg\revive\overlayIcons\u100_ca.paa';
					_color = [0,0,1,_alpha];
				};
				_vehicle = vehicle _unit;
				_isMan = _vehicle isKindOf 'Man';
				if (_alpha > 0) then {
					drawIcon3D [
						_icon,
						_color,
						(if (_isMan) then {(_unit modelToWorldVisual (_unit selectionPosition 'Spine3'))} else {(_vehicle modelToWorldVisual [0,0,0])}),
						0.666,
						0.666,
						0,
						(if (_isMan) then {(format ['%1 (%2m)',(name _unit),(ceil _pdist)])} else {''}),
						1,
						0.03,
						'RobotoCondensed',
						'center',
						TRUE
					];
				};
			};
		};
	} count (missionNamespace getVariable ['QS_client_medicIcons_units',[]]);
} else {
	if ((_player getUnitTrait 'engineer') || {(_player getUnitTrait 'explosivespecialist')}) then {
		/*/private ['_v','_drawDist','_vt','_minePos'];/*/
		private _show = FALSE;
		{
			if ((_x select 0) isEqualTo 'MineDetectorDisplay') exitWith {
				_show = TRUE;
			};
		} forEach [(infoPanel 'left'),(infoPanel 'right')];
		if (_show) then {
			_v = vehicle _player;
			_vt = typeOf _v;
			if (('MineDetector' in (items _player)) || {((toLower _vt) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f'])}) then {
				_drawDist = 17.5;
				if ((toLower _vt) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']) then {
					_drawDist = 35;
				};
				{
					if ((_x distance2D _player) < _drawDist) then {
						_icon = 'a3\ui_f\data\map\VehicleIcons\iconexplosivegp_ca.paa';
						_minePos = getPosATLVisual _x;
						_scale = 1 - ((((_cameraOn distance2D _x) / (_drawDist + 0.1))) % 1);
						if (_scale > 0) then {
							drawIcon3D [
								_icon,
								[1,0,0,_scale],
								[(_minePos select 0),(_minePos select 1),((_minePos select 2) + 1)],
								1,
								1,
								0
							];
						};
					};
				} count (detectedMines playerSide);
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
			_icon = 'a3\ui_f\data\igui\cfg\cursors\select_ca.paa';
			{
				_objectParent = objectParent _x;
				drawIcon3D [
					_icon,
					[0,125,255,([1,0.5] select ((getPlayerChannel _x) isEqualTo -1))],
					(if (isNull _objectParent) then {(_x modelToWorldVisual (_x selectionPosition 'Spine3'))} else {(_objectParent modelToWorldVisual [0,0,0])}),
					0.5,
					0.5,
					0,
					'',
					0,
					0,
					'RobotoCondensed',
					'right',
					FALSE
				];
				if (_x isEqualTo (leader _player)) then {
					drawIcon3D [
						'a3\ui_f\data\igui\cfg\cursors\leader_ca.paa',
						[0,125,255,([1,0.5] select ((getPlayerChannel _x) isEqualTo -1))],
						(if (isNull _objectParent) then {(_x modelToWorldVisual (_x selectionPosition 'Spine3'))} else {(_objectParent modelToWorldVisual [0,0,0])}),
						0.5,
						0.5,
						0,
						'',
						0,
						0,
						'RobotoCondensed',
						'right',
						TRUE
					];
				};
			} count ((units _player) - [_player]);
		};
		if (freeLook) then {
			{
				if ((isPlayer _x) || {(_x in (units _player))}) then {
					if (!(_unit getVariable ['QS_hidden',FALSE])) then {
						_unit = _x;
						if (!(_unit isEqualTo _player)) then {
							if (((speed _unit) < 20) && ((speed _unit) > -20)) then {
								_icon = '';
								if (_unit in [cursorObject,cursorTarget]) then {
									_unitType = _player getVariable [(format ['QS_HUD_unitDN#%1',_unitType]),''];
									if (_unitType isEqualTo '') then {
										_unitType = getText (configFile >> 'CfgVehicles' >> (typeOf _unit) >> 'displayName');
										_player setVariable [(format ['QS_HUD_unitDN#%1',_unitType]),_unitType,FALSE];
									};
									_unitName = (name _unit) + (format [' (%1)',_unitType]);
								} else {
									_unitName = (name _unit);
								};
								_distance = _cameraOn distance _unit;
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
										(1 * 0.025),
										'RobotoCondensed',
										'right',
										FALSE
									];
								};
							};
						};
					};
				};
			} count ((getPosATL _player) nearEntities ['CAManBase',30]);
		} else {
			_unit = cursorTarget;
			if (isNull _unit) then {
				_unit = cursorObject;
			} else {
				if (!(_unit isKindOf 'Man')) then {
					_unit = cursorObject;
				};
			};
			if (!isNull _unit) then {
				if ((_unit isKindOf 'Man') || {((effectiveCommander _unit) isKindOf 'Man')}) then {
					if (((side _unit) isEqualTo playerSide) || {(isPlayer _unit)}) then {
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
										_unitType = _player getVariable [(format ['QS_HUD_unitDN#%1',_unitType]),''];
										if (_unitType isEqualTo '') then {
											_unitType = getText (configFile >> 'CfgVehicles' >> (typeOf _unit) >> 'displayName');
											_player setVariable [(format ['QS_HUD_unitDN#%1',_unitType]),_unitType,FALSE];
										};
										_unitName = (name _unit) + (format [' (%1)',_unitType]);
									} else {
										if (!isNil {_unit getVariable 'QS_ST_customDN'}) then {
											_unitType = _unit getVariable ['QS_ST_customDN',''];
										} else {
											_unitType = _player getVariable [(format ['QS_HUD_unitDN#%1',_unitType]),''];
											if (_unitType isEqualTo '') then {
												_unitType = getText (configFile >> 'CfgVehicles' >> (typeOf _unit) >> 'displayName');
												_player setVariable [(format ['QS_HUD_unitDN#%1',_unitType]),_unitType,FALSE];
											};
										};
										_unitName = '[AI]' + (format [' (%1)',_unitType]);
									};
								};
								drawIcon3D [
									_icon,
									[0,125,255,1],	/*/[0.25,1,0.25,1],/*/
									(_unit modelToWorldVisual ((_unit selectionPosition (['pilot','head'] select (_unit isKindOf 'Man'))) vectorAdd [0,0,0.5])),	/*/Issue here when vehicle is crossing bridge or something/*/
									1,
									1,
									0,
									_unitName,
									2,
									(1 * 0.03),
									'RobotoCondensed',
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
							0
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
				if ((_cameraOn distance2D (_array select 2)) < 29.5) then {
					_rgba = _array select 1;
					_rgba set [3,(1 - ((((_cameraOn distance2D (_array select 2)) / 30)) % 1))];
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
					if ((_cameraOn distance2D (_array select 2)) < 29.5) then {
						_rgba = _array select 1;
						_rgba set [3,(1 - ((((_cameraOn distance2D (_array select 2)) / 30)) % 1))];
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
						if ((_cameraOn distance2D (_array select 2)) < 29.5) then {
							_rgba = _array select 1;
							_rgba set [3,(1 - ((((_cameraOn distance2D (_array select 2)) / 30)) % 1))];
							_array set [1,_rgba];
							drawIcon3D _array;
						};
					};
				} count (missionNamespace getVariable ['QS_client_carrierIcons',[]]);
			};
		};
	};
};