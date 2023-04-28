/*/
File: fn_AIXExplosion.sqf
Author:

	Quiksilver
	
Last modified:

	30/11/2022 A3 2.10 by Quiksilver
	
Description:

	AI ragdolled by nearby explosion
________________________________________/*/

params ['_unit','_damage','_source'];
private _strength = (0 max _damage) * 45;
if (
	(_strength < 0.05) ||
	(!((lifeState _unit) in ['HEALTHY','INJURED']))
) exitWith {
	_damage
};
if (isNull _source) exitWith {};
_unit removeEventHandler [_thisEvent,_thisEventHandler];
_sourcePos = (getPosASL _source) vectorAdd [0,0,0.3];
if (missionNamespace getVariable ['QS_missionConfig_knockdown',TRUE]) then {
	if (
		((random 1) > 0.666) &&
		{(_strength > 0.5)} &&
		{(isNull (objectParent _unit))} &&
		{(isNull (attachedTo _unit))} &&
		{(!surfaceIsWater (getPosASL _unit))} &&
		{(diag_tickTime > (_unit getVariable ['QS_feedback_lastExpRagdoll',-1]))} &&
		{(isNull (missionNamespace getVariable ['QS_script_incapacitated',scriptNull]))} &&
		{(((stance _unit) in ['STAND']) || (((vectorMagnitude (velocity _unit)) * 3.6) > 12))}
	) then {
		_dir = (_sourcePos vectorFromTo (getPosASL _unit)) vectorMultiply _damage;
		_dir set [2,(_dir # 2) max 0.5];
		_unit setVariable ['QS_feedback_lastExpRagdoll',diag_tickTime + (random [45,60,90]),QS_system_AI_owners];
		_script = [
			_unit,
			[
				_dir,
				[random [-2,0,2],random [-2,0,2],random [-2,0,2]]
			]
		] spawn (missionNamespace getVariable 'QS_fnc_ragdoll');
	};
};
_damage;