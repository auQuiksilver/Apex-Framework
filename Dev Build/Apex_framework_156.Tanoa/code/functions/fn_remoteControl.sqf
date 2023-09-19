/*/
File: fn_remoteControl.sqf
Author:

	Quiksilver
	
Last Modified:

	19/03/2023 A3 2.12 by Quiksilver
	
Description:

	Basic Remote Control
___________________________________________/*/

params ['_unit',['_requireLocal',TRUE],['_conditional',FALSE]];
if (
	(!canSuspend) ||
	{(!alive _unit)} ||
	{(isPlayer _unit)} ||
	{(_requireLocal && (!local _unit))} ||
	{(_conditional && (!(_unit getVariable ['QS_unit_remoteControllable',FALSE])))} ||
	{!((side (group _unit)) in [east,west,resistance,civilian])} ||
	{!isNull (remoteControlled _unit)} ||
	{isRemoteControlling player} ||
	{(!(_unit checkAIFeature 'TEAMSWITCH'))}
) exitWith {
	systemChat (localize 'STR_QS_Chat_169');
};
player setVariable ['QS_client_remoteControlling',TRUE,TRUE];
missionNamespace setVariable ['bis_fnc_moduleRemoteControl_unit',_unit,FALSE];
_unit setVariable ['bis_fnc_moduleRemoteControl_owner',player,TRUE];
_initialView = cameraView;
player remotecontrol _unit;
private _vehicle = vehicle _unit;
if (cameraon isNotEqualTo _vehicle) then {
	_vehicle switchcamera _initialView;
};
_color = ppeffectcreate ['colorCorrections',1896];
_color ppeffectenable true;
_color ppeffectadjust [1,1,0,[0,0,0,1],[1,1,1,1],[0,0,0,0],[0.9,0.0,0,0,0,0.5,1]];
_color ppeffectcommit 0;
sleep 0.3;
_color ppeffectadjust [1,1,0,[0,0,0,1],[1,1,1,1],[0,0,0,0],[0.9,0.85,0,0,0,0.5,1]];
_color ppeffectcommit 0.3;
private _vehicleRole = str (assignedvehiclerole _unit);
_rating = rating player;
waitUntil {
	if (
		(
			((vehicle _unit) isNotEqualTo _vehicle) || 
			{((str (assignedvehiclerole _unit)) != _vehicleRole)}
		) && 
		{alive _unit}
	) then {
		player remotecontrol _unit;
		_vehicle = vehicle _unit;
		_vehicleRole = str assignedvehiclerole _unit;
	};
	if ((rating player) < _rating) then {
		player addrating (0 - (rating player));
	};
	uiSleep (diag_deltaTime * 3);
	(
		!isnull curatorcamera ||
		{cameraon isEqualTo (vehicle player)} ||
		{!alive _unit} ||
		{(!((lifeState player) in ['HEALTHY','INJURED']))}
	)
};
player addrating (0 - (rating player));
objnull remotecontrol _unit;
_unit setvariable ['bis_fnc_moduleRemoteControl_owner',nil,TRUE];
ppeffectdestroy _color;
player switchcamera _initialView;
bis_fnc_moduleRemoteControl_unit = nil;
player setVariable ['QS_client_remoteControlling',FALSE,TRUE];