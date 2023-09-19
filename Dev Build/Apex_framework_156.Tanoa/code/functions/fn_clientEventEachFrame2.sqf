/*/
File: fn_clientEventEachFrame2.sqf
Author: 

	Quiksilver
	
Last modified:

	21/04/2023 A3 2.12 by Quiksilver
	
Description:

	Each Frame
______________________________________________/*/

_unit = objNull;
_player = QS_player;
_units = ((units (_player getVariable ['QS_unit_side',WEST])) inAreaArray [positionCameraToWorld [0,0,0],localNamespace getVariable ['QS_laser_maxVD',300],localNamespace getVariable ['QS_laser_maxVD',300],0,FALSE,-1]) apply { [_x distance _player,_x] };
_units sort TRUE;
if ((count _units) > (localNamespace getVariable ['QS_laser_maxRays',24])) then {
	_units = _units select [0,(localNamespace getVariable ['QS_laser_maxRays',24])];
};
{
	_unit = _x # 1;
	if (
		(
			(isNull (objectParent _unit)) ||
			(isTurnedOut _unit)
		) &&
		{(!weaponLowered _unit)} &&
		{((lifeState _unit) in ['HEALTHY','INJURED'])} &&
		{(_unit getVariable ['QS_toggle_visibleLaser',FALSE])} &&
		{(!((toLowerANSI (pose _unit)) in ['swimming','surfaceswimming']))}
	) then {
		if ((_unit getVariable ['QS_unit_currentWeapon2','']) isNotEqualTo (toLowerANSI (currentWeapon _unit))) then {
			[_unit,toLowerANSI (currentWeapon _unit)] call QS_fnc_updateLaserInfo;
		} else {
			// Drop the below line in to enable laser only on ADS aim down sight.
			// 				(_unit getVariable ['QS_unit_isADS',FALSE])
			// Also need to enable the line in "fn_clientEventOpticsSwitch.sqf"
			if ((_unit getVariable ['QS_unit_weaponProxy','']) isNotEqualTo '') then {
				(_unit call QS_fnc_updateLaserPos) params ['_laserStart','_weaponDirection'];
				(_unit getVariable ['QS_unit_laserBeamParams',[[1000,0,0],[1000,0,0],0.25,0.25,150,FALSE,FALSE,[500,0,0]]]) params ['_beamColor','_dotColor','_dotSize','_beamDiameter','_beamMaxDist','_isIR','_highPower','_dotColorLP'];
				drawLaser [
					_laserStart,
					_weaponDirection, 
					[[0,0,0],_beamColor] select _highPower, 
					[_dotColorLP,_dotColor] select _highPower,
					_dotSize, 
					_beamDiameter, 
					[_beamMaxDist / 2,_beamMaxDist] select _highPower, 
					((currentVisionMode _unit) isNotEqualTo 0)
				];
			};
		};
	};
} forEach _units;