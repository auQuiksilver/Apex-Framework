/*/
File: fn_isBusyAttached.sqf
Author:

	Quiksilver
	
Last Modified:

	20/01/2023 A3 2.10 by Quiksilver
	
Description:

	Is Player Busy (Something attached to them)
_______________________________________________/*/

params ['_unit'];
(((attachedObjects _unit) findIf {
	(!isNull _x) &&
	{
		(!(
			(_x isKindOf 'Sign_Sphere10cm_F') ||
			(_x isKindOf 'Logic')
		))
	}
}) isNotEqualTo -1)