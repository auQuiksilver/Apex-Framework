/*/
File: fn_AIAssaultSector.sqf
Author:

	Quiksilver
	
Last Modified:

	27/03/2022 A3 2.08 by Quiksilver
	
Description:

	Set Cruise Control
	
Note:

	See if we can change it to "cameraOn"
_____________________________________________________________________/*/

if (isNull (objectParent player)) exitWith {};
private _speed = round ((vectorMagnitude (velocity (objectParent player))) * 3.6);
(objectParent player) setCruiseControl [_speed,TRUE];
50 cutText [(format ['Cruise control - %1 km/h',round _speed]),'PLAIN DOWN',0.5];