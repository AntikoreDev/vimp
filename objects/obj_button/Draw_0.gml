if (!window_has_focus()) exit;

draw_self();

if (is_hovering){
	var _top_button = y < 24;
	draw_set_halign(_top_button ? fa_right : fa_center);
	draw_set_valign(_top_button ? fa_top : fa_bottom);
	draw_set_font(fnt_main);
	
	var _xx = (_top_button ? room_width - 4 : x);
	var _yy = (_top_button ? 4 : y - 6);
	draw_text(_xx, _yy, label_text);
}