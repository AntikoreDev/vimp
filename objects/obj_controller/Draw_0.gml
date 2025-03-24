draw_set_font(fnt_main);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _timesprite_idx = is_nighttime(current_hour);
var _daymins = current_minute + (current_hour * 60);
draw_sprite(spr_timesprite, _timesprite_idx, 4, 4);
draw_text(16, 3, $"{secs_to_string(_daymins)}");
draw_text(4, 16, $"{get_weekday(current_weekday)} {current_day} · {get_month_name(current_month)} {current_year}");