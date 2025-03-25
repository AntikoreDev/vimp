is_hovering	     = point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom);
var _is_clicking = mouse_check_button_pressed(mb_left);

image_blend = (is_highlighted() ? c_white : c_gray);

if (is_hovering && _is_clicking){
	on_action();
}

label_text = get_label_text() ?? label_text;
image_index = get_image_index() ?? image_index;