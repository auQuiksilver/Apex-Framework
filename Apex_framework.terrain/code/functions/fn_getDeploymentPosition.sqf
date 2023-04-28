/*/
File: fn_getDeploymentPosition.sqf
Author:

	Quiksilver
	
Last Modified:
	
	24/03/2023 A3 2.12 by Quiksilver
	
Description:

	Deployment Positions
____________________________________________________/*/

params ['_deploymentType','_deploymentLocationData'];
if (_deploymentType isEqualTo 'MARKER') exitWith {
	(markerPos [_deploymentLocationData,TRUE])
};
if (_deploymentType isEqualTo 'POS') exitWith {
	_deploymentLocationData
};
if (_deploymentType isEqualTo 'VEHICLE') exitWith {
	(getPosASL _deploymentLocationData)
};
if (_deploymentType isEqualTo 'UNIT') exitWith {
	(getPosASL _deploymentLocationData)
};
[0,0,0]