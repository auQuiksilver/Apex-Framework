/*
File: fn_clientEventMarkerUpdated.sqf
Author:

	Quiksilver
	
Last modified:

	22/12/2022 A3 2.10
	
Description:
	
	Marker Updated event
	
Note:

	Be careful adding "setMarkerX" commands here, it will create infinite cycle
_______________________________________*/

params ['_marker','_local'];
if (_local) exitWith {};
if (
	(!_local) &&
	{((markerText _marker) isNotEqualTo '')} &&
	{(isLocalized (markerText _marker))}
) then {
	_marker setMarkerTextLocal (localize _markerText);
};
if (
	(!_local) &&
	{(_marker in ['QS_marker_fpsMarker','QS_marker_curators'])} &&
	{((markerAlpha _marker) < 0.5)}
) then {
	_marker setMarkerAlphaLocal 0.5;
};