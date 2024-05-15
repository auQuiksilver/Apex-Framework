/*/
File: fn_clientInteractUnload.sqf
Author:

	Quiksilver
	
Last Modified:

	4/09/2017 A3 1.76 by Quiksilver
	
Description:

	-
_____________________________________________________________/*/

private [
	'_t','_a','_c','_approved','_unit','_anim','_exit','_position'
];
_t = cursorTarget;
_approved = FALSE;
if (((vectorMagnitude (velocity _t)) * 3.6) < 2) then {
	if ((_t isKindOf 'LandVehicle') || {(_t isKindOf 'Air')} || {(_t isKindOf 'Ship')}) then {
		_approved = TRUE;
	};
};
if (!(_approved)) exitWith {
	50 cutText [localize 'STR_QS_Text_163','PLAIN DOWN',0.3];
};
_exit = FALSE;
{
	_unit = _x;
	if (alive _unit) then {
		if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
			_exit = TRUE;
			if ((!isNull (attachedTo _unit)) && (unitIsUav (attachedTo _unit))) then {
				if ([_t,0] call (missionNamespace getVariable 'QS_fnc_clientInteractUGV')) then {
					_exit = [_t,3,_unit] call (missionNamespace getVariable 'QS_fnc_clientInteractUGV');
					if (_exit) then {
						_unit setVariable ['QS_RD_loaded',FALSE,TRUE];
						_unit setVariable ['QS_RD_loadable',TRUE,TRUE];
					};
				};
			};
		};
		if (_exit) exitWith {};
		if (_unit getVariable ['QS_RD_loadable',FALSE]) then {
			if (local _unit) then {
				unassignVehicle _unit;
				moveOut _unit;
				_unit enableAIFeature ['MOVE',FALSE];
				_unit enableAIFeature ['FSM',FALSE];
				_unit enableAIFeature ['PATH',FALSE];
			} else {
				0 = [90,_unit,1] remoteExec ['QS_fnc_remoteExec',0,FALSE];
			};
			50 cutText [(format [localize 'STR_QS_Text_164',(name _unit)]),'PLAIN DOWN',0.3];
			_unit setVariable ['QS_RD_loaded',FALSE,TRUE];
			waitUntil {
				(isNull (objectParent _unit))
			};
			if (!(_unit isNil 'QS_RD_isIncapacitated')) then {
				if (_unit getVariable 'QS_RD_isIncapacitated') then {
					if (local _unit) then {
						if (!(_unit isNil 'QS_RD_storedAnim')) then {
							0 = ['switchMove',_unit,(_unit getVariable 'QS_RD_storedAnim')] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						} else {
							0 = ['switchMove',_unit,'AinjPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						};
					} else {
						0 = [12,_unit] remoteExec ['QS_fnc_remoteExec',0,FALSE];
					};
				};
			};
			if (!(_unit isNil 'QS_isSurrendered')) then {
				if (_unit getVariable 'QS_isSurrendered') then {
					0 = ['switchMove',_unit,'amovpercmstpssurwnondnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
				};
			};
			_exit = TRUE;
		};
	};
	if (_exit) exitWith {
		50 cutText [(format [localize 'STR_QS_Text_164',(name _unit)]),'PLAIN DOWN',0.5];
	};
} count ((crew _t) + (attachedObjects _t));
TRUE;