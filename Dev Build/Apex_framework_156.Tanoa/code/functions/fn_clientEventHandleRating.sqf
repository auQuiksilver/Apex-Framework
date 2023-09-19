/*/
File: fn_clientEventHandleRating.sqf
Author: 

	Quiksilver
	
Last modified:

	30/08/2016 A3 1.62 by Quiksilver
	
Description:

	Handle Rating Event
___________________________________________________________________/*/

params ['_unit','_rating'];
if ((rating _unit) < 0) then {_unit addRating (0 - (rating _unit))};