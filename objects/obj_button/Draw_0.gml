draw_self();

if (is_hovering){
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_font(fnt_main);
	draw_text(x, y - 12, label_text);
}