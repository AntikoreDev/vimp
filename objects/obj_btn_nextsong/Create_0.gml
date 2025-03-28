event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Next Song";

image_index = 1;

is_highlighted = function(){
	return !(controller.track_index + 1 >= array_length(controller.track_list) && controller.repeat_mode == RepeatMode.NoRepeat);
}

on_action = function(){
	var _last = controller.track_index + 1 >= array_length(controller.track_list);
	if (_last && controller.repeat_mode == RepeatMode.NoRepeat)
		return;	
	
	if (_last && controller.repeat_mode == RepeatMode.RepeatAll){
		controller.select_song(0);
		return;
	}
	
	if (_last && controller.repeat_mode == RepeatMode.RepeatOne){
		controller.select_song(controller.track_index);
		return;
	}
	
	controller.select_song(controller.track_index + 1);
}

accelerator = function(){
	return keyboard_check_pressed(vk_right);	
}