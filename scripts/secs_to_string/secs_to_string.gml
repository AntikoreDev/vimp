function secs_to_string(_secs){
	var _h = 0;
	var _m = 0;
	var _s = floor(_secs);
	
	while (_s >= 3600){
		_h++;
		_s -= 3600;
	}

	while (_s >= 60){
		_m++;
		_s -= 60;
	}
	
	if (_h > 0)
		return $"{_h}:{format_time_number(_m)}:{format_time_number(_s)}";
	else
		return $"{_m}:{format_time_number(_s)}";
}

function format_time_number(_n){
	return (_n >= 10 ? string(_n) : $"0{_n}");	
}