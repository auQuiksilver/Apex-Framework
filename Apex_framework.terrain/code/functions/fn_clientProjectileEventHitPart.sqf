/*/
File: fn_clientProjectileEventHitPart.sqf
Author:

	Quiksilver
	
Last Modified:

	28/06/2023 A3 2.12 by Quiksilver
	
Description:

	Player projectile hitpart event
_______________________________________________/*/

params ['_projectile','_hitEntity','','','','','','',''];
if (
	(alive _hitEntity) &&
	{(simulationEnabled _hitEntity)} &&
	{((player distance _hitEntity) <= viewDistance)} &&
	{((player distance _hitEntity) <= (getObjectViewDistance # 0))}
) then {
	if (_hitEntity isKindOf 'CAManBase') then {
		if (((side (group _hitEntity)) in [player getVariable ['QS_unit_side',WEST],CIVILIAN]) || ((side _hitEntity) in [CIVILIAN])) then {
			50 cutText [localize 'STR_QS_Text_185','PLAIN',0.25,TRUE,TRUE];
		} else {
			if ((side (group _hitEntity)) in ((player getVariable ['QS_unit_side',WEST]) call (missionNamespace getVariable 'QS_fnc_enemySides'))) then {
				_projectile removeEventHandler [_thisEvent,_thisEventHandler];
				if (
					((missionNamespace getVariable ['QS_missionConfig_hitMarker',1]) isNotEqualTo 0) && (missionNamespace getVariable ['QS_HUD_toggleHitMarker',FALSE])
				) then {
					if (isDamageAllowed _hitEntity) then {
						playSoundUI ['hit_marker_2',0.3,1];
					};
				};
				if (_projectile getVariable ['QS_projectile_accuracy',FALSE]) then {
					if (_projectile getVariable ['QS_projectile_sniper',FALSE]) then {
						player setVariable ['QS_client_hits_sniper',(player getVariable 'QS_client_hits_sniper') + 1,FALSE];
					} else {
						player setVariable ['QS_client_hits',(player getVariable 'QS_client_hits') + 1,FALSE];
					};
				};
			};
		};
	} else {
		if (alive (effectiveCommander _hitEntity)) then {
			if (_hitEntity in vehicles) then {
				if ((side (group (effectiveCommander _hitEntity))) in [player getVariable ['QS_unit_side',WEST],CIVILIAN]) then {
					50 cutText [localize 'STR_QS_Text_185','PLAIN',0.25,TRUE,TRUE];
				} else {
					if ((side (group (effectiveCommander _hitEntity))) in ((player getVariable ['QS_unit_side',WEST]) call (missionNamespace getVariable 'QS_fnc_enemySides'))) then {
						_projectile removeEventHandler [_thisEvent,_thisEventHandler];
						if (
							((missionNamespace getVariable ['QS_missionConfig_hitMarker',1]) isNotEqualTo 0) && (missionNamespace getVariable ['QS_HUD_toggleHitMarker',FALSE])
						) then {
							if (isDamageAllowed _hitEntity) then {
								playSoundUI ['hit_marker_2',0.3,1];
							};
						};
					};
				};
			};
		};
	};
};