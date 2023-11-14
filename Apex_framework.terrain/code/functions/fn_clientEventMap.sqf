/*
File: fn_clientEventMap.sqf
Author: 

	Quiksilver
	
Last modified:

	13/11/2023 A3 2.14 by Quiksilver
	
Description:

	Map Mission Event
___________________________________________________________________*/

params ['_mapIsOpened','_mapIsForced'];
if (_mapIsOpened) then {
	_localProps = QS_list_playerBuildables select {local _x};
	if ((missionProfileNamespace getVariable ['QS_quickbuild_mapHint',0]) < 10) then {
		if (!(_mapIsForced)) then {
			if (_localProps isNotEqualTo []) then {
				missionProfileNamespace setVariable ['QS_quickbuild_mapHint',(missionProfileNamespace getVariable ['QS_quickbuild_mapHint',0]) + 1];
				50 cutText [localize 'STR_QS_Text_479','PLAIN DOWN',1,TRUE];
			};
		};
	};
	uiNamespace setVariable ['QS_map_playerBuildables',_localProps];
	uiNamespace setVariable ['QS_map_closestBuildable',objNull];
	_globalObjects = (8 allObjects 8) select {(_x getVariable ['QS_logistics_virtual',FALSE])};
	localNamespace setVariable ['QS_map_globalObjects',_globalObjects];
	localNamespace setVariable ['QS_map_deleteDistance',50];
	QS_map_drawBuildables = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler [
		'Draw',
		{
			params ['_map'];
			if (!(missionNamespace getVariable ['QS_menu_extendedContext',FALSE])) exitWith {};
			_cursorPos = uiNamespace getVariable ['QS_map_cursorPos',[0,0,0]];
			private _iconSize = 20;
			private _distance = localNamespace getVariable ['QS_map_deleteDistance',50];
			private _nearish = [];
			private _text = '';
			private _color = [0.5,0.5,0.5,1];
			private _obj = objnull;
			{
				_obj = _x;
				if (
					(!isNull _obj) &&
					{((['LandVehicle','Air','Ship'] findIf { _obj isKindOf _x }) isEqualTo -1)} &&
					{(isNull (attachedTo _obj))} &&
					{(isNull (isVehicleCargo _obj))} &&
					{(isNull (ropeAttachedTo _obj))} &&
					{((ropes _obj) isEqualTo [])} &&
					{((crew _obj) isEqualTo [])}
				) then {
					_icon = _obj getVariable ['QS_map_icon',''];
					if (_icon isEqualTo '') then {
						_icon = getText ((configOf _obj) >> 'icon');
						_obj setVariable ['QS_map_icon',_icon];
					};
					_text = _obj getVariable ['QS_map_name',''];
					if (_text isEqualTo '') then {
						_text = getText ((configOf _obj) >> 'displayName');
						_obj setVariable ['QS_map_name',_text];
					};
					_color = [[0.5,0.5,0.5,1],[0.5,1,0.5,1]] select (local _obj);
					if ((_obj distance2D _cursorPos) < 100) then {
						_nearish pushBack _obj;
					};
					_map drawIcon [
						_icon,
						_color,
						(getPosASLVisual _obj),
						_iconSize,
						_iconSize,
						(getDirVisual _obj),
						_text,
						1,
						0.03,
						'RobotoCondensedBold',
						'left'
					];
				};
			} forEach (QS_list_playerBuildables + (localNamespace getVariable ['QS_map_globalObjects',[]]));
			if (_nearish isNotEqualTo []) then {
				_nearest = [_nearish,_cursorPos] call BIS_fnc_nearestPosition;
				uiNamespace setVariable ['QS_map_closestBuildable',_nearest];
				_text = localize 'STR_QS_Text_389';
				_icon = _nearest getVariable ['QS_map_icon',''];
				if (_icon isEqualTo '') then {
					_icon = getText ((configOf _nearest) >> 'icon');
					_nearest setVariable ['QS_map_icon',_icon];
				};
				_map drawIcon [
					_icon,
					[1,0,0,1],
					getPosASLVisual _nearest,
					5,
					5,
					getDirVisual _nearest,
					_text,
					1,
					0.04,
					'RobotoCondensedBold',
					'right'
				];
			};
			private _nearishMarkers = [];
			private _nearestMarker = '';
			private _markerIcon = '';
			private _marker = '';
			private _serverTime = serverTime;
			private _allMarkers = allMapMarkers;
			private _markerColor = [0,0,0,0];
			_markerIcon = localNamespace getVariable ['QS_supportMarker_icon',''];
			if (_markerIcon isEqualTo '') then {
				_markerIcon = getText (configFile >> 'CfgMarkers' >> 'mil_dot' >> 'icon');
				localNamespace setVariable ['QS_supportMarker_icon',_markerIcon];
			};
			{
				if (_x isEqualType []) then {
					_marker = _x # 0;
					_timeout = _x # 1;
					if (
						(_marker in _allMarkers) &&
						{(_serverTime > (_timeout + 60))}
					) then {
						_markerColor = [1,0.5,0.5,1];
						if (((markerPos _marker) distance2D _cursorPos) < 100) then {
							_nearishMarkers pushBack _marker;
						};
						_map drawIcon [
							_markerIcon,
							_markerColor,
							markerPos _marker,
							5,
							5,
							0,
							'',
							1,
							0.03,
							'RobotoCondensedBold',
							'left'
						];
					};
				};
			} forEach QS_markers_fireSupport;
			if (_nearishMarkers isNotEqualTo []) then {
				_nearestMarker = [_nearishMarkers,_cursorPos] call BIS_fnc_nearestPosition;
				uiNamespace setVariable ['QS_map_closestSupportMarker',_nearestMarker];
				_markerIcon = localNamespace getVariable ['QS_map_icon',''];
				if (_markerIcon isEqualTo '') then {
					_markerIcon = getText (configFile >> 'CfgMarkers' >> 'mil_dot' >> 'icon');
					localNamespace setVariable ['QS_supportMarker_icon',_markerIcon];
				};
				_map drawIcon [
					_markerIcon,
					[1,0,0,1],
					markerPos _nearestMarker,
					5,
					5,
					0,
					localize 'STR_QS_Text_389',
					1,
					0.04,
					'RobotoCondensedBold',
					'left'
				];
			};
		}
	];
	QS_map_mouseMovingBuildables = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler [
		'MouseMoving',
		{
			params [
				["_mapCtrl",controlNull, [controlNull]],
				["_xPos",-1,[0]],
				["_yPos",-1,[0]],
				["_mouseIn", false, [true]]
			];
			if (diag_frameNo > (uiNamespace getVariable ['QS_map_lastFramePos',-1])) then {
				uiNamespace setVariable ['QS_map_lastFramePos',diag_frameNo + 1];
				_worldCoord = _mapCtrl ctrlMapScreenToWorld [_xPos,_yPos];
				uiNamespace setVariable ['QS_map_cursorPos',_worldCoord];
			};
		}
	];
	QS_map_mouseButtonDownBuildables = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler [
		'MouseButtonDown',
		{
			params ['','_button','','','','_ctrl',''];
			if (
				(_button isEqualTo 1) &&
				_ctrl
			) then {
				_closestBuildable = uiNamespace getVariable ['QS_map_closestBuildable',objNull];
				if (!isNull _closestBuildable) then {
					if ((_closestBuildable distance2D (uiNamespace getVariable ['QS_map_cursorPos',[0,0,0]])) < 100) then {
						_nearUnits = allPlayers - [player];
						_radius = localNamespace getVariable ['QS_map_deleteDistance',50];
						if ((_nearUnits inAreaArray [_closestBuildable,_radius,_radius,0,FALSE]) isEqualTo []) then {
							if (!local _closestBuildable) then {
								['systemChat',format [localize 'STR_QS_Text_401',profileName,(getText ((configOf _closestBuildable) >> 'displayName')),mapGridPosition _closestBuildable]] remoteExec ['QS_fnc_remoteExecCmd',_closestBuildable,FALSE];
							};
							deleteVehicle _closestBuildable;
						} else {
							50 cutText [localize 'STR_QS_Text_400','PLAIN',0.5,TRUE];
						};
					};
				};
				_closestMarker = uiNamespace getVariable ['QS_map_closestSupportMarker',''];
				if (_closestMarker in allMapMarkers) then {
					if (((markerPos _closestMarker) distance2D (uiNamespace getVariable ['QS_map_cursorPos',[0,0,0]])) < 100) then {
						deleteMarker _closestMarker;
						uiNamespace setVariable ['QS_map_closestSupportMarker',''];
					};
				};
			};
		}
	];
} else {
	((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ['Draw',QS_map_drawBuildables];
	((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ['MouseMoving',QS_map_mouseMovingBuildables];
	((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ['MouseButtonDown',QS_map_mouseButtonDownBuildables];
};