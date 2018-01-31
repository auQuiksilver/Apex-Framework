/*/
File: fn_enemyDetected.sqf
Author:

	Quiksilver

Last Modified:

	29/11/2017 A3 1.78 by Quiksilver
	
Description:

	-
________________________________________________________/*/

params [['_unit',objNull],['_radius',300]];
private _detected = FALSE;
_targets = _unit targets [TRUE,_radius];
(!(_targets isEqualTo []));