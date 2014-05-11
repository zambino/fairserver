
ZFM_Admins_Online = [];

/*
*	ZFM_Player_IsAdmin
*
*	Finds out if the player is an admin user.
*/
ZFM_Player_IsAdmin ={
	private["_player"];
	_player = _this select 1;
	
	// Get information on the player and defined admin IDs
	_playerUID = getPlayerUID _player;
	_numAdmins = count ZFM_Admin_UIDs;
	
	_isAdmin = false;
	
	if (_numAdmins == 0) exitWith {diag_log("ZFM_Player_IsAdmin: No Admin players defined. Exiting.")};
	
	for [{_x =0},{_x <= _numAdmins-1},{_x = _x +1} ] do
	{
		_thisRow = ZFM_Admin_UIDs select _x;
		
		_adminUID = _thisRow select 0;
		
		if(_adminUID == _playerUID) then
		{
			_isAdmin = true;
		};
	};
	_isAdmin
};

/*
*	ZFM_Get_Online_Admins
*
*	Gets the online administrators and adds them to an array which is accessible..
*/
ZFM_Get_Online_Admins = {
	private["_onlinePlayers"];
	
	// Get the online players.
	_onlinePlayers = playableUnits;
	
	// Find out the number of online players
	_numOnlinePlayers = count _onlinePlayers;
	
	// Exit if nobody is online
	if (_numOnlinePlayers == 0) exitWith {diag_log("ZFM_Get_Online_Admins: Nobody online. Exiting.")};
	
	// Loop through online players
	for [{_x =0},{_x <= _numOnlinePlayers-1},{_x = _x +1} ] do
	{
		// Find the player..
		_currentPlayer = _onlinePlayers select _x;
		
		_isAdmin = [_currentPlayer] call ZFM_Player_IsAdmin;
		
		if(_isAdmin)
		{
			ZFM_Admins_Online = ZFM_Admins_Online + _currentPlayer;
		}
	};
};

// Get the config stuff..
ZFM_Includes_Admin_Config = "\z\addons\dayz_server\ZFM\Config\ZFM_Admin_Config.sqf";

// We need to get access to these functions..
call compile preprocessFileLineNumbers ZFM_Includes_Admin_Config;