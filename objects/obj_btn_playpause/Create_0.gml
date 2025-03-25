event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Play";

get_label_text = function(){
	return controller.is_paused ? "Play" : "Pause";
}

get_image_index = function(){
	return controller.is_paused ? 0 : 1;	
}

on_action = function(){
	controller.is_paused = !controller.is_paused;	
}