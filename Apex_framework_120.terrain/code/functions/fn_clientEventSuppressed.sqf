/*
File: fn_clientEventSuppressed.sqf
Author: 

	Quiksilver
	
Last modified:

	16/04/2022 A3 2.08 by Quiksilver
	
Description:

	Suppressed Event
	
	Triggers when enemy projectile is passing by closer than defined suppression radius ammo value in config.
___________________________________________________________________*/

params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];