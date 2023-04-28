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
	50 cutText [localize 'STR_QS_Text_160','PLAIN DOWN',0.5];
};
if (((count _engies) < 2) && {(!((toLowerANSI (typeOf _v)) in (['crv'] call QS_data_listVehicles)))}) then {
	if ((getMass _t) >= 10000) then {
		_canUnflip = FALSE;
		50 cutText [localize 'STR_QS_Text_161','PLAIN DOWN',1];
	};
};
if (
	(!alive _t) ||
	{(!_canUnflip)} ||
	{(!isNull (attachedTo _t))} ||
	{(!isNull (ropeAttachedTo _t))} ||
	{(!isNull (isVehicleCargo _t))}
) exitWith {
	50 cutText ['Unflip Failed','PLAIN DOWN',0.3];
};
50 cutText [localize 'STR_QS_Text_162','PLAIN DOWN',0.3];
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