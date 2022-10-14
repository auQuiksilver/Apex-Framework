/*/
File: fn_clientInteractStabilise.sqf
Author:

	Quiksilver

Last modified:

	3/11/2017 A3 1.76 by Quiksilver
	
Description:

	Stablise
___________________________________________________/*/

_t = cursorTarget;
if (!(_t isKindOf 'CAManBase')) exitWith {};
if (!alive _t) exitWith {};
if (!(_t getVariable ['QS_interact_stabilise',FALSE])) exitWith {};
if (_t getVariable ['QS_interact_stabilised',FALSE]) exitWith {};
missionNamespace setVariable ['QS_client_stabilise_timeout',(diag_tickTime + 10),FALSE];
missionNamespace setVariable ['QS_client_stabilise_entity',_t,FALSE];
_event = player addEventHandler [
	'AnimDone',
	{
		params ['_unit','_anim'];
		if (diag_tickTime > (missionNamespace getVariable ['QS_client_stabilise_timeout',-1])) then {
			player removeEventHandler [_thisEvent,_thisEventHandler];
			missionNamespace setVariable ['QS_client_stabilise_timeout',nil,FALSE];
			missionNamespace setVariable ['QS_client_stabilise_entity',objNull,FALSE];
		};
		if (
			(['medicdummyend',_anim,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || 
			((['medicother',_anim,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) && (!(['medicotherin',_anim,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))))
		) then {
			player removeEventHandler [_thisEvent,_thisEventHandler];
			if (alive player) then {
				if ((lifeState player) in ['HEALTHY','INJURED']) then {
					_entity = missionNamespace getVariable ['QS_client_stabilise_entity',objNull];
					if (alive _entity) then {
						if ((lifeState _entity) isEqualTo 'INCAPACITATED') then {
							_entity setVariable ['QS_interact_stabilise',FALSE,TRUE];
							_entity setVariable ['QS_interact_stabilised',TRUE,TRUE];
							if (_entity getVariable ['QS_unit_needsStabilise',FALSE]) then {
								for '_x' from 0 to 2 step 1 do {
									_entity setVariable ['QS_unit_needsStabilise',FALSE,TRUE];
								};
							};
							50 cutText [localize 'STR_QS_Text_153','PLAIN DOWN',0.25];
						};
					};
				};
			};
			missionNamespace setVariable ['QS_client_stabilise_timeout',nil,FALSE];
			missionNamespace setVariable ['QS_client_stabilise_entity',objNull,FALSE];
		};
	}
];
player playAction 'medicother';