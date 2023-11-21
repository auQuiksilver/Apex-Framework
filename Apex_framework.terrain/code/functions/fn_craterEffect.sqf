/*/
File: fn_craterEffect.sqf
Author:

	Quiksilver
	
Last modified:

	7/07/2022 A3 2.10 by Quiksilver
	
Description:

	Artillery craters
_____________________________________________________/*/

if ((missionNamespace getVariable ['QS_missionConfig_craterEffects',0]) isEqualTo 0) exitWith {};
if (!isDedicated) exitWith {
	[100,_this] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if ((count QS_entities_craterEffects) >= (missionNamespace getVariable ['QS_missionConfig_craterEffects',0])) exitWith {};
params ['','_position','_velocity',['_type',0]];
_posATL = ASLToATL _position;
if ((_posATL # 2) > 0.1) then {
	_position set [2,(_position # 2) - (_posATL # 2)];
};
// validate position, filter etc
if (
	([_position,10,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')) ||
	{((nearestObjects [_position,['house'],10,TRUE]) isNotEqualTo [])}
) exitWith {};
if (canSuspend) then {sleep (random 0.5);};
private _isMortar = _type isEqualTo 0;
private _list = [];
private _craterTypes = [['Land_ShellCrater_02_large_F','Land_ShellCrater_02_extralarge_F'],['Land_ShellCrater_01_F','Land_ShellCrater_02_small_F']] select _isMortar;
private _craterDebris = [['Land_ShellCrater_02_debris_F'],['Land_ShellCrater_02_debris_F']] select _isMortar;
private _craterDecals = [['Land_ShellCrater_02_decal_F'],['Land_ShellCrater_01_decal_F']] select _isMortar;
private _vOffset = [0 - random 1,0] select _isMortar;
_surfaceNormal = surfaceNormal _position;
private _obj = createSimpleObject [selectRandom _craterTypes,_position vectorAdd [0,0,_vOffset]];
_obj setDir (random 360);
_obj setVectorUp _surfaceNormal;
_list pushBack _obj;
_obj = createSimpleObject [selectRandom _craterDebris,_position];
_obj setDir (random 360);
_obj setVectorUp _surfaceNormal;
_list pushBack _obj;
private _startDir = 0;
private _offsets = [
	[
		[[-2,-2,0],270],
		[[-2,2,0],0],
		[[2,2,0],90],
		[[2,-2,0],180]
	],
	[
		[[-1.5,-1.5,0],270],
		[[-1.5,1.5,0],0],
		[[1.5,1.5,0],90],
		[[1.5,-1.5,0],180]
	]
] select _isMortar;
for '_i' from 0 to 3 step 1 do {
	_obj = createSimpleObject [selectRandom _craterDecals,(_position vectorAdd ((_offsets # _i) # 0))];
	_obj setDir ((_offsets # _i) # 1);
	_obj setVectorUp _surfaceNormal;
	_list pushBack _obj;
};
if (canSuspend) then {sleep 0.25;};
_oldCrater = nearestObject [_position,'#crater'];
if (!isNull _oldCrater) then {
	_oldCrater setPos [-500,-500,0];
	[122,_position] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
};
QS_entities_craterEffects pushBack [0,_list];
_list;