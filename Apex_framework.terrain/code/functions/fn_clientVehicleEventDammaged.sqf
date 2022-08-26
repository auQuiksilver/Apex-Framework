/*/
File: fn_clientVehicleEventDammaged.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/11/2018 A3 1.84 by Quiksilver

Description:

	Client Vehicle Dammaged Event
_______________________________________________/*/
if (!(local (_this # 0))) exitWith {};
params ['_vehicle','_selection','_damage','_hitIndex','_hitPoint','_shooter','_projectile'];