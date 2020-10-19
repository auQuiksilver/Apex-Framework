/*/
File: fn_clientEventHandleChatMessage.sqf
Author:

	Quiksilver
	
Last Modified:

	7/10/2020 A3 2.00 by Quiksilver
	
Description:

	Handle Chat Messages
	
Fires when a message is received, before adding it to the chat feed. Return true to block a message from being added to the chat feed. Fires clientside.

addMissionEventHandler ["HandleChatMessage", {
	params ["_channelIndex", "_senderId", "_senderName", "_message"];
}];
channelIndex: Number - See radio channel indexes (0 for system)
senderId: Number - owner id of the sender
senderName: String - sender's name
message: String - the sent message
_____________________________________________________________________/*/