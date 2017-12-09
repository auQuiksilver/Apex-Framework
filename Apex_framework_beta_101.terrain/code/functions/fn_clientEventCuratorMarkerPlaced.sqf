/*
File: fn_clientEventCuratorMarkerPlaced.sqf
Author:

	Quiksilver
	
Last Modified:

	20/01/2017 A3 1.66 by Quiksilver
	
Description:

	Curator Marker Placed
__________________________________________________*/

params ['_module','_marker'];
[67,_marker,_module] remoteExec ['QS_fnc_remoteExec',2,FALSE];
_module setVariable [
	'QS_curator_markers',
	((_module getVariable 'QS_curator_markers') + [_marker]),
	TRUE
];