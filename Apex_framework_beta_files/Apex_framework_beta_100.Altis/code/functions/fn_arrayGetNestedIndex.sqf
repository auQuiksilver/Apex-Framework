/*/
File: fn_arrayGetNestedIndex.sqf
Author:

	Cam A
	
Last Modified:

	7/04/2016 A3 1.56 by Cam A
	
Description:

	Pull element index from nested array
________________________________________________________________/*/
params ['_givenSearchArray','_givenSearchValue','_desiredIndex'];
private ['_nestedArray','_currentIndex']; 
scopeName '0';
private _i = -1;
{
	if (!(_desiredIndex isEqualTo -1)) then {
		if ((_x select _desiredIndex) isEqualTo _givenSearchValue) then {
			_i = _forEachIndex;
			breakTo '0';
		}; 
	} else {
		_currentIndex = _forEachIndex;
		_nestedArray = _x;
		{
			if (_x isEqualTo _givenSearchValue) then {
				_i = _currentIndex; 
				breakTo '0'; 
			}; 
		} forEach _nestedArray;
	}; 
} forEach _givenSearchArray;
_i;