/*
File: fn_sectorScan.sqf
Author: 

	Quiksilver

Last Modified:

	8/09/2016 A3 1.62 by Quiksilver

Description:

	Sector Scan
____________________________________________________________________________*/

params [
	'_player','_profileName','_gridPos','_clickPos','_clientOwner','_playerDisplayName'
];
if (time > (missionNamespace getVariable 'QS_sectorScan_lastTime')) then {
	missionNamespace setVariable ['QS_sectorScan_lastTime',(time + 300),TRUE];
	['sideChat',[WEST,'HQ'],(format ['%4 [%1] %2 %5 %3 ...',_playerDisplayName,_profileName,_gridPos,localize 'STR_QS_Chat_056',localize 'STR_QS_Hints_060'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	[_gridPos,_clickPos] spawn {
		private ['_gridPos','_clickPos','_count'];
		_gridPos = _this # 0;
		_clickPos = _this # 1;
		sleep 10;
		_count = 0;
		{
			if ((_x distance2D _clickPos) < 250) then {
				if ((mapGridPosition _x) isEqualTo _gridPos) then {
					_count = _count + 1;
				};
			};
			sleep 0.001;
		} count ((units EAST) + (units RESISTANCE));
		['sideChat',[WEST,'HQ'],(format ['%3, %1 %4 %2',_count,_gridPos,localize 'STR_QS_Chat_057',localize 'STR_QS_Chat_058'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		_marker = createMarker [(format ['QS_marker_sectorScan_%1',time]),_clickPos];
		_marker setMarkerShapeLocal 'Icon';
		_marker setMarkerTypeLocal 'mil_dot';
		_marker setMarkerColorLocal 'ColorGREEN';
		_marker setMarkerAlphaLocal 0.5;
		_marker setMarkerText (format ['%1 %2 %4 %3',(toString [32,32,32]),_count,_gridPos,localize 'STR_QS_Marker_027']);
		sleep 15;
		deleteMarker _marker;
	};
} else {
	comment 'Next sat scan too soon';
	_timeToNext = round (ceil(((missionNamespace getVariable 'QS_sectorScan_lastTime') - time) / 60));
	[63,[5,[(format ['%2 %1 %3',_timeToNext,localize 'STR_QS_Text_266',localize 'STR_QS_Text_267']),'PLAIN']]] remoteExec ['QS_fnc_remoteExec',_clientOwner,FALSE];
};