event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Watch Current";

is_highlighted = function(){
	return (controller.watch_track);
}

on_action = function(){
	controller.watch_track = !controller.watch_track;
	controller.move_to_track();
}

accelerator = function(){
	return keyboard_check_pressed(ord("W"));
}