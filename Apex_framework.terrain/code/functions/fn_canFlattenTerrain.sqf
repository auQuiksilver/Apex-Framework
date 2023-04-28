/*
File: fn_canFlattenTerrain.sqf
Author:

	Quiksilver
	
Last Modified:

	28/04/2023 A3 2.12 by Quiksilver
	
Description:

	Can Flatten Terrain
___________________________________________________*/

params ['_entity',['_radius',30]];
_nearRoads = _entity nearRoads _radius;
_nearTerrainObjects = nearestTerrainObjects [_entity,['HOUSE','MAIN ROAD','TRACK'],_radius,FALSE,TRUE];
_nearHouses = nearestObjects [_entity,['House'],_radius];
_nearAircraft = (_entity nearEntities ['Air',_radius * 3]) select {!isTouchingGround _x};
(
	(_nearRoads isEqualTo []) &&
	{(_nearTerrainObjects isEqualTo [])} &&
	{(_nearHouses isEqualTo [])} &&
	{(_nearAircraft isEqualTo [])}
)