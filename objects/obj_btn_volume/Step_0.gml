event_inherited();
if (is_hovering){
	var _mouse = (mouse_wheel_up() - mouse_wheel_down());
	var _kb = (keyboard_check_pressed(vk_up) - keyboard_check_pressed(vk_down));
	var _val = (_mouse != 0 ? _mouse : _kb);

	if (_val != 0){
		var _shift = keyboard_check(vk_shift);
		var _ctrl = keyboard_check(vk_control);
		
		var _power = 0.02;
		if (_shift && !_ctrl)
			_power = 0.01;
		if (_ctrl && !_shift)
			_power = 0.05;
	
		controller.volume = clamp(controller.volume + (_power * _val), 0, 1.5);
		controller.update_volume();
	}

	for (var _i = 0; _i < array_length(numpad_shortcuts); _i++){
		var _btns = numpad_shortcuts[_i];
		if (keyboard_check_pressed(_btns[0]) || keyboard_check_pressed(_btns[1])){
			controller.volume = 0.1 * _i;
			controller.update_volume();
		}
	}
	
}

accelerator = function(){
	return keyboard_check_pressed(ord("M"));	
}