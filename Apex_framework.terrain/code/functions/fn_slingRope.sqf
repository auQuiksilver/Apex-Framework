/*/
File: fn_slingRope.sqf
Author:

	Quiksilver
	
Last Modified:

	5/05/2018 A3 1.82 by Quiksilver
	
Description:

	Sling Rope
___________________________________________/*/

params ['_type'];
_vehicle = cameraOn;
if (!local _vehicle) exitWith {};
if (!('SlingLoadDisplay' in ((infoPanel 'left') + (infoPanel 'right')))) then {
	if ('EmptyDisplay' in (infoPanel 'left')) then {
		setInfoPanel ['left','SlingLoadDisplay'];
	} else {
		if ('EmptyDisplay' in (infoPanel 'right')) then {
			setInfoPanel ['right','SlingLoadDisplay'];
		} else {
			setInfoPanel ['left','SlingLoadDisplay'];
		};
	};
};
_slingLoad = getSlingLoad _vehicle;
_slingData = [_vehicle,_slingLoad] call (missionNamespace getVariable ['QS_fnc_slingData',{}]);
_slingData params ['','','_attachEnabled','_attachCoordinates','_min','_max','_speed','_speedFast'];
_delta = 1;
_deltaSlow = 0.5;
_deltaFast = 2;
private _speedReal = _speed;
_minFast = _min + 5;
_maxFast = _max - 5;
private _ropeLength = 0;
if (_type isEqualTo 'UP') then {
	if ((ropes _vehicle) isNotEqualTo []) then {
		if (!isNull _slingLoad) then {
			if (!(_slingLoad in (attachedObjects _vehicle))) then {
				private _attached = FALSE;
				_loadIntersected = (lineIntersectsSurfaces [(getPosASL _slingLoad),((getPosASL _slingLoad) vectorAdd [0,0,5]),_slingLoad,objNull,TRUE,1,'GEOM','GEOM',TRUE]) isNotEqualTo [];
				{
					_ropeLength = ropeLength _x;
					if (_ropeLength > _min) then {
						_speedReal = [_speed,_speedFast] select ((_ropeLength > _minFast) && (_ropeLength < _maxFast));
						ropeUnwind [_x,_speedReal,-([([_delta,_deltaFast] select (_ropeLength > _maxFast)),_deltaSlow] select _loadIntersected),TRUE];
					} else {
						if (_attachEnabled) then {
							_attached = TRUE;
							[1,_slingLoad,[_vehicle,_attachCoordinates]] call QS_fnc_eventAttach;
							_vehicle disableCollisionWith _slingLoad;
							_slingLoad disableCollisionWith _vehicle;
						};
					};
					if (_attached) exitWith {};
				} forEach (ropes _vehicle);
				if (_attached) exitWith {
					_vehicle setVariable ['QS_sling_attached',_slingLoad,TRUE];
					{
						ropeUnwind [_x,_speedReal,-([_delta,_deltaFast] select (_ropeLength > _minFast)),TRUE];
					} forEach (ropes _vehicle);
				};
			};
		};
	};
};
if (_type isEqualTo 'DOWN') then {
	if ((ropes _vehicle) isNotEqualTo []) then {
		if (!isNull _slingLoad) then {
			if (!(_slingLoad in (attachedObjects _vehicle))) then {
				_isTouchingGround = isTouchingGround _vehicle;
				_loadIntersected = (lineIntersectsSurfaces [(getPosASL _slingLoad),((getPosASL _slingLoad) vectorAdd [0,0,-5]),_slingLoad,objNull,TRUE,1,'GEOM','GEOM',TRUE]) isNotEqualTo [];
				{
					_ropeLength = ropeLength _x;
					if (_ropeLength < ([_max,10] select _isTouchingGround)) then {
						_speedReal = [_speed,_speedFast] select ((_ropeLength > _minFast) && (_ropeLength < _maxFast));
						ropeUnwind [_x,_speedReal,([([_delta,_deltaFast] select (_ropeLength < _maxFast)),_deltaSlow] select _loadIntersected),TRUE];
					};
				} forEach (ropes _vehicle);
			} else {
				// Check bounding box intersection here for obstructions
				_attachCoordinates set [2,((_attachCoordinates # 2) - ([1,0.1] select (isTouchingGround _vehicle)))];
				[1,_slingLoad,[_vehicle,_attachCoordinates]] call QS_fnc_eventAttach;
				[_vehicle,_slingLoad,_slingData] spawn {
					params ['_vehicle','_slingLoad','_slingData'];
					_slingData params ['','','_attachEnabled','_attachCoordinates','_min','_max','_speed','_speedFast'];
					_vehicle disableCollisionWith _slingLoad;
					_slingLoad disableCollisionWith _vehicle;
					uiSleep 0.1;
					[0,_slingLoad] call QS_fnc_eventAttach;
					50 cutText [localize 'STR_QS_Text_246','PLAIN DOWN',0.3];
					uiSleep 0.2;
					_vehicle enableCollisionWith _slingLoad;
					_slingLoad enableCollisionWith _vehicle;
					if ((ropes _vehicle) isNotEqualTo []) then {
						{
							ropeUnwind [_x,5,(_min + 0.1),FALSE];
						} forEach (ropes _vehicle);
					};
					_slingLoad2 = _vehicle getVariable ['QS_sling_attached',objNull];
					if (!isNull _slingLoad2) then {
						if (_slingLoad2 in (attachedObjects _vehicle)) then {
							[0,_slingLoad2] call QS_fnc_eventAttach;
							uiSleep 0.2;
							_vehicle enableCollisionWith _slingLoad2;
							_slingLoad2 enableCollisionWith _vehicle;
						};
					};
				};
				
			};
		};
	} else {
	
	};
};
if ('SlingLoadDisplay' in ((infoPanel 'left') + (infoPanel 'right'))) then {
	if (isNull ((findDisplay 46) displayCtrl 31081)) then {
		0 spawn {
			scriptName 'QS - Sling - UI';
			disableSerialization;
			private _ctrlPosition = [
				[
					(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFOLEFT_X',0]),
					(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
					(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
					1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
				],
				[
					(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFORIGHT_X',0]),
					(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
					(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
					1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
				]
			] select ('SlingLoadDisplay' in (infoPanel 'right'));
			private _controls = [];
			_QS_ctrlCreateArray = ['RscBackground',31080];
			_QS_ctrl_0 = (findDisplay 46) ctrlCreate _QS_ctrlCreateArray;
			_QS_ctrl_0 ctrlShow FALSE;
			_controls pushBack _QS_ctrl_0;
			_QS_ctrl_0 ctrlSetText '';
			_QS_ctrl_0 ctrlSetBackgroundColor [0,0,0,0.175];
			_QS_ctrl_0 ctrlSetPosition _ctrlPosition;
			_QS_ctrlCreateArray = ['RscProgress',31081];
			_QS_ctrl_1 = (findDisplay 46) ctrlCreate _QS_ctrlCreateArray;
			_QS_ctrl_1 ctrlShow FALSE;
			_controls pushBack _QS_ctrl_1;
			_QS_ctrl_1 ctrlSetText '';
			_QS_ctrl_1 ctrlSetTextColor [(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843]),(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019]),(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862]),(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])];
			_QS_ctrl_1 ctrlSetPosition _ctrlPosition;
			_QS_ctrlCreateArray = ['RscText',31082];
			_QS_ctrl_2 = (findDisplay 46) ctrlCreate _QS_ctrlCreateArray;
			_QS_ctrl_2 ctrlShow FALSE;
			_controls pushBack _QS_ctrl_2;
			_QS_ctrl_2 ctrlSetText (localize 'STR_QS_Menu_105');
			_QS_ctrl_2 ctrlSetPosition _ctrlPosition;
			{
				_x ctrlCommit 0;
			} forEach _controls;
			waitUntil {
				uiSleep 0.01;
				if ('SlingLoadDisplay' in ((infoPanel 'left') + (infoPanel 'right'))) then {
					_ctrlPosition = [
						[
							(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFOLEFT_X',0]),
							(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
							(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
							1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
						],
						[
							(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFORIGHT_X',0]),
							(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
							(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
							1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
						]
					] select ('SlingLoadDisplay' in (infoPanel 'right'));
					if ((ctrlPosition ((findDisplay 46) displayCtrl 31080)) isNotEqualTo _ctrlPosition) then {
						((findDisplay 46) displayCtrl 31080) ctrlSetPosition _ctrlPosition;
						((findDisplay 46) displayCtrl 31080) ctrlCommit 0;
					};
					if ((ctrlPosition ((findDisplay 46) displayCtrl 31081)) isNotEqualTo _ctrlPosition) then {
						((findDisplay 46) displayCtrl 31081) ctrlSetPosition _ctrlPosition;
						((findDisplay 46) displayCtrl 31081) ctrlCommit 0;
					};
					if ((ctrlPosition ((findDisplay 46) displayCtrl 31082)) isNotEqualTo _ctrlPosition) then {
						((findDisplay 46) displayCtrl 31082) ctrlSetPosition _ctrlPosition;
						((findDisplay 46) displayCtrl 31082) ctrlCommit 0;
					};
				};
				((diag_tickTime > ((player getVariable ['QS_sling_keyDownDelay',-1]) + 3)) || {(!('SlingLoadDisplay' in ((infoPanel 'left') + (infoPanel 'right'))))})
			};
			{
				ctrlDelete _x;
			} forEach _controls;
		};
	} else {
		private _ctrlPosition = [
			[
				(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFOLEFT_X',0]),
				(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
				(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFOLEFT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
				1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
			],
			[
				(profileNamespace getVariable ['IGUI_GRID_CUSTOMINFORIGHT_X',0]),
				(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_Y',(10 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 0.9 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) +    ((12.3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)),
				(profilenamespace getvariable ['IGUI_GRID_CUSTOMINFORIGHT_W',(10 * (((safezoneW / safezoneH) min 1.2) / 40))]),
				1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)
			]
		] select ('SlingLoadDisplay' in (infoPanel 'right'));
		if ( (ctrlPosition ((findDisplay 46) displayCtrl 31080)) isNotEqualTo _ctrlPosition) then {
			((findDisplay 46) displayCtrl 31080) ctrlSetPosition _ctrlPosition;
		};
		if ( (ctrlPosition ((findDisplay 46) displayCtrl 31081)) isNotEqualTo _ctrlPosition) then {
			((findDisplay 46) displayCtrl 31081) ctrlSetPosition _ctrlPosition;
		};
		if ( (ctrlPosition ((findDisplay 46) displayCtrl 31082)) isNotEqualTo _ctrlPosition) then {
			((findDisplay 46) displayCtrl 31082) ctrlSetPosition _ctrlPosition;
		};
		if (!(ctrlShown ((findDisplay 46) displayCtrl 31080))) then {
			((findDisplay 46) displayCtrl 31080) ctrlShow TRUE;
		};
		if (!(ctrlShown ((findDisplay 46) displayCtrl 31081))) then {
			((findDisplay 46) displayCtrl 31081) ctrlShow TRUE;
		};
		if (!(ctrlShown ((findDisplay 46) displayCtrl 31082))) then {
			((findDisplay 46) displayCtrl 31082) ctrlShow TRUE;
		};
		if ((!isNull _slingLoad) && {(_slingLoad in (attachedObjects _vehicle))}) then {
			((findDisplay 46) displayCtrl 31081) progressSetPosition 0;
			((findDisplay 46) displayCtrl 31082) ctrlSetText (localize 'STR_QS_Menu_106');
		} else {
			((findDisplay 46) displayCtrl 31081) progressSetPosition (_ropeLength / _max);
			((findDisplay 46) displayCtrl 31082) ctrlSetText (format ['%2 %1 m',(round _ropeLength),localize 'STR_QS_Menu_107']);
		};
		((findDisplay 46) displayCtrl 31080) ctrlCommit 0;
		((findDisplay 46) displayCtrl 31081) ctrlCommit 0;
		((findDisplay 46) displayCtrl 31082) ctrlCommit 0;
	};
};