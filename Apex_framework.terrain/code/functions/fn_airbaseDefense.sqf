/*/
File: fn_airbaseDefense.sqf
Author:

	Quiksilver
	
Last Modified:

	1/01/2023 A3 1.76 by Quiksilver

Description:

	Air Defense
	
	
___________________________________________________/*/

private ['_defensePos','_airdefenseGroup','_defender','_nearAir','_duration','_cooldown','_relPos','_defenderType','_gunner'];
_nearAir = _this # 0;
_duration = time + 300;	// online for x seconds
_cooldown = time + 900;	// unavailable for x seconds
_defensePos = markerPos ['QS_marker_airbaseDefense',TRUE];
[_defensePos,15,30,75] call (missionNamespace getVariable 'QS_fnc_clearPosition');
_defenderType = selectRandom (['base_aa_1'] call QS_data_listVehicles);	// This one is the best mix of effectiveness and spectacle.
_defender = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _defenderType,_defenderType],[-500,-500,50],[],0,'NONE'];
_defender allowDamage FALSE;
_defender allowCrewInImmobile [TRUE,TRUE];
_defender enableVehicleCargo FALSE;
_defender enableRopeAttach FALSE;
_worldName = worldName;
{ 
	_defender setObjectTextureGlobal [_forEachIndex,_x]; 
} forEach (getArray ((configOf _defender) >> 'TextureSources' >> (['Sand','Green'] select (_worldName in ['Tanoa','Enoch'])) >> 'textures'));
_defender setVehicleRadar 2;
if (unitIsUav _defender) then {
	_defender setVariable ['QS_uav_protected',TRUE,FALSE];
};
_defender setVariable ['QS_curator_disableEditability',TRUE,FALSE];
_defender setVariable ['QS_inventory_disabled',TRUE,TRUE];
_defender setVehicleReportRemoteTargets FALSE;
_defender setVehicleReceiveRemoteTargets FALSE;
if ((toLowerANSI _defenderType) in ['b_sam_system_01_f','b_sam_system_02_f','b_sam_system_03_f']) then {
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
	if (_worldName isEqualTo 'Stratis') then {_defender setDir 107;};
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
_gunner addRating (0 - (rating _gunner));
_gunner allowDamage FALSE;
[[_gunner],1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_gunner setSkill ['aimingAccuracy',0.075];
_airdefenseGroup setFormDir 135;
_relPos = markerPos 'QS_marker_aoMarker';
_gunner doWatch (_relPos vectorAdd [0,0,2000]);
_airdefenseGroup setBehaviour 'AWARE';
_airdefenseGroup setCombatMode 'RED';
[[_defender],{player disableUAVConnectability [(_this # 0),TRUE];}] remoteExec ['call',-2,_defender];
if (_nearAir isNotEqualTo []) then {
	{
		_airdefenseGroup reveal [_x,4];
	} count _nearAir;
};
[[_defender,_gunner],_duration,_cooldown];