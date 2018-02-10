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
if ((speed _t) < 2) then {
	if ((speed _t) > -2) then {
		if ((_t isKindOf 'LandVehicle') || {(_t isKindOf 'Air')} || {(_t isKindOf 'Ship')}) then {
			_approved = TRUE;
		};
	};
};
if (!(_approved)) exitWith {
	50 cutText ['Vehicle is moving','PLAIN DOWN',0.3];
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
					/*/0 = ['switchMove',_unit,(['AinjPpneMstpSnonWnonDnon','acts_InjuredLyingRifle02'] select (isPlayer _unit))] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];/*/
				};
			} else {
				0 = [_unit,_t] spawn {
					params ['_unit','_t'];
					if (isPlayer _unit) exitWith {
						_unit setVariable ['QS_incapacitated_processMoveOutRequest',TRUE,TRUE];
					};
					0 = [70,_unit] remoteExecCall ['QS_fnc_remoteExec',_unit,FALSE];
					waitUntil {
						uiSleep 0.1;
						((isNull (objectParent _unit)) ||
						(!alive _unit) ||
						(isNull _unit))
					};
					uiSleep 0.1;
					_position = _t modelToWorld (_t selectionPosition ['pos cargo','memory']);
					_unit setVehiclePosition [_position,[],0,'CAN_COLLIDE'];
					uiSleep 0.01;
					_unit setVehiclePosition [(_t getRelPos [((_unit distance _t) + 0.5),(_t getRelDir _unit)]),[],0,'CAN_COLLIDE'];
					if (alive _unit) then {
						for '_x' from 0 to 9 step 1 do {
							if (!alive _unit) exitWith {};
							if ((toLower (animationState _unit)) in ['acts_injuredlyingrifle02','ainjppnemstpsnonwnondnon']) exitWith {};
							0 = ['switchMove',_unit,(['AinjPpneMstpSnonWnonDnon','acts_InjuredLyingRifle02'] select (isPlayer _unit))] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];
							uiSleep 0.1;
							if ((toLower (animationState _unit)) in ['acts_injuredlyingrifle02','ainjppnemstpsnonwnondnon']) exitWith {};
							uiSleep 0.5;
						};
					};
				};
			};
		};
		if (_exit) exitWith {};
		if (!isNil {_unit getVariable 'QS_RD_loadable'}) then {
			if (_unit getVariable 'QS_RD_loadable') then {
				if (local _unit) then {
					unassignVehicle _unit;
					moveOut _unit;
					_unit disableAI 'MOVE';
					_unit disableAI 'FSM';
					_unit disableAI 'PATH';
				} else {
					0 = [2,_unit] remoteExec ['QS_fnc_remoteExec',0,FALSE];
				};
				50 cutText [(format ['%1 unloaded',(name _unit)]),'PLAIN DOWN',0.3];
				_unit setVariable ['QS_RD_loaded',FALSE,TRUE];
				waitUntil {
					(isNull (objectParent _unit))
				};
				if (!isNil {_unit getVariable 'QS_RD_isIncapacitated'}) then {
					if (_unit getVariable 'QS_RD_isIncapacitated') then {
						if (local _unit) then {
							if (!isNil {_unit getVariable 'QS_RD_storedAnim'}) then {
								0 = ['switchMove',_unit,(_unit getVariable 'QS_RD_storedAnim')] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
							} else {
								0 = ['switchMove',_unit,'AinjPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
							};
						} else {
							0 = [12,_unit] remoteExec ['QS_fnc_remoteExec',0,FALSE];
						};
					};
				};
				if (!isNil {_unit getVariable 'QS_isSurrendered'}) then {
					if (_unit getVariable 'QS_isSurrendered') then {
						0 = ['switchMove',_unit,'amovpercmstpssurwnondnon'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					};
				};
				_exit = TRUE;
			};
		};
	};
	if (_exit) exitWith {
		50 cutText [(format ['%1 unloaded',(name _unit)]),'PLAIN DOWN',0.5];
	};
} count ((crew _t) + (attachedObjects _t));
TRUE;