/*
File: QS_data_chatMessages.sqf
Author:

	Quiksilver
	
Last modified:

	23/02/2016 A3 1.56 by Quiksilver
	
Description:

	Messages to show up in chat on a regular basis
__________________________________________________________________________*/

if (['SG',missionName,FALSE] call (missionNamespace getVariable 'BIS_fnc_inString')) then {
	[
		'This is a new high-performance server, made possible by your continued support. Thank you!',
		'Register on our forums to keep up to date with community news and development',
		'"Coffee tastes better if the latrines are dug downstream from an encampment."     - US Army Field Regulations, 1861',
		'This is a new high-performance server, made possible by your continued support. Thank you!',
		'This server restarts daily at   AEST 06:00,12:00,18:00,24:00   to maximize performance',
		(format ['Teamspeak:     %1',(missionNamespace getVariable 'QS_teamspeak_address')]),
		'"We make war that we may live in peace"     - Aristotle',
		'Pilots and UAV operator must be on Teamspeak',
		'This server restarts daily at   AEST 06:00,12:00,18:00,24:00   to maximize performance',
		'"Go, tell the Spartans, passerby, that here by Spartan law, we lie."     - Simonides of Ceos',
		(format ['Interested in a staff position? Apply on the forums now! %1',(missionNamespace getVariable 'QS_community_website')]),
		'This is a new high-performance server, made possible by your continued support. Thank you!',
		'"Great is the guilt of an unnecessary war"     - John Adams',
		'This server restarts daily at   AEST 06:00,12:00,18:00,24:00   to maximize performance',
		'"When you are short of everything but the enemy, you are in combat."     - Unknown',
		'Allowed addons: JSRS DragonFyre Apex',
		'This is a new high-performance server, made possible by your continued support. Thank you!',
		'"Only the dead have seen the end of war"     - Plato',
		'This server restarts daily at   AEST 06:00,12:00,18:00,24:00   to maximize performance',
		'"When the power of love overcomes the love of power, the world will know peace."     - Jimi Hendrix',
		'This is a new high-performance server, made possible by your continued support. Thank you!',
		'This server restarts daily at   AEST 06:00,12:00,18:00,24:00   to maximize performance',
		'"The object of war is not to die for your country, but to make the other bastard die for his."     - George Patton Jr.',
		'Press [Home] to access your Client Menu',
		'"In times of war the law falls silent"     - Marcus Tullius Cicero'
	]
} else {
	[
		'"Coffee tastes better if the latrines are dug downstream from an encampment."     - US Army Field Regulations, 1861',
		'This server restarts daily at CST 06:00, 12:00, 18:00, 24:00 to maximize performance',
		'"We make war that we may live in peace"     - Aristotle',
		'Pilots and UAV operator must be on Teamspeak',
		'This server restarts daily at CST 06:00, 12:00, 18:00, 24:00 to maximize performance',
		'"Go, tell the Spartans, passerby, that here by Spartan law, we lie."     - Simonides of Ceos',
		'"Great is the guilt of an unnecessary war"     - John Adams',
		'This server restarts daily at CST 06:00, 12:00, 18:00, 24:00 to maximize performance',
		'"When you are short of everything but the enemy, you are in combat."     - Unknown',
		'Allowed addons: JSRS DragonFyre Apex',
		'"Only the dead have seen the end of war"     - Plato',
		'This server restarts daily at CST 06:00, 12:00, 18:00, 24:00 to maximize performance',
		'"When the power of love overcomes the love of power, the world will know peace."     - Jimi Hendrix',
		'This server restarts daily at CST 06:00, 12:00, 18:00, 24:00 to maximize performance',
		'"The object of war is not to die for your country, but to make the other bastard die for his."     - George Patton Jr.',
		'Press [Home] to access your Client Menu',
		'"In times of war the law falls silent"     - Marcus Tullius Cicero',
		'"Thanks the night mother for Robocop.. Didnt realize pressing space with no scroll would detonate"		- MoparGamer'
	]
};