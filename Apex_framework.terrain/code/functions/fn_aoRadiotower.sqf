/*/
File: fn_aoRadiotower.sqf
Author: 

	Quiksilver

Last Modified:

	29/12/2022 A3 2.10 by Quiksilver

Description:

	Spawn AO Radio tower
__________________________________________________/*/

params ['_pos'];
_baseMarker = markerPos 'QS_marker_base_marker';
_hqPos = missionNamespace getVariable ['QS_HQpos',[0,0,0]];
private _position = [0,0,0];
for '_x' from 0 to 9 step 1 do {
	_position = ['RADIUS',_pos,((missionNamespace getVariable 'QS_aoSize') * 0.75),'LAND',[1,0,0.5,4,0,FALSE,objNull],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (
		((_position distance2D _baseMarker) > 500) && 
		((_position distance2D _hqPos) > 200) && 
		((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])
	) exitWith {};
};
_position set [2,0];
_roughPos = [((_position # 0) - 140) + (random 280),((_position # 1) - 140) + (random 280),0];
private _type = selectRandom (['ao_radiotower_types_1'] call QS_data_listVehicles);
_radiotower = createVehicle [_type,_position,[],0,'NONE'];
_radiotower setVectorUp [0,0,1];
_radiotower allowDamage FALSE;
_radiotower addEventHandler ['Killed',{call (missionNamespace getVariable 'QS_fnc_eventRTKilled');}];
missionNamespace setVariable ['QS_radioTower',_radiotower,FALSE];
missionNamespace setVariable ['QS_radioTower_pos',_position,FALSE];
missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
{
	_x setMarkerPosLocal _roughPos;
} count ['QS_marker_radioMarker','QS_marker_radioCircle'];
'QS_marker_radioCircle' setMarkerSizeLocal [150,150];
TRUE;