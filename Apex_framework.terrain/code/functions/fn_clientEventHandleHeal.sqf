/*
File: fn_clientEventHandleHeal.sqf
Author: 

	Quiksilver
	
Last modified:

	30/08/2016 A3 1.62 by Quiksilver
	
Description:

	Handle Heal Event
___________________________________________________________________*/

params ['_unit','_healer','_healerIsMedic'];
if (!isPlayer _healer) then {
	_this spawn {
		params ['_unit','_healer','_healerIsMedic'];
		if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
			_healer doWatch _unit;
			private _dirTo = _healer getDir _unit;
			(group _healer) setFormDir _dirTo;
			_healer setDir _dirTo;
			private _dmg = damage _unit;
			private _t = time + 7;
			waitUntil {
				((damage _unit) < _dmg) ||
				(!alive _unit) ||
				(!alive _healer) ||
				(time > _t)
			};
			if (alive _unit) then {
				if (alive _healer) then {
					if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
						if (local _unit) then {
							_unit setUnconscious FALSE;
							_unit setCaptive FALSE;
						} else {
							[68,_unit,FALSE,FALSE] remoteExec ['QS_fnc_remoteExec',_unit,FALSE];
						};
						_unit allowDamage TRUE;
					};
					if (isPlayer _unit) then {
						['systemChat',(format [localize 'STR_QS_Chat_089',(name _healer)])] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];
					};
					_healer doWatch objNull;
				};
			};
		};
	};
} else {
	if (player isNotEqualTo _healer) then {
		if (player isEqualTo _unit) then {
			50 cutText [(format [localize 'STR_QS_Text_019',(name _healer)]),'PLAIN DOWN',0.5];
		};
	};
};