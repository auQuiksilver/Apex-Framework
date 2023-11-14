/*/
File: fn_clientInteractUnflipVehicle.sqf
Author:

	Quiksilver

Last modified:

	14/11/2023 A3 2.14 by Quiksilver
	
Description:

	Unflip Vehicle
___________________________________________________/*/

getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
if ((getObjectType _cursorObject) isNotEqualTo 8) exitWith {systemchat 'invalid object';};
private _canUnflip = TRUE;
_nearUnits = (getPosATL _cursorObject) nearEntities [['CAManBase'],10];
_v = vehicle QS_player;
if ((!(unitIsUav _cursorObject)) && (!(((crew _cursorObject) findIf {(alive _x)}) isEqualTo -1))) exitWith {
	50 cutText [localize 'STR_QS_Text_160','PLAIN DOWN',0.5];
};
if (
	(!alive _cursorObject) ||
	{(!isNull (attachedTo _cursorObject))} ||
	{(!isNull (ropeAttachedTo _cursorObject))} ||
	{(!isNull (isVehicleCargo _cursorObject))}
) exitWith {
	50 cutText [localize 'STR_QS_Text_467','PLAIN DOWN',0.3];
};
if (
	((getMass _cursorObject) >= 15000) &&
	(((count _nearUnits) < 2) && {(!((toLowerANSI (typeOf _v)) in (['crv'] call QS_data_listVehicles)))})
) exitWith {
	50 cutText [localize 'STR_QS_Text_161','PLAIN DOWN',1];
};
50 cutText [localize 'STR_QS_Text_162','PLAIN DOWN',0.3];
_isDamageAllowed = isDamageAllowed QS_player;
if (_isDamageAllowed) then {
	QS_player allowDamage FALSE;
};
if ((['LandVehicle','StaticWeapon','Reammobox_F','Ship','Cargo_base_F'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1) then {
	[87,_cursorObject] remoteExec ['QS_fnc_remoteExec',_cursorObject,FALSE];
	if (isNull (objectParent QS_player)) then {
		QS_player playAction 'PutDown';
		uiSleep 1;
		QS_player setDir (QS_player getDir _cursorObject);		// Not sure about this
	};
};
QS_player allowDamage _isDamageAllowed;