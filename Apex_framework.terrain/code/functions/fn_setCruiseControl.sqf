/*/
File: fn_setCruiseControl.sqf
Author:

	Quiksilver
	
Last Modified:

	16/11/2022 A3 2.10 by Quiksilver
	
Description:

	Set Cruise Control
_______________________________________/*/

params [['_entity',objNull]];
if (isNull _entity) then {
	_entity = cameraOn;
};
if (!alive _entity) exitWith {};
if (
	(_entity isKindOf 'LandVehicle') ||
	(_entity isKindOf 'Ship')
) then {
	_speed = round ((vectorMagnitude (velocity (objectParent player))) * 3.6);
	_entity setCruiseControl [_speed,TRUE];
	50 cutText [(format ['%2 %1 %3',round _speed,localize 'STR_QS_Text_241',localize 'STR_QS_Text_242']),'PLAIN DOWN',0.5];
};