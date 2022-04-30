/*/
File: fn_clientEventHandleChatMessage.sqf
Author:

	Quiksilver
	
Last Modified:

	23/04/2022 A3 2.08 by Quiksilver
	
Description:

	Handle Chat Messages
______________________________________________/*/

params [
	'_channel','_owner','_from','_text','_person','_name','_strID',
	'_forcedDisplay','_isPlayerMessage','_sentenceType','_chatMessageType','_systemInfo'
];
private _return = FALSE;
if (missionNamespace getVariable ['QS_HUD_toggleChatSpam',TRUE]) then {
	if (_channel isEqualTo 16) then {
		if (_systemInfo isNotEqualTo []) then {
			if ((_systemInfo # 0) isEqualType '') then {
				_systemInfoType = _systemInfo # 0;
				if (_systemInfoType in ['$STR_MP_CONNECTING','$STR_MP_CONNECTION_LOOSING']) then {
					_return = TRUE;
				};
			};
		} else {
			_strings = [
				'uses modified data',
				'steam ticket check',
				'query timeout',
				'battleye:',
				'wrong signature for file',
				'file:',
				'files',
				'kicked off'
			];
			{
				if ([_x,_text] call (missionNamespace getVariable 'QS_fnc_inString')) exitWith {
					_return = TRUE;
				};
			} forEach _strings;
		};
	};
};
_return;