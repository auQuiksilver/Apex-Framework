/*
File: fn_clientEventPlayerViewChanged.sqf
Author: 

	Quiksilver
	
Last modified:

	2/12/2016 A3 1.66 by Quiksilver
	
Description:

	View Changed
___________________________________________________________________*/

params ['_oldBody','_newBody','_vehicleIn','_oldCameraOn','_newCameraOn','_uav'];
player setVariable ['QS_client_playerViewChanged',TRUE,FALSE];