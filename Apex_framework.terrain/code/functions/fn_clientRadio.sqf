/*
File: fn_clientRadio.sqf
Author:
	
	Quiksilver
	
Last Modified:

	29/06/2016 A3 1.62 by Quiksilver

Description:

	Client Radio
	
Example:

	[0,((missionNamespace getVariable 'QS_radioChannels') # 2)] call (missionNamespace getVariable 'QS_fnc_clientRadio');
__________________________________________________________*/

params ['_type','_channel'];
if (_type isEqualTo 0) then {
	if (_channel in (missionNamespace getVariable 'QS_client_radioChannels')) then {
		_channel radioChannelRemove [player];
		if (currentChannel > 5) then {
			setCurrentChannel 5;
		};
		diag_log format ['***** RADIO ***** Removed from channel %1',_channel];
		missionNamespace setVariable [
			'QS_client_radioChannels',
			((missionNamespace getVariable 'QS_client_radioChannels') - [_channel]),
			FALSE
		];
	};
} else {
	if (_type isEqualTo 1) then {
		if (!(_channel in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
			if (_channel isNotEqualTo 1) then {
				_channel radioChannelAdd [player];
			};
			diag_log format ['***** RADIO ***** Added to channel %1',_channel];
			missionNamespace setVariable [
				'QS_client_radioChannels',
				((missionNamespace getVariable 'QS_client_radioChannels') + [_channel]),
				FALSE
			];
		};
	} else {
		if (_type isEqualTo 2) then {
			/*/Respawn Event/*/
			if ((missionNamespace getVariable 'QS_client_radioChannels') isNotEqualTo []) then {
				{
					if (_x isNotEqualTo 1) then {
						_x radioChannelAdd [player];
					};
				} forEach (missionNamespace getVariable 'QS_client_radioChannels');
			};
		} else {
			if (_type isEqualTo 3) then {
				/*/Killed Event/*/
				if (currentChannel > 5) then {
					setCurrentChannel 5;
				};
				if ((missionNamespace getVariable 'QS_client_radioChannels') isNotEqualTo []) then {
					{
						if (_x isNotEqualTo 1) then {
							_x radioChannelRemove [player];
						};
					} forEach (missionNamespace getVariable 'QS_client_radioChannels');
				};
			};
		};
	};
};