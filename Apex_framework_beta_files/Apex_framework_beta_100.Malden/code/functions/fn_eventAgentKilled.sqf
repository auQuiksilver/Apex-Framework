/*
@filename: fn_vRT.sqf
Author:

	Quiksilver
	
Last modified:

	20/01/2016 ArmA 1.54 by Quiksilver
	
Description:

	Respawn timer
__________________________________________________*/

params ['_killed','_killer','_instigator','_usedEffects'];
private _text = '';
if (!isNull _instigator) then {
	if (isPlayer _instigator) then {
		if (!isNil {_killed getVariable 'QS_surrender_captor'}) then {
			_captor = (_killed getVariable 'QS_surrender_captor') select 0;
			if (!(_captor == (name _instigator))) then {
				_text = format ['%1 has killed %2s prisoner!',(name _instigator),_captor];
				['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			} else {
				_text = format ['%1 has killed a prisoner!',(name _instigator)];
				['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			};
		} else {
			_text = format ['%1 has killed a prisoner!',(name _instigator)];
			['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
};
if (!isNull (attachedTo _killed)) then {
	detach _killed;
};
TRUE;