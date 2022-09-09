/*/
File: fn_clientInteractLoadCargo.sqf
Author:

	Quiksilver
	
Last Modified:

	25/10/2017 A3 1.76 by Quiksilver
	
Description:

	Load Vehicle Transport Cargo
_____________________________________________________________/*/

(_this # 3) params ['_child','_parent'];
if (
	(!alive _parent) ||
	{(!alive _child)}
) exitWith {
	50 cutText [localize 'STR_QS_Text_116','PLAIN DOWN',0.5];
};
private _text = '';
if (_parent setVehicleCargo _child) then {
	_text = format ['%1 %3 %2',(_child getVariable ['QS_ST_customDN',(getText (configFile >> 'CfgVehicles' >> (typeOf _child) >> 'displayName'))]),(getText (configFile >> 'CfgVehicles' >> (typeOf _parent) >> 'displayName')),localize 'STR_QS_Text_114'];
} else {
	_text = localize 'STR_QS_Text_116';
};
50 cutText [_text,'PLAIN DOWN',0.5];