/*/
File: fn_supportRequestServer.sqf
Author:

	Quiksilver
	
Last Modified:

	31/05/2023 A3 2.12 by Quiksilver
	
Description:

	Serverside component of support request
____________________________________________/*/

if ((_this # 0) isEqualType []) then {
	params ['_targetPos','_unit','_name','_supportType','_isAI','_asset'];
	_marker = createMarker [str systemTime,ASLToAGL _targetPos,1,_unit];
	_marker setMarkerTypeLocal 'mil_dot';
	_marker setMarkerShapeLocal 'Icon';
	_marker setMarkerColorLocal (['ColorRed','ColorPink'] select _isAI);
	_marker setMarkerSizeLocal [0.5,0.5];
	_marker setMarkerTextLocal _supportType;
	_marker setMarkerAlpha 0.75;
	QS_markers_fireSupport_queue = QS_markers_fireSupport_queue select {_x isEqualType []};
	QS_markers_fireSupport_queue pushBack [_marker,serverTime];
	_text = format [localize 'STR_QS_Chat_177',mapGridPosition _targetPos,_name,groupId (group _unit),_supportType];
	[[side (group _unit),'BLU'],_text] remoteExec ['sideChat',-2];
	_text2 = format ['***** FIRE SUPPORT ***** %4 called on grid %1 by %2 ( %3 ) *****',mapGridPosition _targetPos,_name,groupId (group _unit),_supportType];
	diag_log _text2;
	_nearbyPlayers = allPlayers inAreaArray [_targetPos,100,100,0,FALSE];
	if (_nearbyPlayers isNotEqualTo []) then {
		[[],{
			50 cutText [localize 'STR_QS_Menu_223','PLAIN',0.75];
		}] remoteExec ['call',_nearbyPlayers,FALSE];
	};
	if (!_isAI) then {
		_commander = effectiveCommander _asset;
		[
			[_marker,_targetPos,_unit,_asset,_supportType],
			{
				params ['_marker','_targetPos','_unit','_asset','_supportType'];
				_marker setMarkerColorLocal 'ColorGreen';
				//player commandChat (format [localize 'STR_QS_Chat_176',_supportType,mapGridPosition _targetPos]);
				playSoundUI ['QS_audio_notification_2',0.75,0.75,FALSE];
				_text2 = format ['***** FIRE SUPPORT ***** %4 called on grid %1 by %2 ( %3 ) *****',mapGridPosition _targetPos,name _unit,groupId (group _unit),_supportType];
				diag_log _text2;
			}
		] remoteExec ['call',((crew _asset) select {(isPlayer _x)}),FALSE];
	};
} else {
	_asset = _this # 0;
	if (_asset isKindOf 'B_Ship_MRLS_01_F') then {
		params ['','_target','_caller'];
		_asset setVariable ['QS_supportRequest_caller',_caller,FALSE];
		_asset setVariable ['QS_cruisemissile_target',_target,TRUE];
		(gunner _asset) doTarget _target;
		(gunner _asset) addEventHandler [
			'FiredMan',
			{
				params ['_unit','','','','','_magazine','_projectile','_vehicle'];
				_unit removeEventHandler [_thisEvent,_thisEventHandler];
				[_projectile,_vehicle,_magazine] spawn {
					params ['_projectile','_vehicle','_magazine'];
					_target = _vehicle getVariable ['QS_cruisemissile_target',objNull];
					_requester = _vehicle getVariable ['QS_fireSupport_requester',''];
					_caller = _vehicle getVariable ['QS_supportRequest_caller',objnull];
					if (_requester isNotEqualTo '') then {
						_text = format [localize 'STR_QS_Chat_179',mapGridPosition (getPosWorld _target),_requester,groupId (group _caller),(_vehicle getVariable ['QS_fireSupport_type',''])];
						[[side (group _caller),'BLU'],_text] remoteExec ['sideChat',-2];
					};
					waitUntil {
						(((getPosATL _projectile) # 2) > 50)
					};
					if (!isNull _target) then {
						missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
						missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
						_projectile setMissileTarget _target;
					};
					if (!isNull _projectile) then {
						if ((toLowerANSI _magazine) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg','magazine_shipcannon_120mm_he_shells_x32','magazine_shipcannon_120mm_he_guided_shells_x2','magazine_shipcannon_120mm_he_lg_shells_x2','magazine_missiles_cruise_01_x18']) then {
							if ((toLowerANSI _magazine) in ['8rnd_82mm_mo_shells']) then {
								_projectile addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
							} else {
								_projectile addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
							};
						};
					};
				};
			}
		];
		sleep 0.1;
		(gunner _asset) forceWeaponFire [currentMuzzle (gunner _asset),'Cruise'];
	} else {
		params ['','_weapon','_position','_clientOwner'];
		if (
			(_asset isKindOf 'b_ship_gun_01_f') &&
			(!isNull (attachedTo _asset))
		) then {
			[0,_asset] call QS_fnc_eventAttach;
			(group (effectiveCommander _asset)) setGroupOwner _clientOwner;
			_asset setOwner _clientOwner;
			[_asset] spawn {
				params ['_asset'];
				sleep 60;
				_asset setDir ((getDir (missionNamespace getVariable 'QS_destroyerObject')) - 180);
				_asset setPosWorld ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [0,-79.1348,14.7424]);
				_asset setVelocity [0,0,0];
				_logic = (missionNamespace getVariable 'QS_destroyerObject') getVariable 'QS_carrier_defenseLogic';
				[_asset,_logic,TRUE] call (missionNamespace getVariable 'QS_fnc_attachToRelative');
			};
		};
		if ((ASLToAGL _position) inRangeOfArtillery [[gunner _asset],((magazines _asset) # 0)]) then {
			(gunner _asset) addEventHandler [
				'FiredMan',
				{
					params ['_unit','','','','','','_projectile','_vehicle'];
					if (_asset isKindOf 'b_ship_gun_01_f') then {
						
					};
					_unit removeEventHandler [_thisEvent,_thisEventHandler];
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
					missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
					if (!isNull _projectile) then {
						if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg','magazine_shipcannon_120mm_he_shells_x32','magazine_shipcannon_120mm_he_guided_shells_x2','magazine_shipcannon_120mm_he_lg_shells_x2','magazine_missiles_cruise_01_x18']) then {
							if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
								_projectile addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
							} else {
								_projectile addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
							};
						};
					};
				}
			];
			_volley = [3,1] select ((((weapons _asset) apply {toLowerANSI _x}) # 0) in ['rockets_230mm_gat']);
			(gunner _asset) doArtilleryFire [_position,(magazines _asset) # 0,_volley];
			private _cooldown = [180,360] select ((((weapons _asset) apply {toLowerANSI _x}) # 0) in ['rockets_230mm_gat']);
			if (_asset isKindOf 'StaticMortar') then {
				comment 'reduce cooldown further?';
			};
			_asset setVariable ['QS_fireSupport_cooldown',serverTime + _cooldown,TRUE];
		};
	};
};