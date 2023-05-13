/*
@filename: fn_vRT.sqf
Author:

	Quiksilver
	
Last modified:

	01/05/2023 A3 2.10 by Quiksilver
	
Description:

	Respawn timer
__________________________________________________*/

params ['_killed','_killer','_instigator','_usedEffects'];
private _text = '';
if (!isNull _instigator) then {
	if (isPlayer _instigator) then {
		_text = format [localize 'STR_QS_Chat_107',(name _instigator)];
		['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
};
if (!isNull (attachedTo _killed)) then {
	detach _killed;
};
TRUE;