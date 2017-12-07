/*
File: QS_supporters.sqf
Author:

	Quiksilver
	
Last modified:

	13/04/2016 ArmA 3 1.56 by Quiksilver
	
Description:

	Supporters
	
	Ghetto database
	
Notes:

	Insert UIDs between the two dummy entries.
	The name segment is not important, does not have to be exactly accurate. What is important is level and UID
	
Entry format (include comma at end):

	['player UID','player name',supporter level],
	['000000000000000','John Doe',0],
	
Supporter Levels (monthly):

	1 = $5
	2 = $15
	3 = $30
	4 = $50+		??
	5 = $100+		??
	
76561198127637215
__________________________________________________________________________*/

private _return = [];
if (['SG',missionName,FALSE] call (missionNamespace getVariable 'BIS_fnc_inString')) then {
	_return = [
		['000000000000000','Han Solo',0],
		/*/insert entries below/*/
		['76561198214984928','J17',2],	
		['76561198027166400','Fitz',2],
		['76561198107403916','Krow',2],
		['76561198085917189','Littleblacksheep',2],
		['76561197976546912','Dasweetdude',2],
		['76561198084065754','Quiksilver',2],
		['76561198010638484','Cassidy',2],
		['76561198018540405','White Beast',2],
		['76561198154689454','Pvt Parts',2],
		['76561198063955650','InfamousNova',2],
		['76561197999436142','EZRA',2],
		['76561198201496979','Excellent26k6',2],
		['76561198118446908','cocane6',2],
		['76561198001601587','Suzaku',2],
		['76561198075406717','Unemployment Benefit',2],
		['76561198004026295','Aramius',2],
		['76561198000878718','shift597',2],
		['76561198234337020','black fox',2],
		['76561198032126177','AIR_RAIDER',2],
		['76561198160061047','C.Whiskey',2],
		['76561198192272161','Matsozetex',2],
		['76561198045641614','Bones',2],
		['76561197960797129','VooKain',2],
		['76561198049308013','dohdoh64',2],
		['76561198114194315','Sonaint',2],
		['76561198063531934','[ATC]Tracuer',2],
		['76561198150359668','RiddimWise',2],
		['76561198048700779','22A',2],
		['76561198022690399','Spadge',2],
		['76561198036701061','vortex1018',2],
		['76561198137013603','JMaverick',2],
		['76561198114739208','SharpShooter',2],
		['76561198071103805','Whitts',2],
		['76561198088441620','Marquez',2],
		['76561197982847025','=S.N.A.F.U.=',2],
		['76561197970686483','Zybisko',2],
		['76561198137918156','shady',2],
		['76561198127637215','Funky',2],
		/*/insert entries above/*/
		['111111111111111','Luke Skywalker',0]
	];
} else {
	_return = [
		['000000000000000','Han Solo',0],
		/*/insert entries below/*/
		['76561197976546912','Dasweetdude',2],
		['76561198084065754','Quiksilver',2],		
		/*/insert entries above/*/
		['111111111111111','Luke Skywalker',0]	
	];
};
_return;