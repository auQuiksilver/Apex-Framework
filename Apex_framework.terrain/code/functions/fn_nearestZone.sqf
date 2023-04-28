/*/
File: fn_nearestZone.sqf
Author:

	Quiksilver
	
Last Modified:

	26/04/2023 A3 2.12 by Quiksilver
	
Description:

	Nearest zone
______________________________________________/*/

params [
	['_origin',[0,0,0]],
	['_zt',''],
	['_lvl',-1]
];
private _dist = 999999;
private _nearest = '';
{
	_x params ['_id','_zoneActive','_zoneType','_type','_level','_areaParams','','','','',''];
	if (
		_zoneActive &&
		{(_type isEqualTo 'RAD')} &&
		{(
			(
				(_zt isEqualType '') && 
				{
					(_zoneType isEqualTo _zt) ||
					(_zt isEqualTo '')
				}
			) ||
			((_zt isEqualType []) && {(_zoneType in _zt)})
		)}
	) then {
		if ((_areaParams # 0) isEqualType '') then {
			if ((_origin distance (markerPos (_areaParams # 0))) < _dist) then {
				if (_lvl in [-1,_level]) then {
					_dist = _origin distance (markerPos (_areaParams # 0));
					_nearest = _id;
				};
			};
		};
		if ((_areaParams # 0) isEqualTypeAny [objNull,[]]) then {
			if ((_origin distance (_areaParams # 0)) < _dist) then {
				if (_lvl in [-1,_level]) then {
					_dist = _origin distance (_areaParams # 0);
					_nearest = _id;
				};
			};
		};
	};
} forEach (QS_system_zones + QS_system_zonesLocal);
[_nearest,_dist]