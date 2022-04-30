/*/
File: fn_airbaseDefense.sqf
Author:

	Quiksilver
	
Last Modified:

	20/11/2017 A3 1.76 by Quiksilver

Description:

	Air Defense
___________________________________________________/*/

private ['_defensePos','_airdefenseGroup','_defender','_nearAir','_duration','_cooldown','_relPos','_defenderType','_gunner'];
_nearAir = _this select 0;
_duration = time + 300;	// online for x seconds
_cooldown = time + 900;	// unavailable for x seconds
_defensePos = markerPos 'QS_marker_airbaseDefense';
[_defensePos,15,30,75] call (missionNamespace getVariable 'QS_fnc_clearPosition');
_defenderType = 'b_aaa_system_01_f';
/*/
_defenderType = selectRandomWeighted [
	'b_aaa_system_01_f',0.333,	//0.5
	'b_sam_system_01_f',0.333,	//0.25
	'b_sam_system_02_f',0.333,	//0.25
	'b_sam_system_03_f',0.0		// kind of sucks at base defense
];
/*/
_defender = createVehicle [_defenderType,[-500,-500,50],[],0,'NONE'];
_defender allowDamage FALSE;
_defender allowCrewInImmobile TRUE;
_defender enableVehicleCargo FALSE;
_defender enableRopeAttach FALSE;
_worldName = worldName;
{ 
	_defender setObjectTextureGlobal [_forEachIndex,_x]; 
} forEach (getArray (configFile >> 'CfgVehicles' >> _defenderType >> 'TextureSources' >> (['Sand','Green'] select (_worldName in ['Tanoa','Lingor3'])) >> 'textures'));
_defender setVehicleRadar 2;
if (unitIsUav _defender) then {
	_defender setVariable ['QS_uav_protected',TRUE,FALSE];
};
_defender setVariable ['QS_curator_disableEditability',TRUE,FALSE];
_defender setVariable ['QS_inventory_disabled',TRUE,TRUE];
_defender setVehicleReportRemoteTargets FALSE;
_defender setVehicleReceiveRemoteTargets FALSE;
if ((toLower _defenderType) in ['b_sam_system_01_f','b_sam_system_02_f','b_sam_system_03_f']) then {
	_defender addEventHandler [
		'Fired',
		{
			params ['','','','','','','_projectile',''];
			missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
			missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
		}
	];
};
_defender addRating (0 - (rating _defender));
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	if (_worldName isEqualTo 'Altis') then {_defender setDir 135;};
	if (_worldName isEqualTo 'Tanoa') then {_defender setDir 77.8;};
	if (_worldName isEqualTo 'Malden') then {_defender setDir 269.576;};
	if (_worldName isEqualTo 'Enoch') then {_defender setDir 313.878;};
} else {
	_defender setDir (markerDir 'QS_marker_airbaseDefense');
};
_defender setVehiclePosition [_defensePos,[],0,'NONE'];
_defender lock 2;
_airdefenseGroup = createVehicleCrew _defender;
_gunner = gunner _defender;
_gunner setVariable ['QS_curator_disableEditability',TRUE,FALSE];
_defender setVariable ['QS_hidden',TRUE,TRUE];
_gunner setVariable ['QS_hidden',TRUE,TRUE];
_airdefenseGroup deleteGroupWhenEmpty TRUE;
missionNamespace setVariable [
	'QS_analytics_entities_created',
	((missionNamespace getVariable 'QS_analytics_entities_created') + 2),
	FALSE
];
_gunner addRating (0 - (rating _gunner));
_gunner allowDamage FALSE;
[[_gunner],1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_gunner setSkill ['aimingAccuracy',0.075];
_airdefenseGroup setFormDir 135;
_relPos = markerPos 'QS_marker_aoMarker';
_gunner doWatch [(_relPos select 0),(_relPos select 1),((_relPos select 2) + 2000)];
_airdefenseGroup setBehaviourStrong 'AWARE';
_airdefenseGroup setCombatMode 'RED';
[[_defender],{player disableUAVConnectability [(_this select 0),TRUE];}] remoteExec ['call',-2,_defender];
if (_nearAir isNotEqualTo []) then {
	{
		_airdefenseGroup reveal [_x,4];
	} count _nearAir;
};
[[_defender,_gunner],_duration,_cooldown];