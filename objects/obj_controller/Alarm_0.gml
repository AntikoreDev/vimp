var _len = array_length(openable);
for (var _i = 0; _i < _len; _i++){
	var _f = openable[_i];
	if (string_ends_with(_f, ".vipl")){
		add_list(_f);	
	}else{
		add_song(_f);
	}	
}