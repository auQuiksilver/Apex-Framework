/*/
File: fn_vKilled2.sqf
Author:

	Quiksilver
	
Last modified:

	4/04/2018 A3 1.82 by Quiksilver
	
Description:

	-
__________________________________________________/*/
params ['_killed','_killer','_instigator',''];
if (!isNull _killer) then {
	if ((vehicle _killer) isKindOf 'Air') then {
		if (isPlayer (effectiveCommander _killer)) then {
			_killerName = if ((alive _instigator) && {(isPlayer _instigator)}) then {(name _instigator)} else {(name (effectiveCommander _killer))};
			_killerType = typeOf (vehicle _killer);
			_killedType = typeOf _killed;
			_killerDisplayName = getText ((configOf (vehicle _killer)) >> 'displayName');
			_killedDisplayName = getText ((configOf _killed) >> 'displayName');
			if (isServer) then {
				[[WEST,'BLU'],(format ['%1 %4 %2 %5 %3!',_killerName,_killedDisplayName,_killerDisplayName,localize 'STR_QS_Chat_045',localize 'STR_QS_Chat_046'])] remoteExec ['sideChat',-2,FALSE];
			} else {
				['sideChat',[WEST,'BLU'],(format ['%1 %4 %2 %5 %3!',_killerName,_killedDisplayName,_killerDisplayName,localize 'STR_QS_Chat_045',localize 'STR_QS_Chat_046'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			};
		};
	};
};