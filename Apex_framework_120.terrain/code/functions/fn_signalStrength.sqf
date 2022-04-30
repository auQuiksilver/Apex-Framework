/*/
File: fn_signalStrength.sqf
Author: 

	Quiksilver

Last Modified:

	8/04/2018 A3 1.82 by Quiksilver

Description:

	Signal Strength
_____________________________________________/*/

params ['_type','_position','_radius',['_requireGPS',TRUE]];
private _val = 0.1;
private _text = '';
if (_type isEqualTo 0) then {
	if ((lifeState player) in ['HEALTHY','INJURED']) then {
		if ((player distance2D _position) < _radius) then {
			_val = round ((1 - ((player distance2D _position) / _radius)) * 100);
		};
		if (underwater player) then {
			if ((('ItemGPS' in (assignedItems player)) && _requireGPS) || {(!(_requireGPS))}) then {
				if (isNull (objectParent player)) then {
					_text = format ['<t size="1.5">Signal Strength</t><br/><br/> %1 percent',_val];
					50 cutText [_text,'PLAIN DOWN',0.5,TRUE,TRUE];
				};
			} else {
				_text = format ['<t size="1.5">Signal Strength</t><br/><br/> No GPS Receiver ...',_val];
				50 cutText [_text,'PLAIN DOWN',0.5,TRUE,TRUE];
			};
		};
	};
};
if (_type isEqualTo 1) then {
	if ((lifeState player) in ['HEALTHY','INJURED']) then {
		if (!(captive player)) then {
			if ((player distance2D _position) < _radius) then {
				_val = round ((1 - ((player distance2D _position) / _radius)) * 100);
			};
			if (isNull (objectParent player)) then {
				if ((('ItemGPS' in (assignedItems player)) && _requireGPS) || {(!(_requireGPS))}) then {
					_text = format ['<t size="1.5">Signal Strength</t><br/><br/> %1 percent',_val];
					50 cutText [_text,'PLAIN DOWN',0.5,TRUE,TRUE];
				} else {
					_text = format ['<t size="1.5">Signal Strength</t><br/><br/> No GPS Receiver ...',_val];
					50 cutText [_text,'PLAIN DOWN',0.5,TRUE,TRUE];
				};
			};
		};
	};
};