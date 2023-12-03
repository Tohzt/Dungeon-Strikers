extends CanvasLayer

const loading_scene = "res://Scenes/Menus/Loading/loading_scene.tscn"

func _ready():
	pass

func _process(_delta):
	pass

func _on_button_resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()

func _on_button_quit_pressed():
	get_tree().quit()
