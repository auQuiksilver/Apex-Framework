/*/
File: fn_respawnPilot.sqf
Author: 
	
	Quiksilver
	
Last modified: 

	23/10/2022 A3 2.10 by Quiksilver

Description: 

	Separate pilot respawn and UAV operator
	Also handles naval respawning
	
	Probably should be renamed to "QS_fnc_respawnPosition" instead of "respawnPilot"
__________________________________________________/*/

_worldName = worldName;
/*/
if (
	(missionNamespace getVariable ['QS_missionConfig_zeusRespawnFlag',FALSE]) &&
	{((['QS_trait_fighterPilot','QS_trait_pilot'] findIf { (player getUnitTrait _x) }) isEqualTo -1)}
) exitWith {};
/*/
if (['INPOLYGON_FOOT',player] call (missionNamespace getVariable 'QS_fnc_destroyer')) exitWith {
	['RESPAWN_PLAYER'] spawn (missionNamespace getVariable 'QS_fnc_destroyer');
};
if (['INPOLYGON_FOOT',player] call (missionNamespace getVariable 'QS_fnc_carrier')) exitWith {
	['RESPAWN_PLAYER'] spawn (missionNamespace getVariable 'QS_fnc_carrier');
};
if (player getUnitTrait 'QS_trait_fighterPilot') exitWith {
	if ((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isNotEqualTo 0) then {
		['RESPAWN_PLAYER'] spawn (missionNamespace getVariable 'QS_fnc_carrier');
	} else {
		if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
			if (_worldName isEqualTo 'Altis') exitWith {
				player setDir (314.968 + (5 - (random 10)));
				player setPosWorld [14461.8,16265.6,18.6627];
			};
			if (_worldName isEqualTo 'Tanoa') exitWith {
				player setDir (72 + (5 - (random 10)));
				player setPosWorld [6830,7261,2.69];
			};
			if (_worldName isEqualTo 'Malden') exitWith {
				player setDir 100.961;
				player setPosWorld [8055.05,10014.9,30.0609];
			};
			if (_worldName isEqualTo 'Enoch') exitWith {
				player setDir 68.4751;
				player setPosWorld [4306.76,10501.5,68.1707];
			};
			if (_worldName isEqualTo 'Stratis') exitWith {
				player setDir 341;
				player setPosWorld [1910.55,5938.28,5.50144];
			};
		} else {
			if ((missionNamespace getVariable ['QS_mission_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']) then {
				player setDir (random 360);
				player setPos (markerPos ['QS_marker_respawn_jetpilot',TRUE]);		// position AGL. https://community.bistudio.com/wiki/markerPos . see alternative syntax
			};
		};
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2) exitWith {
	['RESPAWN_PLAYER'] spawn (missionNamespace getVariable 'QS_fnc_carrier');
};
if ((missionNamespace getVariable ['QS_missionConfig_destroyerRespawn',0]) isEqualTo 1) exitWith {
	['RESPAWN_PLAYER'] spawn (missionNamespace getVariable 'QS_fnc_destroyer');
};
if (
	(missionNamespace getVariable ['QS_missionConfig_zeusRespawnFlag',FALSE]) &&
	((missionNamespace getVariable ['QS_mission_aoType','CLASSIC']) in ['NONE','ZEUS'])
) exitWith {};
if (player getUnitTrait 'QS_trait_pilot') then {
	if ((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2) then {
		['RESPAWN_PLAYER'] spawn (missionNamespace getVariable 'QS_fnc_carrier');
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
			if (_worldName isEqualTo 'Stratis') exitWith {
				player setDir (random 360);
				player setPosWorld [1947.32,5820.64,5.50144];
			};
		} else {
			player setDir (random 360);
			player setPos (markerPos ['QS_marker_respawn_helipilot',TRUE]);		// position AGL. https://community.bistudio.com/wiki/markerPos . see alternative syntax
		};
	};
};
if (player getUnitTrait 'uavhacker') then {
	if ((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2) then {
		['RESPAWN_PLAYER'] spawn (missionNamespace getVariable 'QS_fnc_carrier');
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
			if (_worldName isEqualTo 'Stratis') exitWith {
				player setDir 294.613;
				player setPosWorld [1906.07,5713.91,18.4492];
			};
		} else {
			player setDir (random 360);
			player setPos (markerPos ['QS_marker_respawn_uavoperator',TRUE]);	// position AGL. https://community.bistudio.com/wiki/markerPos . see alternative syntax
		};
	};
};