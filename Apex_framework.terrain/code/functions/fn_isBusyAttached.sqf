/*/
File: fn_isBusyAttached.sqf
Author:

	Quiksilver
	
Last Modified:

	30/10/2023 A3 2.14 by Quiksilver
	
Description:

	Is Player Busy (Something attached to them)
_______________________________________________/*/

params ['_unit'];
(((attachedObjects _unit) findIf {
	(!isNull _x) &&
	{
		(!(
			(_x isKindOf 'Sign_Sphere10cm_F') ||
			(_x isKindOf 'Logic') ||
			((toLowerANSI (typeOf _x)) in ['#lightpoint'])
		))
	}
}) isNotEqualTo -1)