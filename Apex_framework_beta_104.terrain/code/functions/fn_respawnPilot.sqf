/*/
File: fn_respawnPilot.sqf
Author: 
	
	Quiksilver
	
Last modified: 

	17/12/2017 A3 1.80 by Quiksilver

Description: 

	Separate pilot respawn and UAV operator
__________________________________________________/*/

private ['_spawnBuilding','_positions','_position'];
_worldName = worldName;
_typeL = toLower (typeOf player);
if (_typeL in ['b_pilot_f','b_helipilot_f','b_t_helipilot_f','b_helicrew_f','o_pilot_f','o_helipilot_f','o_helicrew_f','i_pilot_f','i_helipilot_f','i_helicrew_f']) then {
	if ((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2) then {
		['RESPAWN_PLAYER'] call (missionNamespace getVariable 'QS_fnc_carrier');
	} else {
		if (_worldName isEqualTo 'Altis') exitWith {
			player setDir 130;
			player setPosWorld [(14752.6 + 3 - (random 6)),(16856.8 + 3 - (random 6)),18.001];
		};
		if (_worldName isEqualTo 'Tanoa') exitWith {
			player setDir (random 360);
			player setPosWorld [(7089.77 + 2 - (random 4)),(7300 + 2 - (random 4)),2.66144];
		};
		if (_worldName isEqualTo 'Malden') exitWith {
			player setDir (random 360);
			player setPosWorld [(8057.48 + 2 - (random 4)),(10291 + 2 - (random 4)),29.8258];
		};
	};
};
if (_typeL in ['b_soldier_uav_f','b_t_soldier_uav_f']) then {
	if ((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2) then {
		['RESPAWN_PLAYER'] call (missionNamespace getVariable 'QS_fnc_carrier');
	} else {
		if (_worldName isEqualTo 'Altis') then {
			player setDir 110.352;
			player setPosWorld [14624.7,16721.2,30.8307];
		};
		if (_worldName isEqualTo 'Tanoa') exitWith {
			player setDir 76.499;
			player setPosWorld [6899.05,7423.78,15.7328];
		};
		if (_worldName isEqualTo 'Malden') exitWith {
			player setDir 252.468;
			player setPosWorld [8106.64,10104.3,42.5627];
		};
	};
};
if (_typeL in ['b_fighter_pilot_f']) then {
	if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
		['RESPAWN_PLAYER'] call (missionNamespace getVariable 'QS_fnc_carrier');
	} else {
		if (_worldName isEqualTo 'Altis') exitWith {
			player setDir (314.968 + (5 - (random 10)));
			player setPosWorld [14461.8,16265.6,18.6627];
		};
		if (_worldName isEqualTo 'Tanoa') exitWith {
			player setDir (72 + (5 - (random 10)));
			player setPosWorld [(6830 + (2 - (random 4))),(7261 + (2 - (random 4))),2.69];
		};
		if (_worldName isEqualTo 'Malden') exitWith {
			player setDir 100.961;
			player setPosWorld [8055.05,10014.9,30.0609];
		};
	};
};