/*/
File: fn_respawnPilot.sqf
Author: 
	
	Quiksilver
	
Last modified: 

	17/08/2018 A3 1.84 by Quiksilver

Description: 

	Separate pilot respawn and UAV operator
	Also handles naval respawning
__________________________________________________/*/

_worldName = worldName;
if (player getUnitTrait 'QS_trait_fighterPilot') exitWith {
	if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
		['RESPAWN_PLAYER'] call (missionNamespace getVariable 'QS_fnc_carrier');
	} else {
		if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
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
			if (_worldName isEqualTo 'Enoch') exitWith {
				player setDir 68.4751;
				player setPosWorld [4306.76,10501.5,68.1707];
			};
		} else {
			player setDir (random 360);
			player setPosATL [((markerPos 'QS_marker_respawn_jetpilot') # 0),((markerPos 'QS_marker_respawn_jetpilot') # 1), 0];	/*/ Edit the 0 here to change elevation /*/
		};
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2) exitWith {
	['RESPAWN_PLAYER'] call (missionNamespace getVariable 'QS_fnc_carrier');
};
if ((missionNamespace getVariable ['QS_missionConfig_destroyerRespawn',0]) isEqualTo 1) exitWith {
	['RESPAWN_PLAYER'] call (missionNamespace getVariable 'QS_fnc_destroyer');
};
if (player getUnitTrait 'QS_trait_pilot') then {
	if ((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2) then {
		['RESPAWN_PLAYER'] call (missionNamespace getVariable 'QS_fnc_carrier');
	} else {
		if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
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
			if (_worldName isEqualTo 'Enoch') exitWith {
				player setDir (random 360);
				player setPosWorld [3864.66,10137,67.7403];
			};
		} else {
			player setDir (random 360);
			player setPosATL [((markerPos 'QS_marker_respawn_helipilot') # 0),((markerPos 'QS_marker_respawn_helipilot') # 1), 0];	/*/ Edit the 0 here to change elevation /*/
		};
	};
};
if (player getUnitTrait 'uavhacker') then {
	if ((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2) then {
		['RESPAWN_PLAYER'] call (missionNamespace getVariable 'QS_fnc_carrier');
	} else {
		if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
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
			if (_worldName isEqualTo 'Enoch') exitWith {
				player setDir 258.922;
				player setPosWorld [4110.76,10286.7,77.2023];
			};
		} else {
			player setDir (random 360);
			player setPosATL [((markerPos 'QS_marker_respawn_uavoperator') # 0),((markerPos 'QS_marker_respawn_uavoperator') # 1), 0];	/*/ Edit the 0 here to change elevation /*/
		};
	};
};