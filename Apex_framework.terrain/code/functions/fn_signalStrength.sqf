/*/
File: fn_signalStrength.sqf
Author: 

	Quiksilver

Last Modified:

	9/10/2023 A3 2.14 by Quiksilver

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
		if (((eyePos player) # 2) < 0) then {
			if ((((QS_player getSlotItemName 612) isNotEqualTo '') && _requireGPS) || {(!(_requireGPS))}) then {
				if (isNull (objectParent player)) then {
					_text = format ['<t size="1.5">%2</t><br/><br/> %1 %3',_val,localize 'STR_QS_Text_243',localize 'STR_QS_Text_245'];
					50 cutText [_text,'PLAIN DOWN',0.5,TRUE,TRUE];
				};
			} else {
				_text = format ['<t size="1.5">%2</t><br/><br/> %1',localize 'STR_QS_Text_244',localize 'STR_QS_Text_243'];
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
				if (
					(((QS_player getSlotItemName 612) isNotEqualTo '') && _requireGPS) || 
					{(!(_requireGPS))}
				) then {
					_text = format ['<t size="1.5">%2</t><br/><br/> %1 %3',_val,localize 'STR_QS_Text_243',localize 'STR_QS_Text_245'];
					50 cutText [_text,'PLAIN DOWN',0.5,TRUE,TRUE];
				} else {
					_text = format ['<t size="1.5">%2</t><br/><br/> %3',_val,localize 'STR_QS_Text_243',localize 'STR_QS_Text_244'];
					50 cutText [_text,'PLAIN DOWN',0.5,TRUE,TRUE];
				};
			};
		};
	};
};