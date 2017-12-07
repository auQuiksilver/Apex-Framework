/*/
File: fn_signalStrength.sqf
Author: 

	Quiksilver

Last Modified:

	15/10/2017 A3 1.76 by Quiksilver

Description:

	Signal Strength
____________________________________________________________________________/*/

params ['_type','_position','_radius'];
private _val = 0.1;
private _text = '';
if (_type isEqualTo 0) then {
	if ((player distance _position) < _radius) then {
		_val = round ((1 - ((player distance _position) / _radius)) * 100);
	};
	if (underwater player) then {
		if ('ItemGPS' in (assignedItems player)) then {
			if (isNull (objectParent player)) then {
				_text = parseText (format ['<t size="1.5">Signal Strength</t><br/><br/> %1 percent',_val]);
				(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,5,-1,_text,[],-1];
			};
		} else {
			_text = parseText (format ['<t size="1.5">Signal Strength</t><br/><br/> No GPS Receiver ...',_val]);
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,FALSE,5,-1,_text,[],-1];
		};
	};
};
if (_type isEqualTo 1) then {
	if ((player distance _position) < _radius) then {
		_val = round ((1 - ((player distance _position) / _radius)) * 100);
	};
	if (isNull (objectParent player)) then {
		if ('ItemGPS' in (assignedItems player)) then {
			_text = parseText (format ['<t size="1.5">Signal Strength</t><br/><br/> %1 percent',_val]);
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,TRUE,5,-1,_text,[],-1];
		} else {
			_text = parseText (format ['<t size="1.5">Signal Strength</t><br/><br/> No GPS Receiver ...',_val]);
			(missionNamespace getVariable 'QS_managed_hints') pushBack [2,FALSE,5,-1,_text,[],-1];
		};
	};
};