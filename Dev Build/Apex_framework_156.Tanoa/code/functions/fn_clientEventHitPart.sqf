/*
File: fn_clientEventHitPart.sqf
Author: 

	Quiksilver
	
Last modified:

	27/02/2023 A3 2.12 by Quiksilver
	
Description:

	Hit Part event
	
target: Object - Object that got injured/damaged.
shooter: Object - Unit that inflicted the damage. If injured by a vehicle impact or a fall the target itself is returned, or, in case of explosions, the null object. In case of explosives that were planted by someone (e.g. satchel charges), that unit is returned.
bullet: Object - Object that was fired.
position: Position3D - Position the bullet impacted (ASL).
velocity: Vector3D - 3D speed at which bullet impacted.
selection: Array - Array of Strings with named selection of the object that were hit.
ammo: Array - Ammo info: [hit value, indirect hit value, indirect hit range, explosive damage, ammo class name] OR, if there is no shot object: [impulse value on object collided with,0,0,0]
direction: Vector3D - vector that is orthogonal (perpendicular) to the surface struck. For example, if a wall was hit, vector would be pointing out of the wall at a 90 degree angle.
radius: Number - Radius (size) of component hit.
surface: String - Surface type struck.
direct: Boolean - true if object was directly hit, false if it was hit by indirect/splash damage.
___________________________________________________________________*/

//params ['_target','_shooter','_bullet','_position','_velocity','_selection','_ammo','_direction','_radius','_surface','_direct'];

//systemchat str _this;