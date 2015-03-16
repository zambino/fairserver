
ZFM_Markers_Create_Marker_PseudoRandomName ={
	private["_stringLength","_characters","_outputString","_x"];
	_stringLength = _this select 0;

	// Characters we can 
	_characters = [
		"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
		"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
		"0","1","2","3","4","5","6","7","8","9","!","_","-","&","$","*","(",")","<",">",".",",","{","}"
	];

	// Pre-create the output string
	_outputString = "";

	// Cache so we're not continually counting the array
	_charLength = count _characters;

	// Create the string
	for [{_x= 1},{_x <= _stringLength},{_x = _x + 1}] do
	{
		_outputString = _outputString + (_characters call BIS_fnc_selectRandom);
	};

	// Return it
	_outputString
};


/*
*	ZFM_Markers_Create_Marker
*
*	Creates a marker as specified, and sets all properties in one.
*
*	Parameters:
*	[ (String) Title, (Position) Position, (String) Type, (String) Shape, (Number) Width, (Number) Height, (Number) Direction, (String) Colour, (String) FillTexture, (Number) Opacity ]
*	
*/
ZFM_Markers_Create_Marker ={
	private["_title","_subtitle","_position","_type","_shape","_width","_height","_direction","_colour","_fillTexture","_opacity","_markerOne","_markerTwo"];
	_title = _this select 0;
	_subtitle = _this select 1;
	_position = _this select 2;
	_type =_this select 3;
	_titletype = _this select 4;
	_subtitletype = _this select 5;
	_shape = _this select 6;
	_width = _this select 7;
	_height = _this select 8;
	_direction = _this select 9;
	_colour = _this select 10;
	_fillTexture = _this select 11;
	_opacity = _this select 12;

	// Create a marker for the colour and shape, then create one for the text.
	_markerOneName = [30] call ZCR_PseudoUniqueString;
	_markerOne = createMarker[_markerOneName,_position];
	_markerOne setMarkerType _type;
	_markerOne setMarkerShape _shape;
	_markerOne setMarkerSize[_width,_height];
	_markerOne setMarkerDir _direction;
	_markerOne setMarkerColor _colour;
	_markerOne setMarkerBrush _fillTexture;
	_markerOne setMarkerAlpha _opacity;

	// Create a marker for the text..
 	_markerTwoName = [30] call ZCR_PseudoUniqueString;
 	_markerTwo = createMarker[_markerTwoName,[_position select 0,(_position select 1)-60]];
 	_markerTwo setMarkerColor "ColorBlack";
 	_markerTwo setMarkerType _subtitletype;
 	_markerTwo setMarkerText _subtitle;

 	_markerThreeName = [30] call ZCR_PseudoUniqueString;
 	_markerThree = createMarker[_markerThreeName,_position];
 	_markerThree setMarkerColor "ColorBlack";
 	_markerThree setMarkerType _titletype;
 	_markerThree setMarkerText _title;

 	[_markerOne,_markerTwo]
};
