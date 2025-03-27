event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Shuffle";

is_highlighted = function(){
	return (controller.shuffling);
}

on_action = function(){
	controller.shuffle();	
}

accelerator = function(){
	return keyboard_check_pressed(ord("S"));
}