/*/
	Author: 
		Grumpy Old Man  (  https://forums.bohemia.net/forums/topic/215557-bis_fnc_arrayshuffle-does-it-work/?do=findComment&comment=3278000   )
	
	Description:
		This returns a new array with randomized order of elements from input array
	
	Parameters:
		_this: ARRAY
	
	Returns:
		ARRAY
______________________________________________/*/

_this = +_this;
_cnt = count _this;
for '_i' from 1 to _cnt do {
	_this pushBack (_this deleteAt floor random (_cnt + 1 - _i));
};
_this;