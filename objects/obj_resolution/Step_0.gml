var _ww = window_get_width();
var _wh = window_get_height();

if (window_has_focus() && (_wh != wh || _ww != ww) && (_ww != 0 && _wh != 0)){
	ww = _ww;
	wh = _wh;
	
	surface_resize(application_surface, ww, wh);
}