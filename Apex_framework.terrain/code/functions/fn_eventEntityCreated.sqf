/*
File: fn_eventEntityDeleted.sqf
Author:

	Quiksilver
	
Last modified:

	27/05/2022 A3 2.10 by Quiksilver
	
Description:

	Entity Created mission event
__________________________________________________*/

params ['_entity'];
diag_log (format ['Entity Created: %1',_this]);
QS_analytics_entities_created = QS_analytics_entities_created + 1;
QS_analytics_entities_log = QS_analytics_entities_log select {!isNull _x};
QS_analytics_entities_log pushBack _entity;