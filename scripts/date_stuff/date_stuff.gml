function get_weekday(_idx){
	var _list = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
	return _list[_idx - 1];
}

function get_month_name(_idx){
	var _list = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" ];
	return _list[_idx - 1];
}

function is_nighttime(_hour){
	return (_hour >= 20 || _hour <= 7);
}