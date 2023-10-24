/*
@filename: fn_vRT.sqf
Author:

	Quiksilver
	
Last modified:

	5/09/2022 A3 2.10 by Quiksilver
	
Description:

	Respawn timer
__________________________________________________*/

params ['_killed','_killer','_instigator','_usedEffects'];
private _text = '';
if (!isNull _instigator) then {
	if (isPlayer _instigator) then {
		_text = format ['%1 %2',(name _instigator),localize 'STR_QS_Chat_107'];
		['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
};
if (!isNull (attachedTo _killed)) then {
	[0,_killed] call QS_fnc_eventAttach;
};
TRUE;