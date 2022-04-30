/*--------------------------------------------------------------------------------------------------

	Author: Nelson Duarte?

	Return if vehicle is armed or not.

	Example:
	_isArmed:bool = _vehicle:object call bis_fnc_moduleSpawnAISectorTactic_isVehicleArmed;

--------------------------------------------------------------------------------------------------*/
(!(_this call bis_fnc_moduleSpawnAISectorTactic_getVehicleWeapons isEqualTo []))