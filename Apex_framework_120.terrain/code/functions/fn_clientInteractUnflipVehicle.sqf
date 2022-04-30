/*/
File: fn_clientInteractUnflipVehicle.sqf
Author:

	Quiksilver

Last modified:

	19/01/2018 A3 1.80 by Quiksilver
	
Description:

	Unflip Vehicle
___________________________________________________/*/

private _canUnflip = TRUE;
_t = cursorTarget;
_engies = (getPosATL _t) nearEntities [['Man'],10];
_v = vehicle player;
if ((!(unitIsUav _t)) && (!(((crew _t) findIf {(alive _x)}) isEqualTo -1))) exitWith {
	50 cutText ['Crew in vehicle, unflip failed!','PLAIN DOWN',0.5];
};
if (((count _engies) < 2) && {(!((toLower (typeOf _v)) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']))}) then {
	if ((getMass _t) >= 10000) then {
		_canUnflip = FALSE;
		50 cutText ['Need another person nearby to unflip this vehicle, or use a(n) CRV-6e Bobcat APC','PLAIN DOWN',1];
	};
};
if (!alive _t) exitWith {};
if (!(_canUnflip)) exitWith {};
50 cutText ['Unflipping','PLAIN DOWN',0.3];
player allowDamage FALSE;
if ((_t isKindOf 'LandVehicle') || {(_t isKindOf 'Reammobox_F')} || {(_t isKindOf 'StaticWeapon')}) then {
	if (isNull (objectParent player)) then {
		player playAction 'PutDown';
		uiSleep 1;
	};
	[87,_t] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
	uiSleep 1;
};
player allowDamage TRUE;