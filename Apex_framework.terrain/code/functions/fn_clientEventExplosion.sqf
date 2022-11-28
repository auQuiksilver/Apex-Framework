/*
File: fn_clientEventExplosion.sqf
Author: 

	Quiksilver
	
Last modified:

	27/11/2022 A3 2.10 by Quiksilver
	
Description:

	Explosion Event
_______________________________________________*/


params ['_unit','_damage','_source'];
_this call (missionNamespace getVariable 'QS_fnc_feedbackDirtEffect');
private _strength = (0 max _damage) * 45;
if (
	(_strength < 0.05) ||
	(!((lifeState player) in ['HEALTHY','INJURED']))
) exitWith {
	_damage
};
if (
	(!(player getVariable ['QS_RD_earplugs',FALSE])) &&
	(diag_tickTime > (player getVariable ['QS_combatDeafness',0]))
) then {
	player setVariable ['QS_combatDeafness',(diag_tickTime + 60),FALSE];
	0 spawn {
		uiSleep (random [0.3,0.4,0.5]);
		playSoundUI ['combat_deafness',1,random [0.75,1,1.25],TRUE];
	};
};
_sourcePos = getPosASL _source;
_sourcePos = _sourcePos vectorAdd [0,0,0.3];
_visibilityHead = [_unit,'VIEW'] checkVisibility [_sourcePos,_unit modelToWorldWorld (_unit selectionPosition 'head')];
if (
	(isNull (objectParent _unit)) &&
	(isNull (attachedTo _unit)) &&
	(_visibilityHead > 0.1) &&
	(diag_tickTime > (_unit getVariable ['QS_feedback_lastExpSuppress',-1]))
) then {
	_goggles = ['g_combat','g_combat_goggles_tna_f','g_balaclava_combat'];
	_helmets = [];
	_isCombatGoggles = ['combat',toLowerANSI (goggles _unit),FALSE] call (missionNamespace getVariable 'QS_fnc_inString');
	_fadeOutConstant = [1,0.25] select _isCombatGoggles;
	_fadeOutConstant2 = [1,0.3] select _isCombatGoggles;
	_strength = ([2,1] select _isCombatGoggles) min _strength max ([0.5,0.25] select _isCombatGoggles);
	_unit setVariable ['QS_feedback_lastExpSuppress',diag_tickTime + 0,FALSE];
	BIS_suppressImpactBlur ppEffectEnable TRUE;
	BIS_suppressImpactBlur ppEffectForceInNVG TRUE;
	BIS_suppressImpactBlur ppEffectAdjust [(0.023 * _strength), (0.023 * _strength), (0.28 * _strength), (0.28 * _strength)];
	BIS_suppressImpactBlur ppEffectCommit 0;
	BIS_suppressCC ppEffectEnable TRUE;
	BIS_suppressCC ppEffectForceInNVG TRUE;
	BIS_suppressCC ppEffectAdjust [1, 1, 0, [0, 0, 0, (0.6 * _strength)], [1, 1, 1, 1], [1, 1 , 1, 0]];
	BIS_suppressCC ppEffectCommit 0;
	BIS_suppressImpactBlur ppEffectAdjust [0, 0, 0, 0];
	BIS_suppressImpactBlur ppEffectCommit (_fadeOutConstant2 + (0.5 * _strength));
	BIS_suppressCC ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [1, 1, 1, 0]];
	BIS_suppressCC ppEffectCommit (_fadeOutConstant + (0.4 * _strength));
};
if (missionNamespace getVariable ['QS_missionConfig_knockdown',TRUE]) then {
	_visibilityCOM = [_unit,'VIEW'] checkVisibility [_sourcePos,aimPos _unit];
	if (
		((random 1) > 0.5) &&
		{(isNull (objectParent _unit))} &&
		{(isNull (attachedTo _unit))} &&
		{(!surfaceIsWater (getPosASL _unit))} &&
		{(_strength > 0.5)} &&
		{(_visibilityCOM > 0.1)} &&
		{(diag_tickTime > (_unit getVariable ['QS_feedback_lastExpRagdoll',-1]))} &&
		{(isNull (missionNamespace getVariable ['QS_script_incapacitated',scriptNull]))} &&
		{(((stance _unit) in ['STAND']) || (((vectorMagnitude (velocity _unit)) * 3.6) > 12))}
	) then {
		_dir = (_sourcePos vectorFromTo (getPosASL _unit)) vectorMultiply _damage;
		_dir set [2,(_dir # 2) max 0.5];
		_unit setVariable ['QS_feedback_lastExpRagdoll',diag_tickTime + (random [45,60,90]),FALSE];
		_script = [
			_unit,
			[
				_dir,
				getCenterOfMass _unit
			]
		] spawn (missionNamespace getVariable 'QS_fnc_ragdoll');
	};
};
_damage;