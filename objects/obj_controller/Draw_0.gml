draw_set_font(fnt_main);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _timesprite_idx = is_nighttime(current_hour);
var _daymins = current_minute + (current_hour * 60);
draw_sprite(spr_timesprite, _timesprite_idx, 4, 4);
draw_text(16, 3, $"{secs_to_string(_daymins)}");
draw_text(4, 16, $"{get_weekday(current_weekday)} {current_day} · {get_month_name(current_month)} {current_year}");

draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(room_width - 4, 4, "TRACK LIST");

draw_sprite_ext(spr_pixel, 0, 8, room_height - 8, room_width - 16, 2, 0, c_gray, 1);
if (instance_number(obj_song) <= 0){
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);

	draw_text(8, room_height - 10, "-:--");	
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);

	draw_text(room_width - 8, room_height - 10, "-:--");	
}
	