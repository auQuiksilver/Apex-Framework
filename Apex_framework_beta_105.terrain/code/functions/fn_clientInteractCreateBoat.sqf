/*/
File: fn_clientInteractCreateBoat.sqf
Author:

	Quiksilver
	
Last modified:
	
	13/09/2017 A3 1.76 by Quiksilver
	
Description:

	Engineer creates a boat and consumes a toolkit
_______________________________________________________/*/

if (!isNull (objectParent player)) exitWith {};
if (!('ToolKit' in (items player))) exitWith {};
private _exit = FALSE;
if (!isNil {player getVariable 'QS_client_createdBoat'}) then {
	if (!isNull (player getVariable 'QS_client_createdBoat')) then {
		if (alive (player getVariable 'QS_client_createdBoat')) then {
			_exit = TRUE;
		};
	};
};
if (_exit) exitWith {
	50 cutText [(format ['You already have an active boat at grid %1, please respawn or destroy it before creating another.',(mapGridPosition (player getVariable 'QS_client_createdBoat'))]),'PLAIN DOWN'];
};
player removeItem 'ToolKit';
private _boatType = ['B_Lifeboat','B_T_Lifeboat'] select (worldName isEqualTo 'Tanoa');
if ((!underwater player) && (((eyePos player) select 2) > 0.25)) then {
	_boatType = ['B_Boat_Transport_01_F','B_T_Boat_Transport_01_F'] select (worldName isEqualTo 'Tanoa');
};
private _position = player modelToWorld [0,15,0];
_position set [2,1];
[37,profileName,[_boatType,_position,[],0,'NONE'],(getDir player),_position,clientOwner,player] remoteExec ['QS_fnc_remoteExec',2,FALSE];
50 cutText [(format ['%1 inflated, toolkit removed',(getText (configFile >> 'CfgVehicles' >> _boatType >> 'displayName'))]),'PLAIN DOWN',0.75];