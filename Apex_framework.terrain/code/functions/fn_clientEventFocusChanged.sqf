/*/
File: fn_clientEventFocusChanged.sqf
Author:
	
	Quiksilver
	
Last Modified:

	27/01/2024 A3 2.16 by Quiksilver
	
Description:

	-
______________________________________________________/*/

params ['_oldFocus','_newFocus'];
localNamespace setVariable ['QS_focusOn',_newFocus];