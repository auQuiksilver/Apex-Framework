/*/
File: fn_clientMFindHealer.sqf
Author:

	Quiksilver
	
Last modified:

	9/12/2017 A3 1.80 by Quiksilver

Description:

	Allow injured to know if a valid medic is nearby, and how far away.
_________________________________________________________________________________________/*/

_px = player;
private _md = 500;
private _mg = format ['No medics within %1m',_md];
_ps = getPosATL _px;
_mc = ['Man'];
_vt = ['LandVehicle','Ship','Air'];
private _mn = _ps nearEntities [_mc,_md];
_vn = _ps nearEntities [_vt,_md];
private _mx = objNull;
{
	if ((crew _x) isNotEqualTo []) then {
		{
			if (alive _x) then {
				_mn pushBack _x;
			};
		} forEach (crew _x);
	};
} forEach _vn;
if (_mn isNotEqualTo []) then {
	{
		if (_x isNotEqualTo _px) then {
			if (!(captive _x)) then {
				if (((side (group _x)) getFriend (side (group player))) > 0.6) then {
					if (alive _x) then {
						if (isPlayer _x) then {
							if (((vehicle _x) distance _px) < _md) then {
								if (_x getUnitTrait 'medic') then {
									_mx = _x;
									_md = (vehicle _x) distance _px;
									_mg = format ['Nearest medic is %1 (%2m)',(name _mx),(round (_md))];
								};
							};
						};
					};
				};
			};
		};
	} count _mn;
};
_mg;