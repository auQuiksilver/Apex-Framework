/*
File: fn_clientEventMapSingleClick.sqf
Author: 

	Quiksilver
	
Last modified:

	3/09/2016 A3 1.62 by Quiksilver
	
Description:

	Map Single Click Mission Event
___________________________________________________________________*/

params ['_units','_pos','_alt','_shift'];
if ((_pos distance2D (markerPos 'QS_marker_module_fob')) < 250) then {
	[nil,nil,nil,1] call (missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal');
};
if (missionNamespace getVariable ['QS_customAO_GT_active',FALSE]) then {
	if (_shift) then {
		if ((markerAlpha 'QS_marker_GT_TP') isEqualTo 1) then {
			if ((_pos distance2D (markerPos 'QS_marker_GT_TP')) < 100) then {
				if ((player distance2D (markerPos 'QS_marker_aoMarker')) > 1000) then {
					if (isNull (objectParent player)) then {
						if (!(player call QS_fnc_isBusyAttached)) then {
							if (((lifeState player) in ['HEALTHY','INJURED']) && (!captive player)) then {
								setViewDistance 500;
								setObjectViewDistance 500;
								player setDir (random 360);
								preloadCamera (markerPos 'QS_marker_GT_TP');
								0 spawn {
									player allowDamage FALSE;
									uiSleep 10;
									player allowDamage TRUE;
								};
								player setVehiclePosition [(markerPos 'QS_marker_GT_TP'),[],15,'NONE'];
								openMap FALSE;
								50 cutText [(format ['%2 %1',(['Kavala','Georgetown'] select (worldName isEqualTo 'Tanoa')),localize 'STR_QS_Text_043']),'PLAIN DOWN',0.5];
							} else {
								50 cutText [localize 'STR_QS_Text_044','PLAIN DOWN',0.5];
							};
						} else {
							50 cutText [localize 'STR_QS_Text_045','PLAIN DOWN',0.5];
						};
					} else {
						50 cutText [localize 'STR_QS_Text_046','PLAIN DOWN',0.5];
					};
				} else {
					50 cutText [localize 'STR_QS_Text_047','PLAIN DOWN',0.5];
				};
			};
		};
	};
};