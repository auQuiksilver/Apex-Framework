/*
File: fn_eventEntityKilled.sqf
Author:

	Quiksilver
	
Last modified:

	30/03/2017 A3 1.68 by Quiksilver
	
Description:

	Event Entity Killed
__________________________________________________*/

params ['_killed','_killer','_instigator','_useEffects'];
missionNamespace setVariable [
	'QS_analytics_entities_killed',
	((missionNamespace getVariable 'QS_analytics_entities_killed') + 1),
	FALSE
];
missionNamespace setVariable ['QS_system_entitiesKilled',((missionNamespace getVariable ['QS_system_entitiesKilled',0]) + 1),FALSE];
if (isPlayer _killed) then {
	if (!isNull _killer) then {
		if (!(_killer isEqualTo _killed)) then {
			missionNamespace setVariable [
				'QS_playerKilledCountServer',
				((missionNamespace getVariable 'QS_playerKilledCountServer') + 1),
				FALSE
			];	
			if (unitIsUAV _killer) then {
				if (!local _killer) then {
					if (([(getPosATL _killer),15,[WEST,CIVILIAN],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
						deleteVehicle _killer;
					};
				};
			};
		};
	};
} else {
	if ((vehicle _killed) isKindOf 'Man') then {
		if (local _killed) then {
			{
				_killed setVariable [_x,nil,FALSE];
			} count (allVariables _killed);
		};
		if (((toLower (typeOf _killed)) in ['o_sniper_f','o_ghillie_ard_f','o_ghillie_lsh_f','o_ghillie_sard_f','o_t_sniper_f','o_t_ghillie_tna_f','i_sniper_f']) || (_killed getUnitTrait 'QS_trait_sniper')) then {
			if (!isNull _killer) then {
				if (isPlayer _killer) then {
					if (!((vehicle _killer) isKindOf 'Air')) then {
						_text = format ['Enemy sniper ( %1 ) killed by %2!',(name _killed),(name _killer)];
						['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
					};
				};
			};
		};
	} else {
		if (_killed isKindOf 'Reammobox_F') then {
			if (!isNull (attachedTo _killed)) then {
				detach _killed;
			};
		};
		if (_killed isKindOf 'AllVehicles') then {
			if (local _v) then {
				_v engineOn FALSE;
				_v setFuel 0;
			};
			{
				if (alive _x) then {
					detach _x;
					_x setDamage [1,FALSE];
					deleteVehicle _x;
				};
			} count (attachedObjects _killed);
		};
	};
};