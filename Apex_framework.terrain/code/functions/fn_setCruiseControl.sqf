/*/
File: fn_setCruiseControl.sqf
Author:

	Quiksilver
	
Last Modified:

	27/03/2022 A3 2.08 by Quiksilver
	
Description:

	Set Cruise Control
	
Note:

	See if we can change it to "cameraOn"
_______________________________________/*/

if (isNull (objectParent player)) exitWith {};
private _speed = round ((vectorMagnitude (velocity (objectParent player))) * 3.6);
(objectParent player) setCruiseControl [_speed,TRUE];
50 cutText [(format ['%2 %1 %3',round _speed,localize 'STR_QS_Text_241',localize 'STR_QS_Text_242']),'PLAIN DOWN',0.5];