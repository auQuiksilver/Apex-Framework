/*/
File: fn_clientInteractCivilian.sqf
Author:

	Quiksilver
	
Last Modified:

	01/05/2023 A3 2.10
	
Description:

	-
________________________________________________/*/

_t = cursorTarget;
if (
	(!alive _t) ||
	{(!isNull (objectParent _t))} ||
	{((side _t) isNotEqualTo CIVILIAN)} ||
	{(!(_t getVariable ['QS_civilian_interactable',FALSE]))}
) exitWith {};
private _text = '';
_QS_interacted = _t getVariable 'QS_civilian_interacted';
if (_QS_interacted) exitWith {
	if ((random 1) > 0.5) then {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,localize 'STR_QS_Hints_019',[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
	} else {
		if ((random 1) > 0.5) then {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,localize 'STR_QS_Hints_020',[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
		} else {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,localize 'STR_QS_Hints_021',[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
		};
	};
};
_QS_responseNeutrality = _t getVariable 'QS_civilian_neutrality';
if (_QS_responseNeutrality isEqualTo 0) then {
	_t setVariable ['QS_civilian_interacted',TRUE,TRUE];
	if ((random 1) > 0.40) then {
		if ((missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality') < 3) then {
			missionNamespace setVariable ['QS_sideMission_POW_civIntel_quality',((missionNamespace getVariable 'QS_sideMission_POW_civIntel_quality') + 1),TRUE];
			if ((random 1) > 0.5) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,localize 'STR_QS_Hints_022',[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
			} else {
				_text = format [localize 'STR_QS_Hints_024',name _t];
				(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,_text,[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
			};
		} else {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,localize 'STR_QS_Hints_025',[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
		};
	} else {
		if ((random 1) > 0.5) then {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,localize 'STR_QS_Hints_026',[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
		} else {
			if ((random 1) > 0.5) then {
				_text = format [localize 'STR_QS_Hints_027',(name _t)];
				(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,_text,[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
			} else {
				if ((random 1) > 0.25) then {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,localize 'STR_QS_Hints_028',[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
				} else {
					_t setVariable ['QS_civilian_suicideBomber',TRUE,TRUE];
				};
			};
		};
	};
		
};
if (_QS_responseNeutrality isEqualTo -1) then {
	_t setVariable ['QS_civilian_interacted',TRUE,TRUE];
	if ((random 1) > 0.25) then {
		if ((random 1) > 0.5) then {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,10,-1,localize 'STR_QS_Hints_029',[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
		} else {
			_text = format [localize 'STR_QS_Hints_030',name _t,worldName];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,_text,[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
		};
	} else {
		if ((random 1) > 0.5) then {
			_text = format [localize 'STR_QS_Hints_031',name _t];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,_text,[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
			_t setVariable ['QS_civilian_alertingEnemy',TRUE,TRUE];
		} else {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,localize 'STR_QS_Hints_032',[],-1,TRUE,localize 'STR_QS_Hints_023',TRUE];
		};
	};
};
true;