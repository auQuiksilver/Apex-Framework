/*/
File: fn_geomGetOutlier.sqf
Author: 

	Quiksilver

Last Modified:

	16/02/2018 A3 1.80 by Quiksilver

Description:

	Get Outlier
____________________________________________________________________________/*/

_data = _this;
_dataCount = count _data;
_data = _data apply { if (_x isEqualType objNull) then {(getPosWorld _x)} else {_x}; };
_centroid = _data call (missionNamespace getVariable 'QS_fnc_geomPolygonCentroid');
_data2 = _data apply { (_x distance2D _centroid) };