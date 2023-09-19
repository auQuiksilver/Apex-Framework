/*
File: fn_clientEventFiredNear.sqf
Author: 

	Quiksilver
	
Last modified:

	6/02/2015 A3 1.54 by Quiksilver
	
Description:

	Apply code to player when a weapon is fired near a player
	
unit: Object - Object the event handler is assigned to
firer: Object - Object which fires a weapon near the unit
distance: Number - Distance in meters between the unit and firer (max. distance ~69m)
weapon: String - Fired weapon
muzzle: String - Muzzle that was used
mode: String - Current mode of the fired weapon
ammo: String - Ammo used
___________________________________________________________________*/

//params ['_unit','_firer','_distance','_weapon','_muzzle','_mode','_ammo','_gunner'];