/*/
File: fn_AIAssaultSector.sqf
Author:

	Quiksilver
	
Last Modified:

	15/08/2017 A3 2017 by Quiksilver
	
Description:

	AI Assault of a sector (above and beyond mere attack & defend)
	
Flow:

	Scripted assault
		when near losing
		x select zone (road access, nearby buildings, etc)
		x get defended state (nil, minor, major)
		x number of enemies spawned to assault zone
		x a few artillery shells fired at the attacked zone when enemy gets in range
		x attack heli/gunship/CAS used to support attack
		x light vehicle attack
_____________________________________________________________________/*/