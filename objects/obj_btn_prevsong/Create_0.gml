event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Prev Song";
time_after_click = 0;

image_index = 0;

on_action = function(){
	if (time_after_click == 0 || controller.track_index == 0){
		controller.select_song(controller.track_index);
		time_after_click = 0.3;
		return;
	}
	
	controller.select_song(controller.track_index - 1);
}