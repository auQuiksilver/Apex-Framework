/*/
File: fn_clientEventDraw3D.sqf
Author:

	Quiksilver
	
Last modified:

	20/11/2023 A3 2.14 by Quiksilver
	
Description:

	Draw 3D Event
_________________________________________________/*/

_time = diag_tickTime;
_player = QS_player;
_focusOn = focusOn;
_cameraOn = cameraOn;
_curatorView = !isNull curatorCamera;
_cameraView = cameraView;
_thisFrame = diag_frameNo;
// Eval every 10 frames
if (_thisFrame > (uiNamespace getVariable ['QS_eval_frameInterval_10',-1])) then {
	uiNamespace setVariable ['QS_eval_frameInterval_10',_thisFrame + 10];
	if (
		(local _cameraOn) &&
		{(alive (ropeAttachedTo _cameraOn))} &&
		{(_cameraOn isKindOf 'LandVehicle')}
	) then {
		_parent = ropeAttachedTo _cameraOn;
		_rope = (ropes _parent) # 0;
		if ((_rope getVariable ['QS_rope_relation',[]]) isNotEqualTo []) then {
			(_rope getVariable ['QS_rope_relation',[]]) params ['_parent','_child','_relation'];
			if (
				(_child isEqualTo _cameraOn) &&
				{((getTowParent _child) isNotEqualTo _parent)}
			) then {
				_child setTowParent _parent;
			};
		};
	};
	_goggles = toLowerANSI (goggles _player);
	if ((_goggles in ['g_blindfold_01_black_f','g_blindfold_01_white_f']) && (!_curatorView) && (_cameraView in ['INTERNAL','EXTERNAL','GUNNER'])) then {
		if (!(missionNamespace getVariable ['QS_facewear_effect_1',FALSE])) then {
			missionNamespace setVariable ['QS_facewear_effect_1',TRUE];
			(['QS_facewear_effect1'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutRsc ['RscBlindfold','PLAIN'];
		};
	} else {
		if (missionNamespace getVariable ['QS_facewear_effect_1',FALSE]) then {
			missionNamespace setVariable ['QS_facewear_effect_1',FALSE];
			(['QS_facewear_effect1'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutText ['','PLAIN'];
		};
	};
	if ((_goggles in ['g_airpurifyingrespirator_01_f','g_airpurifyingrespirator_02_sand_f','g_airpurifyingrespirator_02_olive_f','g_airpurifyingrespirator_02_black_f','g_airpurifyingrespirator_01_nofilter_f']) && (!_curatorView) && (_cameraView in ['INTERNAL','EXTERNAL','GUNNER'])) then {
		if (_time > (uiNamespace getVariable ['QS_ui_cbrnBreathInterval',-1])) then {
			uiNamespace setVariable ['QS_ui_cbrnBreathInterval',_time + ((random [3.8,4,4.2]) - (1.5 * ((getFatigue _player) max (damage _player))))];
			_pitch = random [0.97,1,1.03];
			if (_goggles in ['g_airpurifyingrespirator_01_nofilter_f']) then {
				_pitch = random [1.20,1.23,1.26];
			} else {
				_pitch = random [1.07,1.1,1.13];
			};
			if ((toLowerANSI (backpack _player)) in ['b_combinationunitrespirator_01_f']) then {
				_pitch = random [0.77,0.8,0.83];
			};
			if ((toLowerANSI (backpack _player)) in ['b_scba_01_f']) then {
				_pitch = random [0.71,0.75,0.79];
			};
			_volume = random [0.45,0.5,0.55];
			_volume = [_volume - 0.2,_volume] select (_cameraView isEqualTo 'INTERNAL');
			playSoundUI ['QS_cbrn_2',_volume,_pitch,TRUE];
		};
		if (!(missionNamespace getVariable ['QS_facewear_effect_2',FALSE])) then {
			missionNamespace setVariable ['QS_facewear_effect_2',TRUE];
			(['QS_facewear_effect2'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutRsc ['RscCBRN_APR','PLAIN'];
			(['QS_facewear_effect22'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutRsc ['RscCBRN_APR','PLAIN'];
			(['QS_facewear_effect222'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutRsc ['RscCBRN_APR','PLAIN'];
		};
	} else {
		if (missionNamespace getVariable ['QS_facewear_effect_2',FALSE]) then {
			missionNamespace setVariable ['QS_facewear_effect_2',FALSE];
			(['QS_facewear_effect2'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutText ['','PLAIN'];
			(['QS_facewear_effect22'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutText ['','PLAIN'];
			(['QS_facewear_effect222'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutText ['','PLAIN'];
		};
	};
	if ((_goggles in ['g_regulatormask_f']) && (!_curatorView) && (_cameraView in ['INTERNAL','EXTERNAL','GUNNER'])) then {
		if (_time > (uiNamespace getVariable ['QS_ui_cbrnBreathInterval',-1])) then {
			uiNamespace setVariable ['QS_ui_cbrnBreathInterval',_time + ((random [3.8,4,4.2]) - (1.5 * ((getFatigue _player) max (damage _player))))];
			_pitch = random [0.95,1,1.05];
			if ((toLowerANSI (backpack _player)) in ['b_combinationunitrespirator_01_f']) then {
				_pitch = random [0.75,0.8,0.85];
			};
			if ((toLowerANSI (backpack _player)) in ['b_scba_01_f']) then {
				_pitch = random [0.7,0.75,0.8];
			};
			_volume = random [0.45,0.5,0.55];
			_volume = [_volume - 0.2,_volume] select (_cameraView isEqualTo 'INTERNAL');
			playSoundUI ['QS_cbrn_2',_volume,_pitch,TRUE];
		};
		if (!(missionNamespace getVariable ['QS_facewear_effect_3',FALSE])) then {
			missionNamespace setVariable ['QS_facewear_effect_3',TRUE];
			(['QS_facewear_effect3'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutRsc ['RscCBRN_Regulator','PLAIN'];
			(['QS_facewear_effect33'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutRsc ['RscCBRN_Regulator','PLAIN'];
			(['QS_facewear_effect333'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutRsc ['RscCBRN_Regulator','PLAIN'];
		};
	} else {
		if (missionNamespace getVariable ['QS_facewear_effect_3',FALSE]) then {
			missionNamespace setVariable ['QS_facewear_effect_3',FALSE];
			(['QS_facewear_effect3'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutText ['','PLAIN'];
			(['QS_facewear_effect33'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutText ['','PLAIN'];
			(['QS_facewear_effect333'] call (missionNamespace getVariable 'BIS_fnc_rscLayer')) cutText ['','PLAIN'];
		};
	};
};
// Eval every 30 frames
if (_thisFrame > (uiNamespace getVariable ['QS_eval_frameInterval_30',-1])) then {
	uiNamespace setVariable ['QS_eval_frameInterval_30',_thisFrame + 30];
	['EVAL',_player] call QS_fnc_zoneManager;
};
if (_focusOn isNotEqualTo (localNamespace getVariable ['QS_focusOn',objNull])) then {
	[localNamespace getVariable ['QS_focusOn',objNull],_focusOn] call QS_fnc_clientEventFocusChanged;
};
if (missionNamespace getVariable ['QS_missionConfig_weaponLasers',TRUE]) then {
	if (
		(_player getVariable ['QS_toggle_visibleLaser',FALSE]) &&
		{((_player getVariable ['QS_unit_laserBeamParams',[]]) # 6)}
	) then {
		if (_time > (localNamespace getVariable ['QS_laser_chargeInterval',-1])) then {
			localNamespace setVariable ['QS_laser_chargeInterval',_time + 1];
			// Eval ON
			_capacity = localNamespace getVariable ['QS_laser_capacity',10];
			_charge = (_capacity min ((localNamespace getVariable ['QS_laser_charge',0]) - 1) max 0);
			localNamespace setVariable ['QS_laser_charge',_charge];
			if (_charge <= 0) then {
				/*/
				_beamParams = _player getVariable ['QS_unit_laserBeamParams',[]];
				_beamParams set [6,FALSE];
				_player setVariable ['QS_unit_laserBeamParams',_beamParams,TRUE];
				/*/
				_mags = magazines _player;
				_magIndex = (_mags apply {toLowerANSI _x}) findAny qs_core_classnames_laserbatteries;
				if (_magIndex isNotEqualTo -1) then {
					localNamespace setVariable ['QS_laser_charge',_capacity];
					_player removeMagazine (_mags # _magIndex);
				} else {
					_beamParams = _player getVariable ['QS_unit_laserBeamParams',[]];
					_beamParams set [6,FALSE];
					_player setVariable ['QS_unit_laserBeamParams',_beamParams,TRUE];
				};
			};
		};
	} else {
		/*/ Allows natural recharge over time
		if (_time > (localNamespace getVariable ['QS_laser_rechargeInterval',-1])) then {
			localNamespace setVariable ['QS_laser_rechargeInterval',_time + (localNamespace getVariable ['QS_laser_rcRate',5])];
			// Eval OFF
			_capacity = localNamespace getVariable ['QS_laser_capacity',10];
			_charge = _capacity min (localNamespace getVariable ['QS_laser_charge',0]) max 0;
			if (_charge < _capacity) then {
				localNamespace setVariable ['QS_laser_charge',(_charge + 1) min _capacity];
			};
		};
		/*/
	};
};
if (uiNamespace getVariable ['QS_targetBoundingBox_draw',FALSE]) then {
	_bbObj = uiNamespace getVariable ['QS_targetBoundingBox_target',objNull];
	if (uiNamespace getVariable ['QS_targetBoundingBox_cursor',FALSE]) then {
		_bbObj = getCursorObjectParams # 0;
	};
	if (
		(_bbObj isEqualType objNull) &&
		{(!isNull _bbObj)}
	) then {
		_bbColor = uiNamespace getVariable ['QS_targetBoundingBox_color',[0,1,0,1]];
		_bb = QS_hashmap_boundingBoxes getOrDefaultCall [
			toLowerANSI (typeOf _bbObj),
			{0 boundingBoxReal _bbObj},
			TRUE
		];
		_bbox = [_bb,0,_bbObj,[]] call QS_fnc_prepareBoundingBox;
		private _intersected = [0,1] select ([_bbObj,0,_bbox] call QS_fnc_isBoundingBoxIntersected);
		if ((uiNamespace getVariable ['QS_targetBoundingBox_intersected',0]) isNotEqualTo _intersected) then {
			uiNamespace setVariable ['QS_targetBoundingBox_intersected',_intersected];
		};
		if (_intersected isEqualTo 1) then {
			_intersected = [1,2] select (([_bbObj,0,_bbox,1] call QS_fnc_isBoundingBoxIntersected) isNotEqualTo []);
			if ((uiNamespace getVariable ['QS_targetBoundingBox_intersected',0]) isNotEqualTo _intersected) then {
				uiNamespace setVariable ['QS_targetBoundingBox_intersected',_intersected];
			};
		};
		_bbColor = [[0,1,0,1],[1,1,0,1],[1,0,0,1]] # _intersected;
		if (alive (localNamespace getVariable ['QS_placementMode_carrier',objNull])) then {
			_bbColor = [0,0,1,1];
		};
		for '_i' from 0 to 7 step 2 do {
			drawLine3D [_bbox # _i,_bbox # (_i + 2),_bbColor];
			drawLine3D [_bbox # (_i + 2),_bbox # (_i + 3),_bbColor];
			drawLine3D [_bbox # (_i + 3),_bbox # (_i + 1),_bbColor];
		};
	};
	if (_bbObj isEqualType '') then {
		_bbColor = uiNamespace getVariable ['QS_targetBoundingBox_color',[1,1,0,1]];
		_refDir = uiNamespace getVariable ['QS_targetBoundingBox_azi',0];
		_bb = QS_hashmap_boundingBoxes getOrDefaultCall [
			toLowerANSI _bbObj,
			{_o = createSimpleObject [_bbObj,[0,0,0],TRUE]; _r = 0 boundingBoxReal _o; deleteVehicle _o; _r},
			TRUE
		];
		_bbox = [_bb,1,(uiNamespace getVariable ['QS_targetBoundingBox_drawPos',[0,0,0]]),[[(cos _refDir),(sin _refDir)],[-(sin _refDir),(cos _refDir)]]] call QS_fnc_prepareBoundingBox;
		for '_i' from 0 to 7 step 2 do {
			drawLine3D [_bbox # _i,_bbox # (_i + 2),_bbColor];
			drawLine3D [_bbox # (_i + 2),_bbox # (_i + 3),_bbColor];
			drawLine3D [_bbox # (_i + 3),_bbox # (_i + 1),_bbColor];
		};	
	};
};
if ((!((lifeState _player) in ['HEALTHY','INJURED'])) || {(!isNull (findDisplay 49))} || {_curatorView}) exitWith {};
if (
	(_cameraOn isKindOf 'CAManBase') &&
	{(_cameraOn isNotEqualTo _player)}
) then {
	_player = _cameraOn;
};
if ('MinimapDisplay' in ((infoPanel 'left') + (infoPanel 'right'))) then {
	if (missionNamespace getVariable ['QS_module_gpsJammer_inArea',FALSE]) then {
		50 cutText [localize 'STR_QS_Text_012','PLAIN DOWN',0.5];
		openGPS FALSE;
		openGPS FALSE;
	};
};
if ((missionNamespace getVariable ['QS_enabledWaypoints',2]) isEqualTo 0) then {
	_cwp = customWaypointPosition;
	if (
		(_cwp isNotEqualTo []) &&
		((worldToScreen _cwp) isNotEqualTo [])
	) then {
		if (
			(
				(!(_cameraOn isKindOf 'Plane')) || 
				(_cameraOn isKindOf 'VTOL_01_base_F')
			) &&
			(!(unitIsUAV _cameraOn)) &&
			(
				(
					(_cameraOn isKindOf 'CAManBase') && 
					((_cameraOn getSlotItemName 612) isNotEqualTo '')
				) || 
				(!(_cameraOn isKindOf 'CAManBase'))
			)
		) then {
			private _cwpCanShow = TRUE;
			_gpsJammers = missionNamespace getVariable ['QS_mission_gpsJammers',[]];
			if (_gpsJammers isNotEqualTo []) then {
				{
					private _cwpPos = _x;
					if ((_gpsJammers findIf {((_cwpPos distance2D (_x # 2)) <= (_x # 3))}) isNotEqualTo -1) then {
						_cwpCanShow = FALSE;
					};
				} forEach [_cwp,positionCameraToWorld [0,0,0]];
			};
			if (_cwpCanShow) then {
				private _cwpDistance = ceil(round((positionCameraToWorld [0,0,0]) distance _cwp));
				private _metric = 'm';
				if (_cwpDistance >= 1000) then { 
					_metric = 'km';
					_cwpDistance = (_cwpDistance / 1000) toFixed 1;
				};
				drawIcon3D [
					'\a3\ui_f\data\igui\cfg\cursors\custommark_ca.paa',
					[1,1,1,0.5],
					_cwp,
					1, 
					1, 
					0, 
					(format ['%1 %2',_cwpDistance,_metric]), 
					2, 
					0.034, 
					'RobotoCondensed', 
					'center', 
					FALSE, 
					0, 
					0 
				];
			};
		};
	};
	if (!isNull (currentTask _player)) then {
		_task = currentTask _player;
		_taskPosition = taskDestination _task;
		if ((worldToScreen _taskPosition) isNotEqualTo []) then {
			_taskType = taskType _task;
			_isLetter = (count _taskType) isEqualTo 1;
			private _taskFilePath = format ['\a3\ui_f\data\igui\cfg\simpleTasks\types\%1_ca.paa',_taskType];
			if (_isLetter) then {
				_taskFilePath = format ['\a3\ui_f\data\igui\cfg\simpleTasks\letters\%1_ca.paa',_taskType];
			};	
			private _cwpDistance = ceil(round((positionCameraToWorld [0,0,0]) distance _taskPosition));
			private _metric = 'm';
			if (_cwpDistance >= 1000) then { 
				_metric = 'km';
				_cwpDistance = (_cwpDistance / 1000) toFixed 1;
			};
			drawIcon3D [
				'\a3\ui_f\data\igui\cfg\simpleTasks\background1_ca.paa',
				[0.75,0.75,0.75,0.5], 
				_taskPosition,
				0.7, 
				0.7, 
				0, 
				'', 
				2, 
				0.034, 
				'RobotoCondensed', 
				'center', 
				FALSE, 
				0, 
				0 
			];
			drawIcon3D [
				_taskFilePath,
				[0.75,0.75,0.75,0.5], 
				_taskPosition,
				0.4, 
				0.4, 
				0, 
				(format ['%1 %2',_cwpDistance,_metric]), 
				2, 
				0.034, 
				'RobotoCondensed', 
				'center', 
				TRUE, 
				0, 
				0 
			];
		};
	};
};
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
	if ((_player getSlotItemName 611) isNotEqualTo '') then {
		if (!((getPlayerChannel _player) in [-1,5,4])) then {
			if (!(uiNamespace getVariable ['QS_UI_radio_shown',FALSE])) then {
				uiNamespace setVariable ['QS_UI_radio_shown',TRUE];
				'QS_ui_radio_layer' cutRsc ['QS_radio','PLAIN'];
				// Animation
				if (
					(!((gestureState _player) in ['handsignalradio'])) &&
					{(!((pose _player) in ['Swimming','SurfaceSwimming']))} &&
					{((currentWeapon _player) isEqualTo (primaryWeapon _player))} &&
					{((currentWeapon _player) isNotEqualTo '')} &&
					{((lifeState _player) in ['HEALTHY','INJURED'])} &&
					{(!(['reload',gestureState _player] call QS_fnc_inString))}
				) then {
					// blocks players ability to aim-down-sight and shoot for a few seconds
					//_player playAction 'HandSignalRadio';
				};
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
	if ((missionNamespace getVariable ['QS_client_medicIcons_units',[]]) isNotEqualTo []) then {
		_pulse = ([2,25] call (missionNamespace getVariable 'QS_fnc_pulsate')) max 0.25;
		{
			_unit = _x;
			if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
				_distance = _player distance2D _unit;
				if (_distance > 2) then {
					_icon = 'a3\ui_f\data\igui\cfg\revive\overlayIcons\r100_ca.paa';
					_alpha = (1 - (((_distance / 500)) % 1)) min _pulse;
					_rgba = [1,(([0.41,(0.41 * ((((_unit getVariable ['QS_revive_downtime',_sTime]) + 600) - _sTime) / 600))] select (isPlayer _unit)) max 0),0,_alpha];
					if (((_unit nearEntities ['CAManBase',2]) select {(_x isNotEqualTo _unit) && (_x getUnitTrait 'medic') && ((lifeState _x) in ['HEALTHY','INJURED'])}) isNotEqualTo []) then {
						_icon = 'a3\ui_f\data\igui\cfg\revive\overlayIcons\u100_ca.paa';
						_rgba = [0.25,0.5,1,_alpha];
					};
					_vehicle = vehicle _unit;
					if (_alpha > 0) then {
						if ((worldToScreen (_vehicle modelToWorldVisual [0,0,0])) isNotEqualTo []) then {
							drawIcon3D [
								_icon,
								_rgba,
								(if (_vehicle isKindOf 'CAManBase') then {(_unit modelToWorldVisual (selectionPosition [_unit,'spine3',11,TRUE]))} else {(_vehicle modelToWorldVisual (_vehicle worldToModelVisual (getPosWorldVisual _unit)))}),          
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
			};
		} count (missionNamespace getVariable ['QS_client_medicIcons_units',[]]);
	};
} else {
	if ((_player getUnitTrait 'engineer') || {(_player getUnitTrait 'explosivespecialist')}) then {
		if ('MineDetectorDisplay' in ((infoPanel 'left') + (infoPanel 'right'))) then {
			_v = vehicle _player;
			_vt = typeOf _v;
			if (
				((((items _player) apply {toLowerANSI _x}) findAny qs_core_classnames_itemminedetectors) isNotEqualTo -1) || 
				{((toLowerANSI _vt) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f'])}
			) then {
				_drawDist = 17.5;
				if ((toLowerANSI _vt) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']) then {
					_drawDist = 35;
				};
				{
					if (_x mineDetectedBy (_player getVariable ['QS_unit_side',WEST])) then {
						_minePos = getPosATLVisual _x;
						_scale = 1 - ((((_cameraOn distance2D _x) / (_drawDist + 0.1))) % 1);
						if (_scale > 0) then {
							if ((worldToScreen _minePos) isNotEqualTo []) then {
								drawIcon3D [
									'a3\ui_f\data\map\VehicleIcons\iconexplosivegp_ca.paa',
									[1,0,0,_scale],
									(_minePos vectorAdd [0,0,1]),
									1,
									1,
									0
								];
							};
						};					
					};				
				} forEach (nearestMines [_player,[],_drawDist]);
			};
		};
	};
};
if (!isStreamFriendlyUIEnabled) then {
	if (!shownChat) then {
		showChat TRUE;
	};
	(profileNamespace getVariable ['ApexFramework_3DGroupIconColor',(missionNamespace getVariable ['QS_missionConfig_3DIconColor',[0,125,255]])]) params ['_r','_g','_b'];
	if (!isNull _cameraOn) then {
		if (
			((_player getSlotItemName 612) isNotEqualTo '') &&
			{(missionNamespace getVariable ['QS_HUD_show3DHex',TRUE])}
		) then {
			{
				if (
					((worldToScreen (_x modelToWorldVisual [0,0,0])) isNotEqualTo []) &&
					(cameraOn isNotEqualTo (vehicle _x))
				) then {
					_alpha = [0.25 max (1 - ((((_cameraOn distance2D _x) / 1000)) % 1)),0.25] select ((_cameraOn distance2D _x) >= 1000);
					_objectParent = objectParent _x;
					_iconPos = if (isNull _objectParent) then {
						(_x modelToWorldVisual (selectionPosition [_x,'spine3',11,TRUE]))
					} else {
						(_objectParent modelToWorldVisual (_objectParent worldToModelVisual (_x modelToWorldVisual (selectionPosition [_x,'spine3',11,TRUE]))))
					};
					if ((_player isEqualTo (leader (group _player))) && (_x in (groupSelectedUnits _player))) then {
						private _teamID = (['','MAIN','RED','GREEN','BLUE','YELLOW'] find (assignedTeam _x)) max 1;
						_noChannel = (getPlayerChannel _x) isEqualTo -1;
						drawIcon3D [
							'a3\ui_f\data\igui\cfg\cursors\select_ca.paa',
							([
								([_r,_g,_b,([1,0.75] select _noChannel)]),
								([_r,_g,_b,([1,0.75] select _noChannel)]),
								[1,0,0,([1,0.75] select _noChannel)],
								[0,1,0.5,([1,0.75] select _noChannel)],
								[0,0.5,1,([1,0.75] select _noChannel)],
								[1,1,0,([1,0.75] select _noChannel)]
							] # _teamID),
							_iconPos,
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
							[_r,_g,_b,([1,_alpha] select ((getPlayerChannel _x) isEqualTo -1))],
							_iconPos,
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
							[_r,_g,_b,([1,_alpha] select ((getPlayerChannel _x) isEqualTo -1))],
							_iconPos,
							0.5,
							0.5,
							0,
							'',
							1,
							0,
							_font,
							'center',
							FALSE
						];
					};
				};
			} count ((units _player) - [_player]);
		};
		if (freeLook) then {
			private _v = objNull;
			private _list = [];
			{
				_v = _x;
				if (_v isKindOf 'CAManBase') then {
					_list pushBackUnique _v;
				} else {
					{
						_list pushBackUnique _x;
					} forEach (crew _v);
				};
			} forEach (_player nearEntities [['CAManBase','LandVehicle','Air','Ship','StaticWeapon'],40]);
			{
				_unit = _x;
				if (
					(!isNull (group _unit)) &&
					{((side (group _unit)) isEqualTo (_player getVariable ['QS_unit_side',WEST]))} &&
					{(_unit isNotEqualTo _player)} &&
					{(!(_unit getVariable ['QS_hidden',FALSE]))} &&
					{(((vectorMagnitude (velocity _unit)) * 3.6) <= 24)}
				) then {
					if (
						(isPlayer _unit) &&
						{(_unit isNotEqualTo _player)} &&
						{((_unit getVariable ['QS_unit_face','']) isNotEqualTo '')} &&
						{((toLowerANSI (face _unit)) isNotEqualTo (toLowerANSI (_unit getVariable ['QS_unit_face',''])))} &&
						{!dialog}
					) then {
						_unit setFace (_unit getVariable ['QS_unit_face','']);
					};
					_objectParent = objectParent _x;
					_iconPos = if (isNull _objectParent) then {
						((_x modelToWorldVisual (selectionPosition [_x,'head',11,TRUE])) vectorAdd [0,0,0.5])
					} else {
						((_objectParent modelToWorldVisual (_objectParent worldToModelVisual (_x modelToWorldVisual (selectionPosition [_x,'head',11,TRUE])))) vectorAdd [0,0,0.5])
					};
					_unitName = (['AI',(name _unit)] select (isPlayer _unit));
					if (_unit in [getCursorObjectParams # 0,cursorTarget]) then {
						if (isPlayer _unit) then {
							if ((_unit getVariable ['QS_ST_customDN','']) isNotEqualTo '') then {
								_unitType = _unit getVariable ['QS_ST_customDN',''];
							} else {
								if ((_unit getVariable ['QS_unit_role_displayName',-1]) isEqualTo -1) then {
									_unitType = ['GET_ROLE_DISPLAYNAME',(_unit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
								} else {
									_unitType = _unit getVariable ['QS_unit_role_displayName','Rifleman'];
								};
							};
						} else {
							if ((_unit getVariable ['QS_ST_customDN','']) isNotEqualTo '') then {
								_unitType = _unit getVariable ['QS_ST_customDN',''];
							} else {
								_unitType = QS_hashmap_configfile getOrDefaultCall [
									format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _unit)],
									{getText ((configOf _unit) >> 'displayName')},
									TRUE
								];
							};
						};
						_unitName = _unitName + (format [' (%1)',_unitType]);
					};
					if (_player getUnitTrait 'medic') then {
						_unitName = format ['%1 (%2)',_unitName,(lifeState _unit)];
					};
					if (unitIsUav _objectParent) then {
						_uavControl = remoteControlled (effectiveCommander _objectParent);
						if (!isNull _uavControl) then {
							_unitName = name _uavControl;
						};
					};
					_distance = _cameraOn distance2D _unit;
					_alpha = 1 - (((_distance / 31)) % 1);
					if (_alpha > 0) then {
						drawIcon3D [
							'',
							[0.75,0.75,0.75,_alpha],
							_iconPos,
							1,
							1,
							0,
							_unitName,
							2,
							0.025,
							_font,
							'center',
							FALSE,
							0,
							-0.03
						];
					};
				};
			} count _list;
		} else {
			_cursorTarget = cursorTarget;
			if (isNull _cursorTarget) then {
				_cursorTarget = getCursorObjectParams # 0;
				if (isNull _cursorTarget) then {
					_cursorTarget = cursorObject;
				};
			};
			if (
				(!isNull _cursorTarget) &&
				{(!(_cursorTarget in [QS_player,_cameraOn]))} &&
				{(
					(
						((_cursorTarget isKindOf 'CAManBase') || {((effectiveCommander _cursorTarget) isKindOf 'CAManBase')}) &&
						{(_cursorTarget isNotEqualTo _cameraOn)} &&
						{(!(_cursorTarget in (attachedObjects _cameraOn)))} &&
						{(
							((_cursorTarget isKindOf 'CAManBase') && {((side (group _cursorTarget)) isEqualTo (_player getVariable ['QS_unit_side',WEST]))}) ||
							((!(_cursorTarget isKindOf 'CAManBase')) && {((side (assignedGroup (effectiveCommander _cursorTarget))) isEqualTo (_player getVariable ['QS_unit_side',WEST]))})
						)} &&
						{(!(_cursorTarget getVariable ['QS_hidden',FALSE]))}
					) ||
					{(
						(!(_cursorTarget isKindOf 'CAManBase')) &&
						{(
							(([['QS_ST_showDisplayName',FALSE],['QS_logistics_wreck',FALSE],['QS_logistics_deployed',FALSE],['QS_logistics_isCargoParent',FALSE]] findIf {(_cursorTarget getVariable _x)}) isNotEqualTo -1) ||
							{((!isNull (assignedGroup _cursorTarget)) && {((side (assignedGroup _cursorTarget)) isEqualTo (_player getVariable ['QS_unit_side',WEST]))})}
						)}
					)}
				)}
			) then {
				if ((QS_ui_3DCursorTargets findIf { (_x # 0) isEqualTo _cursorTarget }) isEqualTo -1) then {
					QS_ui_3DCursorTargets pushBack [_cursorTarget,0.01];
				};
			};
			QS_ui_3DCursorTargets = QS_ui_3DCursorTargets select { ((_x # 1) > 0) };
			if (QS_ui_3DCursorTargets isNotEqualTo []) then {
				private _cursorColor = [_r,_g,_b,1];
				{
					_unit = _x # 0;
					_fade = _x # 1;
					_unitName = '';
					if (_unit in [QS_player,_cameraOn]) exitWith {};
					if ((_unit isKindOf 'CAManBase') || {((effectiveCommander _unit) isKindOf 'CAManBase')}) then {
						if ((_cameraOn distance2D _unit) >= 30) then {
							if ((_cameraOn distance2D _unit) >= 300) then {
								_unitName = format ['(%1)',localize 'STR_QS_Utility_029'];
							} else {
								if (isPlayer _unit) then {
									_unitName = (name _unit) + (format [' (%1)',localize 'STR_QS_Utility_029']);
								} else {
									_unitName = format ['[%2] (%1)',localize 'STR_QS_Utility_029',localize 'STR_QS_Utility_030'];
								};
							};
						} else {
							if (isPlayer _unit) then {
								if ((_unit getVariable ['QS_ST_customDN','']) isNotEqualTo '') then {
									_unitType = _unit getVariable ['QS_ST_customDN',''];
								} else {
									_unitType = ['GET_ROLE_DISPLAYNAME',(_unit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
								};								
								_unitName = (name _unit) + (format [' (%1)',_unitType]);
							} else {
								if ((_unit getVariable ['QS_ST_customDN','']) isNotEqualTo '') then {
									_unitType = _unit getVariable ['QS_ST_customDN',''];
								} else {
									_unitType = QS_hashmap_configfile getOrDefaultCall [
										format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _unit)],
										{getText ((configOf _unit) >> 'displayName')},
										TRUE
									];
								};
								_unitName = (format ['[%1]',localize 'STR_QS_Utility_030']) + (format [' (%1)',_unitType]);
							};
						};
						_alpha = [0.1 max (1 - ((((_cameraOn distance2D _unit) / 1000)) % 1)),0.1] select ((_cameraOn distance2D _unit) >= 1000);
						QS_ui_3DCursorTargets set [_forEachIndex,[_unit,([(_fade + 0.1) min 1,(_fade - 0.1) max 0] select (_unit isNotEqualTo _cursorTarget))]]; 
						_alpha = _alpha * _fade;
						_cursorColor = _unit getVariable ['QS_ST_cursorIcon_color',[_r,_g,_b,_alpha]];
					} else {
						if (
							(_unit getVariable ['QS_ST_showDisplayName',FALSE]) ||
							{(_unit getVariable ['QS_logistics_wreck',FALSE])} ||
							{(_unit getVariable ['QS_logistics_deployed',FALSE])} ||
							{(_unit getVariable ['QS_logistics_isCargoParent',FALSE])}
						) then {
							_unitName = _unit getVariable ['QS_ST_customDN',''];
							if (_unitName isEqualTo '') then {
								_unitName = QS_hashmap_configfile getOrDefaultCall [
									format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _unit)],
									{(getText ((configOf _unit) >> 'displayName'))},
									TRUE
								];
								_unit setVariable ['QS_ST_customDN',_unitName,FALSE];
							};
							if (_unit getVariable ['QS_logistics_wreck',FALSE]) then {
								_unitName = format ['%1 (%2)',_unitName,localize 'STR_QS_Text_384'];
							};
							if (_unit getVariable ['QS_logistics_deployed',FALSE]) then {
								_unitName = format ['%1 (%2)',_unitName,localize 'STR_QS_Text_409'];
							};
							if (_unit getVariable ['QS_logistics_isCargoParent',FALSE]) then {
								_unitName = format ['%1 (%2)',_unitName,localize 'STR_QS_Text_410'];
							};
						};
						if (
							(_unitName isEqualTo '') &&
							{(!isNull (assignedGroup _unit))} &&
							{((crew _unit) isEqualTo [])}
						) then {
							_unitName = groupId (assignedGroup _unit);
						};
						_alpha = [0 max (1 - ((((_cameraOn distance2D _unit) / 30)) % 1)),0] select ((_cameraOn distance2D _unit) >= 30);
						QS_ui_3DCursorTargets set [_forEachIndex,[_unit,([(_fade + 0.1) min 1,(_fade - 0.1) max 0] select (_unit isNotEqualTo _cursorTarget))]]; 
						_alpha = _alpha * _fade;
						_cursorColor = _unit getVariable ['QS_ST_cursorIcon_color',[0.5,0.5,0.5,_alpha]];
					};
					if (_alpha > 0) then {
						drawIcon3D [
							'',
							_cursorColor,
							((_unit modelToWorldVisual ((selectionPosition [_unit,(['pilot','head'] select (_unit isKindOf 'CAManBase')),11,TRUE]))) vectorAdd [0,0,0.5]),
							1,
							1,
							0,
							_unitName,
							2,
							0.03,
							_font,
							'center',
							FALSE,
							0,
							-0.03
						];
					};
				} forEach QS_ui_3DCursorTargets;
			};
			if (
				(!isNull _cursorTarget) &&
				{((_cameraOn distance _cursorTarget) < 30)}
			) then {
				if (_cursorTarget isKindOf 'CAManBase') then {
					if (
						(!isNull (backpackContainer _cursorTarget)) &&
						{(alive _cursorTarget)} &&
						{(
							(_cursorTarget getVariable ['QS_lockedInventory',FALSE]) || 
							{((backpackContainer _cursorTarget) getVariable ['QS_lockedInventory',FALSE])}
						)}
					) then {
						if (!lockedInventory (backpackContainer _cursorTarget)) then {
							(backpackContainer _cursorTarget) lockInventory TRUE;
						};
					} else {
						if (lockedInventory (backpackContainer _cursorTarget)) then {
							(backpackContainer _cursorTarget) lockInventory FALSE;
						};						
					};
				} else {
					if (
						(_cursorTarget getVariable ['QS_lockedInventory',FALSE]) ||
						{(_cursorTarget getVariable ['QS_inventory_disabled',FALSE])} ||
						{(_cursorTarget getVariable ['QS_logistics_wreck',FALSE])}
					) then {
						if (!lockedInventory _cursorTarget) then {
							_cursorTarget lockInventory TRUE;
						};
					} else {
						if (lockedInventory _cursorTarget) then {
							_cursorTarget lockInventory FALSE;
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
if ((missionNamespace getVariable ['QS_draw3D_projectiles',[]]) isNotEqualTo []) then {
	private _scale = 1;
	_array = missionNamespace getVariable ['QS_draw3D_projectiles',[]];
	_deg = ((ceil _time) - _time) * 720;
	private _dist = 1000;
	if (_cameraOn isKindOf 'Air') then {
		_dist = 2000;
	};
	{
		if (
			(_x isEqualType objNull) &&
			{(!isNull _x)} &&
			{((_cameraOn distance2D _x) < (_dist - 1))}
		) then {
			if ((worldToScreen (_x modelToWorldVisual [0,0,0])) isNotEqualTo []) then {
				_scale = 1 - ((((_cameraOn distance2D _x) / _dist)) % 1);
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
	} count _array;
};
if ((missionNamespace getVariable ['QS_client_customDraw3D',[]]) isNotEqualTo []) then {
	_array = missionNamespace getVariable ['QS_client_customDraw3D',[]];
	{
		if (_x isEqualType []) then {
			drawIcon3D _x;
		};
	} count _array;
};
if (_player getVariable ['QS_client_inBaseArea',FALSE]) then {
	if ((missionNamespace getVariable ['QS_client_baseIcons',[]]) isNotEqualTo []) then {
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
		if ((missionNamespace getVariable ['QS_client_fobIcons',[]]) isNotEqualTo []) then {
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
			if ((missionNamespace getVariable ['QS_client_carrierIcons',[]]) isNotEqualTo []) then {
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