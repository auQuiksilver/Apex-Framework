/*
File: fn_clientATAdjust.sqf
Author:
	
	Quiksilver
	
Last Modified:

	23/12/2015 ArmA 3 1.54 by Quiksilver

Description:

__________________________________________________________*/

_t = _this select 0;
[42,[_t,0,player]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
_text = format ['%1 has been pardoned by %2',(name _t),profileName];
['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];