/*/
File: fn_getVehicleStealth.sqf
Author:

	Quiksilver
	
Last Modified:

	25/08/2022 A3 2.10 by Quiksilver
	
Description:

	Is vehicle behaving in stealthy manner
	
Notes:
	
	- We do not consider Thermal state, since players need to travel long distances and we want gameplay to flow. 
	- Thermal state decays too slowly. We could spend time modeling increased thermal decay, but is it worth it?
	- We could return a number for "stealth factor", but again, is it worth it yet?
__________________________________________________/*/

params ['_vehicle'];
private _c = FALSE;
if (_vehicle isKindOf 'Man') exitWith {_c};
if (
	(
		(
			((_vehicle animationSourcePhase 'showcamonethull') isEqualTo 1) && 
			(((vectorMagnitude (velocity _vehicle)) * 3.6) < 30)
		) || 
		(!isEngineOn _vehicle)
	) &&
	{(((getPosATL _vehicle) getEnvSoundController 'shooting') > 0.9)} &&
	{((getAmmoCargo _vehicle) <= 0)} &&
	{(!isVehicleRadarOn _vehicle)} &&
	{(!isOnRoad _vehicle)} &&
	{(!((toLowerANSI (surfaceType (getPosWorld _vehicle))) in ['#gdtasphalt']))} &&
	{(
		(((getPosATL _vehicle) getEnvSoundController 'houses') isEqualTo 0) || 
		{(((getPosATL _vehicle) getEnvSoundController 'forest') isEqualTo 1)}
	)}
) then {
	_c = TRUE;
};
_c;