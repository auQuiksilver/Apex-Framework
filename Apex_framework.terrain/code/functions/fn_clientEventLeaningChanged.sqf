/*/
File: fn_clientEventLeaningChanged.sqf
Author:
	
	Quiksilver
	
Last Modified:

	26/12/2023 A3 2.10 by Quiksilver
	
Description:

	Triggered when a soldier leaning factor is changed between -1 (extreme left), 0 (not leaning) and 1 (extreme right)
	
Notes:
	
	unit: Object - soldier
	newLeaning: Number from -1 to 1
	oldLeaning: Number from -1 to 1
______________________________________________________/*/

params ['_unit','_newLeaning','_oldLeaning'];