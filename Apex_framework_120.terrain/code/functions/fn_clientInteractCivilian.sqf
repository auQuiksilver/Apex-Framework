/*/
File: fn_clientInteractCivilian.sqf
Author:

	Quiksilver
	
Last Modified:

	13/06/2018 ArmA 3 1.82
	
Description:

	-
________________________________________________/*/

_t = cursorTarget;
private _c = FALSE;
if (isNull (objectParent _t)) then {
	if ((side _t) isEqualTo CIVILIAN) then {
		if (alive _t) then {
			if (!isNil {_t getVariable 'QS_civilian_interactable'}) then {
				if (_t getVariable 'QS_civilian_interactable') then {
					_c = TRUE;
				};
			};
		};
	};
};
if (!(_c)) exitWith {false;};
private _text = '';
_QS_interacted = _t getVariable 'QS_civilian_interacted';
if (_QS_interacted) exitWith {
	if ((random 1) > 0.5) then {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,'This civilian is no longer interested in speaking to your kind.',[],-1,TRUE,'Civilian',TRUE];
	} else {
		if ((random 1) > 0.5) then {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,'This civilian has nothing more to say to your kind.',[],-1,TRUE,'Civilian',TRUE];
		} else {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,'You are wasting your breath, this civilian is not listening anymore',[],-1,TRUE,'Civilian',TRUE];
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
				(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,'The civilian has narrowed down the location of the P.O.W. on your map',[],-1,TRUE,'Civilian',TRUE];
			} else {
				_text = format ['%1 has improved the accuracy of your mission map marker',name _t];
				(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,_text,[],-1,TRUE,'Civilian',TRUE];
			};
		} else {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,'The civilian can provide no further assistance.',[],-1,TRUE,'Civilian',TRUE];
		};
	} else {
		if ((random 1) > 0.5) then {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,'This civilian does not know anything useful',[],-1,TRUE,'Civilian',TRUE];
		} else {
			if ((random 1) > 0.5) then {
				_text = format ['%1 has not spoken in six years, what makes you think he will open up to you?',(name _t)];
				(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,_text,[],-1,TRUE,'Civilian',TRUE];
			} else {
				if ((random 1) > 0.25) then {
					(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,'The civilian mutters something quietly and keeps moving',[],-1,TRUE,'Civilian',TRUE];
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
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,10,-1,'This civilians family was killed in a NATO airstrike last week. He will not say anything useful',[],-1,TRUE,'Civilian',TRUE];
		} else {
			_text = format ['%1 wants nothing to do with NATO and would like you to leave %2.',name _t,worldName];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,_text,[],-1,TRUE,'Civilian',TRUE];
		};
	} else {
		if ((random 1) > 0.5) then {
			_text = format ['%1 appears to be going to alert the enemy',name _t];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,_text,[],-1,TRUE,'Civilian',TRUE];
			_t setVariable ['QS_civilian_alertingEnemy',TRUE,TRUE];
		} else {
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,7.5,-1,'This civilian will happily watch you die',[],-1,TRUE,'Civilian',TRUE];
		};
	};
};
true;