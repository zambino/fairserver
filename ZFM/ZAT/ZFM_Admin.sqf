

// Get the config stuff..
ZFM_Includes_Admin_Config = "\z\addons\dayz_server\ZFM\Config\ZFM_Admin_Config.sqf";

// We need to get access to these functions..
call compile preprocessFileLineNumbers ZFM_Includes_Admin_Config;

/*
*	ZFM_Player_Is_Admin
*
*	Returns TRUE or FALSE based on if the player is an admin or not.
* 	This function is awful, I know, but I am just testing the potentiality of doing Admin-stuff without modifications to a lot of stuff.
*/
ZFM_Player_Is_Admin ={
	private ["_playerUID"];
	
	_player = _this select 0;
	_playerUID = getPlayerUID _player;
	
	_admins_count = count ZFM_Admin_UIDs;
	
	diag_log(format["Player is Admin, params %1",_this]);
	
	if(_admins_count == 0) exitWith { diag_log(format["%1 %2 - No admin players defined.",ZFM_Name,ZFM_Version])};
	
	_isAdmin = false;
	
	// Loop through existing admins
	for [{_x =0},{_x <= _admins_count-1},{_x = _x +1} ] do
	{
		// Get the row of admin IDs
		_thisrow = ZFM_Admin_UIDs select _x;
		
		diag_log(format["THISROW: %1, PlayerUID %2",_thisrow,_playerUID]);
		
		// Get the Admin UID
		_adminUID = _thisrow select 0;
		
		if(_playerUID == _adminUID) then
		{
			diag_log(format["%1 %2 - Admin user with UID %3",ZFM_Name,ZFM_Version,_playerUID]);
			_isAdmin = true;
		};
	};
	
	_isAdmin
};

ZFM_AddAdminPowers ={
	private ["_player"];
	
	_player = _this select 0;
	
	diag_log(format["AddAdminPowers: MOTHERFUCKING PLAYER %1",_player]);
	
	_adminPowerVar = _player getVariable["ZFS_AdminPowers",[]];
	if(count _adminPowerVar ==1) exitWith{};
	
	
	if(typeName _adminPowerVar != "STRING") then
	{
		_player setVariable["ZFS_AdminPowers",["ADMIN_ALL_POWERS"],true];
	};
};


ZFM_LoopOnlinePlayers_Admin ={
	private["_onlinePlayers","_isAdminPlayer"];

	_onlinePlayers = playableUnits;
	
	diag_log(format["OnlinePlayers %1",_onlinePlayers]);
	
	_numOnlinePlayersInit = count _onlinePlayers;

	if(_numOnlinePlayersInit ==0) exitWith { diag_log(format["%1 %2 - No online players found. Exiting",ZFM_Name,ZFM_Version])};
	
	// Loop through each of the online players
	for [{_x =0},{_x <= _numOnlinePlayersInit-1},{_x = _x +1} ] do
	{
		// Get the row
		_row = _onlinePlayers select _x;
		
		_adminPowerVar = _row getVariable["ZFS_AdminPowers",[]];
		if(count _adminPowerVar ==1) exitWith{};
		
		if(typeName _row != "ARRAY" && typeName _adminPowerVar != "STRING") then
		{
			diag_log(format["OnlinePlayers Admin, Row: %1",_row]);

			// Okay, we find out if the person is an admin or not
			_isAdminPlayer = [_row] call ZFM_Player_Is_Admin;
			
			if(_isAdminPlayer) then
			{
				[_row] call ZFM_AddAdminPowers;
			};		
		};
	};
};

