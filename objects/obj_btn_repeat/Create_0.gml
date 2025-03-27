event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Play";

get_label_text = function(){
	switch (controller.repeat_mode){
		case RepeatMode.RepeatOne:
			return "Repeat One";
		case RepeatMode.RepeatAll:
			return "Repeat All";
		default:
			return "No Repeat";
	}
}

get_image_index = function(){
	return (controller.repeat_mode == RepeatMode.RepeatOne ? 1 : 0);
}

is_highlighted = function(){
	return (controller.repeat_mode != RepeatMode.NoRepeat);
}

on_action = function(){
	switch (controller.repeat_mode){
		case RepeatMode.RepeatOne:
			controller.repeat_mode = RepeatMode.NoRepeat;
			break;
		case RepeatMode.RepeatAll:
			controller.repeat_mode = RepeatMode.RepeatOne;
			break;
		default:
			controller.repeat_mode = RepeatMode.RepeatAll;
			break;
	}
}

accelerator = function(){
	return keyboard_check_pressed(ord("R"));
}