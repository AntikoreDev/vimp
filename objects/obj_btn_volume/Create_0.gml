event_inherited();

controller = instance_find(obj_controller, 0);
label_text = "Play";
numpad_shortcuts = [
    [ord("0"), vk_numpad0],
    [ord("1"), vk_numpad1],
    [ord("2"), vk_numpad2],
    [ord("3"), vk_numpad3],
    [ord("4"), vk_numpad4],
    [ord("5"), vk_numpad5],
    [ord("6"), vk_numpad6],
    [ord("7"), vk_numpad7],
    [ord("8"), vk_numpad8],
    [ord("9"), vk_numpad9],
]

get_label_text = function(){
	return (controller.muted ? "No Volume" : $"Volume: {floor(controller.volume * 100)}%");
}

get_image_index = function(){
	if (controller.volume >= 0.8)
		return 0;
	if (controller.volume > 0)
		return 1;
	return 2;
}

is_highlighted = function(){
	return (!controller.muted);
}

on_action = function(){
	controller.muted = !controller.muted;
	controller.update_volume();
}