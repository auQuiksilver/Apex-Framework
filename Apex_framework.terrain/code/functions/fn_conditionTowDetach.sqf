/*
File: fn_conditionTowDetach.sqf
Author: 

	Quiksilver
	
Last modified:

	30/12/2022 A3 2.10 by Quiksilver
	
Description:

	Condition for add-Action
____________________________________________*/

_v = _this # 0;
(
	(_v isKindOf 'LandVehicle') &&
	{((_v getVariable ['QS_tow_veh',-1]) > 0)} &&
	{((  (attachedObjects _v) findIf { _x getVariable ['QS_attached',FALSE] }) isNotEqualTo -1)} &&
	{(((vectorMagnitude (velocity _v)) * 3.6) < 1)}
)