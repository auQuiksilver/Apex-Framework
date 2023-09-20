/*/
File: fn_eventUAVCrewCreated.sqf
Author:

	Quiksilver
	
Last modified:

	28/08/2023 A3 2.14 by Quiksilver
	
Description:

	UAV Crew Created event
__________________________________________________/*/

params ['_entity','_driver','_gunner'];
diag_log format ['UAV Crew Created: %1',_this];		// Debug