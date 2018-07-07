/*/
File: fn_dynSim.sqf
Author: 

	Quiksilver

Last Modified:

	20/03/2017 A3 1.68 by Quiksilver

Description:

	Initialize Dynamic Simulation (Server)
____________________________________________________________________________/*/

params ['_type'];
if (_type isEqualTo 0) then {
	enableDynamicSimulationSystem FALSE;
};
if (_type isEqualTo 1) then {
	//comment 'Disable while we configure';
	enableDynamicSimulationSystem FALSE;
	'GROUP' setDynamicSimulationDistance 500;
	'VEHICLE' setDynamicSimulationDistance 350;
	'EMPTYVEHICLE' setDynamicSimulationDistance 250;
	'PROP' setDynamicSimulationDistance 250;
	'ISMOVING' setDynamicSimulationDistanceCoef 2;
	//comment 'Enable after configure';
	enableDynamicSimulationSystem TRUE;
};