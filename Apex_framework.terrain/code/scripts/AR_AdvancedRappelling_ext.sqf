/* The MIT License (MIT)  Copyright (c) 2016 Seth Duda  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */ 
if !(missionNamespace isNil 'AR_RAPPELLING_INIT') exitWith {};
AR_RAPPELLING_INIT = compileFinal "TRUE"; 
AP_RAPPEL_POINTS = []; 
AR_RAPPEL_POINT_CLASS_HEIGHT_OFFSET = [ 	["All", [-0.05, -0.05, -0.05, -0.05, -0.05, -0.05]] ]; 
AR_Has_Addon_Animations_Installed = compileFinal " 	(count getText ( configFile / ""CfgMovesBasic"" / ""ManActions"" / ""AR_01"" )) > 0; ";  
AR_Has_Addon_Sounds_Installed = compileFinal " 	private [""_config"",""_configMission""]; 	_config = getArray ( configFile / ""CfgSounds"" / ""AR_Rappel_Start"" / ""sound"" ); 	_configMission = getArray ( missionConfigFile / ""CfgSounds"" / ""AR_Rappel_Start"" / ""sound"" ); 	(((count _config) > 0) || ((count _configMission) > 0)); ";  
AR_Rappel_All_Cargo = compileFinal " 	params [""_vehicle"",[""_rappelHeight"",25],[""_positionASL"",[]]]; 	if(isPlayer (driver _vehicle)) exitWith {}; 	if(local _vehicle) then { 		_this spawn { 			params [""_vehicle"",[""_rappelHeight"",25],[""_positionASL"",[]]]; 	 			_heliGroup = group driver _vehicle; 			_vehicle setVariable [""AR_Units_Rappelling"",true];  			_heliGroupOriginalBehaviour = behaviour (leader _heliGroup); 			_heliGroupOriginalCombatMode = combatMode (leader _heliGroup); 			_heliGroupOriginalFormation = formation _heliGroup;  			if (_positionASL isEqualTo []) then { 				_positionASL = AGLtoASL [(getPos _vehicle) # 0, (getPos _vehicle) # 1, 0]; 			}; 			_positionASL = _positionASL vectorAdd [0, 0, _rappelHeight]; 			 			_gameLogicLeader = _heliGroup createUnit [""LOGIC"", ASLToAGL _positionASL, [], 0, """"]; 			_heliGroup selectLeader _gameLogicLeader;  			_heliGroup setBehaviour ""Careless""; 			_heliGroup setCombatMode ""Blue""; 			_heliGroup setFormation ""File""; 			 			waitUntil { (vectorMagnitude (velocity _vehicle)) < 10 && _vehicle distance2d _gameLogicLeader < 50  }; 			 			[_vehicle, _positionASL] spawn { 				params [""_vehicle"",""_positionASL""]; 				 				while { _vehicle getVariable [""AR_Units_Rappelling"",false] && alive _vehicle } do {  					_velocityMagatude = 5; 					_distanceToPosition = ((getPosASL _vehicle) distance _positionASL); 					if( _distanceToPosition <= 10 ) then { 						_velocityMagatude = (_distanceToPosition / 10) * _velocityMagatude; 					}; 					 					_currentVelocity = velocity _vehicle; 					_currentVelocity = _currentVelocity vectorAdd (( (getPosASL _vehicle) vectorFromTo _positionASL ) vectorMultiply _velocityMagatude); 					_currentVelocity = (vectorNormalized _currentVelocity) vectorMultiply ( (vectorMagnitude _currentVelocity) min _velocityMagatude ); 					_vehicle setVelocity _currentVelocity; 					 					sleep 0.05; 				}; 			};  			_rappelUnits = []; 			_rappelledGroups = []; 			{ 				if( group _x != _heliGroup && alive _x ) then { 					_rappelUnits pushBack _x; 					_rappelledGroups = _rappelledGroups + [group _x]; 				}; 			} forEach crew _vehicle; 	 			_unitsOutsideVehicle = []; 			while { count _unitsOutsideVehicle != count _rappelUnits } do { 	 				_distanceToPosition = ((getPosASL _vehicle) distance _positionASL); 				if(_distanceToPosition < 3) then { 					{ 						[_x, _vehicle] call AR_Rappel_From_Heli;					 						sleep 1; 					} forEach (_rappelUnits-_unitsOutsideVehicle); 					{ 						if!(_x in _vehicle) then { 							_unitsOutsideVehicle pushBack _x; 						}; 					} forEach (_rappelUnits-_unitsOutsideVehicle); 				}; 				sleep 2; 			}; 			 			_unitsRappelling = true; 			while { _unitsRappelling } do { 				_unitsRappelling = false; 				{ 					if( _x getVariable [""AR_Is_Rappelling"",false] ) then { 						_unitsRappelling = true; 					}; 				} forEach _rappelUnits; 				sleep 3; 			}; 			 			deleteVehicle _gameLogicLeader; 			 			_heliGroup setBehaviour _heliGroupOriginalBehaviour; 			_heliGroup setCombatMode _heliGroupOriginalCombatMode; 			_heliGroup setFormation _heliGroupOriginalFormation;  			_vehicle setVariable [""AR_Units_Rappelling"",nil]; 	 		}; 	} else { 		[_this,""AR_Rappel_All_Cargo"",_vehicle] call AR_RemoteExec; 	}; "; 
AR_Get_Heli_Rappel_Points = compileFinal " 	params [""_vehicle""]; 	 	 	private [""_preDefinedRappelPoints"",""_className"",""_rappelPoints"",""_preDefinedRappelPointsConverted""]; 	_preDefinedRappelPoints = []; 	{ 		_className = _x # 0; 		_rappelPoints = _x # 1; 		if( _vehicle isKindOf _className ) then { 			_preDefinedRappelPoints = _rappelPoints; 		}; 	} forEach (AP_RAPPEL_POINTS + (missionNamespace getVariable [""AP_CUSTOM_RAPPEL_POINTS"",[]])); 	if(count _preDefinedRappelPoints > 0) exitWith { 		_preDefinedRappelPointsConverted = []; 		{ 			if (_x isEqualType '') then { 				_modelPosition = _vehicle selectionPosition _x; 				if( [0,0,0] distance _modelPosition > 0 ) then { 					_preDefinedRappelPointsConverted pushBack _modelPosition; 				}; 			} else { 				_preDefinedRappelPointsConverted pushBack _x; 			}; 		} forEach _preDefinedRappelPoints; 		_preDefinedRappelPointsConverted; 	};  	private [ 		""_rappelPointsArray"",""_cornerPoints"",""_frontLeftPoint"",""_frontRightPoint"",""_rearLeftPoint"",""_rearRightPoint"",""_rearLeftPointFinal"", 		""_rearRightPointFinal"",""_frontLeftPointFinal"",""_frontRightPointFinal"",""_middleLeftPointFinal"",""_middleRightPointFinal"",""_vehicleUnitVectorUp"", 		""_rappelPoints"",""_modelPoint"",""_modelPointASL"",""_surfaceIntersectStartASL"",""_surfaceIntersectEndASL"",""_surfaces"",""_intersectionASL"",""_intersectionObject"", 		""_la"",""_lb"",""_n"",""_p0"",""_l"",""_d"",""_validRappelPoints"" 	]; 	 	_rappelPointsArray = []; 	_cornerPoints = [_vehicle] call AR_Get_Corner_Points; 	 	_frontLeftPoint = (((_cornerPoints # 2) vectorDiff (_cornerPoints # 3)) vectorMultiply 0.2) vectorAdd (_cornerPoints # 3); 	_frontRightPoint = (((_cornerPoints # 2) vectorDiff (_cornerPoints # 3)) vectorMultiply 0.8) vectorAdd (_cornerPoints # 3); 	_rearLeftPoint = (((_cornerPoints # 0) vectorDiff (_cornerPoints # 1)) vectorMultiply 0.2) vectorAdd (_cornerPoints # 1); 	_rearRightPoint = (((_cornerPoints # 0) vectorDiff (_cornerPoints # 1)) vectorMultiply 0.8) vectorAdd (_cornerPoints # 1); 	 	_rearLeftPointFinal = ((_frontLeftPoint vectorDiff _rearLeftPoint) vectorMultiply 0.2) vectorAdd _rearLeftPoint; 	_rearRightPointFinal = ((_frontRightPoint vectorDiff _rearRightPoint) vectorMultiply 0.2) vectorAdd _rearRightPoint; 	_frontLeftPointFinal = ((_rearLeftPoint vectorDiff _frontLeftPoint) vectorMultiply 0.2) vectorAdd _frontLeftPoint; 	_frontRightPointFinal = ((_rearRightPoint vectorDiff _frontRightPoint) vectorMultiply 0.2) vectorAdd _frontRightPoint; 	_middleLeftPointFinal = ((_frontLeftPointFinal vectorDiff _rearLeftPointFinal) vectorMultiply 0.5) vectorAdd _rearLeftPointFinal; 	_middleRightPointFinal = ((_frontRightPointFinal vectorDiff _rearRightPointFinal) vectorMultiply 0.5) vectorAdd _rearRightPointFinal;  	_vehicleUnitVectorUp = vectorNormalized (vectorUp _vehicle); 	 	_rappelPointHeightOffset = 0; 	{ 		if(_vehicle isKindOf (_x # 0)) then { 			_rappelPointHeightOffset = (_x # 1); 		}; 	} forEach AR_RAPPEL_POINT_CLASS_HEIGHT_OFFSET; 	 	_rappelPoints = []; 	{ 		_modelPoint = _x; 		_modelPointASL = _vehicle modelToWorldVisualWorld _modelPoint; 		_surfaceIntersectStartASL = _modelPointASL vectorAdd ( _vehicleUnitVectorUp vectorMultiply -5 ); 		_surfaceIntersectEndASL = _modelPointASL vectorAdd ( _vehicleUnitVectorUp vectorMultiply 5 );  		_la = ASLToAGL _surfaceIntersectStartASL; 		_lb = ASLToAGL _surfaceIntersectEndASL; 		 		if(_la # 2 < 0 && _lb # 2 > 0) then { 			_n = [0,0,1]; 			_p0 = [0,0,0.1]; 			_l = (_la vectorFromTo _lb); 			if((_l vectorDotProduct _n) != 0) then { 				_d = ( ( _p0 vectorAdd ( _la vectorMultiply -1 ) ) vectorDotProduct _n ) / (_l vectorDotProduct _n); 				_surfaceIntersectStartASL = AGLToASL ((_l vectorMultiply _d) vectorAdd _la); 			}; 		}; 		 		_surfaces = lineIntersectsSurfaces [_surfaceIntersectStartASL, _surfaceIntersectEndASL, objNull, objNull, true, 100]; 		_intersectionASL = []; 		{ 			_intersectionObject = _x # 2; 			if (_intersectionObject isEqualTo _vehicle) exitWith { 				_intersectionASL = _x # 0; 			}; 		} forEach _surfaces; 		if (_intersectionASL isNotEqualTo []) then { 			_intersectionASL = _intersectionASL vectorAdd (( _surfaceIntersectStartASL vectorFromTo _surfaceIntersectEndASL ) vectorMultiply (_rappelPointHeightOffset select (count _rappelPoints))); 			_rappelPoints pushBack (_vehicle worldToModelVisual (ASLToAGL _intersectionASL)); 		} else { 			_rappelPoints pushBack []; 		}; 	} forEach [_middleLeftPointFinal, _middleRightPointFinal, _frontLeftPointFinal, _frontRightPointFinal, _rearLeftPointFinal, _rearRightPointFinal];  	_validRappelPoints = []; 	{ 		if(count _x > 0 && count _validRappelPoints < missionNamespace getVariable [""AR_MAX_RAPPEL_POINTS_OVERRIDE"",6]) then { 			_validRappelPoints pushBack _x; 		}; 	} forEach _rappelPoints; 	 	_validRappelPoints; ";  
AR_Rappel_From_Heli = compileFinal " 	params [""_player"",""_heli""]; 	if (isServer) then { 	 		if!(_player in _heli) exitWith {}; 		if(_player getVariable [""AR_Is_Rappelling"", false]) exitWith {};  		_rappelPoints = [_heli] call AR_Get_Heli_Rappel_Points; 		_rappelPointIndex = 0; 		{ 			_rappellingPlayer = _heli getVariable [""AR_Rappelling_Player_"" + str _rappelPointIndex,objNull]; 			if(isNull _rappellingPlayer) exitWith {}; 			_rappelPointIndex = _rappelPointIndex + 1; 		} forEach _rappelPoints;  		if ((count _rappelPoints) isEqualTo _rappelPointIndex) exitWith { 			if(isPlayer _player) then { 				[[""All rappel anchors in use. Please try again."", false],""AR_Hint"",_player] call AR_RemoteExec; 			}; 		}; 		 		_heli setVariable [""AR_Rappelling_Player_"" + str _rappelPointIndex,_player];  		_player setVariable [""AR_Is_Rappelling"",true,true];  		[_player,_heli,_rappelPoints # _rappelPointIndex] spawn AR_Client_Rappel_From_Heli;  		[_player, _heli, _rappelPointIndex] spawn { 			params [""_player"",""_heli"", ""_rappelPointIndex""]; 			for '_x' from 0 to 1 step 0 do { 				if(!alive _player) exitWith {}; 				if!(_player getVariable [""AR_Is_Rappelling"", false]) exitWith {}; 				sleep 2; 			}; 			_heli setVariable [""AR_Rappelling_Player_"" + str _rappelPointIndex, nil]; 		};  	} else { 		[_this,""AR_Rappel_From_Heli"",true] call AR_RemoteExecServer; 	}; ";  
AR_Client_Rappel_From_Heli = compileFinal "    	
	params [""_player"",""_heli"",""_rappelPoint""];	 	
	if (local _player) then { 		
		[_player] orderGetIn false; 		
		moveOut _player; 		
		waitUntil { vehicle _player isEqualTo _player}; 		
		_playerStartPosition = (_heli modelToWorldVisualWorld _rappelPoint) vectorAdd [
			-((((random 100)-50))/25),
			-((((random 100)-50))/25),
			-1
		];	
		_player setPosWorld _playerStartPosition;  		
		_anchor = createVehicle ['Land_Can_V2_F',[(random 10),(random 10),(10 + (random 10))],[],0,'NONE'];
		_anchor allowDamage false;
		_anchor hideObject TRUE;
		[[_anchor],'AR_Hide_Object_Global',TRUE] call AR_RemoteExecServer;
		_anchor disableCollisionWith _heli;
		_heli disableCollisionWith _anchor;
		if (!local _heli) then {
			[65,_anchor,_heli,FALSE] remoteExecCall ['QS_fnc_remoteExec',_heli,FALSE];
		};
		[1,_anchor,[_heli,_rappelPoint]] call QS_fnc_eventAttach;
		_deviceType = 'B_UAV_01_F';
		_rappelDevice = createVehicle [_deviceType,[(random 10),(random 10),(10 + (random 10))],[],0,'NONE'];
		_rappelDevice allowDamage false;
		_rappelDevice hideObject TRUE;
		_rappelDevice hideObject TRUE;
		_rappelDevice hideObject TRUE;
		for '_x' from 0 to 1 step 1 do {
			[[_rappelDevice],'AR_Hide_Object_Global',TRUE] call AR_RemoteExecServer;
		};
		_rappelDevice disableCollisionWith _heli;
		_heli disableCollisionWith _rappelDevice;
		if (canSuspend) then {
			uiSleep 0.01;
		};
		[65,_rappelDevice,_heli,FALSE,101] remoteExecCall ['QS_fnc_remoteExec',0,FALSE];
		if (canSuspend) then {
			uiSleep 0.01;
		};
		_rappelDevice setPosWorld ((getPosWorld player) vectorAdd [0,0,-1]);
		_bottomRopeLength = 60;
		_topRopeLength = 3;
		_topRope = ropeCreate [_rappelDevice, [0,0.15,0], _anchor, [0, 0, 0], _topRopeLength];
		_topRope allowDamage false;
		[_player] spawn AR_Enable_Rappelling_Animation_Client;
		_gravityAccelerationVec = [0,0,-9.8];
		_velocityVec = [0,0,0];
		_lastTime = diag_tickTime;
		_lastPosition = _rappelDevice modelToWorldVisualWorld [0,0,0];
		_lookDirFreedom = 50;
		_dir = (random 360) + (_lookDirFreedom / 2);
		_dirSpinFactor = (((random 10) - 5) / 5) max 0.1;
		_ropeKeyDownHandler = -1;
		_ropeKeyUpHandler = -1;
		if (_player isEqualTo player) then {
			_player setVariable [""AR_DECEND_PRESSED"",false];
			_player setVariable [""AR_FAST_DECEND_PRESSED"",false];
			_player setVariable [""AR_RANDOM_DECEND_SPEED_ADJUSTMENT"",0];
			_ropeKeyDownHandler = (findDisplay 46) displayAddEventHandler [
				""KeyDown"",
				{
					if(_this # 1 in (actionKeys ""MoveBack"")) then {
						player setVariable [""AR_DECEND_PRESSED"",true];
					};
					if(_this # 1 in (actionKeys ""Turbo"")) then {
						player setVariable [""AR_FAST_DECEND_PRESSED"",true];
					};
				}
			];
			_ropeKeyUpHandler = (findDisplay 46) displayAddEventHandler [
				""KeyUp"",
				{
					if(_this # 1 in (actionKeys ""MoveBack"")) then {
						player setVariable [""AR_DECEND_PRESSED"",false];
					};
					if(_this # 1 in (actionKeys ""Turbo"")) then {
						player setVariable [""AR_FAST_DECEND_PRESSED"",false];
					};
				}
			];
		} else {
			_player setVariable [""AR_DECEND_PRESSED"",false];
			_player setVariable [""AR_FAST_DECEND_PRESSED"",false];
			_player setVariable [""AR_RANDOM_DECEND_SPEED_ADJUSTMENT"",(random 2) - 1];
			[_player] spawn {
				params [""_player""];
				uiSleep 2;
				_player setVariable [""AR_DECEND_PRESSED"",true];
			};
		};
		_this spawn {
			params [""_player"",""_heli""];
			while {_player getVariable [""AR_Is_Rappelling"", false]} do {
				if(speed _heli > 150) then {
					if(isPlayer _player) then {
						[""Moving too fast! You've lost grip of the rope."", false] call AR_Hint;
					};
					[_player] call AR_Rappel_Detach_Action;
				};
				uiSleep 2;
			};
		};
		for '_x' from 0 to 1 step 0 do {
			_currentTime = diag_tickTime;
			_timeSinceLastUpdate = _currentTime - _lastTime;
			_lastTime = _currentTime;
			if (_timeSinceLastUpdate > 1) then {
				_timeSinceLastUpdate = 0;
			};
			_environmentWindVelocity = wind;
			_playerWindVelocity = _velocityVec vectorMultiply -1;
			_helicopterWindVelocity = (vectorUp _heli) vectorMultiply -30;
			_totalWindVelocity = _environmentWindVelocity vectorAdd _playerWindVelocity vectorAdd _helicopterWindVelocity;
			_totalWindForce = _totalWindVelocity vectorMultiply (9.8/53);
			_accelerationVec = _gravityAccelerationVec vectorAdd _totalWindForce;
			_velocityVec = _velocityVec vectorAdd ( _accelerationVec vectorMultiply _timeSinceLastUpdate );
			_newPosition = _lastPosition vectorAdd ( _velocityVec vectorMultiply _timeSinceLastUpdate );
			_heliPos = _heli modelToWorldVisualWorld _rappelPoint;
			if((_newPosition distance _heliPos) > _topRopeLength) then {
				_newPosition = (_heliPos) vectorAdd (( vectorNormalized ( (_heliPos) vectorFromTo _newPosition )) vectorMultiply _topRopeLength);
				_surfaceVector = ( vectorNormalized ( _newPosition vectorFromTo (_heliPos) ));
				_velocityVec = _velocityVec vectorAdd (( _surfaceVector vectorMultiply (_velocityVec vectorDotProduct _surfaceVector)) vectorMultiply -1);
			};
			_rappelDevice setPosWorld (_lastPosition vectorAdd ((_newPosition vectorDiff _lastPosition) vectorMultiply 6));
			_rappelDevice setVectorDir (vectorDir _player);
			_player setPosWorld (_newPosition vectorAdd [0,0,-0.6]);
			_player setVelocity [0,0,0];
			if(_player getVariable [""AR_DECEND_PRESSED"",false]) then {
				_decendSpeedMetersPerSecond = 3.5;
				if(_player getVariable [""AR_FAST_DECEND_PRESSED"",false]) then {
					_decendSpeedMetersPerSecond = 5;
				};
				_decendSpeedMetersPerSecond = _decendSpeedMetersPerSecond + (_player getVariable [""AR_RANDOM_DECEND_SPEED_ADJUSTMENT"",0]);
				_bottomRopeLength = _bottomRopeLength - (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);
				_topRopeLength = _topRopeLength + (_timeSinceLastUpdate * _decendSpeedMetersPerSecond);
				ropeUnwind [_topRope, _decendSpeedMetersPerSecond, _topRopeLength - 0.5];
			};
			_dir = _dir + ((360/1000) * _dirSpinFactor);
			if(isPlayer _player) then {
				_currentDir = getDir _player;
				_minDir = (_dir - (_lookDirFreedom/2)) mod 360;
				_maxDir = (_dir + (_lookDirFreedom/2)) mod 360;
				_minDegreesToMax = 0;
				_minDegreesToMin = 0;
				if( _currentDir > _maxDir ) then {
					_minDegreesToMax = (_currentDir - _maxDir) min (360 - _currentDir + _maxDir);
				};
				if( _currentDir < _maxDir ) then {
					_minDegreesToMax = (_maxDir - _currentDir) min (360 - _maxDir + _currentDir);
				};
				if( _currentDir > _minDir ) then {
					_minDegreesToMin = (_currentDir - _minDir) min (360 - _currentDir + _minDir);
				};
				if( _currentDir < _minDir ) then {
					_minDegreesToMin = (_minDir - _currentDir) min (360 - _minDir + _currentDir);
				};
				if( _minDegreesToMin > _lookDirFreedom || _minDegreesToMax > _lookDirFreedom ) then {
					if( _minDegreesToMin < _minDegreesToMax ) then {
						_player setDir _minDir;
					} else {
						_player setDir _maxDir;
					};
				} else {
					_player setDir (_currentDir  + ((360/1000) * _dirSpinFactor));
				};
			} else {
				_player setDir _dir;
			};
			_lastPosition = _newPosition;
			if ( (((getPos _player) # 2) < 1) || (!((lifeState _player) in ['HEALTHY','INJURED'])) || ((vehicle _player) isNotEqualTo _player) || (_bottomRopeLength <= 1) || (_player getVariable [""AR_Detach_Rope"",false]) ) exitWith {};
			uiSleep 0.01;
		};
		if ((_bottomRopeLength > 1) && ((lifeState _player) in ['HEALTHY','INJURED']) && ((vehicle _player) isEqualTo _player)) then {
			_playerStartASLIntersect = getPosASL _player;
			_playerEndASLIntersect = [_playerStartASLIntersect # 0, _playerStartASLIntersect # 1, (_playerStartASLIntersect # 2) - 5];
			_surfaces = lineIntersectsSurfaces [_playerStartASLIntersect, _playerEndASLIntersect, _player, objNull, true, 10];
			_intersectionASL = [];
			{
				scopeName ""surfaceLoop"";
				_intersectionObject = _x # 2;
				_objectFileName = str _intersectionObject;
				if((_objectFileName find "" t_"") isEqualTo -1 && (_objectFileName find "" b_"") isEqualTo -1) then {
					_intersectionASL = _x # 0;
					breakOut ""surfaceLoop"";
				};
			} forEach _surfaces;
			if (_intersectionASL isNotEqualTo []) then {
				_player allowDamage false;
				_player setPosASL _intersectionASL;
			};
			if(_player getVariable [""AR_Detach_Rope"",false]) then {
				if (_intersectionASL isEqualTo []) then {
					_player allowDamage true;
				};
			};
			if(!isEngineOn _heli) then {
				_player allowDamage true;
			};
		};
		ropeDestroy _topRope;
		deleteVehicle _anchor;
		deleteVehicle _rappelDevice;
		_player setVariable [""AR_Is_Rappelling"",nil,true];
		_player setVariable [""AR_Rappelling_Vehicle"", nil, true];
		_player setVariable [""AR_Detach_Rope"",nil];
		if (_ropeKeyDownHandler isNotEqualTo -1) then {
			(findDisplay 46) displayRemoveEventHandler [""KeyDown"", _ropeKeyDownHandler];
		};
		if (_ropeKeyUpHandler isNotEqualTo -1) then {
			(findDisplay 46) displayRemoveEventHandler [""KeyUp"", _ropeKeyUpHandler];
		};
		uiSleep 2;
		_player allowDamage true;
	} else {
		[_this,""AR_Client_Rappel_From_Heli"",_player] call AR_RemoteExec;
	};
";   
AR_Enable_Rappelling_Animation = compileFinal " 	params [""_player""]; 	[75,[_player,TRUE],'AR_Enable_Rappelling_Animation_Client',FALSE] remoteExec ['QS_fnc_remoteExec',0,FALSE]; ";  
AR_Current_Weapon_Type_Selected = compileFinal " 	params [""_player""]; 	if(currentWeapon _player isEqualTo handgunWeapon _player) exitWith {""HANDGUN""}; 	if(currentWeapon _player isEqualTo primaryWeapon _player) exitWith {""PRIMARY""}; 	if(currentWeapon _player isEqualTo secondaryWeapon _player) exitWith {""SECONDARY""}; 	""OTHER""; ";  
AR_Enable_Rappelling_Animation_Client = compileFinal " 	params [""_player"",[""_globalExec"",false]]; 	 	if(local _player && _globalExec) exitWith {}; 	 	if(local _player && !_globalExec) then { 		[[_player],""AR_Enable_Rappelling_Animation""] call AR_RemoteExecServer; 	};  	if (_player isNotEqualTo player) then { 		_player enableSimulation false; 	}; 	 	if(call AR_Has_Addon_Animations_Installed) then {		 		if([_player] call AR_Current_Weapon_Type_Selected isEqualTo ""HANDGUN"") then { 			if(local _player) then { 				if(missionNamespace getVariable [""AR_DISABLE_SHOOTING_OVERRIDE"",false]) then { 					_player switchMove ""AR_01_Idle_Pistol_No_Actions""; 				} else { 					_player switchMove ""AR_01_Idle_Pistol""; 				}; 				_player setVariable [""AR_Animation_Move"",""AR_01_Idle_Pistol_No_Actions"",true]; 			} else { 				_player setVariable [""AR_Animation_Move"",""AR_01_Idle_Pistol_No_Actions""];			 			}; 		} else { 			if(local _player) then { 				if(missionNamespace getVariable [""AR_DISABLE_SHOOTING_OVERRIDE"",false]) then { 					_player switchMove ""AR_01_Idle_No_Actions""; 				} else { 					_player switchMove ""AR_01_Idle""; 				}; 				_player setVariable [""AR_Animation_Move"",""AR_01_Idle_No_Actions"",true]; 			} else { 				_player setVariable [""AR_Animation_Move"",""AR_01_Idle_No_Actions""]; 			}; 		}; 		if!(local _player) then {  			_player switchMove (_player getVariable [""AR_Animation_Move"",""HubSittingChairC_idle1""]); 			sleep 1; 			_player switchMove (_player getVariable [""AR_Animation_Move"",""HubSittingChairC_idle1""]); 			sleep 1; 			_player switchMove (_player getVariable [""AR_Animation_Move"",""HubSittingChairC_idle1""]); 			sleep 1; 			_player switchMove (_player getVariable [""AR_Animation_Move"",""HubSittingChairC_idle1""]); 		}; 	} else { 		if(local _player) then { 			_player switchMove ""HubSittingChairC_idle1""; 			_player setVariable [""AR_Animation_Move"",""HubSittingChairC_idle1"",true]; 		} else { 			_player setVariable [""AR_Animation_Move"",""HubSittingChairC_idle1""];		 		}; 	};  	_animationEventHandler = -1; 	if(local _player) then { 		_animationEventHandler = _player addEventHandler [""AnimChanged"",{ 			params [""_player"",""_animation""]; 			if(call AR_Has_Addon_Animations_Installed) then { 				if((toLowerANSI _animation) find ""ar_"" < 0) then { 					if([_player] call AR_Current_Weapon_Type_Selected isEqualTo ""HANDGUN"") then { 						_player switchMove ""AR_01_Aim_Pistol""; 						_player setVariable [""AR_Animation_Move"",""AR_01_Aim_Pistol_No_Actions"",true]; 					} else { 						_player switchMove ""AR_01_Aim""; 						_player setVariable [""AR_Animation_Move"",""AR_01_Aim_No_Actions"",true]; 					}; 				} else { 					if(toLowerANSI _animation isEqualTo ""ar_01_aim"") then { 						_player setVariable [""AR_Animation_Move"",""AR_01_Aim_No_Actions"",true]; 					}; 					if(toLowerANSI _animation isEqualTo ""ar_01_idle"") then { 						_player setVariable [""AR_Animation_Move"",""AR_01_Idle_No_Actions"",true]; 					}; 					if(toLowerANSI _animation isEqualTo ""ar_01_aim_pistol"") then { 						_player setVariable [""AR_Animation_Move"",""AR_01_Aim_Pistol_No_Actions"",true]; 					}; 					if(toLowerANSI _animation isEqualTo ""ar_01_idle_pistol"") then { 						_player setVariable [""AR_Animation_Move"",""AR_01_Idle_Pistol_No_Actions"",true]; 					}; 				}; 			} else { 				_player switchMove ""HubSittingChairC_idle1""; 				_player setVariable [""AR_Animation_Move"",""HubSittingChairC_idle1"",true]; 			}; 		}]; 	}; 	 	if(!local _player) then { 		[_player] spawn { 			params [""_player""]; 			private [""_currentState""]; 			while {_player getVariable [""AR_Is_Rappelling"",false]} do { 				_currentState = toLowerANSI animationState _player; 				_newState = toLowerANSI (_player getVariable [""AR_Animation_Move"",""""]); 				if!(call AR_Has_Addon_Animations_Installed) then { 					_newState = ""HubSittingChairC_idle1""; 				}; 				if(_currentState != _newState) then { 					_player switchMove _newState; 					_player switchGesture """"; 					sleep 1; 					_player switchMove _newState; 					_player switchGesture """"; 				}; 				sleep 0.1; 			};			 		}; 	}; 	 	waitUntil {!(_player getVariable [""AR_Is_Rappelling"",false])}; 	 	if (_animationEventHandler isNotEqualTo -1) then { 		_player removeEventHandler [""AnimChanged"", _animationEventHandler]; 	}; 	 	_player switchMove """";	 	_player enableSimulation true; 	 ";  
AR_Rappel_Detach_Action = compileFinal " 	params [""_player""]; 	_player setVariable [""AR_Detach_Rope"",true]; ";  
AR_Rappel_Detach_Action_Check = compileFinal " 	params [""_player""]; 	if!(_player getVariable [""AR_Is_Rappelling"",false]) exitWith {false;}; 	true; ";  
AR_Rappel_From_Heli_Action = compileFinal " 	params [""_player"",""_vehicle""];	 	if([_player, _vehicle] call AR_Rappel_From_Heli_Action_Check) then { 		[_player, _vehicle] call AR_Rappel_From_Heli; 	}; "; 
AR_Rappel_From_Heli_Action_Check = compileFinal "
	params ['_player','_vehicle']; 	
	private _c = FALSE; 	
	if ([_vehicle] call AR_Is_Supported_Vehicle) then {
		if (_player isNotEqualTo (currentPilot _vehicle)) then {
			private _vehPos = getPosWorld _vehicle;
			if (surfaceIsWater _vehPos) then {
				_vehPos = getPosASL _vehicle;
			} else {
				_vehPos = getPosATL _vehicle;
			};
			if (
				(!(_vehicle getVariable ['QS_rappellSafety',FALSE])) &&
				{((_vehPos # 2) < 55)} &&
				{((_vehPos # 2) > 5)} &&
				{((lineIntersectsSurfaces [(_vehicle modelToWorldWorld [0,0,-1]),(_vehicle modelToWorldWorld [0,0,-6]),_vehicle,objNull,TRUE,-1,'GEOM','ROADWAY',TRUE]) isEqualTo [])} &&
				{(((vectorMagnitude (velocity _vehicle)) * 3.6) < 35)} &&
				{((toLower ((assignedVehicleRole _player) # 0)) in ['cargo','turret'])}
			) then {
				if ((count (assignedVehicleRole _player)) > 1) then {
					if (!((((assignedVehicleRole _player) # 0) isEqualTo 'Turret') && ((((assignedVehicleRole _player) # 1) # 0) < 1))) then {
						_c = TRUE;
					};
				} else {
					_c = TRUE;
				};
			};
		};
	};
	_c; 
"; 
AR_Rappel_AI_Units_From_Heli_Action_Check = compileFinal " 	params [""_player""]; 	if((leader _player) != _player) exitWith {false}; 	_canRappelOne = false; 	{ 		if(((vehicle _x) != _x) && (!isPlayer _x)) then { 			if([_x, vehicle _x] call AR_Rappel_From_Heli_Action_Check) then { 				_canRappelOne = true; 			}; 		}; 	} forEach (units _player); 	_canRappelOne; ";  
AR_Get_Corner_Points = compileFinal " 	params [""_vehicle""]; 	private [""_centerOfMass"",""_bbr"",""_p1"",""_p2"",""_rearCorner"",""_rearCorner2"",""_frontCorner"",""_frontCorner2""]; 	private [""_maxWidth"",""_widthOffset"",""_maxLength"",""_lengthOffset"",""_widthFactor"",""_lengthFactor"",""_maxHeight"",""_heightOffset""]; 	 	_widthFactor = 0.5; 	_lengthFactor = 0.5; 	if(_vehicle isKindOf ""Air"") then { 		_widthFactor = 0.3; 	}; 	if(_vehicle isKindOf ""Helicopter"") then { 		_widthFactor = 0.2; 		_lengthFactor = 0.45; 	}; 	 	_centerOfMass = getCenterOfMass _vehicle; 	_bbr = boundingBoxReal _vehicle; 	_p1 = _bbr # 0; 	_p2 = _bbr # 1; 	_maxWidth = abs ((_p2 # 0) - (_p1 # 0)); 	_widthOffset = ((_maxWidth / 2) - abs ( _centerOfMass # 0 )) * _widthFactor; 	_maxLength = abs ((_p2 # 1) - (_p1 # 1)); 	_lengthOffset = ((_maxLength / 2) - abs (_centerOfMass # 1 )) * _lengthFactor; 	_maxHeight = abs ((_p2 # 2) - (_p1 # 2)); 	_heightOffset = _maxHeight/6; 	 	_rearCorner = [(_centerOfMass # 0) + _widthOffset, (_centerOfMass # 1) - _lengthOffset, (_centerOfMass # 2)+_heightOffset]; 	_rearCorner2 = [(_centerOfMass # 0) - _widthOffset, (_centerOfMass # 1) - _lengthOffset, (_centerOfMass # 2)+_heightOffset]; 	_frontCorner = [(_centerOfMass # 0) + _widthOffset, (_centerOfMass # 1) + _lengthOffset, (_centerOfMass # 2)+_heightOffset]; 	_frontCorner2 = [(_centerOfMass # 0) - _widthOffset, (_centerOfMass # 1) + _lengthOffset, (_centerOfMass # 2)+_heightOffset]; 	 	[_rearCorner,_rearCorner2,_frontCorner,_frontCorner2]; "; /*/"VTOL_Base_F"/*/ 
AR_SUPPORTED_VEHICLES = [ 	"Helicopter" ];  
AR_Is_Supported_Vehicle = compileFinal " 	params [""_vehicle"",""_isSupported""]; 	_isSupported = false; 	if(not isNull _vehicle) then { 		{ 			if(_vehicle isKindOf _x) then { 				_isSupported = true; 			}; 		} forEach (missionNamespace getVariable [""AR_SUPPORTED_VEHICLES_OVERRIDE"",AR_SUPPORTED_VEHICLES]); 	}; 	_isSupported; ";  
AR_Hint = compileFinal "
	params ['_msg',['_isSuccess',true]];
	hint _msg;
";  
AR_Hide_Object_Global = compileFinal "
	params ['_obj'];
	if((_obj isKindOf 'Land_Can_V2_F') || {(_obj isKindOf 'B_static_AA_F')} || {(_obj isKindOf 'B_UAV_01_F')}) then {
		for '_x' from 0 to 2 step 1 do {
			_obj hideObject TRUE;
			_obj hideObjectGlobal TRUE;
		};
	};
";  
AR_RemoteExec = compileFinal " 	
	params ['_params','_functionName','_target',['_isCall',false]];
	[75,_params,_functionName,_isCall] remoteExecCall ['QS_fnc_remoteExec',_target]; 
";  
AR_RemoteExecServer = compileFinal "
	params ['_params','_functionName',['_isCall',false]];
	[75,_params,_functionName,_isCall] remoteExecCall ['QS_fnc_remoteExec',2];
";