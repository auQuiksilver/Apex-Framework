/*/
File: fn_enemyDetected.sqf
Author:

	Quiksilver

Last Modified:

	17/02/2018 A3 1.80 by Quiksilver
	
Description:

	-
________________________________________________________/*/

params [['_unit',objNull],['_radius',300]];
((_unit targets [TRUE,_radius]) isNotEqualTo []);