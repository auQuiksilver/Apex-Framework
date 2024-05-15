/*/
File: fn_zeusMission.sqf
Author:

	Quiksilver
	
Last Modified:

	26/08/2022 A3 2.10 by Quiksilver
	
Description:

	Zeus Mission Server Component
___________________________________________/*/

params ['_type'];
if (_type isEqualTo 'CAPTURE_MAN') exitWith {
	if (isDedicated) then {
		params ['','_unit','_isMission'];
		// SERVER - step 3
		if (_isMission) then {
			_text = format ['%2 %1',localize 'STR_QS_Marker_047',(toString [32,32,32])];
			private _radius = 150;
			_radiusVehicle = 500;
			_radiusFoot = 250;
			_refreshrate = 5;
			private _markerPos = [0,0,0];
			_marker = createMarker ['QS_curatorInterface_captureMan_marker1',[0,0,0]];
			_marker setMarkerShapeLocal 'ellipse';
			_marker setMarkerBrushLocal 'border';
			_marker setMarkerSizeLocal [_radius,_radius];
			_marker setMarkerTextLocal _text;
			_marker setMarkerColorLocal 'ColorOPFOR';
			_marker setMarkerShadowLocal TRUE;
			_marker setMarkerAlpha 0.75;
			_marker2 = createMarker ['QS_curatorInterface_captureMan_marker2',[0,0,0]];
			_marker2 setMarkerShapeLocal 'icon';
			_marker2 setMarkerTypeLocal 'mil_dot';
			_marker2 setMarkerSizeLocal [0.5,0.5];
			_marker2 setMarkerTextLocal _text;
			_marker2 setMarkerColorLocal 'ColorOPFOR';
			_marker2 setMarkerShadowLocal TRUE;
			_marker2 setMarkerAlpha 0.75;
			while {(alive _unit)} do {
				if (isNull (objectParent _unit)) then {
					_radius = _radiusFoot;
				} else {
					_radius = _radiusVehicle;
				};
				_marker setMarkerSize [_radius,_radius];
				if (isNull _unit) exitWith {};
				if ((_unit distance2D _markerPos) > _radius) then {
					_markerPos = _unit getPos [(_radius * (sqrt (random 1))),(random 360)];
					_markerPos set [2,0];
					{_x setMarkerPos _markerPos;} count [_marker,_marker2];
				};
				uiSleep _refreshrate;
			};
			{
				deleteMarker _x;
			} count [_marker,_marker2];
		};
	} else {
		params ['','_unit'];
		// CLIENT - step 1
		_unit setVariable ['QS_hidden',TRUE,TRUE];
		_unit enableAIFeature ['PATH',FALSE];
		_unit addEventHandler ['HandleDamage',{0}];
		_unit setVariable ['QS_lastHitTime',-1];
		_unit addEventHandler [
			'Hit',
			{
				params ['_unit','_source','_damage','_instigator'];
				if (!(local _unit)) exitWith {};
				if (isNull (objectParent _unit)) then {
					if (isPlayer _instigator) then {
						if (diag_tickTime > (_unit getVariable ['QS_lastHitTime',-1])) then {
							_unit setVariable ['QS_lastHitTime',diag_tickTime + 0.1];
							if (!((lifeState _unit) isEqualTo 'INCAPACITATED')) then {
								_unit addForce [_unit vectorModelToWorld [0,0,0], [0,0,0]];
							};
						};
					};
				};
			}
		];
		_unit spawn {
			while {alive _this} do {
				if ((lifeState _this) isEqualTo 'INCAPACITATED') then {
					sleep 4;
					_this setUnconscious FALSE;
					_this switchMove ['AmovPpneMstpSnonWnonDnon'];
				};
				sleep 1;
			};
		};
		if (!alive (missionNamespace getVariable ['QS_zeus_captureMan',objNull])) then {
			missionNamespace setVariable ['QS_zeus_captureMan',_unit,FALSE];
			[43,_type,_unit,TRUE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		} else {
			[43,_type,_unit,FALSE] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
	};
};