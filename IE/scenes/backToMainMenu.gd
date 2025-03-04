extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal main_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("main_menu",GameState.scene_switcher,"main_menu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_mainMenu_pressed():
	emit_signal("main_menu")
