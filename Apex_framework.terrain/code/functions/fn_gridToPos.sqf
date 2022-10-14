/*
	Author: Karel Moricky (tweaked by Quiksilver A3 1.84)

	Description:
	Converts grid coordinates to world position.
	Correct results outside of the map area are not guaranteed.

	Parameter(s):
		0: STRING - grid returned by mapGridPosition command

	Returns:
	ARRAY in format [[gridX:Number,gridY:Number],[gridWidth:Number,gridHeight:Number]]
*/

params ['_posGrid'];
_cfgGrid = configfile >> 'CfgWorlds' >> worldName >> 'Grid';
_offsetX = getnumber (_cfgGrid >> 'offsetX');
_offsetY = getnumber (_cfgGrid >> 'offsetY');
private _zoomMax = 1e99;
private _format = '';
private _formatX = '';
private _formatY = '';
private _stepX = 1e10;
private _stepY = 1e10;
{
	_zoom = getnumber (_x >> 'zoomMax');
	if (_zoom < _zoomMax) then {
		_zoomMax = _zoom;
		_format = gettext (_x >> 'format');
		_formatX = gettext (_x >> 'formatX');
		_formatY = gettext (_x >> 'formatY');
		_stepX = getnumber (_x >> 'stepX');
		_stepY = getnumber (_x >> 'stepY');
	};
} foreach (configproperties [_cfgGrid,'isclass _x',false]);
private _iX = -1;
private _iY = -1;
{if (_iX < 0) then {_iX = _format find _x;};} foreach ['X','x'];
{if (_iY < 0) then {_iY = _format find _x;};} foreach ['Y','y'];
_formatXcount = count _formatX;
_formatYcount = count _formatY;
_replaceBefore = toarray ' 0123456789abcdefghijklmnopqrestuvwxyz';
_replaceAfter = [-1,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25];
private _posGridX = _posGrid select [_iX,_formatXcount];
private _posGridY = _posGrid select [_iY + _formatXcount - 1,_formatYcount];
_fnc_lettersToNumbers = {
	_array = toarray toLowerANSI (_this # 0);
	_count = _this # 1;
	_step = _this # 2;
	_result = 0;
	{
		_result = _result + (_replaceAfter select ((_replaceBefore find _x) max 0)) * _step * 0.1 * 10^(_count - _foreachindex);
	} foreach _array;
	_result
};
_posGridX = [_posGridX,_formatXcount,_stepX] call _fnc_lettersToNumbers;
_posGridY = [_posGridY,_formatYcount,_stepY] call _fnc_lettersToNumbers;
_formatX = [_formatX,_formatXcount,_stepX] call _fnc_lettersToNumbers;
_formatY = [_formatY,_formatYcount,_stepY] call _fnc_lettersToNumbers;
_posGridX = _posGridX - _formatX;
_posGridY = _posGridY - _formatY;
if (_stepY > 0) then {_offsetY = _offsetY + _stepY;};
[[_offsetX + _posGridX,worldSize - _offsetY - _posGridY],[abs _stepX,abs _stepY]]