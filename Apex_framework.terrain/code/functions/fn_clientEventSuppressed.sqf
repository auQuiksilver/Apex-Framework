/*
File: fn_clientEventSuppressed.sqf
Author: 

	Quiksilver (based on work by LAxemann in https://steamcommunity.com/sharedfiles/filedetails/?id=825174634 )
	
Last modified:

	27/11/2022 A3 2.10 by Quiksilver
	
Description:

	Suppressed Event
___________________________________________________________________*/

params ['_unit','_distance','','_instigator','','','_ammoConfig'];
_screenPos = worldToScreen (ASLToAGL (getPosASL _instigator));
if (
	(isNull _instigator) ||
	{(!((_screenPos isEqualTo []) || {(((_screenPos # 0) > 1.5) || ((_screenPos # 0) < -0.5))} ||{(((_screenPos # 1) > 1.5) || ((_screenPos # 1) < -0.5))}))} ||
	{(!((lifeState _unit) in ['HEALTHY','INJURED']))} ||
	{((!isNull (objectParent _unit)) && (!isTurnedOut _unit))} ||
	{!isNull curatorCamera} ||
	{(isRemoteControlling _unit)} ||
	{(!(missionNamespace getVariable ['QS_HUD_toggleSuppression',TRUE]))}
) exitWith {};
private _ammoData = QS_client_hashmap_ammoConfig getOrDefault [_ammoConfig,[]];
if (_ammoData isEqualTo []) then {
	_ammoData = [getNumber (_ammoConfig >> 'suppressionRadiusBulletClose'),getNumber (_ammoConfig >> 'caliber')];
	QS_client_hashmap_ammoConfig set [
		_ammoConfig,
		_ammoData
	];
};
if (_distance > (_ammoData # 0)) exitWith {};
private _factor = ((1 /_distance) * (_ammoData # 1)) min 1;
_factor = (_factor / 2) + (random (_factor / 2));
_timeDiff = 1 - ((30 min ( (missionNamespace getVariable ['QS_suppressed_effectFired',0]) - diag_tickTime) max 0) / 30);
_factor = (_factor * _timeDiff) max 0.05;
BIS_suppressImpactBlur ppEffectEnable TRUE;
BIS_suppressImpactBlur ppEffectForceInNVG TRUE;
BIS_suppressImpactBlur ppEffectAdjust [(0.023 * _factor), (0.023 * _factor), (0.28 * _factor), (0.28 * _factor)];
BIS_suppressImpactBlur ppEffectCommit 0;
BIS_suppressCC ppEffectEnable TRUE;
BIS_suppressCC ppEffectForceInNVG TRUE;
BIS_suppressCC ppEffectAdjust [1, 1, 0, [0, 0, 0, (0.6 * _factor)], [1, 1, 1, 1], [1, 1 , 1, 0]];
BIS_suppressCC ppEffectCommit 0;
BIS_suppressImpactBlur ppEffectAdjust [0, 0, 0, 0];
BIS_suppressImpactBlur ppEffectCommit (0.3 + (0.5 * _factor));
BIS_suppressCC ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [1, 1, 1, 0]];
BIS_suppressCC ppEffectCommit (0.25 + (0.4 * _factor));
if ((diag_tickTime - BIS_suppressLastShotTime) >= 60) then {
	addCamShake [3, 0.4, 80];
};
BIS_suppressLastShotTime = diag_tickTime;